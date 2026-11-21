# `Turbine.Gameplay.Attributes.GuardianAttributes`

Provides class information for the Guardian player class.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → `Turbine.Gameplay.ClassAttributes` → **Turbine.Gameplay.Attributes.GuardianAttributes**

## Methods

### `GetStance()`

Gets the current stance.

```lua
function GuardianAttributes:GetStance();
```

**Returns:** `number` — The current stance.

### `IsBlockTier1Available()`

Returns true if the first tier block skills are usable.

```lua
function GuardianAttributes:IsBlockTier1Available();
```

**Returns:** `boolean` — True if the first tier block skills are usable.

### `IsBlockTier2Available()`

Returns true if the second tier block skills are usable.

```lua
function GuardianAttributes:IsBlockTier2Available();
```

**Returns:** `boolean` — True if the second tier block skills are usable.

### `IsBlockTier3Available()`

Returns true if the third tier block skills are usable.

```lua
function GuardianAttributes:IsBlockTier3Available();
```

**Returns:** `boolean` — True if the third tier block skills are usable.

### `IsParryTier1Available()`

Returns true if the first tier parry skills are usable.

```lua
function GuardianAttributes:IsParryTier1Available();
```

**Returns:** `boolean` — True if the first tier parry skills are usable.

### `IsParryTier2Available()`

Returns true if the second tier parry skills are usable.

```lua
function GuardianAttributes:IsParryTier2Available();
```

**Returns:** `boolean` — True if the second tier parry skills are usable.

### `IsParryTier3Available()`

Returns true if the third tier parry skills are usable.

```lua
function GuardianAttributes:IsParryTier3Available();
```

**Returns:** `boolean` — True if the third tier parry skills are usable.


## Events

### `IsBlockTier1AvailableChanged`

Event fired when the block tier 1 availability has changed.

```lua
function GuardianAttributes:IsBlockTier1AvailableChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsBlockTier2AvailableChanged`

Event fired when the block tier 2 availability has changed.

```lua
function GuardianAttributes:IsBlockTier2AvailableChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsBlockTier3AvailableChanged`

Event fired when the block tier 2 availability has changed.

```lua
function GuardianAttributes:IsBlockTier3AvailableChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsParryTier1AvailableChanged`

Event fired when the parry tier 1 availability has changed.

```lua
function GuardianAttributes:IsParryTier1AvailableChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsParryTier2AvailableChanged`

Event fired when the parry tier 2 availability has changed.

```lua
function GuardianAttributes:IsParryTier2AvailableChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsParryTier3AvailableChanged`

Event fired when the parry tier 2 availability has changed.

```lua
function GuardianAttributes:IsParryTier3AvailableChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `StanceChanged`

Event fired when the stance changes.

```lua
function GuardianAttributes:StanceChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

