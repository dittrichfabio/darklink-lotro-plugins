# `Turbine.UI.Control`

The base control class for all available user interface elements.

The Control class provides all the base functionality for displaying user interface elements in game to a user. A Control can be instantiate but will not be visible unless parented inside of a Window.Controls by themself are transparent objects. In order for a control to be visible, set either its background with SetBackground or set its background color with SetBackColor.

**Inheritance:** `Turbine.Object` → **Turbine.UI.Control** → `Turbine.UI.Lotro.BaseItemControl` → `Turbine.UI.Lotro.EffectDisplay` → `Turbine.UI.Lotro.EntityControl` → `Turbine.UI.Lotro.Quickslot` → `Turbine.UI.ScrollableControl` → `Turbine.UI.ScrollBar` → `Turbine.UI.TreeNode` → `Turbine.UI.Window`

## Methods

### `Focus()`

Request that the control take focus.

```lua
function Control:Focus();
```

Attempts to take the focus in the current window.

### `GetAllowDrop()`

Gets if the control supports drop operations from drag and drop.

```lua
function Control:GetAllowDrop();
```

**Returns:** `boolean` — True if the control will handle drag and drop events.

### `GetBackColor()`

Gets the solid background color of the control.

```lua
function Control:GetBackColor();
```

**Returns:** [Color](Turbine.UI.Color.md) — Returns a color table containing the current control background color.

### `GetBackColorBlendMode()`

Gets the blend mode applied to the background color.

```lua
function Control:GetBackColorBlendMode();
```

**Returns:** `number` — Returns one of the values from BlendMode that describes how to blend the background color.

### `GetBackground()`

Gets the background graphic of the control.

```lua
function Control:GetBackground();
```

**Returns:** [Graphic](Turbine.UI.Graphic.md) — The background graphic of the control..

### `GetBlendMode()`

Gets the blend mode applied to the background image.

```lua
function Control:GetBlendMode();
```

**Returns:** `number` — Returns one of the values from BlendMode that describes how to blend the background image.

### `GetControls()`

Gets the list of child controls.

```lua
function Control:GetControls();
```

**Returns:** [ControlList](Turbine.UI.ControlList.md) — The list of child controls.

Gets the list of child controls. This list is mutable and reflects the contents of the current control. Modifications to this list will be immediately reflected by the control.If a control is added to this list that is already parented in another window, the control will be removed from its previous container before being added to this one.

### `GetHeight()`

Gets the height of the control.

```lua
function Control:GetHeight();
```

**Returns:** `number` — The height of the control.

### `GetLeft()`

Gets the left coordinate of the control.

```lua
function Control:GetLeft();
```

**Returns:** `number` — The left position of the window.

Gets the left position of the control in screen pixels relative to its parent. If the control is not parented, the position is in screen space.

### `GetMousePosition()`

Gets the mouse position relative to this control.

```lua
function Control:GetMousePosition();
```

**Returns:** `number, number` — The mouse position relative to this control.

### `GetOpacity()`

Gets the opacity of the window.

```lua
function Control:GetOpacity();
```

**Returns:** `number` — A value of 0 to 1 indicating how transparent the window is.

This gets the current opacity of the window which determines its level of transparency when being displayed.

### `GetParent()`

Gets the parent of the control.

```lua
function Control:GetParent();
```

**Returns:** [Control](Turbine.UI.Control.md) — The parent of the control.

This method will return the parent of the control.

### `GetPosition()`

Gets the position of the control.

```lua
function Control:GetPosition();
```

**Returns:** `number, number` — List of two elements containing the left and top positions of the control.

Gets the left and top positions of the control, returning them as a pair of integer values.

### `GetSize()`

Gets the size of the control.

```lua
function Control:GetSize();
```

**Returns:** `number, number` — The width and height as a pair of integers.

Gets the size of the control, returning the pair of width and height in a list of integers.

### `GetTop()`

Gets the top coordinate of the window.

```lua
function Control:GetTop();
```

**Returns:** `number` — The top position of the window.

