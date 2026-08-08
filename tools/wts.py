"""Read and edit war3map.wts, the map's string table.

Object data never stores readable text on Reforged maps.  A name or tooltip
is the string 'TRIGSTR_1145' in war3mapSkin.w3a, pointing at entry 1145 here.
The file is UTF-8 with a BOM, and each entry looks like:

    STRING 1145
    // Abilities: A0DY (Summon Quilbeast Q), Ubertip (Tooltip - Normal - Extended)
    {
    Summons 1 angry <nqb1,realHP> hit point quilbeast ... |nLasts <A0DY,Dur1> seconds.
    }

The comment records which object and field the World Editor wrote it for, so
it is the fastest way to find the text behind an id.

Tooltips rarely spell numbers out.  '<A0DY,Dur1>' means "the Duration field of
ability A0DY at level 1" and is resolved when the map loads, so text stays in
step with the object data - as long as it names the right object.  A tooltip
pointing at a stock id (`<ANsq,Dur1>`) keeps displaying the stock value however
often the map's own copy is rebalanced, which reads exactly like a stale
tooltip.  Suspect the reference before believing the number.

Edits are applied back to front so that earlier entries keep their offsets,
and the BOM and line endings are preserved.
"""

import re

# STRING <id>, optional comment lines, then the text between braces.
ENTRY = re.compile(r'^STRING (\d+)\r?\n(.*?)^\{\r?\n(.*?)\r?\n\}', re.S | re.M)


class Entry:
    def __init__(self, id, comment, text, span):
        self.id = id
        self.comment = comment
        self.text = text
        self.span = span  # where the text sits in the file, for editing

    def __repr__(self):
        return '<STRING %d %r>' % (self.id, self.text[:40])


class Strings:
    """A parsed string table, still holding its original text."""

    def __init__(self, path, raw, entries):
        self.path = path
        self.raw = raw
        self.entries = entries  # id -> Entry
        self._edits = {}

    def __getitem__(self, id):
        return self.entries[id]

    def get(self, id):
        return self.entries.get(id)

    def find(self, needle, in_comment=False):
        """Entries whose text - or comment - contains `needle`."""
        return [e for e in self.entries.values()
                if needle.lower() in (e.comment if in_comment else e.text).lower()]

    def set_text(self, id, text):
        """Queue a replacement for one entry's text."""
        self._edits[id] = text
        return self.entries[id].text

    def save(self, path=None):
        """Apply queued edits and write the file. Returns the number applied."""
        raw = self.raw
        for id in sorted(self._edits, key=lambda i: -self.entries[i].span[0]):
            start, end = self.entries[id].span
            raw = raw[:start] + self._edits[id] + raw[end:]
        with open(path or self.path, 'w', encoding='utf-8-sig', newline='') as fh:
            fh.write(raw)
        return len(self._edits)


def parse(path):
    raw = open(path, encoding='utf-8-sig', newline='').read()
    entries = {}
    for m in ENTRY.finditer(raw):
        entries[int(m.group(1))] = Entry(int(m.group(1)), m.group(2).strip(),
                                         m.group(3), m.span(3))
    return Strings(path, raw, entries)


def trigstr(value):
    """The entry id behind a 'TRIGSTR_1145' object-data value, or None."""
    return int(value.split('_')[1]) if str(value).startswith('TRIGSTR_') else None


def _main(argv):
    import argparse

    ap = argparse.ArgumentParser(description=__doc__.split('\n')[0])
    ap.add_argument('file')
    ap.add_argument('--id', type=int, action='append', help='show this entry')
    ap.add_argument('--text', help='show entries whose text contains this')
    ap.add_argument('--comment', help='show entries whose comment contains this, '
                                      'e.g. an ability id')
    args = ap.parse_args(argv)

    st = parse(args.file)
    print('%d entries' % len(st.entries))
    found = [st[i] for i in args.id or [] if i in st.entries]
    if args.text:
        found += st.find(args.text)
    if args.comment:
        found += st.find(args.comment, in_comment=True)
    for e in sorted(found, key=lambda e: e.id):
        print('--- STRING %d | %s\n%s' % (e.id, e.comment, e.text))
    return 0


if __name__ == '__main__':
    import sys
    raise SystemExit(_main(sys.argv[1:]))
