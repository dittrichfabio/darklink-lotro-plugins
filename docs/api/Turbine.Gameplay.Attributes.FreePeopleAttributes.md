# `Turbine.Gameplay.Attributes.FreePeopleAttributes`

Provides class information for the Free People entities.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → **Turbine.Gameplay.Attributes.FreePeopleAttributes**

## Methods

### `GetAgility()`

Gets the modified agility of the player.

```lua
function FreePeopleAttributes:GetAgility();
```

**Returns:** `number` — The modified agility of the player.

### `GetArmor()`

Gets the armor value of the player.

```lua
function FreePeopleAttributes:GetArmor();
```

**Returns:** `number` — The armor value of the player.

### `GetBaseAgility()`

Gets the unmodified agility of the player.

```lua
function FreePeopleAttributes:GetBaseAgility();
```

**Returns:** `number` — The unmodified agility of the player.

### `GetBaseArmor()`

Gets the base armor value of the player.

```lua
function FreePeopleAttributes:GetBaseArmor();
```

**Returns:** `number` — The base armor value of the player.

### `GetBaseFate()`

Gets the unmodified fate of the player.

```lua
function FreePeopleAttributes:GetBaseFate();
```

**Returns:** `number` — The unmodified fate of the player.

### `GetBaseMight()`

Gets the unmodified might of the player.

```lua
function FreePeopleAttributes:GetBaseMight();
```

**Returns:** `number` — The unmodified might of the player.

### `GetBaseResistance()`

Gets the base resistance of the player.

```lua
function FreePeopleAttributes:GetBaseResistance();
```

**Returns:** `number` — The base resistance of the player.

### `GetBaseVitality()`

Gets the unmodified vitality of the player.

```lua
function FreePeopleAttributes:GetBaseVitality();
```

**Returns:** `number` — The unmodified vitality of the player.

### `GetBaseWill()`

Gets the unmodified will of the player.

```lua
function FreePeopleAttributes:GetBaseWill();
```

**Returns:** `number` — The unmodified will of the player.

### `GetDestinyPoints()`

Gets the destiny points of the player.

```lua
function FreePeopleAttributes:GetDestinyPoints();
```

**Returns:** `number` — . The destiny points of the player.

### `GetDiseaseResistance()`

Gets the disease resistance of the player.

```lua
function FreePeopleAttributes:GetDiseaseResistance();
```

**Returns:** `number` — The disease resistance of the player.

### `GetFate()`

Gets the modified fate of the player.

```lua
function FreePeopleAttributes:GetFate();
```

**Returns:** `number` — The modified fate of the player.

### `GetFearResistance()`

Gets the fear resistance of the player.

```lua
function FreePeopleAttributes:GetFearResistance();
```

**Returns:** `number` — The fear resistance of the player.

### `GetMight()`

Gets the modified might of the player.

```lua
function FreePeopleAttributes:GetMight();
```

**Returns:** `number` — The modified might of the player.

### `GetMoney()`

Gets the money of the player in copper.

```lua
function FreePeopleAttributes:GetMoney();
```

**Returns:** `number` — . The money of the player in copper.

### `GetMoneyComponents()`

Gets the money of the player in gold, silver, and copper.

```lua
function FreePeopleAttributes:GetMoneyComponents();
```

**Returns:** `(Unrecognized type)` — . The money of the player returned as three values that are the gold, silver, and copper.

### `GetPoisonResistance()`

Gets the poison resistance of the player.

```lua
function FreePeopleAttributes:GetPoisonResistance();
```

**Returns:** `number` — The poison resistance of the player.

### `GetProfessionInfo()`

Gets information about a player's profession.

```lua
function FreePeopleAttributes:GetProfessionInfo(profession);
```

**Parameters:**

- `profession` (`number`)

**Returns:** [ProfessionInfo](Turbine.Gameplay.ProfessionInfo.md) — The profession information for the specified profession if that player has that profession. If the player does not have that profession, nil will be returned.

### `GetVitality()`

Gets the modified vitality of the player.

```lua
function FreePeopleAttributes:GetVitality();
```

**Returns:** `number` — The modified vitality of the player.

### `GetVocation()`

Gets the current vocation of the player.

```lua
function FreePeopleAttributes:GetVocation();
```

**Returns:** `number` — The current vocation of the player.

### `GetWill()`

Gets the modified will of the player.

```lua
function FreePeopleAttributes:GetWill();
```

**Returns:** `number` — The modified will of the player.

### `GetWoundResistance()`

Gets the wound resistance of the player.

```lua
function FreePeopleAttributes:GetWoundResistance();
```

**Returns:** `number` — The wound resistance of the player.