Gets the top position of the window in screen pixels relative to its parent. If the control is not parented, the position is in screen space.

### `GetWantsKeyEvents()`

Gets a flag indicating if the control wants to receive key events.

```lua
function Control:GetWantsKeyEvents();
```

**Returns:** `boolean` — True if the control wants to receive key events.

### `GetWantsUpdates()`

Gets the flag indicating if the control wants to receive Update notifications.

```lua
function Control:GetWantsUpdates();
```

**Returns:** `boolean` — True if the control is receiving update notifications.

### `GetWidth()`

Gets the width of the control.

```lua
function Control:GetWidth();
```

**Returns:** `number` — The width of the control.

### `GetZOrder()`

Gets the Z ordering index of the control.

```lua
function Control:GetZOrder();
```

**Returns:** `number` — The current Z order of the control.

This will return the current Z ordering of the control. Controls with higher Z orders will render on top of controls with lower values.

### `HasFocus()`

Returns true if the control has focus.

```lua
function Control:HasFocus();
```

**Returns:** `boolean` — Returns true if the control has focus.

### `IsAltKeyDown()`

Test if the alt key is pressed.

```lua
function Control.IsAltKeyDown();
```

**Returns:** `boolean` — True if the alt key is pressed.

### `IsControlKeyDown()`

Test if the control key is pressed.

```lua
function Control.IsControlKeyDown();
```

**Returns:** `boolean` — True if the control key is pressed.

### `IsDisplayed()`

Gets a flag indicating if the control is displayed.

```lua
function Control:IsDisplayed();
```

**Returns:** `boolean` — True if the control is displayed.

Gets a flag indicating if the control is displayed. A control is only displayed if it is visible and all of its parents to the root are visible.

### `IsEnabled()`

Gets a flag indicating if the control is enabled.

```lua
function Control:IsEnabled();
```

**Returns:** `boolean` — True if the control is enabled.

Sets a flag indicating if the control is enabled. The enabled state is used to determine how a control can be interacted with by the user, typically ignoring user actions while disabled.

### `IsMouseVisible()`

Gets a flag indicating if the mouse will see this control.

```lua
function Control:IsMouseVisible();
```

**Returns:** `boolean` — True if the control processing mouse messages.

Gets a flag indicating if the mouse is visible to the control. If the mouse is not visible then controls underneath will handle mouse messages.

### `IsShiftKeyDown()`

Test if the shift key is pressed.

```lua
function Control.IsShiftKeyDown();
```

**Returns:** `boolean` — True if the shift key is pressed.

### `IsVisible()`

Gets a flag indicating if the control is visible.

```lua
function Control:IsVisible();
```

**Returns:** `boolean` — True if the control is visible.

### `PointToClient()`

Converts a coordinate from control space to screen space.

```lua
function Control:PointToClient(x, y);
```

**Parameters:**

- `x` (`number`) — The X coordinate.
- `y` (`number`) — The Y coordinate.

**Returns:** `number, number` — The control coordinate for the screen coordinate specified.

Converts a coordinate from screen space to control space. The coordinate is relative to the top left of the game client window and the returned coordinate will be relative to the top left of the control.

### `PointToScreen()`

Converts a coordinate from control space to screen space.

```lua
function Control:PointToScreen(x, y);
```

**Parameters:**

- `x` (`number`) — The X coordinate.
- `y` (`number`) — The Y coordinate.

**Returns:** `number, number` — The screen coordinate for the control coordinate specified.

Converts a coordinate from control space to screen space. The coordinate is relative to the top left of the control and the returned coordinate will be relative to the top left of the game client window.

### `SetAllowDrop()`

Sets if the control supports drop operations from drag and drop.

```lua
function Control:SetAllowDrop(value);
```

**Parameters:**

- `value` (`boolean`) — True if the control will handle drag and drop events.

### `SetBackColor()`

Sets the background color of the control.

```lua
function Control:SetBackColor(value);
```

**Parameters:**

- `value` ([Color](Turbine.UI.Color.md)) — The new background color for the control.

