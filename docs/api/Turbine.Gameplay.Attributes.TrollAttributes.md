# `Turbine.Gameplay.Attributes.TrollAttributes`

Provides class information for the Black Arrow monster class.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → `Turbine.Gameplay.ClassAttributes` → **Turbine.Gameplay.Attributes.TrollAttributes**

## Methods

### `GetRampage()`

Gets the current rampage of a Troll.

```lua
function TrollAttributes:GetRampage();
```

**Returns:** `number` — The current rampage of a Troll.


## Events

### `RampageChanged`

Event fired when the rampage of a Troll has changed.

```lua
function TrollAttributes:RampageChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

