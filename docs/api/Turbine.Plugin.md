# `Turbine.Plugin`

Provides information about a specific plugin that has been loaded.

A plugin class is created for every plugin that has been loaded. Plugins are registered into the global __plugins table by their name. To query all the plugins that are loaded, just iterate over that table.

**Inheritance:** `Turbine.Object` → **Turbine.Plugin**

## Methods

### `GetAuthor()`

Gets the author of the plugin.

```lua
function Plugin:GetAuthor();
```

**Returns:** `string` — The author of the plugin.

This method gets the author of the plugin that was specified in the plugin information file.

### `GetConfiguration()`

Gets the plugin configuration information.

```lua
function Plugin:GetConfiguration();
```

**Returns:** [Object](Turbine.Object.md) — The plugin's configuration.

This method returns a structure of information mapped out of the plugin information file under the configuration element.

### `GetName()`

Gets the name of the plugin.

```lua
function Plugin:GetName();
```

**Returns:** `string` — The name of the plugin.

This method gets the name of the plugin that was specified in the plugin information file.

### `GetVersion()`

Gets the version of the plugin.

```lua
function Plugin:GetVersion();
```

**Returns:** `string` — The version of the plugin.

This method gets the version of the plugin that was specified in the plugin information file.


## Events

### `Load`

Event fired when a plugin's main package has finished loading.

```lua
function Plugin:Load(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `Unload`

Event fired before a plugin is unloaded.

```lua
function Plugin:Unload(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

