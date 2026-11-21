# `Turbine.Gameplay.ProfessionInfo`

Information about a profession.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.ProfessionInfo**

## Methods

### `GetMasteryExperience()`

Gets the current mastery experience earned for the profession.

```lua
function ProfessionInfo:GetMasteryExperience();
```

**Returns:** `number` — The current mastery experience earned for the profession.

### `GetMasteryExperienceTarget()`

Gets the target mastery experience for the profession.

```lua
function ProfessionInfo:GetMasteryExperienceTarget();
```

**Returns:** `number` — The target mastery experience for the profession.

### `GetMasteryLevel()`

Gets the current mastery level of the profession.

```lua
function ProfessionInfo:GetMasteryLevel();
```

**Returns:** `number` — The current mastery level of the profession.

### `GetMasteryTitle()`

Gets the current mastery title of the profession.

```lua
function ProfessionInfo:GetMasteryTitle();
```

**Returns:** `string` — The current mastery title of the profession.

### `GetName()`

Gets the name of the profession.

```lua
function ProfessionInfo:GetName();
```

**Returns:** `string` — The name of the profession.

### `GetProficiencyExperience()`

Gets the current proficiency experience earned for the profession.

```lua
function ProfessionInfo:GetProficiencyExperience();
```

**Returns:** `number` — The current proficiency experience earned for the profession.

### `GetProficiencyExperienceTarget()`

Gets the target proficiency experience for the profession.

```lua
function ProfessionInfo:GetProficiencyExperienceTarget();
```

**Returns:** `number` — The target proficiency experience for the profession.

### `GetProficiencyLevel()`

Gets the current proficiency level of the profession.

```lua
function ProfessionInfo:GetProficiencyLevel();
```

**Returns:** `number` — The current proficiency level of the profession.

### `GetProficiencyTitle()`

Gets the current proficiency title of the profession.

```lua
function ProfessionInfo:GetProficiencyTitle();
```

**Returns:** `string` — The current proficiency title of the profession.

### `GetRecipe()`

Gets the specified recipes for this profession.

```lua
function ProfessionInfo:GetRecipe(index);
```

**Parameters:**

- `index` (`number`)

**Returns:** [Recipe](Turbine.Gameplay.Recipe.md) — The specified recipes for this profession.

### `GetRecipeCount()`

Gets the number of recipes the player knows for this profession.

```lua
function ProfessionInfo:GetRecipeCount();
```

**Returns:** `number` — The number of recipes the player knows for this profession.


## Events

### `MasteryExperienceChanged`

Event fired when the current mastery experience earned for the profession has changed.

```lua
function ProfessionInfo:MasteryExperienceChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MasteryExperienceTargetChanged`

Event fired when the target mastery experience for the profession has changed.

```lua
function ProfessionInfo:MasteryExperienceTargetChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MasteryLevelChanged`

Event fired when the current mastery level of the profession has changed.

```lua
function ProfessionInfo:MasteryLevelChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MasteryTitleChanged`

Event fired when the current mastery title of the profession has changed.

```lua
function ProfessionInfo:MasteryTitleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ProficiencyExperienceChanged`

Event fired when the current proficiency experience earned for the profession has changed.

```lua
function ProfessionInfo:ProficiencyExperienceChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ProficiencyExperienceTargetChanged`

Event fired when the target proficiency experience for the profession has changed.

```lua
function ProfessionInfo:ProficiencyExperienceTargetChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ProficiencyLevelChanged`

Event fired when the current proficiency level of the profession has changed.

```lua
function ProfessionInfo:ProficiencyLevelChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ProficiencyTitleChanged`

Event fired when the current proficiency title of the profession has changed.

```lua
function ProfessionInfo:ProficiencyTitleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `RecipeAdded`

Event fired when a recipe has been added.

```lua
function ProfessionInfo:RecipeAdded(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `RecipeRemoved`

Event fired when a recipe has been removed.

```lua
function ProfessionInfo:RecipeRemoved(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

