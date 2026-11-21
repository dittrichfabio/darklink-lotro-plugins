# common/

Shared Lua code usable by every plugin in `plugins/`.

Deploys to the game's `Plugins/Common/` folder. Any `.lua` file (or
subfolder of files) placed here can be imported by a plugin:

```lua
import "Common.Json";   -- -> Plugins/Common/Json.lua
```

Important: Turbine's `import` scopes each file's globals under its package
namespace — the folder path *is* the namespace. Symbols defined in
`Common/ItemLinkDecode/Decode.lua` are reachable as
`Common.ItemLinkDecode.<symbol>`, never as bare globals:

```lua
import "Common.ItemLinkDecode";
local DecodeLinkData = Common.ItemLinkDecode.DecodeLinkData;
```

Keep shared code free of plugin-specific state — each plugin runs in its own
apartment and loads its own copy of these files.

## Contents

- `ItemLinkDecode/` — vendored copy of Equendil's "Item Links Decoding"
  library ([lotrointerface.com info844](https://www.lotrointerface.com/downloads/info844-ItemLinksDecoding.html)),
  re-pathed to `Common.ItemLinkDecode.*`. Decodes
  `<ExamineItemInstance:ItemInfo:*>` and `<ExamineIA:IAInfo:*>` item links
  captured from chat via `Turbine.Chat.Received`. The link data is a
  zlib-compressed binary blob containing the item's instance/generic IDs,
  true level, equip level, armour value, worth, binding, crafter name, and
  — for legendary items — legacies, relics, stat IDs, and damage info.
  Provides a pure-Lua zlib inflater (`ZlibDeflate`) plus
  `TurbineUTF8Binary` (LOTRO's `\u01xx` binary-as-text encoding) and
  `bit32` bit-field helpers, all reusable on their own. Entry point:
  `Common.ItemLinkDecode.DecodeLinkData(data, isLI)`.

Note: this works because the whole repo deploys together. If a plugin is ever
published standalone, bundle the shared files it needs inside its own plugin
folder instead (e.g. `plugins/X/lib/`, imported as `X.lib.Y`), since end users
won't have `Plugins/Common/` installed.
