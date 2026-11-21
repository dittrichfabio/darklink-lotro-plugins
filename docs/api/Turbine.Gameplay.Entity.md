# `Turbine.Gameplay.Entity`

Base class for any entity in the game.

The base for any game entity.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → **Turbine.Gameplay.Entity** → `Turbine.Gameplay.Actor` → `Turbine.Gameplay.Item` → `Turbine.Gameplay.Mount`

## Methods

### `GetName()`

Gets the name of the entity.

```lua
function Entity:GetName();
```

**Returns:** `string` — The name of the entity.

### `IsLocalPlayer()`

Returns true if this entity is the local player entity. (Deprecated).

```lua
function Entity:IsLocalPlayer();
```

**Returns:** `boolean` — Whether this is the local player entity or not.

Returns true if this entity is the local player entity. (Deprecated)


## Events

### `NameChanged`

Event fired when the actor's name changes.

```lua
function Entity:NameChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

