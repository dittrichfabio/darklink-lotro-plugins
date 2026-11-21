# `Turbine.Gameplay.Attributes.MonsterPlayerAttributes`

Provides class information for the Monster Player entities.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Attributes` → **Turbine.Gameplay.Attributes.MonsterPlayerAttributes**

## Methods

### `GetDestinyPoints()`

Gets the destiny points of the player.

```lua
function MonsterPlayerAttributes:GetDestinyPoints();
```

**Returns:** `number` — . The destiny points of the player.

### `GetMoney()`

Gets the money of the player in copper.

```lua
function MonsterPlayerAttributes:GetMoney();
```

**Returns:** `number` — . The money of the player in copper.

### `GetMoneyComponents()`

Gets the money of the player in gold, silver, and copper.

```lua
function MonsterPlayerAttributes:GetMoneyComponents();
```

**Returns:** `(Unrecognized type)` — . The money of the player returned as three values that are the gold, silver, and copper.

