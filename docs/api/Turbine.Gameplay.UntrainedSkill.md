# `Turbine.Gameplay.UntrainedSkill`

Information about a skill the player has not trained yet.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.Skill` → **Turbine.Gameplay.UntrainedSkill**

## Methods

### `GetPrice()`

Gets the cost to purchase the skill.

```lua
function UntrainedSkill:GetPrice();
```

**Returns:** `number` — The cost to purchase the skill.

### `GetRequiredLevel()`

Gets the required level necessary to purchase the skill.

```lua
function UntrainedSkill:GetRequiredLevel();
```

**Returns:** `number` — The required level necessary to purchase the skill.

### `GetRequiredRank()`

Gets the required rank necessary to purchase the skill.

```lua
function UntrainedSkill:GetRequiredRank();
```

**Returns:** `number` — The required rank necessary to purchase the skill.

*Methods inherited from base classes:*

- `GetSkillInfo` — Gets information about the skill.

