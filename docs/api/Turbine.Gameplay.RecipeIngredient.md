# `Turbine.Gameplay.RecipeIngredient`

Information about a recipe ingredient.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.RecipeIngredient**

## Methods

### `GetCriticalChanceBonus()`

Gets the critical chance this ingredient adds when used as part of a recipe.

```lua
function RecipeIngredient:GetCriticalChanceBonus();
```

**Returns:** `number` — The critical chance this ingredient adds when used as part of a recipe.

### `GetItemInfo()`

Gets the item information for the ingredient.

```lua
function RecipeIngredient:GetItemInfo();
```

**Returns:** [ItemInfo](Turbine.Gameplay.ItemInfo.md) — The item information for the ingredient.

### `GetRequiredQuantity()`

Gets the quantity required for the recipe.

```lua
function RecipeIngredient:GetRequiredQuantity();
```

**Returns:** `number` — The quantity required for the recipe.

