# StatsExporter

A plugin for [The Lord of the Rings Online](https://www.lotro.com) that exports
your character's combat statistics (and, in progress, items) to JSON files via
the game's Turbine/Lua API.

## What it does

The plugin shows a floating window ("Character Stats Exporter") with buttons to:

- **Export Character Stats to File** — collects class, level, morale, power,
  armour, the five attributes (Might, Agility, Vitality, Will, Fate),
  critical/mastery/mitigation ratings, and in/out-of-combat regeneration, then
  saves them as JSON with `Turbine.PluginData.Save` scoped to the current
  character.
- **Export Items to File** — partially implemented. The window includes an item
  quickslot that accepts dragged items; the export handler is not yet wired up.

## Project layout

- `StatsExporter.plugin` — plugin manifest (name, author, version, entry point).
- `src/main.lua` — the plugin source, loaded as `StatsExporter.src.main`.
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
  reference (also gitignored).

Both `docs/` subdirectories are documentation only and not needed at runtime.

## Development

Plugins are Lua scripts executed inside the game client. To test changes, copy
the plugin directory into the game's `Plugins` folder and reload plugins
in-game. There is no build step — `src/main.lua` is plain Lua.
