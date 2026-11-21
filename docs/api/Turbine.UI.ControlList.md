# `Turbine.UI.ControlList`

Defines a list of controls.

This class is directly used by a Control class to maintain its list of child controls. From this list other controls can be added or removed as children of the owner control.

**Inheritance:** `Turbine.Object` → **Turbine.UI.ControlList**

## Methods

### `Add()`

Adds a menu item.

```lua
function ControlList:Add(item);
```

**Parameters:**

- `item` ([Control](Turbine.UI.Control.md)) — The menu item to add.

### `Clear()`

Clears the items from the list.

```lua
function ControlList:Clear();
```

### `Contains()`

Test is the list contains a specific menu item.

```lua
function ControlList:Contains(item);
```

**Parameters:**

- `item` ([Control](Turbine.UI.Control.md)) — The item to check for.

**Returns:** `boolean` — True if the item is contained in the list.

### `Get()`

Gets the item at the specified index.

```lua
function ControlList:Get(index);
```

**Parameters:**

- `index` (`number`) — The index of the item to retrieve.

**Returns:** [Control](Turbine.UI.Control.md) — The menu item at the specified index.

### `GetCount()`

Gets the number of menu items.

```lua
function ControlList:GetCount();
```

**Returns:** `number` — The number of menu items.

### `IndexOf()`

Gets the index of a menu item in the list.

```lua
function ControlList:IndexOf(item);
```

**Parameters:**

- `item` ([Control](Turbine.UI.Control.md)) — The item to get the index of.

**Returns:** `number` — The index of the item in the list or -1 if it does not exist in the list.

### `Insert()`

Inserts a menu item at a given index.

```lua
function ControlList:Insert(index, item);
```

**Parameters:**

- `index` (`number`) — The index to insert the item at.
- `item` ([Control](Turbine.UI.Control.md)) — The menu item to insert.

### `Remove()`

Removes a menu item from the list.

```lua
function ControlList:Remove(item);
```

**Parameters:**

- `item` ([Control](Turbine.UI.Control.md)) — The item to remove.

### `RemoveAt()`

Removes a menu item at the specified index.

```lua
function ControlList:RemoveAt(index);
```

**Parameters:**

- `index` (`number`) — The index of the item to remove.

### `Set()`

Sets the menu item at the specified index.

```lua
function ControlList:Set(index, item);
```

**Parameters:**

- `index` (`number`) — The index of the menu item to set.
- `item` ([Control](Turbine.UI.Control.md)) — The item to set.

