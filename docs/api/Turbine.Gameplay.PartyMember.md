# `Turbine.Gameplay.PartyMember`

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Entity` → `Turbine.Gameplay.Actor` → `Turbine.Gameplay.Player` → **Turbine.Gameplay.PartyMember**

## Methods

### `GetClass()`

Gets the class of the player.

```lua
function PartyMember:GetClass();
```

**Returns:** `number` — The class of the player.

### `GetLevel()`

Gets the level of the actor.

```lua
function PartyMember:GetLevel();
```

**Returns:** `number` — The level of the actor. If this information is not available, an error will be raised.

### `GetName()`

Gets the name of the entity.

```lua
function PartyMember:GetName();
```

**Returns:** `string` — The name of the entity.

### `GetParty()`

Gets the party the player is a member of.

```lua
function PartyMember:GetParty();
```

**Returns:** [Party](Turbine.Gameplay.Party.md) — Returns the party the player is a member of. If the player is not currently in a party this will return nil.

### `GetRaid()`

Gets the raid the player is a member of.

```lua
function PartyMember:GetRaid();
```

**Returns:** `(Unrecognized type)` — Returns the raid the player is a member of. If the player is not currently in a raid this will return nil.

### `GetReadyState()`

Gets the ready state of a player based on the result of a ready check.

```lua
function PartyMember:GetReadyState();
```

**Returns:** `number` — Returns a value indicating the ready state of a player based on a ready check.

### `IsLinkDead()`

Gets a flag indicating if the player is disconnected.

```lua
function PartyMember:IsLinkDead();
```

**Returns:** `boolean` — A flag indicating if the player is disconnected. If this is ever true and the current player is the local player, please consult a physician, or a zombie master.

### `IsVoiceEnabled()`

Gets a flag indicating if the player has voice communication enabled.

```lua
function PartyMember:IsVoiceEnabled();
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

