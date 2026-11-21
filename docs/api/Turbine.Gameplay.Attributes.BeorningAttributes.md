# `Turbine.Gameplay.Attributes.BeorningAttributes`

Provides class information for the Beorning player class.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → `Turbine.Gameplay.ClassAttributes` → **Turbine.Gameplay.Attributes.BeorningAttributes**

## Methods

### `GetWrath()`

Gets the current wrath amount of a Beorning.

```lua
function BeorningAttributes:GetWrath();
```

**Returns:** `number` — The current wrath amount of a Beorning.

### `IsInBearForm()`

Returns true if the Beorning is in bear form.

```lua
function BeorningAttributes:IsInBearForm();
```

**Returns:** `boolean` — True if the Beorning is in bear form.


## Events

### `FormChanged`

Event fired when the form state of the Beorning changes.

```lua
function BeorningAttributes:FormChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `WrathChanged`

Event fired when the wrath level of a Beorning has changed.

```lua
function BeorningAttributes:WrathChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

