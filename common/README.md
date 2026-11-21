# common/

Shared Lua code usable by every plugin in `plugins/`.

Deploys to the game's `Plugins/Common/` folder. Any `.lua` file (or
subfolder of files) placed here can be imported by a plugin:

```lua
import "Common.Json";   -- -> Plugins/Common/Json.lua
```

Keep shared code free of plugin-specific state — each plugin runs in its own
apartment and loads its own copy of these files.

Note: this works because the whole repo deploys together. If a plugin is ever
published standalone, bundle the shared files it needs inside its own plugin
folder instead (e.g. `plugins/X/lib/`, imported as `X.lib.Y`), since end users
won't have `Plugins/Common/` installed.
