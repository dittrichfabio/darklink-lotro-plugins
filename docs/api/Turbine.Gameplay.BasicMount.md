# `Turbine.Gameplay.BasicMount`

A basic mount.

**Inheritance:** `Turbine.Object` → `Turbine.Gameplay.EntityReference` → `Turbine.Gameplay.PropertyHandler` → `Turbine.Gameplay.Entity` → `Turbine.Gameplay.Mount` → **Turbine.Gameplay.BasicMount**

## Methods

### `GetMaxMorale()`

Gets the max morale of a basic mount.

```lua
function BasicMount:GetMaxMorale();
```

**Returns:** `number` — The max morale of a basic mount.

### `GetMorale()`

Gets the morale of a basic mount.

```lua
function BasicMount:GetMorale();
```

**Returns:** `number` — The morale of a basic mount.

*Methods inherited from base classes:*

- `GetName` — Gets the name of the entity.
- `GetName` — Gets the name of the entity.
- `IsLocalPlayer` — Returns true if this entity is the local player entity. (Deprecated).


## Events

### `MaxMoraleChanged`

Event fired when the mount's max morale changes.

```lua
function BasicMount:MaxMoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MoraleChanged`

Event fired when the mount's morale changes.

```lua
function BasicMount:MoraleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

*Events inherited from base classes:*

- `NameChanged` — Event fired when the actor's name changes.

