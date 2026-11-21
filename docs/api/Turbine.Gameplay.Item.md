# `Turbine.Gameplay.Item`

An item that a user can have.

This class represents an in-game item that can be obtained and stored in inventory.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Entity` → **Turbine.Gameplay.Item**

## Methods

### `GetItemInfo()`

Gets information about the item.

```lua
function Item:GetItemInfo();
```

**Returns:** [ItemInfo](Turbine.Gameplay.ItemInfo.md) — Information about the item.

Gets information about the item. This information can be used to get things like the item name and description.

*Methods inherited from base classes:*

- `GetName` — Gets the name of the entity.
- `IsLocalPlayer` — Returns true if this entity is the local player entity. (Deprecated).


## Events

*Events inherited from base classes:*

- `NameChanged` — Event fired when the actor's name changes.

