# `Turbine.UI.Lotro.Quickslot`

A quickslot button for using skills or items.

The quickslot control contains all the functionality to create custom quickslots that can represent skills, items, alias, etc...

**Inheritance:** `Turbine.Object` → `Turbine.UI.Control` → **Turbine.UI.Lotro.Quickslot**

## Methods

### `GetShortcut()`

Gets the shortcut on the quickslot.

```lua
function Quickslot:GetShortcut();
```

**Returns:** [Shortcut](Turbine.UI.Lotro.Shortcut.md) — The shortcut info for the quickslot.

*Examples:*

Getting an existing shortcut.

*Getting a shortcut:*

```lua
        -- Gets an existing shortcut on a quickslot
        shortcut = quickslot1:GetShortcut();
```

### `IsUseOnRightClick()`

Gets whether right clicks will activate the quickslot.

```lua
function Quickslot:IsUseOnRightClick();
```

**Returns:** `boolean` — True if right mouse clicks will activate the quickslot.

### `SetShortcut()`

Sets the shortcut on the quickslot.

```lua
function Quickslot:SetShortcut(value);
```

**Parameters:**

- `value` ([Shortcut](Turbine.UI.Lotro.Shortcut.md)) — The new shortcut infor to set the quickslot to use.

*Examples:*

Setting a new shortcut.

*Setting a shortcut:*

```lua
        quickslot = Turbine.UI.Lotro.Quickslot()
        quickslot:SetParent( myWindow );
        quickslot:SetPosition( 50, 50 );
        quickslot:SetSize( 38, 38 );
        quickslot:SetShortcut( Turbine.UI.Shortcut( Turbine.UI.Lotro.ShortcutType.Undefined, "" ) );
```

### `SetUseOnRightClick()`

Sets whether right clicks will activate the quickslot.

```lua
function Quickslot:SetUseOnRightClick(value);
```

**Parameters:**

- `value` (`boolean`) — True if right mouse clicks will activate the quickslot.

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

### `DragDrop`

Event fired when a drag drop operation is completed.

```lua
function Quickslot:DragDrop(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ShortcutChanged`

Event fired when the shortcut changes.

```lua
function Quickslot:ShortcutChanged(sender, args);
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

