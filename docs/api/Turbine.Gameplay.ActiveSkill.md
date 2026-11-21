# `Turbine.Gameplay.ActiveSkill`

Information about an active player's skill.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.Skill` → **Turbine.Gameplay.ActiveSkill**

## Methods

### `GetBaseCooldown()`

Gets the base cooldown of the skill.

```lua
function ActiveSkill:GetBaseCooldown();
```

**Returns:** `number` — The base cooldown of the skill in seconds.

### `GetCooldown()`

Gets the cooldown of the skill.

```lua
function ActiveSkill:GetCooldown();
```

**Returns:** `number` — The cooldown of the skill in seconds.

### `GetResetTime()`

Gets the time that the skill will come off of cooldown.

```lua
function ActiveSkill:GetResetTime();
```

**Returns:** `number` — The base cooldown of the skill in seconds.

Gets the time that the skill will come off of cooldown. This time will be negative if the skill is already off cooldown, otherwise it will have a time that you can subtract Turbine.Engine.GetGameTime from to get the remaining time the skill is in cooldown.

### `IsUsable()`

Gets if the skill is currently usable.

```lua
function ActiveSkill:IsUsable();
```

**Returns:** `boolean`

Gets if the skill is currently usable. There are numerous conditions that affect the usability of a skill: combat state, effects, items, gambits, traits, pets, stealth, etc...

*Methods inherited from base classes:*

- `GetSkillInfo` — Gets information about the skill.


## Events

### `ResetTimeChanged`

Event fired when the reset time of a skill changes.

```lua
function ActiveSkill:ResetTimeChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

