# `Turbine.Gameplay.Attributes.BurglarAttributes`

Provides class information for the Burglar player class.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → `Turbine.Gameplay.ClassAttributes` → **Turbine.Gameplay.Attributes.BurglarAttributes**

## Methods

### `GetStance()`

Gets the current stance.

```lua
function BurglarAttributes:GetStance();
```

**Returns:** `number` — The current stance.

### `IsCriticalTier1Available()`

Returns true if the first tier critical skills are usable.

```lua
function BurglarAttributes:IsCriticalTier1Available();
```

**Returns:** `boolean` — True if the first tier critical skills are usable.

### `IsCriticalTier2Available()`

Returns true if the second tier critical skills are usable.

```lua
function BurglarAttributes:IsCriticalTier2Available();
```

**Returns:** `boolean` — True if the second tier critical skills are usable.


## Events

### `IsCriticalTier1Changed`

Event fired when the critical tier 1 availability has changed.

```lua
function BurglarAttributes:IsCriticalTier1Changed(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsCriticalTier2Changed`

Event fired when the critical tier 2 availability has changed.

```lua
function BurglarAttributes:IsCriticalTier2Changed(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `StanceChanged`

Event fired when the stance changes.

```lua
function BurglarAttributes:StanceChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

