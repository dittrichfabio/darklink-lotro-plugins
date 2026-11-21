# `Turbine.Gameplay.Attributes.WardenAttributes`

Provides class information for the Warden player class.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → `Turbine.Gameplay.ClassAttributes` → **Turbine.Gameplay.Attributes.WardenAttributes**

## Methods

### `GetGambit()`

Gets the active gambit at the specified index.

```lua
function WardenAttributes:GetGambit(index);
```

**Parameters:**

- `index` (`number`)

**Returns:** `number` — The active gambit at the specified index.

### `GetGambitCount()`

Gets the number of gambits active.

```lua
function WardenAttributes:GetGambitCount();
```

**Returns:** `number` — The number of gambits active.

### `GetMaxGambitCount()`

Gets the maximum gambits the warden can use.

```lua
function WardenAttributes:GetMaxGambitCount();
```

**Returns:** `number` — The maximum gambits the warden can use.

### `GetStance()`

Gets the current stance.

```lua
function WardenAttributes:GetStance();
```

**Returns:** `number` — The current stance.

### `GetTrainedGambits()`

Gets the list of trained gambits.

```lua
function WardenAttributes:GetTrainedGambits();
```

**Returns:** [SkillList](Turbine.Gameplay.SkillList.md) — The list of trained gambits.

### `GetUntrainedGambits()`

Gets the list of untrained gambits.

```lua
function WardenAttributes:GetUntrainedGambits();
```

**Returns:** [SkillList](Turbine.Gameplay.SkillList.md) — The list of untrained gambits.


## Events

### `GambitChanged`

Event fired when the gambit has changed.

```lua
function WardenAttributes:GambitChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MaxGambitCountChanged`

Event fired when the number of gambit slots has changed.

```lua
function WardenAttributes:MaxGambitCountChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `StanceChanged`

Event fired when the stance changes.

```lua
function WardenAttributes:StanceChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

