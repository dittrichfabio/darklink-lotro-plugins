# `Turbine.UI.Label`

A simple label for displaying text.

This class extends a control for the purpose of displaying some text. It contains simple methods for describing how to layout the text and display it.

## Examples

This example displays some text in a label contained inside a window.

*Displaying Text:*

```lua
      import "Turbine.UI.Lotro";
      
      window = Turbine.UI.Lotro.Window();
      window:SetPosition( 200, 200 );
      window:SetSize( 200, 200 );
      window:SetText( "Test" );
      window:SetVisible( true );
      
      label = Turbine.UI.Label();
      label:SetParent( window );
      label:SetPosition( 40, 60 );
      label:SetSize( 120, 80 );
      label:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 1 ) );
      label:SetText( "Hello world!" );
      label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
```

**Inheritance:** `Turbine.Object` → `Turbine.UI.Control` → `Turbine.UI.ScrollableControl` → **Turbine.UI.Label** → `Turbine.UI.Button` → `Turbine.UI.CheckBox` → `Turbine.UI.TextBox`

## Methods

### `AppendText()`

Appends text to the end of the label.

```lua
function Label:AppendText(value);
```

**Parameters:**

- `value` (`string`) — The text to append.

### `DeselectAll()`

Deselects all the text in the control.

```lua
function Label:DeselectAll();
```

### `GetFont()`

Gets the current font.

```lua
function Label:GetFont();
```

**Returns:** `number` — The current font.

Gets the current font. The font is represented by an ID of a font that is available.

### `GetFontStyle()`

Gets the font style.

```lua
function Label:GetFontStyle();
```

**Returns:** `number` — The current font style.

Gets the style used to draw the text.

### `GetForeColor()`

Gets the foreground color.

```lua
function Label:GetForeColor();
```

**Returns:** [Color](Turbine.UI.Color.md) — The color used for drawing the text.

Gets the color used to draw the text.

### `GetOutlineColor()`

Gets the text outline color.

```lua
function Label:GetOutlineColor();
```

**Returns:** [Color](Turbine.UI.Color.md) — The color used for outlining the text.

Gets the color used to outline the text. This effect is only applied when the font style includes the outline flag.

### `GetSelectedText()`

Gets the selected text of the label.

```lua
function Label:GetSelectedText();
```

**Returns:** `string` — The selected text of the label.

Gets the selected text of the label. The selected text remains selected only while the label has the focus of the mouse. Once focus is lost, the previously selected text is unselected.

*Examples:*

This example echoes the selected text from a label.

*Displaying Selected Text:*

```lua
        import "Turbine.UI.Lotro";
        
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
        
        label = Turbine.UI.Label();
        label:SetParent( window );
        label:SetSeletable( true );
        label:SetPosition( 40, 60 );
        label:SetSize( 120, 80 );
        label:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        label:SetText( "Hello world!" );
        label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
        
        label.MouseLeave = function( sender, args )
          Turbine.Shell.WriteLine( label:GetSelectedText() );
        end
```

### `GetSelectionLength()`

Gets the length of the selected text.

```lua
function Label:GetSelectionLength();
```

**Returns:** `number` — The length of the selected text.

### `GetSelectionStart()`

Gets the position of the selection start.

```lua
function Label:GetSelectionStart();
```

**Returns:** `number` — The position of the selection start.

### `GetText()`

Gets the text of the label.

```lua
function Label:GetText();
```

**Returns:** `string` — The text of the label.

### `GetTextAlignment()`

Gets the alignment of the text within the label.

```lua
function Label:GetTextAlignment();
```

**Returns:** `number` — The alignment of the text.

This gets the position at which the text will be rendered within the label control.

### `GetTextLength()`

Gets the length of the text of the label.

```lua
function Label:GetTextLength();
```

**Returns:** `number` — The length of the text of the label.

### `InsertText()`

Inserts text into the label at the current cursor position.

```lua
function Label:InsertText(value);
```

**Parameters:**

- `value` (`string`) — The text to insert.

Inserts the text specified into the label at the current cursor position.

### `IsMarkupEnabled()`

Gets a flag indicating if markup is enabled for the label.

```lua
function Label:IsMarkupEnabled();
```

**Returns:** `boolean` — True if text markup is enabled.

Labels support internal markup to allow for some formatting of the text in the control. The markup supports simple tags such as <u></u>, , , and <rgb=XXXXXX></rgb>.

### `IsMultiline()`

Gets if the label is set to display multiple lines.

```lua
function Label:IsMultiline();
```

**Returns:** `boolean` — True if the label will display on multiple lines.

