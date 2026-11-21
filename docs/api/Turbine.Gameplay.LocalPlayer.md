# `Turbine.Gameplay.LocalPlayer`

A class that represents the local player.

This class represents the Local Player in the world. The local player is the player logged into the world on the client which a script using this class is running.A Local Player has access to information beyond just a player, providing the ability to access the player's backpack.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Entity` → `Turbine.Gameplay.Actor` → `Turbine.Gameplay.Player` → **Turbine.Gameplay.LocalPlayer**

## Methods

### `GetAttributes()`

Gets the general attributes of a player.

```lua
function LocalPlayer:GetAttributes();
```

**Returns:** [Attributes](Turbine.Gameplay.Attributes.md)

### `GetBackpack()`

Gets the player's backpack.

```lua
function LocalPlayer:GetBackpack();
```

**Returns:** [Backpack](Turbine.Gameplay.Backpack.md) — The player's backpack.

### `GetClassAttributes()`

Gets attribute information specific to a class.

```lua
function LocalPlayer:GetClassAttributes();
```

**Returns:** [Attributes](Turbine.Gameplay.Attributes.md) — Attributes specified to the class.

### `GetEquipment()`

Gets the player's equipment.

```lua
function LocalPlayer:GetEquipment();
```

**Returns:** [Equipment](Turbine.Gameplay.Equipment.md) — The player's backpack.

### `GetInstance()`

Gets the instance of the Local Player.

```lua
function LocalPlayer.GetInstance();
```

**Returns:** [LocalPlayer](Turbine.Gameplay.LocalPlayer.md) — The instance of the Local Player.

Gets the instance of the Local Player. There is only ever one instance of the local player class that is accessed using this static method. Plugins should be aware that all plugins share the same instance. Proper precautions should be used when using the events on the instance.

### `GetMount()`

Gets the player's mount.

```lua
function LocalPlayer:GetMount();
```

**Returns:** [Mount](Turbine.Gameplay.Mount.md) — A reference to the player's current mount of nil if the player is not riding a mount.

Gets the player's mount if they are currently mounted.

### `GetRaceAttributes()`

Gets attribute information specific to a race.

```lua
function LocalPlayer:GetRaceAttributes();
```

**Returns:** [Attributes](Turbine.Gameplay.Attributes.md) — Attributes specified to the race.

### `GetReadyState()`

Gets the ready state of a player based on the result of a ready check.

```lua
function LocalPlayer:GetReadyState();
```

**Returns:** `number` — Returns a value indicating the ready state of a player based on a ready check.

### `GetSharedStorage()`

Gets the player's shared storage.

```lua
function LocalPlayer:GetSharedStorage();
```

**Returns:** [SharedStorage](Turbine.Gameplay.SharedStorage.md) — The player's shared storage.

### `GetTrainedSkills()`

Gets the list of trained skills.

```lua
function LocalPlayer:GetTrainedSkills();
```

**Returns:** [SkillList](Turbine.Gameplay.SkillList.md) — The list of the trained skills.

### `GetUntrainedSkills()`

Gets the list of untrained skills.

```lua
function LocalPlayer:GetUntrainedSkills();
```

**Returns:** [SkillList](Turbine.Gameplay.SkillList.md) — The list of the trained skills.

### `GetVault()`

Gets the player's vault.

```lua
function LocalPlayer:GetVault();
```

**Returns:** [Vault](Turbine.Gameplay.Vault.md) — The player's vault.

### `GetWallet()`

Gets the player's wallet.

```lua
function LocalPlayer:GetWallet();
```

**Returns:** [Wallet](Turbine.Gameplay.Wallet.md) — The player's wallet.

### `IsInCombat()`

Gets a flag indicating if the player is in combat.

```lua
function LocalPlayer:IsInCombat();
```

**Returns:** `boolean` — True if the player is in combat.

### `IsLinkDead()`

Gets a flag indicating if the player is disconnected.

```lua
function LocalPlayer:IsLinkDead();
```

**Returns:** `boolean` — A flag indicating if the player is disconnected. If this is ever true and the current player is the local player, please consult a physician, or a zombie master.

### `IsVoiceEnabled()`

Gets a flag indicating if the player has voice communication enabled.

```lua
function LocalPlayer:IsVoiceEnabled();
```

**Returns:** `boolean` — A flag indicating if the player has voice communication enabled.

*Methods inherited from base classes:*

- `GetAlignment` — Gets the alignment of the player.
- `GetBaseMaxMorale` — Gets the base max morale of the actor.
- `GetBaseMaxPower` — Gets the base max power of the actor.
- `GetClass` — Gets the class of the player.
- `GetEffects` — Gets the effects on the actor.
- `GetLevel` — Gets the level of the actor.
- `GetMaxMorale` — Gets the max morale of the actor.
- `GetMaxPower` — Gets the max power of the actor.
- `GetMaxTemporaryMorale` — Gets the maximum temporary morale of the actor.
- `GetMaxTemporaryPower` — Gets the max temporary power of the actor.
- `GetMorale` — Gets the current morale of the actor.
- `GetName` — Gets the name of the entity.
- `GetParty` — Gets the party the player is a member of.
- `GetPet` — Gets the pet of the player.
- `GetPower` — Gets the current power of the actor.
- `GetRace` — Gets the race of the player.
- `GetReadyState` — Gets the ready state of a player based on the result of a ready check.
- `GetTarget` — Gets the actor's target.
- `GetTemporaryMorale` — Gets the temporary morale of the actor.
- `GetTemporaryPower` — Gets the temporary power of the actor.
- `IsLinkDead` — Gets a flag indicating if the player is disconnected.
- `IsLocalPlayer` — Returns true if this entity is the local player entity. (Deprecated).
- `IsVoiceActive` — Gets a flag indicating if the player is currently transmitting voice data.
- `IsVoiceEnabled` — Gets a flag indicating if the player has voice communication enabled.


## Events

### `InCombatChanged`

Event fired when the player's in combat state changes.

```lua
function LocalPlayer:InCombatChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MountChanged`

Event fired when the player's mount has changed.

```lua
function LocalPlayer:MountChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

*Events inherited from base classes:*

- `BaseMaxMoraleChanged` — Event fired when the actor's base max morale changes.
- `BaseMaxPowerChanged` — Event fired when he actor's base max power changes.
- `IsLinkDeadChanged` — Event fired when the link dead state of the player has changed.
- `IsVoiceActiveChanged` — Event fired when the state of the player transmitting voice data has changed.
- `IsVoiceEnabledChanged` — Event fired when the voice enabled state of the player has changed.
- `LevelChanged` — Event fired when the actor's level changes.
- `MaxMoraleChanged` — Event fired when the actor's max morale changes.
- `MaxPowerChanged` — Event fired when he actor's max power changes.
- `MaxTemporaryMoraleChanged` — Event fired when the actor's max temporary morale changes.
- `MaxTemporaryPowerChanged` — Event fired when he actor's max temporary power changes.
- `MoraleChanged` — Event fired when the actor's morale changes.
- `NameChanged` — Event fired when the actor's name changes.
- `PartyChanged` — Event fired when the party of the player has changed.
- `PetChanged` — Event fired when the pet of the player has changed.
- `PowerChanged` — Event fired when he actor's power changes.
- `RaidChanged` — Event fired when the raid of the player has changed.
- `ReadyStateChanged` — Event fired when the ready state of the player has changed.
- `TargetChanged` — Event fired when the actor's target changes.
- `TemporaryMoraleChanged` — Event fired when the actor's temporary morale changes.
- `TemporaryPowerChanged` — Event fired when he actor's temporary power changes.

