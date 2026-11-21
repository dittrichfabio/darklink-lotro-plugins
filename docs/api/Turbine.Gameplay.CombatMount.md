# `Turbine.Gameplay.CombatMount`

A mount that can be used in combat.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Entity` → `Turbine.Gameplay.Mount` → **Turbine.Gameplay.CombatMount**

## Methods

### `GetAgility()`

Gets the modified agility of the player.

```lua
function CombatMount:GetAgility();
```

**Returns:** `number` — The modified agility of the player.

### `GetArmor()`

Gets the armor value of the mount.

```lua
function CombatMount:GetArmor();
```

**Returns:** `number` — The armor value of the mount.

### `GetBaseAgility()`

Gets the unmodified agility of the mount.

```lua
function CombatMount:GetBaseAgility();
```

**Returns:** `number` — The unmodified agility of the mount.

### `GetBaseArmor()`

Gets the base armor value of the mount.

```lua
function CombatMount:GetBaseArmor();
```

**Returns:** `number` — The base armor value of the mount.

### `GetBaseMaxMorale()`

Gets the base max morale of the mount.

```lua
function CombatMount:GetBaseMaxMorale();
```

**Returns:** `number` — The base max morale of the mount.

### `GetBaseMaxPower()`

Gets the base max power of the mount.

```lua
function CombatMount:GetBaseMaxPower();
```

**Returns:** `number` — The base max power of the mount.

### `GetBaseStrength()`

Gets the unmodified strength of the mount.

```lua
function CombatMount:GetBaseStrength();
```

**Returns:** `number` — The unmodified strength of the mount.

### `GetFury()`

Gets the current fury of the combat horse.

```lua
function CombatMount:GetFury();
```

**Returns:** `number` — The current fury of the combat horse.

### `GetMaxFury()`

Gets the max fury of the combat horse.

```lua
function CombatMount:GetMaxFury();
```

**Returns:** `number` — The max fury of the combat horse.

### `GetMaxMorale()`

Gets the max morale of the mount.

```lua
function CombatMount:GetMaxMorale();
```

**Returns:** `number` — The max morale of the mount.

### `GetMaxPower()`

Gets the max power of the mount.

```lua
function CombatMount:GetMaxPower();
```

**Returns:** `number` — The max power of the mount.

### `GetMaxTemporaryMorale()`

Gets the maximum temporary morale of the mount.

```lua
function CombatMount:GetMaxTemporaryMorale();
```

**Returns:** `number` — The maximum temporary morale of the mount.

### `GetMaxTemporaryPower()`

Gets the max temporary power of the mount.

```lua
function CombatMount:GetMaxTemporaryPower();
```

**Returns:** `number` — The max temporary power of the mount.

### `GetMorale()`

Gets the current morale of the mount.

```lua
function CombatMount:GetMorale();
```

**Returns:** `number` — The current morale of the mount.

### `GetPower()`

Gets the current power of the mount.

```lua
function CombatMount:GetPower();
```

**Returns:** `number` — The current power of the mount.

### `GetStrength()`

Gets the modified strength of the player.

```lua
function CombatMount:GetStrength();
```

**Returns:** `number` — The modified strength of the player.

### `GetTemporaryMorale()`

Gets the temporary morale of the mount.

```lua
function CombatMount:GetTemporaryMorale();
```

**Returns:** `number` — The temporary morale of the mount.

### `GetTemporaryPower()`

Gets the temporary power of the mount.

```lua
function CombatMount:GetTemporaryPower();
```

**Returns:** `number` — The temporary power of the mount.

*Methods inherited from base classes:*

- `GetName` — Gets the name of the entity.
- `GetName` — Gets the name of the entity.
- `IsLocalPlayer` — Returns true if this entity is the local player entity. (Deprecated).


## Events

### `BaseMaxMoraleChanged`

Event fired when the mount's base max morale changes.

```lua
function CombatMount:BaseMaxMoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `BaseMaxPowerChanged`

Event fired when he mount's base max power changes.

```lua
function CombatMount:BaseMaxPowerChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `FuryChanged`

Event fired when he mount's max temporary power changes.

```lua
function CombatMount:FuryChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MaxMoraleChanged`

Event fired when the mount's max morale changes.

```lua
function CombatMount:MaxMoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MaxPowerChanged`

Event fired when he mount's max power changes.

```lua
function CombatMount:MaxPowerChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MaxTemporaryMoraleChanged`

Event fired when the mount's max temporary morale changes.

```lua
function CombatMount:MaxTemporaryMoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MaxTemporaryPowerChanged`

Event fired when he mount's max temporary power changes.

```lua
function CombatMount:MaxTemporaryPowerChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MoraleChanged`

Event fired when the mount's morale changes.

```lua
function CombatMount:MoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `PowerChanged`

Event fired when he mount's power changes.

```lua
function CombatMount:PowerChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `TemporaryMoraleChanged`

Event fired when the mount's temporary morale changes.

```lua
function CombatMount:TemporaryMoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `TemporaryPowerChanged`

Event fired when he mount's temporary power changes.

```lua
function CombatMount:TemporaryPowerChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

*Events inherited from base classes:*

- `NameChanged` — Event fired when the actor's name changes.