When true the text exceeds the width of the label, the text will automatically wrap onto the next line.

### `IsSelectable()`

Gets a flag indicating if the text in the label is selectable.

```lua
function Label:IsSelectable();
```

**Returns:** `boolean` — True if the text in the label is selectable.

When true, the text of a label can be selected using the mouse by clicking and dragging.

### `SelectAll()`

Selects all the text in the control.

```lua
function Label:SelectAll();
```

### `SetFont()`

Sets the current font.

```lua
function Label:SetFont(value);
```

**Parameters:**

- `value` (`number`) — The desired font.

Sets the current font. The font is represented by an ID of a font that is available.

### `SetFontStyle()`

Sets the font style.

```lua
function Label:SetFontStyle(value);
```

**Parameters:**

- `value` (`number`) — The desired font style.

Sets the style used to draw the text.

*Examples:*

This example demonstrates using outlining to emphasize text in a label.

*Turns on Font Outlining:*

```lua
        import "Turbine.UI.Lotro";
        
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
        
        label = Turbine.UI.Label();
        label:SetParent( window );
        label:SetSeletable( true );
        label:SetPosition( 40, 60 );
        label:SetSize( 120, 80 );
        label:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        label:SetOutlineColor( Turbine.UI.Color( 1, 0, 0 ) );
        label:SetFontStyle( Turbine.UI.FontStyle.Outline );
        label:SetText( "Hello world!" );
        label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
```

### `SetForeColor()`

Sets the foreground color.

```lua
function Label:SetForeColor(value);
```

**Parameters:**

- `value` ([Color](Turbine.UI.Color.md)) — The color used for drawing the text.

Sets the color used to draw the text.

*Examples:*

This example demonstrates changing the color of the text displayed by a label.

*Setting the Label Text Color:*

```lua
        import "Turbine.UI.Lotro";
        
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
        
        label = Turbine.UI.Label();
        label:SetParent( window );
        label:SetSeletable( true );
        label:SetPosition( 40, 60 );
        label:SetSize( 120, 80 );
        label:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        label:SetForeColor( Turbine.UI.Color( 1, 1, 0 ) );
        label:SetText( "Hello world!" );
        label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
```

### `SetMarkupEnabled()`

Sets a flag indicating if markup is enabled for the label.

```lua
function Label:SetMarkupEnabled(value);
```

**Parameters:**

- `value` (`boolean`) — Flag indicating if markup should be enabled.

Labels support internal markup to allow for some formatting of the text in the control. The markup supports simple tags such as <u></u>, , , and <rgb=XXXXXX></rgb>.

### `SetMultiline()`

Sets if the label should display on multiple lines.

```lua
function Label:SetMultiline(value);
```

**Parameters:**

- `value` (`boolean`) — True to make the label multiline.

When enabled, the text of a label will wrap at the edge of the labels horizontal boundaries.There are some limitations when text is not multiline. When the text is too width to fit in the label's area, the content alignment will only honor the vertical layout. The horizontal alignment will be left.

*Examples:*

*Turn off Multiline:*

```lua
        import "Turbine.UI.Lotro";
        
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
        
        label = Turbine.UI.Label();
        label:SetParent( window );
        label:SetMultiline( false );
        label:SetPosition( 40, 60 );
        label:SetSize( 120, 80 );
        label:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 1 ) );
        label:SetText( "This text will not wrap" );
        label:SetTextAlignment( Turbine.UI.ContentAlignment.TopLeft );
```

### `SetOutlineColor()`

Sets the text outline color.

```lua
function Label:SetOutlineColor(value);
```

**Parameters:**

- `value` ([Color](Turbine.UI.Color.md)) — The color used for outlining the text.

Sets the color used to outline the text. This effect is only applied when the font style includes the outline flag.

*Examples:*

This example demonstrates using outlining to emphasize text in a label.

*Turns on Font Outlining:*

```lua
        import "Turbine.UI.Lotro";
        
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
        
        label = Turbine.UI.Label();
        label:SetParent( window );
        label:SetSeletable( true );
        label:SetPosition( 40, 60 );
        label:SetSize( 120, 80 );
        label:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        label:SetOutlineColor( Turbine.UI.Color( 1, 0, 0 ) );
        label:SetFontStyle( Turbine.UI.FontStyle.Outline );
        label:SetText( "Hello world!" );
        label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
```

### `SetSelectable()`

Sets a flag indicating if the text in the label can be selected.

```lua
function Label:SetSelectable(value);
```

**Parameters:**

- `value` (`boolean`) — True to enable selection of text in the label.

