# `Turbine.UI.Button`

A simple button control.

This class provides the most basic of buttons. It has no explicit UI and requires the user to implement any look for the control. A button class will process mouse clicks however and will fire Click events.

## Examples

This example displays creating a simple custom button. The button uses the background color to represent the up and down state, the down state a darkened version of the background color.

*Creating a Custom Button:*

```lua
      import "Turbine.UI";
      import "Turbine.Utils";
      
      TestButton = class( Turbine.UI.Button );
      
      function TestButton:Constructor()
      	Turbine.UI.Button.Constructor( self );
      	self:SetBackColor( Turbine.UI.Color( 1, 0.4, 0.4, 1 ) );
      	self:SetSize( 40, 40 );
      
      	self.MouseDown = function( sender, args )
      		Turbine.UI.Button.SetBackColor( sender, self.halfBackColor );
      	end
      
      	self.MouseUp = function( sender, args )
      		Turbine.UI.Button.SetBackColor( sender, self.backColor );
      	end
      end
      
      function TestButton:SetBackColor( color )
      	Turbine.UI.Button.SetBackColor( self, color );
      	self.backColor = color
      	self.halfBackColor = Turbine.UI.Color( color.A, color.R / 2, color.G / 2, color.B / 2 );
      end
   
      -- Test the custom button.
      window = Turbine.UI.Lotro.Window();
      window:SetPosition( 100, 100 );
      window:SetSize( 200, 100 );
      window:SetText( "Test Window" );
      window:SetVisible( true );
   
      customButton = TestButton();
      customButton:SetPosition( 40, 40 );
      customButton:SetSize( 120, 40 );
      customButton:SetParent( window );
      customButton:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 1 ) );
   
      customButton.Click = function( sender, args )
        Turbine.Shell.WriteLine( "Thanks for clicking me!" );
      end
```

**Inheritance:** `Turbine.Object` → `Turbine.UI.Control` → `Turbine.UI.ScrollableControl` → `Turbine.UI.Label` → **Turbine.UI.Button** → `Turbine.UI.Lotro.Button`

## Methods

*Methods inherited from base classes:*

- `AppendText` — Appends text to the end of the label.
- `DeselectAll` — Deselects all the text in the control.
- `Focus` — Request that the control take focus.
- `GetAllowDrop` — Gets if the control supports drop operations from drag and drop.
- `GetBackColor` — Gets the solid background color of the control.
- `GetBackColorBlendMode` — Gets the blend mode applied to the background color.
- `GetBackground` — Gets the background graphic of the control.
- `GetBlendMode` — Gets the blend mode applied to the background image.
- `GetControls` — Gets the list of child controls.
- `GetFont` — Gets the current font.
- `GetFontStyle` — Gets the font style.
- `GetForeColor` — Gets the foreground color.
- `GetHeight` — Gets the height of the control.
- `GetHorizontalScrollBar` — Gets the horizontal scroll bar.
- `GetLeft` — Gets the left coordinate of the control.
- `GetMousePosition` — Gets the mouse position relative to this control.
- `GetOpacity` — Gets the opacity of the window.
- `GetOutlineColor` — Gets the text outline color.
- `GetParent` — Gets the parent of the control.
- `GetPosition` — Gets the position of the control.
- `GetSelectedText` — Gets the selected text of the label.
- `GetSelectionLength` — Gets the length of the selected text.
- `GetSelectionStart` — Gets the position of the selection start.
- `GetSize` — Gets the size of the control.
- `GetText` — Gets the text of the label.
- `GetTextAlignment` — Gets the alignment of the text within the label.
- `GetTextLength` — Gets the length of the text of the label.
- `GetTop` — Gets the top coordinate of the window.
- `GetVerticalScrollBar` — Gets the vertical scroll bar.
- `GetWantsKeyEvents` — Gets a flag indicating if the control wants to receive key events.
- `GetWantsUpdates` — Gets the flag indicating if the control wants to receive Update notifications.
- `GetWidth` — Gets the width of the control.
- `GetZOrder` — Gets the Z ordering index of the control.
- `HasFocus` — Returns true if the control has focus.
- `InsertText` — Inserts text into the label at the current cursor position.
- `IsAltKeyDown` — Test if the alt key is pressed.
- `IsControlKeyDown` — Test if the control key is pressed.
- `IsDisplayed` — Gets a flag indicating if the control is displayed.
- `IsEnabled` — Gets a flag indicating if the control is enabled.
- `IsMarkupEnabled` — Gets a flag indicating if markup is enabled for the label.
- `IsMouseVisible` — Gets a flag indicating if the mouse will see this control.
- `IsMultiline` — Gets if the label is set to display multiple lines.
- `IsSelectable` — Gets a flag indicating if the text in the label is selectable.
- `IsShiftKeyDown` — Test if the shift key is pressed.
- `IsVisible` — Gets a flag indicating if the control is visible.
- `PointToClient` — Converts a coordinate from control space to screen space.
- `PointToScreen` — Converts a coordinate from control space to screen space.
- `SelectAll` — Selects all the text in the control.
- `SetAllowDrop` — Sets if the control supports drop operations from drag and drop.
- `SetBackColor` — Sets the background color of the control.
- `SetBackColorBlendMode` — Sets the blend mode applied to the background color.
- `SetBackground` — Sets the background image of the control.
- `SetBlendMode` — Sets the blend mode applied to the background image.
- `SetEnabled` — Sets a flag indicating if the control is enabled.
- `SetFont` — Sets the current font.
- `SetFontStyle` — Sets the font style.
- `SetForeColor` — Sets the foreground color.
- `SetHeight` — Sets the height of the control.
- `SetHorizontalScrollBar` — Sets the horizontal scroll bar.
- `SetLeft` — Sets the left coordinate of the window.
- `SetMarkupEnabled` — Sets a flag indicating if markup is enabled for the label.
- `SetMouseVisible` — Gets a flag indicating if the mouse will see this control.
- `SetMultiline` — Sets if the label should display on multiple lines.
- `SetOpacity` — Sets the opacity of the window.
- `SetOutlineColor` — Sets the text outline color.
- `SetParent` — Sets the parent of the control.
- `SetPosition` — Sets the position of the control.
- `SetSelectable` — Sets a flag indicating if the text in the label can be selected.
- `SetSelectedText` — Replaces the selected text.
- `SetSelection` — Sets the selected text.
- `SetSelectionLength` — Sets the length of the selected text.
- `SetSelectionStart` — Sets the position of the selection start.
- `SetSize` — Sets the size of the control.
- `SetText` — Sets the text of the label.
- `SetTextAlignment` — Sets the alignment of the text within the label.
- `SetTop` — Sets the top coordinate of the window.
- `SetVerticalScrollBar` — Sets the vertical scroll bar.
- `SetVisible` — Sets the visible flag of a control.
- `SetWantsKeyEvents` — Sets a flag indicating if the control wants to receive key events.
- `SetWantsUpdates` — Sets the flag indicating if the cotnrol wants to receive update notifications.
- `SetWidth` — Sets the width of the control.
- `SetZOrder` — Sets the Z order of the control.


## Events

### `Click`

Event fired when the user clicks on the button.

```lua
function Button:Click(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `EnabledChanged`

Event fired when the enabled state of the control changes.

```lua
function Button:EnabledChanged(sender, args);
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

