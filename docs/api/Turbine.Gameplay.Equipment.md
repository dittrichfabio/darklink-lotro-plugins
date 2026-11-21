# `Turbine.Gameplay.Equipment`

Provides access to a player's equipment.

The equipment is the set of items the player is currently wearing. These items are accessed like an array with specific indices corresponding to specific inventory slots.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.Equipment**

## Methods

### `GetItem()`

Gets and item from the player's backpack.

```lua
function Equipment:GetItem(index);
```

**Parameters:**

- `index` (`number`) — The index of the item to get.

**Returns:** [Item](Turbine.Gameplay.Item.md) — Either nil if there is no item there or the index is invalid, or the Item that is in the given index.

This method will return an Item out of the player's equipment at the specified index. The index must be in the range of 1 to GetSize.

### `GetSize()`

Gets the number of items that can be equipped.

```lua
function Equipment:GetSize();
```

**Returns:** `number` — The number of items that can be equipped.


## Events

### `ItemEquipped`

Event fired when an item is equipped.

```lua
function Equipment:ItemEquipped(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ItemUnequipped`

Event fired when an item is unequipped.

```lua
function Equipment:ItemUnequipped(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

Whenever a player has an item equiped through user actions or game action, this event is fire. The event is fired prior to the item actually being removed in order to give plugins a chance to access the item data before it has been completely deleted. This means that iterating the equipment in an event handler for unequipping items will still return the item being unequipped. The Index field in the arguments table can be used to know which item was removed.

