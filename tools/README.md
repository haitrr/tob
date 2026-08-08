# Map data tools

Helpers for reading and editing the map's data files without opening the World
Editor. `war3map.j` holds the triggers, but ability and unit numbers — damage,
cooldowns, durations — live in binary object-data tables, and the text that
describes them lives somewhere else again. These scripts read all three.

Plain Python 3, no dependencies.

| File | What it handles |
| --- | --- |
| `w3obj.py` | Object data: `war3map.w3a` (abilities), `.w3t` (items), `.w3u` (units), `war3mapSkin.w3a`, … |
| `wts.py` | `war3map.wts`, the string table behind every name and tooltip |

## Where a value actually lives

Three files hold three different halves of the same ability, and mixing them up
is the main way to reach a wrong answer:

- **`war3map.w3a`** — gameplay numbers. Durations, mana costs, damage. This is
  what the game actually runs.
- **`war3mapSkin.w3a`** — names, tooltips, icons, hotkeys. Reforged split these
  out; `war3map.w3a` contains no text fields at all. Their values are not text
  either, but `TRIGSTR_<n>` references.
- **`war3map.wts`** — the strings those references point at.

So a tooltip is three hops from its number, and the last hop is often a
`<ability,field>` reference the game resolves at load time.

## Reading

```sh
# every ability derived from the stock Summon Quilbeast, duration fields only
python3 tools/w3obj.py slash1.26/war3map.w3a --base ANsq --field adur

# one object, everything about it
python3 tools/w3obj.py slash1.26/war3map.w3a --id A0DY

# which objects mention a unit id (finds the abilities that summon quilbeasts)
python3 tools/w3obj.py slash1.26/war3map.w3a --string nqb

# the tooltips for that ability, found by the comment the World Editor left
python3 tools/wts.py slash1.26/war3map.wts --comment "A0DY"
python3 tools/wts.py slash1.26/war3map.wts --id 1145
```

`w3obj.py` picks the right record layout from the file extension — abilities,
doodads and upgrades store a level per field, other types don't — and asserts
that it consumed the file to the last byte. A parse that returns is a parse
that lined up.

## Writing

Numeric fields are patched in place: only those four bytes change, so the file
length and every unrelated byte stay identical. That is worth more than a
clean round trip through a format whose edge cases we'd be guessing at.

```sh
# every level of every hotkey variant, in one go
python3 tools/w3obj.py slash1.26/war3map.w3a --base ANsq --field adur --set 180
python3 tools/w3obj.py slash1.26/war3map.w3a --base ANsq --field ahdu --set 180
```

`--set` needs `--field` plus at least one of `--base` / `--id` / `--string`, so
a typo can't rewrite the whole file. Strings can't be patched this way — they'd
change length — so edit the `.wts` entry, which is where the readable text is:

```python
import sys; sys.path.insert(0, 'tools')
import wts

st = wts.parse('slash1.26/war3map.wts')
for e in st.find('A0DY', in_comment=True):
    st.set_text(e.id, e.text.replace('<ANsq,', '<A0DY,'))
st.save()   # edits applied back to front; BOM and line endings preserved
```

Commit the map files and check `git diff --stat` before pushing. A surgical
edit shows a small line count for `.wts`, and `Bin 1243457 -> 1243457 bytes`
for object data — a changed byte count means something went wrong.

## Two things that will mislead you

**One skill is seven objects.** Abilities are duplicated per hotkey, so Summon
Quilbeast is `A0DY`–`A0E4`, seven identical copies. Change one and six are
still wrong. Select by `--base`, never by a single id.

**Tooltips can point at the wrong ability.** `|nLasts <A0DY,Dur1> seconds.`
resolves to that ability's Duration at level 1 when the map loads. It looks
self-maintaining, and it is — but only if it names the map's own object. These
tooltips originally read `<ANsq,Dur1>`, the *stock* Beastmaster ability, so
they displayed 70s no matter what the map's own copy was set to, which is
indistinguishable from a stale hardcoded number. Before trusting a number in a
tooltip, check which id it reads from. Most of this map (2463 of 2726
references) correctly points at custom ids.

## Worked example: quilbeast duration, 50s → 180s

The path through all three files, which is roughly what any balance change
looks like:

1. `--string nqb` on `war3map.w3a` → seven abilities summon quilbeasts,
   `A0DY`–`A0E4`, all based on `ANsq`.
2. `--base ANsq --field adur` → 50.0 at all ten levels. `adur` is the duration
   for non-hero summoners, `ahdu` for heroes; both need setting or the lifespan
   depends on who cast it.
3. `--set 180` on both fields, 140 values across the seven copies.
4. `war3mapSkin.w3a` → the tooltips are `TRIGSTR_1145`…, and `wts.py --id 1145`
   → they read `<ANsq,Dur1>`, the stock ability. Repointed at the owning id so
   the text tracks the data from now on.

The unit itself has no duration field — a summon's lifespan comes entirely from
the summoning ability's `adur`/`ahdu`, which is what puts the expiration timer
on it. Nothing in `war3map.j` overrides it for these summons.

## Limits

- Reads files already extracted from the MPQ archive; it won't open a `.w3x`.
- In-place numeric edits only, by design. Adding or removing objects or fields
  needs a full serialiser, which this deliberately isn't.
- Field ids (`adur`, `Hwe1`, `amcs`) are World Editor internals; there's no
  table of them here. Look them up, or find them by dumping an object you
  already understand and matching values against the editor.
