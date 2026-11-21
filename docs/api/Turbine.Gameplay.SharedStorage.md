# `Turbine.Gameplay.SharedStorage`

A bank that represents the player's shared storage. This storage is available to all characters on the same account.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.Bank` → **Turbine.Gameplay.SharedStorage**

## Methods

*Methods inherited from base classes:*

- `GetCapacity` — Gets the number of items that the bank can hold.
- `GetChestCount` — Gets the number of chest that are available.
- `GetChestName` — Gets the name of a chest.
- `GetCount` — Gets the numbers of items in the bank.
- `GetItem` — Gets and item from the player's bank.
- `IsAvailable` — Gets a flag indicating if the bank is currently available.
- `PerformShortcutDrop` — Handles the dropping of items into a bank.


## Events

*Events inherited from base classes:*

- `CapacityChanged` — Event fired when the capacity of the bank has changed.
- `ChestNameChanged` — Event fired when the name of a chest has changed.
- `CountChanged` — Event fired when the count of items in the bank changes.
- `IsAvailableChanged` — Event fired when the availability of the bank changes.
- `ItemAdded` — Event fired when an item is added to a bank.
- `ItemMoved` — Event fired when an item is moved from one chest to another.
- `ItemRemoved` — Event fired when an item is removed from a bank.
- `ItemsRefreshed` — Event fired when the contents of the bank has been refreshed.

