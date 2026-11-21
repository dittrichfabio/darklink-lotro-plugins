# `Turbine.Gameplay.Bank`

A container of items that are only accessible at designated bank locations.

A container of items that are only accessible at designated bank locations. The contents of a bank can only be used while interacting with a banker. When a banker is not available the various methods will return default values and the items will not be available.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.Bank** → `Turbine.Gameplay.SharedStorage` → `Turbine.Gameplay.Vault`

## Methods

### `GetCapacity()`

Gets the number of items that the bank can hold.

```lua
function Bank:GetCapacity();
```

**Returns:** `number` — The number of items that the bank can hold.

### `GetChestCount()`

Gets the number of chest that are available.

```lua
function Bank:GetChestCount();
```

**Returns:** `number` — The number of chest that are available.

### `GetChestName()`

Gets the name of a chest.

```lua
function Bank:GetChestName(chestType);
```

**Parameters:**

- `chestType` (`(Unrecognized type)`)

**Returns:** `string` — The name of the specified chest.

### `GetCount()`

Gets the numbers of items in the bank.

```lua
function Bank:GetCount();
```

**Returns:** `number` — The number of items in the bank.

### `GetItem()`

Gets and item from the player's bank.

```lua
function Bank:GetItem(index);
```

**Parameters:**

- `index` (`number`) — The index of the item to get.

**Returns:** `(Unrecognized type)` — Either nil if there is no item there or the index is invalid, or the Item that is in the given index.

This method will return an Item out of the player's bank at the specified index. The index must be in the range of 1 to GetCount.

### `IsAvailable()`

Gets a flag indicating if the bank is currently available.

```lua
function Bank:IsAvailable();
```

**Returns:** `boolean`

Gets a flag indicating if the bank is currently available. The availability of the bank follows the game rules and requires that a player be talking to a banker. When a player does not meet the requirements, the methods will return 0 or nil and the events will not fire.

### `PerformShortcutDrop()`

Handles the dropping of items into a bank.

```lua
function Bank:PerformShortcutDrop(shortcut, targetChest, split);
```

**Parameters:**

- `shortcut` ([Shortcut](Turbine.UI.Lotro.Shortcut.md)) — The shortcut information that was generated as part of a drag and drop event that should contain an item to perform an action on.
- `targetChest` (`(Unrecognized type)`) — The target chest the drop should occur into.
- `split` (`boolean`) — Flag indicating if the item split dialog should be displayed for the operation.


## Events

### `CapacityChanged`

Event fired when the capacity of the bank has changed.

```lua
function Bank:CapacityChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ChestNameChanged`

Event fired when the name of a chest has changed.

```lua
function Bank:ChestNameChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `CountChanged`

Event fired when the count of items in the bank changes.

```lua
function Bank:CountChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsAvailableChanged`

Event fired when the availability of the bank changes.

```lua
function Bank:IsAvailableChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ItemAdded`

Event fired when an item is added to a bank.

```lua
function Bank:ItemAdded(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ItemMoved`

Event fired when an item is moved from one chest to another.

```lua
function Bank:ItemMoved(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ItemRemoved`

Event fired when an item is removed from a bank.

```lua
function Bank:ItemRemoved(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ItemsRefreshed`

Event fired when the contents of the bank has been refreshed.

```lua
function Bank:ItemsRefreshed(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

