# `Turbine.Gameplay.GambitSkillInfo`

Information about a gambit skill.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.SkillInfo` → **Turbine.Gameplay.GambitSkillInfo**

## Methods

### `GetGambit()`

Gets the required gambit at the specified index.

```lua
function GambitSkillInfo:GetGambit(index);
```

**Parameters:**

- `index` (`number`)

**Returns:** `number` — The required gambit at the specified index.

### `GetGambitCount()`

Gets the number of gambits required to use the gambit skill.

```lua
function GambitSkillInfo:GetGambitCount();
```

**Returns:** `number` — The number of gambits required to use the gambit skill.

*Methods inherited from base classes:*

- `GetDescription` — Gets the description of the item.
- `GetIconImageID` — Gets the image ID for the icon of the item.
- `GetName` — Gets the name of the item.
- `GetType` — Gets the type of the skill.

