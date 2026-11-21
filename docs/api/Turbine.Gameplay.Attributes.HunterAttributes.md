# `Turbine.Gameplay.Attributes.HunterAttributes`

Provides class information for the Hunter player class.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → `Turbine.Gameplay.ClassAttributes` → **Turbine.Gameplay.Attributes.HunterAttributes**

## Methods

### `GetFocus()`

Gets the current focus of a hunter.

```lua
function HunterAttributes:GetFocus();
```

**Returns:** `number` — The current focus of a hunter.

### `GetStance()`

Gets the current stance.

```lua
function HunterAttributes:GetStance();
```

**Returns:** `number` — The current stance.


## Events

### `FocusChanged`

Event fired when the focus of a hunter has changed.

```lua
function HunterAttributes:FocusChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `StanceChanged`

Event fired when the stance changes.

```lua
function HunterAttributes:StanceChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

