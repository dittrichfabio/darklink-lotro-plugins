# `Turbine.UI.DragDropInfo`

Container for information about drag drop events.

This class is the base class for drag drop information classes that contain additional information for drag drop events.

**Inheritance:** `Turbine.Object` → **Turbine.UI.DragDropInfo** → `Turbine.UI.Lotro.DragDropInfo`

## Methods

### `IsSuccessful()`

```lua
function DragDropInfo:IsSuccessful();
```

**Returns:** `boolean` — True if the drag drop was successful.

Gets a flag indicating if the drag drop operation was successful.

### `SetSuccessful()`

```lua
function DragDropInfo:SetSuccessful(value);
```

**Parameters:**

- `value` (`boolean`) — True if the drag drop was successful.

Sets a flag indicating if the drag drop operation was successful.

