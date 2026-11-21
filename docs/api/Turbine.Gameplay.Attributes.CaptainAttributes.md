# `Turbine.Gameplay.Attributes.CaptainAttributes`

Provides class information for the Captain player class.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → `Turbine.Gameplay.ClassAttributes` → **Turbine.Gameplay.Attributes.CaptainAttributes**

## Methods

### `IsInEnemyDefeatResponse()`

Returns true if the champion is ready to respond to defeating an enemy.

```lua
function CaptainAttributes:IsInEnemyDefeatResponse();
```

**Returns:** `boolean` — True if the champion is ready to respond to defeating an enemy.

### `IsInFellowDefeatResponse()`

Returns true if the champion is ready to respond to a fellow being defeated.

```lua
function CaptainAttributes:IsInFellowDefeatResponse();
```

**Returns:** `boolean` — True if the champion is ready to respond to a fellow being defeated.

### `IsReadiedTier1Available()`

Returns true if the first tier readied skills are usable.

```lua
function CaptainAttributes:IsReadiedTier1Available();
```

**Returns:** `boolean` — True if the first tier readied skills are usable.

### `IsReadiedTier2Available()`

Returns true if the second tier readied skills are usable.

```lua
function CaptainAttributes:IsReadiedTier2Available();
```

**Returns:** `boolean` — True if the second tier readied skills are usable.


## Events

### `IsInEnemyDefeatResponseChanged`

Event fired when the enemy defeat response changes.

```lua
function CaptainAttributes:IsInEnemyDefeatResponseChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsInFellowDefeatResponseChanged`

Event fired when the fellow defeat response changes.

```lua
function CaptainAttributes:IsInFellowDefeatResponseChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsReadiedTier1Changed`

Event fired when the readied tier 1 availability has changed.

```lua
function CaptainAttributes:IsReadiedTier1Changed(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsReadiedTier2Changed`

Event fired when the readied tier 2 availability has changed.

```lua
function CaptainAttributes:IsReadiedTier2Changed(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