When set, the text in the label control can be selected using the mouse by clicking and dragging a region of text.

*Examples:*

This example demonstrates displaying text in a label that can be selected by the user.

*Create Selectable Text:*

```lua
        import "Turbine.UI.Lotro";
        
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
        
        label = Turbine.UI.Label();
        label:SetParent( window );
        label:SetSeletable( true );
        label:SetPosition( 40, 60 );
        label:SetSize( 120, 80 );
        label:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 1 ) );
        label:SetText( "Hello!nnThis is selectable!" );
        label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
```

### `SetSelectedText()`

Replaces the selected text.

```lua
function Label:SetSelectedText(value);
```

**Parameters:**

- `value` (`string`) — The text to replace the selected text with.

Replaces the selected text with the text specified.

### `SetSelection()`

Sets the selected text.

```lua
function Label:SetSelection(start, length);
```

**Parameters:**

- `start` (`number`) — The starting position to select.
- `length` (`number`) — The length of text to select.

### `SetSelectionLength()`

Sets the length of the selected text.

```lua
function Label:SetSelectionLength(value);
```

**Parameters:**

- `value` (`number`) — The length of the selected text.

### `SetSelectionStart()`

Sets the position of the selection start.

```lua
function Label:SetSelectionStart(value);
```

**Parameters:**

- `value` (`number`) — The position of the selection start.

### `SetText()`

Sets the text of the label.

```lua
function Label:SetText(value);
```

**Parameters:**

- `value` (`string`) — The text of the label.

Sets the text of the label. This will clear any selection that had been made.

*Examples:*

Quick example that changes the text of a label.

*Sets the Text of a Label:*

```lua
        import "Turbine.UI.Lotro";
        
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
        
        label = Turbine.UI.Label();
        label:SetParent( window );
        label:SetSeletable( true );
        label:SetPosition( 40, 60 );
        label:SetSize( 120, 80 );
        label:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        label:SetText( "Hello world!" );
        label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
```

### `SetTextAlignment()`

Sets the alignment of the text within the label.

```lua
function Label:SetTextAlignment(value);
```

**Parameters:**

- `value` (`number`) — The alignment of the text.

This sets the position at which the text will be rendered within the label control.

*Examples:*

This example centers the text of a label vertically and horizontally.

*Demonstrates Setting Text Alignment:*

```lua
        import "Turbine.UI.Lotro";
        
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
        
        label = Turbine.UI.Label();
        label:SetParent( window );
        label:SetSeletable( true );
        label:SetPosition( 40, 60 );
        label:SetSize( 120, 80 );
        label:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        label:SetText( "Hello world!" );
        label:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleCenter );
```

*Methods inherited from base classes:*

- `Focus` — Request that the control take focus.
- `GetAllowDrop` — Gets if the control supports drop operations from drag and drop.
- `GetBackColor` — Gets the solid background color of the control.
- `GetBackColorBlendMode` — Gets the blend mode applied to the background color.
- `GetBackground` — Gets the background graphic of the control.
- `GetBlendMode` — Gets the blend mode applied to the background image.
- `GetControls` — Gets the list of child controls.
- `GetHeight` — Gets the height of the control.
- `GetHorizontalScrollBar` — Gets the horizontal scroll bar.
- `GetLeft` — Gets the left coordinate of the control.
- `GetMousePosition` — Gets the mouse position relative to this control.
- `GetOpacity` — Gets the opacity of the window.
- `GetParent` — Gets the parent of the control.
- `GetPosition` — Gets the position of the control.
- `GetSize` — Gets the size of the control.
- `GetTop` — Gets the top coordinate of the window.
- `GetVerticalScrollBar` — Gets the vertical scroll bar.
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
- `SetHorizontalScrollBar` — Sets the horizontal scroll bar.
- `SetLeft` — Sets the left coordinate of the window.
- `SetMouseVisible` — Gets a flag indicating if the mouse will see this control.
- `SetOpacity` — Sets the opacity of the window.
- `SetParent` — Sets the parent of the control.
- `SetPosition` — Sets the position of the control.
- `SetSize` — Sets the size of the control.
- `SetTop` — Sets the top coordinate of the window.
- `SetVerticalScrollBar` — Sets the vertical scroll bar.
- `SetVisible` — Sets the visible flag of a control.
- `SetWantsKeyEvents` — Sets a flag indicating if the control wants to receive key events.
- `SetWantsUpdates` — Sets the flag indicating if the cotnrol wants to receive update notifications.
- `SetWidth` — Sets the width of the control.
- `SetZOrder` — Sets the Z order of the control.


## Events

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

