# `Turbine.LotroPluginManager`

Provides access to plugin management methods.

The plugin manager class allows scripts to obtain information about the set of available and loaded plugins. It also provides methods for dynamically loading and unloading plugins as well as obtain.There is a slight disconnect in the method used to load and unload plugins. Plugins are loaded by their plugin name but are unloaded by the script state they are loaded into. Multiple plugins can be loaded into the same script state and by doing this those plugins have the ability to share code and interact with each other whereas plugins loaded into separate script states will be forced to create copies of any loaded library and will not have the ability to access each other.During unload, an entire script state gets unloaded which will unload all of the plugins that have been loaded into that script state. It is important to keep in mind this disconnect.

**Inheritance:** `Turbine.PluginManager` → **Turbine.LotroPluginManager**

## Methods

### `ShowOptions()`

Displays the options panel for the specified plugin.

```lua
function LotroPluginManager.ShowOptions(plugin);
```

**Parameters:**

- `plugin` ([Plugin](Turbine.Plugin.md))

*Methods inherited from base classes:*

- `GetAvailablePlugins` — Gets the plugins that are currently available.
- `GetLoadedPlugins` — Gets the plugins that are currently loaded.
- `LoadPlugin` — Loads the plugin that is requested.
- `RefreshAvailablePlugins` — Refreshes the list of available plugins.
- `UnloadScriptState` — Unloads the script state specified.

