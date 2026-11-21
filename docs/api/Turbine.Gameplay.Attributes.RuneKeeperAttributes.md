# `Turbine.Gameplay.Attributes.RuneKeeperAttributes`

Provides class information for the Rune-Keeper player class.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → `Turbine.Gameplay.ClassAttributes` → **Turbine.Gameplay.Attributes.RuneKeeperAttributes**

## Methods

### `GetAttunement()`

Gets the current attunement of a Rune-Keeper.

```lua
function RuneKeeperAttributes:GetAttunement();
```

**Returns:** `number` — The current attunement of a Rune-Keeper.

### `IsCharged()`

Returns true if the Rune-Keeper is charged.

```lua
function RuneKeeperAttributes:IsCharged();
```

**Returns:** `boolean` — True if the Rune-Keeper is charged.


## Events

### `AttunementChanged`

Event fired when the attunement of a Rune-Keeper has changed.

```lua
function RuneKeeperAttributes:AttunementChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsChargedChanged`

Event fired when the charge state of the Rune-Keeper changes.

```lua
function RuneKeeperAttributes:IsChargedChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

