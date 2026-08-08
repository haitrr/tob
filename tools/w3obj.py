"""Read and patch Warcraft III object-data files.

Object data lives in binary tables next to war3map.j inside the map archive:

    war3map.w3a  abilities     war3map.w3u  units          war3map.w3d  doodads
    war3map.w3t  items         war3map.w3b  destructables  war3map.w3q  upgrades

Every one has the same shape: a version int, then two tables (stock objects
the map modified in place, then custom ones), each a count followed by that
many objects.  An object is a base id, its own id, and a list of the fields
the map author changed:

    id4    base id             'ANsq' - the stock object this derives from
    id4    custom id           'A0DY', or 0 in the first table
    i32    number of sets                                   version >= 3 only
      i32  number of listed ids, then that many id4         version >= 3 only
      i32  number of modifications
        id4  field id          'adur'
        i32  value type        0=int, 1=real, 2=unreal, 3=string
        i32  level             leveled files only, see LEVELED
        i32  data pointer      leveled files only
        ...  value             4 bytes, or NUL-terminated for strings
        id4  end marker        repeats the object's id

Abilities, doodads and upgrades carry a level and a data pointer on every
modification; the other types do not.  Getting that wrong desynchronises the
parse, so parse() asserts it consumed the file exactly - trust a parse that
returns, and distrust field ids that look like text.

Names, tooltips and icons are absent from these files on Reforged maps: they
live in war3mapSkin.* (same format) and their values are 'TRIGSTR_<n>'
references into war3map.wts.  See wts.py.

Editing is deliberately in place.  set_value() overwrites the 4 bytes of a
numeric field and nothing else, so every unrelated byte survives untouched -
safer than reserialising a format whose edge cases we would have to guess.
Strings change length and so cannot be patched this way; edit the .wts entry
they point at instead, which is where the readable text actually is.
"""

import os
import struct

# Files whose modifications carry a level and a data pointer.
LEVELED = {'.w3a', '.w3d', '.w3q'}

INT, REAL, UNREAL, STRING = 0, 1, 2, 3


class Mod:
    """One changed field of one object."""

    def __init__(self, id, type, level, ptr, value, offset, end):
        self.id = id
        self.type = type
        self.level = level
        self.ptr = ptr
        self.value = value
        self.offset = offset  # where the value sits in the file, for patching
        # The 4 bytes trailing every modification. The format calls this the
        # object's id repeated, but maps in the wild write zeroes instead, so
        # keep whatever was there rather than regenerating it.
        self.end = end

    def __repr__(self):
        lvl = ' lvl=%d' % self.level if self.level else ''
        return '<%s%s = %r>' % (self.id, lvl, self.value)


class Set:
    """One block of modifications, with the object ids it applies to."""

    def __init__(self, ids, mods):
        self.ids = ids
        self.mods = mods


class Obj:
    """One object: a base id, a custom id, and the fields that were changed."""

    def __init__(self, table, base, custom, sets):
        self.table = table  # 0 = modified stock object, 1 = custom object
        self.base = base
        self.custom = custom
        self.sets = sets

    @property
    def mods(self):
        return [m for s in self.sets for m in s.mods]

    def add(self, field, level, value, like=None):
        """Add a field this object doesn't set yet.

        `like` is an existing Mod to copy the value type, data pointer and
        trailing bytes from - usually the same field at another level, which
        is the only reliable way to get those right.
        """
        if self.get(field, level):
            raise ValueError('%s already sets %s at level %d'
                             % (self.custom, field, level))
        template = like or (self.get(field) or [None])[0]
        if template is None:
            raise ValueError('no template for %s; pass like=' % field)
        mod = Mod(field, template.type, level, template.ptr, value, None,
                  template.end)
        self.sets[0].mods.append(mod)
        return mod

    def get(self, field, level=None):
        """Every modification of `field`, optionally at one level."""
        return [m for m in self.mods
                if m.id == field and (level is None or m.level == level)]

    def values(self, field):
        """The distinct values `field` takes across all levels."""
        return sorted(set(m.value for m in self.get(field)))

    def strings(self):
        return [m.value for m in self.mods if m.type == STRING]

    def __repr__(self):
        return '<Obj %s -> %s, %d mods>' % (self.base, self.custom, len(self.mods))


