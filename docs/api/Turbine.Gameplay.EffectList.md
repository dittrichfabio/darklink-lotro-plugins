# `Turbine.Gameplay.EffectList`

A utility class used by Actors to hold the list of effects.

This utility class stores the list of effects that have been applied to a player.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.EffectList**

## Methods

### `Contains()`

Test if the list contains the specified effect.

```lua
function EffectList:Contains(value);
```

**Parameters:**

- `value` ([Effect](Turbine.Gameplay.Effect.md)) — The effect to test for.

**Returns:** `boolean` — True if the effects list contains the effect.

### `Get()`

Gets an effect.

```lua
function EffectList:Get(index);
```

**Parameters:**

- `index` (`number`) — The index of the effect to get.

**Returns:** [Effect](Turbine.Gameplay.Effect.md) — The effect at th specified index.

Gets an effect at the specified index. If the index is not inside the list, an error will be raised.

### `GetCount()`

Gets the number of effects in the list.

```lua
function EffectList:GetCount();
```

**Returns:** `number` — The number of effects in the list

### `IndexOf()`

Gets the index of an effect in the list.

```lua
function EffectList:IndexOf(value);
```

**Parameters:**

- `value` ([Effect](Turbine.Gameplay.Effect.md)) — The effect to get the index of.

**Returns:** `number` — The index of the effect or -1 if it is not in the list.

Gets the index of an effect in the list. If the effect is not in the list, -1 will be returned instead.


## Events

### `EffectAdded`

Event fired when an effect is added.

```lua
function EffectList:EffectAdded(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `EffectRemoved`

Event fired when an effect is removed.

```lua
function EffectList:EffectRemoved(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `EffectsCleared`

Event fired when all the effects are cleared.

```lua
function EffectList:EffectsCleared(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

