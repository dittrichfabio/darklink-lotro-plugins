# `Turbine.UI.ScrollBar`

A control for scrolling contents.

Scroll bars are composes of three controls: the decrement button, the increment button, and the thumb button. These controls must be set up for a scroll bar to be usable by a user.Scroll bars can be attached to scrollable control. While attached to a scrollable control, none of the range or value setters or getters are available. This is because the range and value are being managed by the scrollable container.

**Inheritance:** `Turbine.Object` → `Turbine.UI.Control` → **Turbine.UI.ScrollBar** → `Turbine.UI.Lotro.ScrollBar`

## Methods

### `GetDecrementButton()`

Gets the button that is used to decrement the value.

```lua
function ScrollBar:GetDecrementButton();
```

**Returns:** [Object](Turbine.Object.md) — The button to decrement the value.

### `GetIncrementButton()`

Gets the button that is used to increment the value.

```lua
function ScrollBar:GetIncrementButton();
```

**Returns:** [Object](Turbine.Object.md) — The button to increment the value.

### `GetLargeChange()`

Gets the large change value of the scrollbar.

```lua
function ScrollBar:GetLargeChange();
```

**Returns:** `number` — The large change value of the scroll bar.

### `GetMaximum()`

Gets the maximum value of the scrollbar.

```lua
function ScrollBar:GetMaximum();
```

**Returns:** `number` — The maximum value of the scroll bar.

### `GetMinimum()`

Gets the minimum value of the scrollbar.

```lua
function ScrollBar:GetMinimum();
```

**Returns:** `number` — The minimum value of the scroll bar.

### `GetOrientation()`

Gets the orientation of the scroll bar.

```lua
function ScrollBar:GetOrientation();
```

**Returns:** `number` — The current orientation of the scrollbar.

### `GetSmallChange()`

Gets the small change value of the scrollbar.

```lua
function ScrollBar:GetSmallChange();
```

**Returns:** `number` — The small change value of the scroll bar.

### `GetThumbButton()`

Gets the thumb button.

```lua
function ScrollBar:GetThumbButton();
```

**Returns:** [Object](Turbine.Object.md) — The button to drag the value.

### `GetValue()`

Gets the current value of the scrollbar.

```lua
function ScrollBar:GetValue();
```

**Returns:** `number` — The current value of the scroll bar.

### `SetDecrementButton()`

Sets the button that is used to decrement the value.

```lua
function ScrollBar:SetDecrementButton(value);
```

**Parameters:**

- `value` ([Object](Turbine.Object.md)) — The button to decrement the value.

### `SetIncrementButton()`

Sets the button that is used to increment the value.

```lua
function ScrollBar:SetIncrementButton(value);
```

**Parameters:**

- `value` ([Object](Turbine.Object.md)) — The button to increment the value.

### `SetLargeChange()`

Sets the large change value of the scrollbar.

```lua
function ScrollBar:SetLargeChange(value);
```

**Parameters:**

- `value` (`number`) — The large change value of the scroll bar.

### `SetMaximum()`

Sets the maximum value of the scrollbar.

```lua
function ScrollBar:SetMaximum(value);
```

**Parameters:**

- `value` (`number`) — The maximum value of the scroll bar.

### `SetMinimum()`

Sets the minimum value of the scrollbar.

```lua
function ScrollBar:SetMinimum(value);
```

**Parameters:**

- `value` (`number`) — The minimum value of the scroll bar.

### `SetOrientation()`

Sets the orientation of the scroll bar.

```lua
function ScrollBar:SetOrientation(value);
```

**Parameters:**

- `value` (`number`) — The orientation of the scrollbar.

### `SetSmallChange()`

Sets the small change value of the scrollbar.

```lua
function ScrollBar:SetSmallChange(value);
```

**Parameters:**

- `value` (`number`) — The small change value of the scroll bar.

### `SetThumbButton()`

Sets the thumb button.

```lua
function ScrollBar:SetThumbButton(value);
```

**Parameters:**

- `value` ([Object](Turbine.Object.md)) — The button to drag the value.

### `SetValue()`

Sets the current value of the scrollbar.

```lua
function ScrollBar:SetValue(value);
```

**Parameters:**

- `value` (`number`) — The current value of the scroll bar.

*Methods inherited from base classes:*

