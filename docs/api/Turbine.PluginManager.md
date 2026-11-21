# `Turbine.PluginManager`

Provides access to plugin management methods.

The plugin manager class allows scripts to obtain information about the set of available and loaded plugins. It also provides methods for dynamically loading and unloading plugins as well as obtain.There is a slight disconnect in the method used to load and unload plugins. Plugins are loaded by their plugin name but are unloaded by the script state they are loaded into. Multiple plugins can be loaded into the same script state and by doing this those plugins have the ability to share code and interact with each other whereas plugins loaded into separate script states will be forced to create copies of any loaded library and will not have the ability to access each other.During unload, an entire script state gets unloaded which will unload all of the plugins that have been loaded into that script state. It is important to keep in mind this disconnect.

**Inheritance:** **Turbine.PluginManager** → `Turbine.LotroPluginManager`

## Methods

### `GetAvailablePlugins()`

Gets the plugins that are currently available.

```lua
function PluginManager.GetAvailablePlugins();
```

**Returns:** [Object](Turbine.Object.md) — Returns a table containing the plugins that are currently available.

### `GetLoadedPlugins()`

Gets the plugins that are currently loaded.

```lua
function PluginManager.GetLoadedPlugins();
```

**Returns:** [Object](Turbine.Object.md) — Returns a table containing the currently loaded plugins

Gets the currently loaded plugins.

### `LoadPlugin()`

Loads the plugin that is requested.

```lua
function PluginManager.LoadPlugin(pluginName);
```

**Parameters:**

- `pluginName` (`string`) — The name of the plugin to load as specified in its plugin definition file.

Loads the plugin that is requested if it is available to load.

### `RefreshAvailablePlugins()`

Refreshes the list of available plugins.

```lua
function PluginManager.RefreshAvailablePlugins();
```

Refreshes the list of available plugins from disk. This does not force the unload of any plugins whose plugin definition file has been removed, but plugins whose plugin definition file has been removed will no longer be visible in the list of available plugins.

### `UnloadScriptState()`

Unloads the script state specified.

```lua
function PluginManager.UnloadScriptState(scriptState);
```

**Parameters:**

- `scriptState` (`string`) — The name of the script state to be unloaded.

Unloads the script state that is specified. Unloading a script state results in the unloading of every plugin that was loaded into that script state.The script state that is used to invoke this method cannot unload itself.

