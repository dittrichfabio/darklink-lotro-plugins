# `Turbine.Gameplay.Attributes.MinstrelAttributes`

Provides class information for the Minstrel player class.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → `Turbine.Gameplay.ClassAttributes` → **Turbine.Gameplay.Attributes.MinstrelAttributes**

## Methods

### `GetStance()`

Gets the current stance.

```lua
function MinstrelAttributes:GetStance();
```

**Returns:** `number` — The current stance.

### `IsSerenadeTier1Available()`

Returns true if the first tier serenade skills are usable.

```lua
function MinstrelAttributes:IsSerenadeTier1Available();
```

**Returns:** `boolean` — True if the first tier serenade skills are usable.

### `IsSerenadeTier2Available()`

Returns true if the second tier serenade skills are usable.

```lua
function MinstrelAttributes:IsSerenadeTier2Available();
```

**Returns:** `boolean` — True if the second tier serenade skills are usable.

### `IsSerenadeTier3Available()`

Returns true if the third tier serenade skills are usable.

```lua
function MinstrelAttributes:IsSerenadeTier3Available();
```

**Returns:** `boolean` — True if the third tier serenade skills are usable.


## Events

### `IsSerenadeTier1Changed`

Event fired when the serenade tier 1 availability has changed.

```lua
function MinstrelAttributes:IsSerenadeTier1Changed(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsSerenadeTier2Changed`

Event fired when the serenade tier 2 availability has changed.

```lua
function MinstrelAttributes:IsSerenadeTier2Changed(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsSerenadeTier3Changed`

Event fired when the serenade tier 2 availability has changed.

```lua
function MinstrelAttributes:IsSerenadeTier3Changed(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `StanceChanged`

Event fired when the stance changes.

```lua
function MinstrelAttributes:StanceChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

