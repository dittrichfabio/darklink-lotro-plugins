# `Turbine.Gameplay.Attributes.ChampionAttributes`

Provides class information for the Champion player class.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → `Turbine.Gameplay.ClassAttributes` → **Turbine.Gameplay.Attributes.ChampionAttributes**

## Methods

### `GetFervor()`

Gets the current fervor of a champion.

```lua
function ChampionAttributes:GetFervor();
```

**Returns:** `number` — The current fervor of a champion.

### `GetStance()`

Gets the current stance.

```lua
function ChampionAttributes:GetStance();
```

**Returns:** `number` — The current stance.


## Events

### `FervorChanged`

Event fired when the fervor of a champion has changed.

```lua
function ChampionAttributes:FervorChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `StanceChanged`

Event fired when the stance changes.

```lua
function ChampionAttributes:StanceChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

