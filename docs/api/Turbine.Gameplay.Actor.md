# `Turbine.Gameplay.Actor`

Base class for any entity that interacts in the world.

Actors include things from players to NPCs to monsters, anything that can interact with other parts of the world.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Entity` → **Turbine.Gameplay.Actor** → `Turbine.Gameplay.Pet` → `Turbine.Gameplay.Player`

## Methods

### `GetBaseMaxMorale()`

Gets the base max morale of the actor.

```lua
function Actor:GetBaseMaxMorale();
```

**Returns:** `number` — The base max morale of the actor.

### `GetBaseMaxPower()`

Gets the base max power of the actor.

```lua
function Actor:GetBaseMaxPower();
```

**Returns:** `number` — The base max power of the actor.

### `GetEffects()`

Gets the effects on the actor.

```lua
function Actor:GetEffects();
```

**Returns:** [EffectList](Turbine.Gameplay.EffectList.md) — The list of effects.

### `GetLevel()`

Gets the level of the actor.

```lua
function Actor:GetLevel();
```

**Returns:** `number` — The level of the actor.

### `GetMaxMorale()`

Gets the max morale of the actor.

```lua
function Actor:GetMaxMorale();
```

**Returns:** `number` — The max morale of the actor.

### `GetMaxPower()`

Gets the max power of the actor.

```lua
function Actor:GetMaxPower();
```

**Returns:** `number` — The max power of the actor.

### `GetMaxTemporaryMorale()`

Gets the maximum temporary morale of the actor.

```lua
function Actor:GetMaxTemporaryMorale();
```

**Returns:** `number` — The maximum temporary morale of the actor.

### `GetMaxTemporaryPower()`

Gets the max temporary power of the actor.

```lua
function Actor:GetMaxTemporaryPower();
```

**Returns:** `number` — The max temporary power of the actor.

### `GetMorale()`

Gets the current morale of the actor.

```lua
function Actor:GetMorale();
```

**Returns:** `number` — The current morale of the actor.

### `GetPower()`

Gets the current power of the actor.

```lua
function Actor:GetPower();
```

**Returns:** `number` — The current power of the actor.

### `GetTarget()`

Gets the actor's target.

```lua
function Actor:GetTarget();
```

**Returns:** [Entity](Turbine.Gameplay.Entity.md) — The target.

### `GetTemporaryMorale()`

Gets the temporary morale of the actor.

```lua
function Actor:GetTemporaryMorale();
```

**Returns:** `number` — The temporary morale of the actor.

### `GetTemporaryPower()`

Gets the temporary power of the actor.

```lua
function Actor:GetTemporaryPower();
```

**Returns:** `number` — The temporary power of the actor.

*Methods inherited from base classes:*

- `GetName` — Gets the name of the entity.
- `IsLocalPlayer` — Returns true if this entity is the local player entity. (Deprecated).


## Events

### `BaseMaxMoraleChanged`

Event fired when the actor's base max morale changes.

```lua
function Actor:BaseMaxMoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `BaseMaxPowerChanged`

Event fired when he actor's base max power changes.

```lua
function Actor:BaseMaxPowerChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `LevelChanged`

Event fired when the actor's level changes.

```lua
function Actor:LevelChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MaxMoraleChanged`

Event fired when the actor's max morale changes.

```lua
function Actor:MaxMoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MaxPowerChanged`

Event fired when he actor's max power changes.

```lua
function Actor:MaxPowerChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MaxTemporaryMoraleChanged`

Event fired when the actor's max temporary morale changes.

```lua
function Actor:MaxTemporaryMoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MaxTemporaryPowerChanged`

Event fired when he actor's max temporary power changes.

```lua
function Actor:MaxTemporaryPowerChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MoraleChanged`

Event fired when the actor's morale changes.

```lua
function Actor:MoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `PowerChanged`

Event fired when he actor's power changes.

```lua
function Actor:PowerChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `TargetChanged`

Event fired when the actor's target changes.

```lua
function Actor:TargetChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `TemporaryMoraleChanged`

Event fired when the actor's temporary morale changes.

```lua
function Actor:TemporaryMoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `TemporaryPowerChanged`

Event fired when he actor's temporary power changes.

```lua
function Actor:TemporaryPowerChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

*Events inherited from base classes:*

- `NameChanged` — Event fired when the actor's name changes.

