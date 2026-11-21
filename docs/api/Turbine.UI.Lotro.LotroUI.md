# `Turbine.UI.Lotro.LotroUI`

Provides access to the built in game UIs.

This class exposes methods for controlling the in game UI allowing for plugins to hide existing UIs and respond to events that would be sent to those windows.

**Inheritance:** `Turbine.Object` → **Turbine.UI.Lotro.LotroUI**

## Methods

### `IsEnabled()`

Gets a flag indicating if a game UI element is enabled.

```lua
function LotroUI.IsEnabled(hudElement);
```

**Parameters:**

- `hudElement` (`number`) — The element to check the enabled state of.

**Returns:** `boolean`

### `Reset()`

Gets the position of an existing game UI element.

```lua
function LotroUI.Reset();
```

Resets the state of the standard UI.Resets the state of the standard UI.

### `SetEnabled()`

Sets a flag indicating if a game UI element is enabled.

```lua
function LotroUI.SetEnabled(hudElement, value);
```

**Parameters:**

- `hudElement` (`number`) — The element to get the enabled state of.
- `value` (`boolean`) — The enabled state to set.

