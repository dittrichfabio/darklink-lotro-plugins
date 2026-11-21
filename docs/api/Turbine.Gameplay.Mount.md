# `Turbine.Gameplay.Mount`

Class representing an in game mount.

This is the base class for the different types of mounts available in the game.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Entity` → **Turbine.Gameplay.Mount** → `Turbine.Gameplay.BasicMount` → `Turbine.Gameplay.CombatMount`

## Methods

### `GetName()`

Gets the name of the entity.

```lua
function Mount:GetName();
```

**Returns:** `string` — The name of the entity.

*Methods inherited from base classes:*

- `GetName` — Gets the name of the entity.
- `IsLocalPlayer` — Returns true if this entity is the local player entity. (Deprecated).


## Events

*Events inherited from base classes:*

- `NameChanged` — Event fired when the actor's name changes.