### `SetBackColorBlendMode()`

Sets the blend mode applied to the background color.

```lua
function Control:SetBackColorBlendMode(value);
```

**Parameters:**

- `value` (`number`) — The new background color blend mode.

Sets the blend mode applied to the background color to one of the values specified in BlendMode.

### `SetBackground()`

Sets the background image of the control.

```lua
function Control:SetBackground(backgroundImage);
```

**Parameters:**

- `backgroundImage` (`any`) — The path or id of the image to set the background of the control to.

This method will change the background image of the control. The value specified can be either a path to a file to load from the plugins folder or a unique id that specifies a game asset.For images loaded from the plugins folder, the path should be a relative directory from the top level plugins folder. Images must be either in TGA or JPG format.

### `SetBlendMode()`

Sets the blend mode applied to the background image.

```lua
function Control:SetBlendMode(value);
```

**Parameters:**

- `value` (`number`) — The new background blend mode.

Sets the blend mode applied to the background image to one of the values specified in BlendMode.

### `SetEnabled()`

Sets a flag indicating if the control is enabled.

```lua
function Control:SetEnabled(value);
```

**Parameters:**

- `value` (`boolean`) — True if the control is to be enabled, false to disable.

Sets a flag indicating if the control is enabled. The enabled state is used to determine how a control can be interacted with by the user, typically ignoring user actions while disabled.

*Examples:*

This example display a disabled button.

*Disable a control:*

```lua
        window = Turbine.UI.Lotro.Window();
        window:SetVisible( true );
        window:SetPosition( 200, 200 );
        window:SetSize( 300, 200 );
     
        button = Turbine.UI.Button();
        button:SetParent( button );
        button:SetText( "Disabled " );
        button:SetPosition( 20, 50 );
        button:SetSize( 100, 25 );
        button:SetEnabled( false );
```

### `SetHeight()`

Sets the height of the control.

```lua
function Control:SetHeight(value);
```

**Parameters:**

- `value` (`number`) — The height of the control.

### `SetLeft()`

Sets the left coordinate of the window.

```lua
function Control:SetLeft(value);
```

**Parameters:**

- `value` (`number`) — The left position of the window.

Sets the left position of the window in screen pixels relative to its parent. If the control is not parented, the position is in screen space.

### `SetMouseVisible()`

Gets a flag indicating if the mouse will see this control.

```lua
function Control:SetMouseVisible(value);
```

**Parameters:**

- `value` (`boolean`) — True if the control should process mouse messages.

Gets a flag indicating if the mouse is visible to the control. If the mouse is not visible then controls underneath will handle mouse messages.

### `SetOpacity()`

Sets the opacity of the window.

```lua
function Control:SetOpacity(value);
```

**Parameters:**

- `value` (`number`)

This Sets the current opacity of the window which determines its level of transparency when being displayed. Valids values are from 0.0 to 1.0 with 0.0 being fully transparent and 1.0 being fully opaque.Opacity is a special property that is only valid for certain controls. Specifically, Windows will make use of opacity to determine how they are blended with the game.

### `SetParent()`

Sets the parent of the control.

```lua
function Control:SetParent(value);
```

**Parameters:**

- `value` ([Control](Turbine.UI.Control.md)) — The desired parent. If this is nil, the control will be unparented.

Changes the parent of a control. This will remove it from its previous parent and add it to the new one if it is not nil.

### `SetPosition()`

Sets the position of the control.

```lua
function Control:SetPosition(left, top);
```

**Parameters:**

- `left` (`number`) — The left position of the control.
- `top` (`number`) — The top position of the control.

Sets the position of the control relative to its parent control. If the control is not parented, the position is in screen space.

### `SetSize()`

Sets the size of the control.

```lua
function Control:SetSize(width, height);
```

**Parameters:**

- `width` (`number`) — The desired width.
- `height` (`number`) — The desired height.

### `SetTop()`

Sets the top coordinate of the window.

```lua
function Control:SetTop(value);
```

**Parameters:**

