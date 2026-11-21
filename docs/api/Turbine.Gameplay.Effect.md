# `Turbine.Gameplay.Effect`

Represents an effect that can be applied to an entity.

Effects are buffs or debuffs that have been applied to an entity through the environment, by other actors, or other game events.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.Effect**

## Methods

### `GetCategory()`

Gets the category of the effect.

```lua
function Effect:GetCategory();
```

**Returns:** `number`

Gets the category of the effect. This is one of the EffectCategory values such as Wound, Poison, etc...

### `GetDescription()`

Gets the description of the effect.

```lua
function Effect:GetDescription();
```

**Returns:** `string` — Thedescription of the effect.

### `GetDuration()`

Gets the duration of the effect.

```lua
function Effect:GetDuration();
```

**Returns:** `number` — The duration of the effect.

### `GetIcon()`

Gets the icon for the effect.

```lua
function Effect:GetIcon();
```

**Returns:** `number` — The icon id for the effect.

### `GetID()`

Gets a unique ID for the effect.

```lua
function Effect:GetID();
```

**Returns:** `number` — A unique ID for the effect.

### `GetName()`

Gets the name of the effect.

```lua
function Effect:GetName();
```

**Returns:** `string` — The name of the effect.

### `GetStartTime()`

Gets the time the effect started.

```lua
function Effect:GetStartTime();
```

**Returns:** `number` — The time the effect started.

### `IsCurable()`

Gets a flag indicating if the effect is a curable.

```lua
function Effect:IsCurable();
```

**Returns:** `boolean` — True if the effect is curable.

### `IsDebuff()`

Gets a flag indicating if the effect is a debuff.

```lua
function Effect:IsDebuff();
```

**Returns:** `boolean` — True if the effect is curable.

### `IsDispellable()`

Gets a flag indicating if the effect is a dispellable effect.

```lua
function Effect:IsDispellable();
```

**Returns:** `boolean` — True if the effect is dispellable.


## Events

### `CategoryChanged`

Event fired when the category changes.

```lua
function Effect:CategoryChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `DescriptionChanged`

Event fired when the description changes.

```lua
function Effect:DescriptionChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `DurationChanged`

Event fired when the duration changes.

```lua
function Effect:DurationChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IconChanged`

Event fired when the icon changes.

```lua
function Effect:IconChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsCurableChanged`

Event fired when the curable state changes.

```lua
function Effect:IsCurableChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsDebuffChanged`

Event fired when the debuff state changes.

```lua
function Effect:IsDebuffChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsDispellableChanged`

Event fired when the dispellable state changes.

```lua
function Effect:IsDispellableChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `NameChanged`

Event fired when the name changes.

```lua
function Effect:NameChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `StartTimeChanged`

Event fired when the start time changes.

```lua
function Effect:StartTimeChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