class ObjectData:
    """A parsed object-data file, still holding its original bytes."""

    def __init__(self, path, version, objects, data, leveled):
        self.path = path
        self.version = version
        self.objects = objects
        self.data = bytearray(data)
        self.leveled = leveled

    def find(self, base=None, custom=None, field=None, string=None):
        """Objects matching every filter given.

        base/custom match ids exactly; field keeps objects that changed that
        field; string keeps objects with a string field containing it.
        """
        out = []
        for o in self.objects:
            if base is not None and o.base != base:
                continue
            if custom is not None and o.custom != custom:
                continue
            if field is not None and not o.get(field):
                continue
            if string is not None and not any(string.lower() in s.lower()
                                              for s in o.strings()):
                continue
            out.append(o)
        return out

    def set_value(self, mod, value):
        """Overwrite one numeric field in place. Returns the previous value."""
        if mod.type == STRING:
            raise ValueError('%s is a string; edit its .wts entry instead' % mod.id)
        fmt = '<i' if mod.type == INT else '<f'
        old = struct.unpack_from(fmt, self.data, mod.offset)[0]
        struct.pack_into(fmt, self.data, mod.offset,
                         int(value) if mod.type == INT else float(value))
        mod.value = value
        return old

    def serialize(self):
        """Rebuild the whole file from the parsed objects.

        Only needed when fields were added, since that changes the length.
        Reserialising an untouched file reproduces it byte for byte - assert
        that (see round_trips()) before trusting the output of a real edit.
        """
        out = bytearray(struct.pack('<I', self.version))
        for table in (0, 1):
            objs = [o for o in self.objects if o.table == table]
            out += struct.pack('<I', len(objs))
            for o in objs:
                out += o.base.encode('latin-1') + o.custom.encode('latin-1')
                if self.version >= 3:
                    out += struct.pack('<I', len(o.sets))
                for s in o.sets:
                    if self.version >= 3:
                        out += struct.pack('<I', len(s.ids))
                        for id in s.ids:
                            out += id.encode('latin-1')
                    out += struct.pack('<I', len(s.mods))
                    for m in s.mods:
                        out += m.id.encode('latin-1') + struct.pack('<I', m.type)
                        if self.leveled:
                            out += struct.pack('<ii', m.level, m.ptr)
                        if m.type == INT:
                            out += struct.pack('<i', int(m.value))
                        elif m.type == STRING:
                            out += m.value.encode('latin-1') + b'\0'
                        else:
                            out += struct.pack('<f', float(m.value))
                        out += m.end.encode('latin-1')
        return bytes(out)

    def round_trips(self):
        """True if reserialising reproduces the file exactly as it was read."""
        return self.serialize() == bytes(self.data)

    def save(self, path=None, rebuild=False):
        """Write the file back.

        By default this writes the patched original bytes, so a numeric edit
        touches only the bytes it changed. `rebuild` reserialises instead,
        which is what added fields require.
        """
        out = path or self.path
        with open(out, 'wb') as fh:
            fh.write(self.serialize() if rebuild else bytes(self.data))
        return out


def parse(path, leveled=None):
    """Parse an object-data file. `leveled` defaults to the extension's rule."""
    if leveled is None:
        leveled = os.path.splitext(path)[1].lower() in LEVELED
    data = open(path, 'rb').read()
    pos = 0

    def num(fmt, size):
        nonlocal pos
        v = struct.unpack_from(fmt, data, pos)[0]
        pos += size
        return v

    def id4():
        nonlocal pos
        v = data[pos:pos + 4].decode('latin-1')
        pos += 4
        return v

    def cstr():
        nonlocal pos
        end = data.index(b'\0', pos)
        v = data[pos:end].decode('latin-1')
        pos = end + 1
        return v

    version = num('<I', 4)
    objects = []
    for table in range(2):
        for _ in range(num('<I', 4)):
            base, custom = id4(), id4()
            sets = []
            for _ in range(num('<I', 4) if version >= 3 else 1):
                ids, mods = [], []
                if version >= 3:
                    for _ in range(num('<I', 4)):  # ids this set applies to
                        ids.append(id4())
                for _ in range(num('<I', 4)):
                    field, vtype = id4(), num('<I', 4)
                    level = num('<i', 4) if leveled else 0
                    ptr = num('<i', 4) if leveled else 0
                    offset = pos
                    if vtype == INT:
                        value = num('<i', 4)
                    elif vtype in (REAL, UNREAL):
                        value = num('<f', 4)
                    elif vtype == STRING:
                        value = cstr()
                    else:
                        raise ValueError('bad value type %d at byte %d - wrong '
                                         '`leveled` for this file?' % (vtype, pos))
                    mods.append(Mod(field, vtype, level, ptr, value, offset,
                                    id4()))
                sets.append(Set(ids, mods))
            objects.append(Obj(table, base, custom, sets))

    assert pos == len(data), 'parsed %d of %d bytes' % (pos, len(data))
    return ObjectData(path, version, objects, data, leveled)


def _main(argv):
    import argparse

    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('file')
    ap.add_argument('--base', help='keep objects derived from this id')
    ap.add_argument('--id', dest='custom', help='keep this object id')
    ap.add_argument('--field', help='keep objects that changed this field')
    ap.add_argument('--string', help='keep objects with a string field containing this')
    ap.add_argument('--set', dest='value', help='set --field on the matched objects '
                                                '(requires --base, --id or --string)')
    args = ap.parse_args(argv)

    od = parse(args.file)
    print('version %d, %d objects' % (od.version, len(od.objects)))
    matched = od.find(args.base, args.custom, args.field, args.string)

    if args.value is None:
        for o in matched:
            print('=== %s -> %s (table %d)' % (o.base, o.custom, o.table))
            mods = o.get(args.field) if args.field else o.mods
            for m in sorted(mods, key=lambda m: (m.id, m.level)):
                print('   %s lvl=%-2d = %r' % (m.id, m.level, m.value))
        return 0

    if not args.field or not (args.base or args.custom or args.string):
        ap.error('--set needs --field and at least one of --base/--id/--string')
    changed = 0
    for o in matched:
        for m in o.get(args.field):
            old = od.set_value(m, float(args.value))
            print('   %s %s lvl=%-2d  %r -> %s' % (o.custom, m.id, m.level, old, args.value))
            changed += 1
    if changed:
        od.save()
    print('patched %d fields in %d objects' % (changed, len(matched)))
    return 0


if __name__ == '__main__':
    import sys
    raise SystemExit(_main(sys.argv[1:]))
