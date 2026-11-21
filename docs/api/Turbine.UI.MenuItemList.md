# `Turbine.UI.MenuItemList`

Defines a list of menu items.

**Inheritance:** `Turbine.Object` → **Turbine.UI.MenuItemList**

## Methods

### `Add()`

Adds a menu item.

```lua
function MenuItemList:Add(item);
```

**Parameters:**

- `item` ([MenuItem](Turbine.UI.MenuItem.md)) — The menu item to add.

### `Clear()`

Clears the items from the list.

```lua
function MenuItemList:Clear();
```

### `Contains()`

Test is the list contains a specific menu item.

```lua
function MenuItemList:Contains(item);
```

**Parameters:**

- `item` ([MenuItem](Turbine.UI.MenuItem.md)) — The item to check for.

**Returns:** `boolean` — True if the item is contained in the list.

### `Get()`

Gets the item at the specified index.

```lua
function MenuItemList:Get(index);
```

**Parameters:**

- `index` (`number`) — The index of the item to retrieve.

**Returns:** [MenuItem](Turbine.UI.MenuItem.md) — The menu item at the specified index.

### `GetCount()`

Gets the number of menu items.

```lua
function MenuItemList:GetCount();
```

**Returns:** `number` — The number of menu items.

### `IndexOf()`

Gets the index of a menu item in the list.

```lua
function MenuItemList:IndexOf(item);
```

**Parameters:**

- `item` ([MenuItem](Turbine.UI.MenuItem.md)) — The item to get the index of.

**Returns:** `number` — The index of the item in the list or -1 if it does not exist in the list.

### `Insert()`

Inserts a menu item at a given index.

```lua
function MenuItemList:Insert(index, item);
```

**Parameters:**

- `index` (`number`) — The index to insert the item at.
- `item` ([MenuItem](Turbine.UI.MenuItem.md)) — The menu item to insert.

### `Remove()`

Removes a menu item from the list.

```lua
function MenuItemList:Remove(item);
```

**Parameters:**

- `item` ([MenuItem](Turbine.UI.MenuItem.md)) — The item to remove.

### `RemoveAt()`

Removes a menu item at the specified index.

```lua
function MenuItemList:RemoveAt(index);
```

**Parameters:**

- `index` (`number`) — The index of the item to remove.

### `Set()`

Sets the menu item at the specified index.

```lua
function MenuItemList:Set(index, item);
```

**Parameters:**

- `index` (`number`) — The index of the menu item to set.
- `item` ([MenuItem](Turbine.UI.MenuItem.md)) — The item to set.

