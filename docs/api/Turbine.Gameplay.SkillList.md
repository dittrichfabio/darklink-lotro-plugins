# `Turbine.Gameplay.SkillList`

A list of skills.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.SkillList**

## Methods

### `GetCount()`

Gets the number of skills in the list.

```lua
function SkillList:GetCount();
```

**Returns:** `number` — The number of skills in the list.

### `GetItem()`

Gets a skill from the list.

```lua
function SkillList:GetItem(index);
```

**Parameters:**

- `index` (`number`) — The index of the skill to get.

**Returns:** [Skill](Turbine.Gameplay.Skill.md) — The skill at the specified index.

