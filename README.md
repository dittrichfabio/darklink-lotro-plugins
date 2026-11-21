# darklink-lotro-plugins

A collection of plugins for
[The Lord of the Rings Online](https://www.lotro.com), written against the
game's Turbine/Lua API.

## Plugins

### StatsExporter

Exports your character's combat statistics and item info via
`Turbine.PluginData.Save` (scoped to the current character). Shows a floating
window ("Character Stats Exporter") on load; `/statsexport` in chat toggles it.

- **Export Character Stats to File** — collects class, level, morale, power,
  armour, the five attributes (Might, Agility, Vitality, Will, Fate),
  critical/mastery/mitigation ratings, and in/out-of-combat regeneration.
- **Add Item** / **Export Items to File** — drag an item onto the quickslot,
  click Add Item to queue it, then Export to save the queued items' info.

Note: `PluginData.Save` writes a `.plugindata` file under
`Documents\The Lord of the Rings\PluginData` containing a serialized **Lua
table** — not JSON. LotRO Lua cannot write arbitrary
files; the saved Lua table is the only export channel available.

## Project layout

- `plugins/<PluginName>/` — one self-contained folder per plugin (manifest,
  `src/`, `resources/`). Deploys to `Plugins/<PluginName>/`, so its
  `<Package>` entry stays `<PluginName>.src.main`.
- `common/` — shared Lua code, deployed to `Plugins/Common/` and imported as
  `import "Common.X"`. See `common/README.md`.
- `deploy.sh` — copies a plugin (plus `common/`) into the game's `Plugins`
  folder.
- `docs/api/` — the official Turbine API reference converted to Markdown, one
  file per type (e.g. `Turbine.Gameplay.Actor.md`) plus namespace overviews and
  a `README.md` index. Use these files as the API reference when implementing
  features. Regenerate with `python3 docs/generate_api_docs.py` (requires
  `beautifulsoup4`).
- `docs/OfficialLuaDocumentation/` — official HTML reference for the LotRO
  Turbine API (`Turbine`, `Turbine.Gameplay`, `Turbine.UI.Lotro`,
  `Turbine.PluginData`, ...), starting at `index.html`. This is the source for
  the generated `docs/api/` files. It is gitignored — re-download it from
  lotrointerface.com (links in "Before You Begin" in
  `docs/OtherReferences/writing-lotro-plugins-for-noobs-part1.md`) and extract
  here to regenerate the Markdown docs.
- `docs/OtherReferences/` — community guides parsed to Markdown
  (`writing-lotro-plugins-for-noobs-part1.md`, `...-part2.md`), from the LotRO
  forums thread "Writing LotRO Lua Plugins for Noobs". Covers plugin
  structure, the `.plugin` manifest, UI controls, scrollable windows, timers,
  and general Lua/Turbine tips. The original HTML is kept alongside for
  reference (also gitignored). Also includes
  `lotro-lua-plugin-api-songbook3.md`, a community-synthesized API reference
  from the Songbook3 repo covering patterns beyond the official docs.

Both `docs/` subdirectories are documentation only and not needed at runtime.

## Development

Plugins are Lua scripts executed inside the game client — there is no build
step. To test changes, deploy a plugin folder into the game's `Plugins`
directory (`Documents\The Lord of the Rings\Plugins`) and run
`/plugins refresh` in-game:

```sh
./deploy.sh StatsExporter "/mnt/c/Users/<you>/Documents/The Lord of the Rings/Plugins"
```

Or set `LOTRO_PLUGINS` once and just run `./deploy.sh StatsExporter`.

To start a new plugin, create `plugins/<NewName>/` with a `<NewName>.plugin`
manifest (`<Package>` pointing at `<NewName>.src.main`) and a `src/main.lua`
entry point.
