# `Turbine.Gameplay.Player`

A class that represents a player in the game.

This class is the base for any player in the world. It provides additional player information beyond an Actor.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Entity` → `Turbine.Gameplay.Actor` → **Turbine.Gameplay.Player** → `Turbine.Gameplay.LocalPlayer` → `Turbine.Gameplay.PartyMember`

## Methods

### `GetAlignment()`

Gets the alignment of the player.

```lua
function Player:GetAlignment();
```

**Returns:** `number` — The alignment of the player.

### `GetClass()`

Gets the class of the player.

```lua
function Player:GetClass();
```

**Returns:** `number` — The class of the player.

### `GetParty()`

Gets the party the player is a member of.

```lua
function Player:GetParty();
```

**Returns:** [Party](Turbine.Gameplay.Party.md) — Returns the party the player is a member of. If the player is not currently in a party this will return nil.

### `GetPet()`

Gets the pet of the player.

```lua
function Player:GetPet();
```

**Returns:** [Pet](Turbine.Gameplay.Pet.md) — The player's pet.

If the player has a pet, this will return their Actor object.

### `GetRace()`

Gets the race of the player.

```lua
function Player:GetRace();
```

**Returns:** `number` — The race of the player.

### `GetReadyState()`

Gets the ready state of a player based on the result of a ready check.

```lua
function Player:GetReadyState();
```

**Returns:** `number` — Returns a value indicating the ready state of a player based on a ready check.

### `IsLinkDead()`

Gets a flag indicating if the player is disconnected.

```lua
function Player:IsLinkDead();
```

**Returns:** `boolean` — A flag indicating if the player is disconnected. If this is ever true and the current player is the local player, please consult a physician, or a zombie master.

### `IsVoiceActive()`

Gets a flag indicating if the player is currently transmitting voice data.

```lua
function Player:IsVoiceActive();
```

**Returns:** `boolean` — A flag indicating if the player is currently transmitting voice data.

### `IsVoiceEnabled()`

Gets a flag indicating if the player has voice communication enabled.

```lua
function Player:IsVoiceEnabled();
```

**Returns:** `boolean` — A flag indicating if the player has voice communication enabled.

*Methods inherited from base classes:*

- `GetBaseMaxMorale` — Gets the base max morale of the actor.
- `GetBaseMaxPower` — Gets the base max power of the actor.
- `GetEffects` — Gets the effects on the actor.
- `GetLevel` — Gets the level of the actor.
- `GetMaxMorale` — Gets the max morale of the actor.
- `GetMaxPower` — Gets the max power of the actor.
- `GetMaxTemporaryMorale` — Gets the maximum temporary morale of the actor.
- `GetMaxTemporaryPower` — Gets the max temporary power of the actor.
- `GetMorale` — Gets the current morale of the actor.
- `GetName` — Gets the name of the entity.
- `GetPower` — Gets the current power of the actor.
- `GetTarget` — Gets the actor's target.
- `GetTemporaryMorale` — Gets the temporary morale of the actor.
- `GetTemporaryPower` — Gets the temporary power of the actor.
- `IsLocalPlayer` — Returns true if this entity is the local player entity. (Deprecated).


## Events

### `IsLinkDeadChanged`

Event fired when the link dead state of the player has changed.

```lua
function Player:IsLinkDeadChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsVoiceActiveChanged`

Event fired when the state of the player transmitting voice data has changed.

```lua
function Player:IsVoiceActiveChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `IsVoiceEnabledChanged`

Event fired when the voice enabled state of the player has changed.

```lua
function Player:IsVoiceEnabledChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `PartyChanged`

Event fired when the party of the player has changed.

```lua
function Player:PartyChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `PetChanged`

Event fired when the pet of the player has changed.

```lua
function Player:PetChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `RaidChanged`

Event fired when the raid of the player has changed.

```lua
function Player:RaidChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ReadyStateChanged`

Event fired when the ready state of the player has changed.

```lua
function Player:ReadyStateChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

*Events inherited from base classes:*

- `BaseMaxMoraleChanged` — Event fired when the actor's base max morale changes.
- `BaseMaxPowerChanged` — Event fired when he actor's base max power changes.
- `LevelChanged` — Event fired when the actor's level changes.
- `MaxMoraleChanged` — Event fired when the actor's max morale changes.
- `MaxPowerChanged` — Event fired when he actor's max power changes.
- `MaxTemporaryMoraleChanged` — Event fired when the actor's max temporary morale changes.
- `MaxTemporaryPowerChanged` — Event fired when he actor's max temporary power changes.
- `MoraleChanged` — Event fired when the actor's morale changes.
- `NameChanged` — Event fired when the actor's name changes.
- `PowerChanged` — Event fired when he actor's power changes.
- `TargetChanged` — Event fired when the actor's target changes.
- `TemporaryMoraleChanged` — Event fired when the actor's temporary morale changes.
- `TemporaryPowerChanged` — Event fired when he actor's temporary power changes.