- `value` (`number`) — The top position of the window.

Sets the top position of the window in screen pixels relative to its parent. If the control is not parented, the position is in screen space.

### `SetVisible()`

Sets the visible flag of a control.

```lua
function Control:SetVisible(value);
```

**Parameters:**

- `value` (`boolean`) — The new visibility state. True to show, false to hide.

A control only being visible means that it should draw itself. However, if its parents are not visible the control will still not be displayed.

*Examples:*

This example demonstrates toggling the visibility of a control by a button press.

*Toggling Visibility:*

```lua
        label:SetText("Hello!");
     
        button = Turbine.UI.Button();
        button.Click[_] = function( sender, args )
          -- Toggle the visibility of the label on each click.
          label:SetVisibility( lable:GetVisibility() );
        end
```

### `SetWantsKeyEvents()`

Sets a flag indicating if the control wants to receive key events.

```lua
function Control:SetWantsKeyEvents(value);
```

**Parameters:**

- `value` (`boolean`) — True if the control wants to receive key events.

### `SetWantsUpdates()`

Sets the flag indicating if the cotnrol wants to receive update notifications.

```lua
function Control:SetWantsUpdates(value);
```

**Parameters:**

- `value` (`boolean`) — True to enable update calls.

Sets the flag indicating if the cotnrol wants to receive update notifications. Update notifications are triggered every frame and should be used with care. Slow performing code will adversely affect the client framerate.

### `SetWidth()`

Sets the width of the control.

```lua
function Control:SetWidth(value);
```

**Parameters:**

- `value` (`number`) — The width of the control.

### `SetZOrder()`

Sets the Z order of the control.

```lua
function Control:SetZOrder(value);
```

**Parameters:**

- `value` (`number`) — The new Z order of the control.

This will set the current Z ordering of the control. Controls with higher Z orders will render on top of controls with lower values.


## Events

### `DragDrop`

Event fired when a drag drop operation is completed.

```lua
function Control:DragDrop(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `DragEnter`

Event fired when a drag drop operation enters the control.

```lua
function Control:DragEnter(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `DragLeave`

Event fired when a drag drop operation leaves the control.

```lua
function Control:DragLeave(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `DragStart`

Event fired when a drag drop operation starts the control.

```lua
function Control:DragStart(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `EnabledChanged`

Event fired when the enabled state of the control changes.

```lua
function Control:EnabledChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `FocusGained`

Event fired when the control gains focus.

```lua
function Control:FocusGained(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `FocusLost`

Event fired when the control loses focus.

```lua
function Control:FocusLost(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `KeyDown`

Event fired when a key is pressed down.

```lua
function Control:KeyDown(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `KeyUp`

Event fired when a key is released.

```lua
function Control:KeyUp(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MouseClick`

Event fired when a mouse button is clicked.

```lua
function Control:MouseClick(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MouseDoubleClick`

Event fired when a mouse button is double clicked.

```lua
function Control:MouseDoubleClick(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MouseDown`

Event fired when a mouse button is pressed.

```lua
function Control:MouseDown(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MouseEnter`

Event fired when the mouse enters the control.

```lua
function Control:MouseEnter(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MouseHover`

Event fired when the mouse is hovering over the control.

```lua
function Control:MouseHover(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MouseLeave`

Event fired when the mouse leaves the cotnrol.

```lua
function Control:MouseLeave(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MouseMove`

Event fired when the mouse moves.

```lua
function Control:MouseMove(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MouseUp`

Event fired when a mouse button is released.

```lua
function Control:MouseUp(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MouseWheel`

Event fired when a mouse wheel moves.

```lua
function Control:MouseWheel(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `PositionChanged`

Event fired when the position of the control changes.

```lua
function Control:PositionChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `SizeChanged`

Event fired when the size of the control changes.

```lua
function Control:SizeChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `Update`

Event fired every frame when WantsUpdates is enabled.

```lua
function Control:Update(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `VisibleChanged`

Event fired when the visible state of the control changes.

```lua
function Control:VisibleChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

