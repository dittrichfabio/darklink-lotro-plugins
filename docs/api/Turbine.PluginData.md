# `Turbine.PluginData`

Provides the ability to save and load plugin data.

This class provides a data store for loading and saving plugin data the is represented by a Lua table. This data can be stored to keys chosen by the plugins and then loaded later to allow a persistent store for information and settings.

## Methods

### `Load()`

Loads plugin data from a given key.

```lua
function PluginData.Load(dataScope, key, dataLoadEventHandler);
```

**Parameters:**

- `dataScope` (`number`) — The scope of the data. Data scope can be specified to an Account, a Server, or to a specific Character.
- `key` (`string`) — The key the data is stored under.
- `dataLoadEventHandler` ([Object](Turbine.Object.md)) — A function that is called when the data loaded.

**Returns:** [Object](Turbine.Object.md) — The loaded data. If the data does not exist, this will simply return nil.

This method deserializes object data. If the data is immediately available it will be returned. If the data is not immediately available this will return nil and the data loaded handler will be invoked later once the data is available.

### `Save()`

Saves plugin data under a given key.

```lua
function PluginData.Save(dataScope, key, data, saveCompleteEventHandler);
```

**Parameters:**

- `dataScope` (`number`) — The scope of the data. This specifies the level of availability of this data when loading. Data scope can be specified to an Account, a Server, or to a specific Character.
- `key` (`string`) — The key to store the data under.
- `data` ([Object](Turbine.Object.md)) — The data to save.
- `saveCompleteEventHandler` ([Object](Turbine.Object.md)) — Event handler called when the data is saved. It has two arguments, the first specifies if the save succeeded and the second is a message if it failed.

This method serializes the object data passed to the specified key. Any existing data is replaced with the new data.

