# `Turbine.Gameplay.ItemInfo`

Container for various item information.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.ItemInfo**

## Methods

### `GetBackgroundImageID()`

Gets the image ID for the background of the item.

```lua
function ItemInfo:GetBackgroundImageID();
```

**Returns:** `number`

### `GetCategory()`

Gets the category of the item.

```lua
function ItemInfo:GetCategory();
```

**Returns:** `number` — The category of the item.

### `GetDescription()`

Gets the description of the item.

```lua
function ItemInfo:GetDescription();
```

**Returns:** `string` — The description of the item.

### `GetDurability()`

Gets the durability of the item.

```lua
function ItemInfo:GetDurability();
```

**Returns:** `number` — A value from ItemDurability representing the durability of the item.

### `GetIconImageID()`

Gets the image ID for the icon of the item.

```lua
function ItemInfo:GetIconImageID();
```

**Returns:** `number`

### `GetMaxQuantity()`

Gets the maximum number of instances that can be contained at one time.

```lua
function ItemInfo:GetMaxQuantity();
```

**Returns:** `number` — The maximum number of instances that can be contained at one time.

### `GetMaxStackSize()`

Gets the maximum number of instances that can be stacked together.

```lua
function ItemInfo:GetMaxStackSize();
```

**Returns:** `number` — The maximum number of instances that can be stacked together.

### `GetName()`

Gets the name of the item.

```lua
function ItemInfo:GetName();
```

**Returns:** `string` — The name of the item.

### `GetNameWithQuantity()`

Gets the name of the item including quantity information.

```lua
function ItemInfo:GetNameWithQuantity(quantity);
```

**Parameters:**

- `quantity` (`number`)

**Returns:** `string` — The name of the item including quantity information.

### `GetQuality()`

Gets the quality of the item.

```lua
function ItemInfo:GetQuality();
```

**Returns:** `number` — A value from ItemQuality representing the quality of the item.

### `GetQualityImageID()`

Gets the image ID for the quality of the item.

```lua
function ItemInfo:GetQualityImageID();
```

**Returns:** `number`

### `GetShadowImageID()`

Gets the image ID for the shadow of the item.

```lua
function ItemInfo:GetShadowImageID();
```

**Returns:** `number`

### `GetUnderlayImageID()`

Gets the image ID for the underlay of the item.

```lua
function ItemInfo:GetUnderlayImageID();
```

**Returns:** `number`

### `IsMagic()`

Gets a flag indicating if the item is considered magical.

```lua
function ItemInfo:IsMagic();
```

**Returns:** `boolean` — A flag indicating if the item is considered magical.

### `IsUnique()`

Gets a flag indicating if the item is unique.

```lua
function ItemInfo:IsUnique();
```

**Returns:** `boolean` — A flag indicating if the item is unique.

