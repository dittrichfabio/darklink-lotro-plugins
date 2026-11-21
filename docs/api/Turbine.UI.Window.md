# `Turbine.UI.Window`

A top level window control.

Provides a top level control that can contain other controls and be displayed to the user.

**Inheritance:** `Turbine.Object` → `Turbine.UI.Control` → **Turbine.UI.Window** → `Turbine.UI.Lotro.Window`

## Methods

### `Activate()`

Activates a window, bringing it to the front.

```lua
function Window:Activate();
```

Brings a window to the front.

### `Close()`

Closes the window.

```lua
function Window:Close();
```

This causes the window to close itself. The Closing event is fired first and if this permits the window to close the window will be set to not visible.

### `GetMaximumHeight()`

Gets the maximum height of the window.

```lua
function Window:GetMaximumHeight();
```

**Returns:** `number` — The maximum height of the window.

### `GetMaximumSize()`

Gets the maximum size of the window.

```lua
function Window:GetMaximumSize();
```

**Returns:** `number, number` — The maximum width and height as a pair of integers.

Gets the maximum size of the control, returning the pair of width and height in a list of integers.

### `GetMaximumWidth()`

Gets the maximum width of the window.

```lua
function Window:GetMaximumWidth();
```

**Returns:** `number` — The maximum width of the window.

### `GetMinimumHeight()`

Gets the minimum height of the window.

```lua
function Window:GetMinimumHeight();
```

**Returns:** `number` — The minimum height of the window.

### `GetMinimumSize()`

Gets the minimum size of the window.

```lua
function Window:GetMinimumSize();
```

**Returns:** `number, number` — The minimum width and height as a pair of integers.

Gets the minimum size of the control, returning the pair of width and height in a list of integers.

### `GetMinimumWidth()`

Gets the minimum width of the window.

```lua
function Window:GetMinimumWidth();
```

**Returns:** `number` — The minimum width of the window.

### `GetText()`

Gets the text of the window.

```lua
function Window:GetText();
```

**Returns:** `string` — The text of the window.

Gets the text that is usually displayed as part of the caption for a window.

### `SetMaximumHeight()`

Sets the maximum height of the window.

```lua
function Window:SetMaximumHeight(value);
```

**Parameters:**

- `value` (`number`) — The maximum height of the window.

### `SetMaximumSize()`

Sets the maximum size of the window.

```lua
function Window:SetMaximumSize(width, height);
```

**Parameters:**

- `width` (`number`) — The desired maximum width.
- `height` (`number`) — The desired maximum height.

### `SetMaximumWidth()`

Sets the maximum width of the window.

```lua
function Window:SetMaximumWidth(value);
```

**Parameters:**

- `value` (`number`) — The maximum width of the window.

### `SetMinimumHeight()`

Sets the minimum height of the window.

```lua
function Window:SetMinimumHeight(value);
```

**Parameters:**

- `value` (`number`) — The minimum height of the window.

### `SetMinimumSize()`

Sets the minimum size of the window.

```lua
function Window:SetMinimumSize(width, height);
```

**Parameters:**

- `width` (`number`) — The desired minimum width.
- `height` (`number`) — The desired minimum height.

### `SetMinimumWidth()`

Sets the minimum width of the window.

```lua
function Window:SetMinimumWidth(value);
```

**Parameters:**

- `value` (`number`) — The minimum width of the window.

### `SetText()`

Sets the text of the window.

```lua
function Window:SetText(value);
```

**Parameters:**

- `value` (`string`) — The text of the window.

Sets the text that is usually displayed as part of the caption for a window.

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

### `Activated`

Event fired when a window is activated.

```lua
function Window:Activated(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

This event is fired when a window is brought to the front.

### `Closed`

Event fired when a window is closed.

```lua
function Window:Closed(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

This event is fired after a window has been closed and is no longer visible.

### `Closing`

Event fired when a window is closing.

```lua
function Window:Closing(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

This event is fired when a window is about to close. The event has the chance to cancel the closing by setting Cancel to true in the event arguments table.

### `Deactivated`

Event fired when a window is deactivated.

```lua
function Window:Deactivated(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

This event is fired when a window is no longer the foreground window.

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