- `Focus` — Request that the control take focus.
- `GetAllowDrop` — Gets if the control supports drop operations from drag and drop.
- `GetBackColor` — Gets the solid background color of the control.
- `GetBackColorBlendMode` — Gets the blend mode applied to the background color.
- `GetBackground` — Gets the background graphic of the control.
- `GetBlendMode` — Gets the blend mode applied to the background image.
- `GetControls` — Gets the list of child controls.
- `GetHeight` — Gets the height of the control.
- `GetLeft` — Gets the left coordinate of the control.
- `GetMousePosition` — Gets the mouse position relative to this control.
- `GetOpacity` — Gets the opacity of the window.
- `GetParent` — Gets the parent of the control.
- `GetPosition` — Gets the position of the control.
- `GetSize` — Gets the size of the control.
- `GetTop` — Gets the top coordinate of the window.
- `GetWantsKeyEvents` — Gets a flag indicating if the control wants to receive key events.
- `GetWantsUpdates` — Gets the flag indicating if the control wants to receive Update notifications.
- `GetWidth` — Gets the width of the control.
- `GetZOrder` — Gets the Z ordering index of the control.
- `HasFocus` — Returns true if the control has focus.
- `IsAltKeyDown` — Test if the alt key is pressed.
- `IsControlKeyDown` — Test if the control key is pressed.
- `IsDisplayed` — Gets a flag indicating if the control is displayed.
- `IsEnabled` — Gets a flag indicating if the control is enabled.
- `IsMouseVisible` — Gets a flag indicating if the mouse will see this control.
- `IsShiftKeyDown` — Test if the shift key is pressed.
- `IsVisible` — Gets a flag indicating if the control is visible.
- `PointToClient` — Converts a coordinate from control space to screen space.
- `PointToScreen` — Converts a coordinate from control space to screen space.
- `SetAllowDrop` — Sets if the control supports drop operations from drag and drop.
- `SetBackColor` — Sets the background color of the control.
- `SetBackColorBlendMode` — Sets the blend mode applied to the background color.
- `SetBackground` — Sets the background image of the control.
- `SetBlendMode` — Sets the blend mode applied to the background image.
- `SetEnabled` — Sets a flag indicating if the control is enabled.
- `SetHeight` — Sets the height of the control.
- `SetLeft` — Sets the left coordinate of the window.
- `SetMouseVisible` — Gets a flag indicating if the mouse will see this control.
- `SetOpacity` — Sets the opacity of the window.
- `SetParent` — Sets the parent of the control.
- `SetPosition` — Sets the position of the control.
- `SetSize` — Sets the size of the control.
- `SetTop` — Sets the top coordinate of the window.
- `SetVisible` — Sets the visible flag of a control.
- `SetWantsKeyEvents` — Sets a flag indicating if the control wants to receive key events.
- `SetWantsUpdates` — Sets the flag indicating if the cotnrol wants to receive update notifications.
- `SetWidth` — Sets the width of the control.
- `SetZOrder` — Sets the Z order of the control.


## Events

### `OrientationChanged`

Event fired when the orientation has changed.

```lua
function ScrollBar:OrientationChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ValueChanged`

Event fired when the value has changed.

```lua
function ScrollBar:ValueChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

*Events inherited from base classes:*

- `DragDrop` — Event fired when a drag drop operation is completed.
- `DragEnter` — Event fired when a drag drop operation enters the control.
- `DragLeave` — Event fired when a drag drop operation leaves the control.
- `DragStart` — Event fired when a drag drop operation starts the control.
- `EnabledChanged` — Event fired when the enabled state of the control changes.
- `FocusGained` — Event fired when the control gains focus.
- `FocusLost` — Event fired when the control loses focus.
- `KeyDown` — Event fired when a key is pressed down.
- `KeyUp` — Event fired when a key is released.
- `MouseClick` — Event fired when a mouse button is clicked.
- `MouseDoubleClick` — Event fired when a mouse button is double clicked.
- `MouseDown` — Event fired when a mouse button is pressed.
- `MouseEnter` — Event fired when the mouse enters the control.
- `MouseHover` — Event fired when the mouse is hovering over the control.
- `MouseLeave` — Event fired when the mouse leaves the cotnrol.
- `MouseMove` — Event fired when the mouse moves.
- `MouseUp` — Event fired when a mouse button is released.
- `MouseWheel` — Event fired when a mouse wheel moves.
- `PositionChanged` — Event fired when the position of the control changes.
- `SizeChanged` — Event fired when the size of the control changes.
- `Update` — Event fired every frame when WantsUpdates is enabled.
- `VisibleChanged` — Event fired when the visible state of the control changes.

