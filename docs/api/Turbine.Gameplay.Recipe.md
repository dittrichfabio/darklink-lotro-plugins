# `Turbine.Gameplay.Recipe`

Information about a recipe.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.Recipe**

## Methods

### `GetBaseCriticalSuccessChance()`

Gets the base chance to crit when crafting this recipe.

```lua
function Recipe:GetBaseCriticalSuccessChance();
```

**Returns:** `number` — The base chance to crit when crafting this recipe.

### `GetCategory()`

Gets the category of the recipe.

```lua
function Recipe:GetCategory();
```

**Returns:** `number` — The category of the recipe.

### `GetCategoryName()`

Gets the name of category of the recipe.

```lua
function Recipe:GetCategoryName();
```

**Returns:** `string` — The name of category of the recipe.

### `GetCooldown()`

Gets the cooldown between using this recipe.

```lua
function Recipe:GetCooldown();
```

**Returns:** `number` — The cooldown between using this recipe.

### `GetCriticalResultItemInfo()`

Gets the item information for the item crafted by this recipe when the player crits.

```lua
function Recipe:GetCriticalResultItemInfo();
```

**Returns:** [ItemInfo](Turbine.Gameplay.ItemInfo.md) — The item information for the item crafted by this recipe when the player crits.

### `GetCriticalResultItemQuantity()`

Gets the quantity of the critical result item actually crafted when the player crits.

```lua
function Recipe:GetCriticalResultItemQuantity();
```

**Returns:** `number` — The quantity of the critical result item actually crafted when the player crits.

### `GetExperienceReward()`

Gets the amount of crafting experience rewarded for crafting this recipe.

```lua
function Recipe:GetExperienceReward();
```

**Returns:** `number` — The amount of crafting experience rewarded for crafting this recipe.

### `GetIngredient()`

Gets the information for the specified ingredient.

```lua
function Recipe:GetIngredient(index);
```

**Parameters:**

- `index` (`number`) — The index of the ingredient to get the information of.

**Returns:** [RecipeIngredient](Turbine.Gameplay.RecipeIngredient.md) — The information for the specified ingredient.

### `GetIngredientCount()`

Gets the number of ingredients required for the recipe.

```lua
function Recipe:GetIngredientCount();
```

**Returns:** `number` — The number of ingredients required for the recipe.

### `GetIngredientPack()`

Gets the recipe ingredient information for an ingredient pack that can be used instead of the recipe ingredients.

```lua
function Recipe:GetIngredientPack();
```

**Returns:** [RecipeIngredient](Turbine.Gameplay.RecipeIngredient.md) — The recipe ingredient information for an ingredient pack that can be used instead of the recipe ingredients.

### `GetName()`

Gets the name of the recipe.

```lua
function Recipe:GetName();
```

**Returns:** `string` — The name of the recipe.

### `GetOptionalIngredient()`

Gets the information for the specified optional ingredient.

```lua
function Recipe:GetOptionalIngredient(index);
```

**Parameters:**

- `index` (`number`) — The index of the optional ingredient to get the information of.

**Returns:** [RecipeIngredient](Turbine.Gameplay.RecipeIngredient.md) — The information for the specified optional ingredient.

### `GetOptionalIngredientCount()`

Gets the number of optional ingredients for the recipe.

```lua
function Recipe:GetOptionalIngredientCount();
```

**Returns:** `number` — The number of optional ingredients for the recipe.

### `GetProfession()`

Gets the profession of the recipe.

```lua
function Recipe:GetProfession();
```

**Returns:** `number` — The profession of the recipe.

### `GetResultItemInfo()`

Gets the item information for the item crafted by this recipe.

```lua
function Recipe:GetResultItemInfo();
```

**Returns:** [ItemInfo](Turbine.Gameplay.ItemInfo.md) — The item information for the item crafted by this recipe.

### `GetResultItemQuantity()`

Gets the quantity of the result item actually crafted.

```lua
function Recipe:GetResultItemQuantity();
```

**Returns:** `number` — The quantity of the result item actually crafted.

### `GetTier()`

Gets the tier of the recipe.

```lua
function Recipe:GetTier();
```

**Returns:** `number` — The tier of the recipe.

### `HasCriticalResultItem()`

Gets if the recipe supports critical result items.

```lua
function Recipe:HasCriticalResultItem();
```

**Returns:** `boolean` — True if the recipe supports critical result items.

### `IsSingleUse()`

Gets a flag indicating if the recipe is a single use recipe.

```lua
function Recipe:IsSingleUse();
```

**Returns:** `boolean` — True if the recipe is a single use recipe.

