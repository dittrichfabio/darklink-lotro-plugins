# `Turbine.UI.ListBox`

A simple list box for laying out child controls in a list.

A list box is simply a container that performs automatic layout of its children. Additionally it monitors for when any of its list items are clicked and tracks which element is currently selected.

## Examples

This examples creates a listbox and populates it with randomly colored child controls.

*Creating a Listbox:*

```lua
      window = Turbine.UI.Lotro.Window();
      window:SetPosition( 200, 200 );
      window:SetSize( 200, 200 );
      window:SetText( "Test" );
      window:SetVisible( true );
   
      listbox = Turbine.UI.ListBox();
      listbox:SetParent( window );
      listbox:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
      listbox:SetPosition( 30, 50 );
      listbox:SetSize( 140, 120 );
   
      for i = 1, 20 do
        local listItem = Turbine.UI.Control();
        listItem:SetSize( 40, 20 );
        listItem:SetBackColor( Turbine.UI.Color( math.random(), math.random(), math.random() ) );
        listbox:AddItem( listItem );
      end
```

**Inheritance:** `Turbine.Object` → `Turbine.UI.Control` → `Turbine.UI.ScrollableControl` → **Turbine.UI.ListBox**

## Methods

### `AddItem()`

Adds an item to the list box.

```lua
function ListBox:AddItem(item);
```

**Parameters:**

- `item` ([Control](Turbine.UI.Control.md)) — The item to add.

### `ClearItems()`

Clears all the items from the listbox.

```lua
function ListBox:ClearItems();
```

### `ContainsItem()`

Test is the list box contains an item.

```lua
function ListBox:ContainsItem(item);
```

**Parameters:**

- `item` ([Control](Turbine.UI.Control.md)) — The item to check for.

**Returns:** `boolean` — True if the list box contains the specified item.

### `EnsureVisible()`

Ensures that the specified item is visible.

```lua
function ListBox:EnsureVisible(index);
```

**Parameters:**

- `index` (`number`) — The one-based index of the item to scroll into view.

This method will scroll into view the specified item index.

### `GetFlippedLayout()`

Gets the flag indicating that the draw order should be flipped.

```lua
function ListBox:GetFlippedLayout();
```

**Returns:** `boolean` — True if flipped layout is enabled.

Gets the flag indicating that the listbox should flip the row-order for horizontal listboxes, and the column-order for vertical listboxes. When a horizontal listbox is flipped, the drawing starts on the last row and continues until each row is drawn, terminating on the first row. The default behavior is false and causes elements to render from the top left to the bottom right.

### `GetIgnoreCellAlignment()`

Gets the flag indicating that cell alignment is ignored during rendering.

```lua
function ListBox:GetIgnoreCellAlignment();
```

**Returns:** `boolean` — True if cell alignment is ignored.

Sets the flag indicating that cell alignment is ignored during rendering. When set to true, consecutive elements are always rendered immediately adjacent to their predecessor, regardless of the current column or row width specification. The default behavior is false which causes cells in a column or row to alway align with the width or height of its predecessor.

### `GetItem()`

Gets the item at the specified index.

```lua
function ListBox:GetItem(index);
```

**Parameters:**

- `index` (`number`) — The index of the item to get.

**Returns:** [Control](Turbine.UI.Control.md) — The item at the specified index.

### `GetItemAt()`

Gets the item at the specified position.

```lua
function ListBox:GetItemAt(x, y);
```

**Parameters:**

- `x` (`number`)
- `y` (`number`)

**Returns:** [Control](Turbine.UI.Control.md) — The item at the specified location in the list box otherwise if no item is there this will return nil.

Gets the item at the specified position. If no item is at that position, this returns nil.

### `GetItemCount()`

Gets the number of items in the list box.

```lua
function ListBox:GetItemCount();
```

**Returns:** `number` — The number of items in the list box.

### `GetMaxColumns()`

Gets the maximum number of columns a listbox can display.

```lua
function ListBox:GetMaxColumns();
```

**Returns:** `number` — The maximum number of columns a listbox can display per row.

Gets the maximum number of columns a listbox can display on a single row.

### `GetMaxItemsPerLine()`

Gets the maximum number of items per line. NOTE: Deprecated - Use GetMaxColumns() and GetMaxRows() instead.

```lua
function ListBox:GetMaxItemsPerLine();
```

**Returns:** `number` — The maximum number of elements per line.

Gets the maximum number of items to place in a single line, horizontally or vertically depending on the control's orientation, before advancing to the next line.

### `GetMaxRows()`

Gets the maximum number of rows a listbox can display.

```lua
function ListBox:GetMaxRows();
```

**Returns:** `number` — The maximum number of rows a listbox can display.

### `GetOrientation()`

Gets the orientation of elements in the listbox.

```lua
function ListBox:GetOrientation();
```

**Returns:** `number` — Returns either Horizontal or Vertical, indicating which direction elements are arranged in the listbox.

### `GetReverseFill()`

Gets the flag indicating if the listbox should fill in reverse.

```lua
function ListBox:GetReverseFill();
```

**Returns:** `boolean` — True if reverse fill is enabled.

Gets the flag indicating if the listbox should fill in reverse. When filling in reverse, elements start at the bottom right and fill to the top left of the listbox. The default behavior is false and causes elements to layout from the top left to the bottom right.

### `GetSelectedIndex()`

Gets the selected index.

```lua
function ListBox:GetSelectedIndex();
```

**Returns:** `number` — The currently selected index or 0 if no item is selected.

Gets the selected index. If nothing is selected this will return 0.

### `GetSelectedItem()`

Gets the currently selected item.

```lua
function ListBox:GetSelectedItem();
```

**Returns:** [Control](Turbine.UI.Control.md) — The currently selected item.

### `GetWrapIndentAmount()`

Gets the number of pixels to indent wrapped rows in a horizontal listbox or wrapped columns in a vertical listbox.

```lua
function ListBox:GetWrapIndentAmount();
```

**Returns:** `number` — The number of pixels to indent wrapped rows or columns.

Gets the number of pixels to indent wrapped rows in a horizontal listbox or wrapped columns in a vertical listbox. The default value is 0, resulting in no indentation.

### `IndexOfItem()`

Gets the index of an item in the list box.

```lua
function ListBox:IndexOfItem(item);
```

**Parameters:**

- `item` ([Control](Turbine.UI.Control.md)) — The item to get the index of.

**Returns:** `number` — The index of the item if it is in the list box otherwise -1.

### `InsertItem()`

Inserts an item to the list box.

```lua
function ListBox:InsertItem(index, item);
```

**Parameters:**

- `index` (`number`) — The index to insert the item at.
- `item` ([Control](Turbine.UI.Control.md)) — The item to insert.

### `RemoveItem()`

Removes an item from the list box.

```lua
function ListBox:RemoveItem(item);
```

**Parameters:**

- `item` ([Control](Turbine.UI.Control.md)) — The item to remove.

### `RemoveItemAt()`

Removes an item at the specified index.

```lua
function ListBox:RemoveItemAt(index);
```

**Parameters:**

- `index` (`number`) — The index of the item to remove.

### `SetFlippedLayout()`

Sets the flag indicating that the draw order should be flipped.

```lua
function ListBox:SetFlippedLayout(value);
```

**Parameters:**

- `value` (`boolean`) — True to enable layout flipping.

Sets the flag indicating that the listbox should flip the row-order for horizontal listboxes, and the column-order for vertical listboxes. When a horizontal listbox is flipped, the drawing starts on the last row and continues until each row is drawn, terminating on the first row. The default behavior is false and causes elements to render from the top left to the bottom right.

### `SetIgnoreCellAlignment()`

Sets the flag indicating that cell alignment is ignored during rendering.

```lua
function ListBox:SetIgnoreCellAlignment(value);
```

**Parameters:**

- `value` (`boolean`) — True to ignore cell alignment.

Sets the flag indicating that cell alignment is ignored during rendering. When set to true, consecutive elements are always rendered immediately adjacent to their predecessor, regardless of the current column or row width specification. The default behavior is false which causes cells in a column or row to alway align with the width or height of its predecessor.

### `SetItem()`

Sets the item at the specified index.

```lua
function ListBox:SetItem(index, item);
```

**Parameters:**

- `index` (`number`) — The index of the item to set.
- `item` ([Control](Turbine.UI.Control.md)) — The item to set at the specified index.

### `SetMaxColumns()`

Sets the maximum number of columns a listbox can display.

```lua
function ListBox:SetMaxColumns(value);
```

**Parameters:**

- `value` (`number`) — The maximum number of columns to display.

Sets the maximum number of columns to place in a single rows.

*Examples:*

This examples creates a listbox that lays out its elements from top to bottom but only allows at most 5 items per column and 4 rows.

*Creating a Multi Column Listbox:*

```lua
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
     
        listbox = Turbine.UI.ListBox();
        listbox:SetParent( window );
        listbox:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        listbox:SetPosition( 30, 50 );
        listbox:SetSize( 140, 120 );
        listbox:SetMaxRows( 4 );
        listbox:SetMaxColumns( 5 );
     
        for i = 1, 30 do
          local listItem = Turbine.UI.Control();
          listItem:SetSize( 20, 20 );
          listItem:SetBackColor( Turbine.UI.Color( math.random(), math.random(), math.random() ) );
          listbox:AddItem( listItem );
        end
```

### `SetMaxItemsPerLine()`

Sets the maximum number of items per line. NOTE: Deprecated - Use SetMaxColumns( i_value ) and SetMaxRows( i_value ) instead.

```lua
function ListBox:SetMaxItemsPerLine(value);
```

**Parameters:**

- `value` (`number`) — The maximum number of elements per line.

Sets the maximum number of items to place in a single line, horizontally or vertically depending on the control's orientation, before advancing to the next line.

*Examples:*

This examples creates a listbox that lays out its elements from top to bottom but only allows at most 5 items per column.

*Creating a Multi Column Listbox:*

```lua
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
     
        listbox = Turbine.UI.ListBox();
        listbox:SetParent( window );
        listbox:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        listbox:SetPosition( 30, 50 );
        listbox:SetSize( 140, 120 );
        listbox:SetMaxItemsPerLine( 5 );
     
        for i = 1, 30 do
          local listItem = Turbine.UI.Control();
          listItem:SetSize( 20, 20 );
          listItem:SetBackColor( Turbine.UI.Color( math.random(), math.random(), math.random() ) );
          listbox:AddItem( listItem );
        end
```

### `SetMaxRows()`

Sets the maximum number of rows a listbox can display.

```lua
function ListBox:SetMaxRows(value);
```

**Parameters:**

- `value` (`number`) — The maximum number of rows to display.

*Examples:*

This examples creates a listbox that lays out its elements from top to bottom but only allows at most 5 items per column and 4 rows.

*Creating a Multi Column Listbox:*

```lua
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
     
        listbox = Turbine.UI.ListBox();
        listbox:SetParent( window );
        listbox:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        listbox:SetPosition( 30, 50 );
        listbox:SetSize( 140, 120 );
        listbox:SetMaxRows( 4 );
        listbox:SetMaxColumns( 5 );
     
        for i = 1, 30 do
          local listItem = Turbine.UI.Control();
          listItem:SetSize( 20, 20 );
          listItem:SetBackColor( Turbine.UI.Color( math.random(), math.random(), math.random() ) );
          listbox:AddItem( listItem );
        end
```

### `SetOrientation()`

Sets the orientation of elements in the listbox.

```lua
function ListBox:SetOrientation(value);
```

**Parameters:**

- `value` (`number`) — Sets the direction in which elements are laid out in the listbox.

*Examples:*

This example demonstrates a listbox whose elements are laid out from left to right instead of top to bottom.

*Creating a Horizontal ListBox:*

```lua
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
     
        listbox = Turbine.UI.ListBox();
        listbox:SetParent( window );
        listbox:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        listbox:SetPosition( 30, 50 );
        listbox:SetSize( 140, 120 );
        listbox:SetOrientation( Turbine.UI.Orientation.Horizontal );
     
        for i = 1, 20 do
          local listItem = Turbine.UI.Control();
          listItem:SetSize( 20, 50 );
          listItem:SetBackColor( Turbine.UI.Color( math.random(), math.random(), math.random() ) );
          listbox:AddItem( listItem );
        end
```

### `SetReverseFill()`

Sets the flag indicating that the listbox should fill in reverse.

```lua
function ListBox:SetReverseFill(value);
```

**Parameters:**

- `value` (`boolean`) — True to enable reverse fill.

Sets the flag indicating that the listbox should fill in reverse. When filling in reverse, elements start at the bottom right and fill to the top left of the listbox. The default behavior is false and causes elements to layout from the top left to the bottom right.

*Examples:*

This examples creates a listbox that lays out its elements from the bottom right and fills towards the top left.

*Creating a Reverse Fill Listbox:*

```lua
        window = Turbine.UI.Lotro.Window();
        window:SetPosition( 200, 200 );
        window:SetSize( 200, 200 );
        window:SetText( "Test" );
        window:SetVisible( true );
     
        listbox = Turbine.UI.ListBox();
        listbox:SetParent( window );
        listbox:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
        listbox:SetPosition( 30, 50 );
        listbox:SetSize( 140, 120 );
        listbox:SetReverseFill( true );
     
        for i = 1, 23 do
          local listItem = Turbine.UI.Control();
          listItem:SetSize( 20, 20 );
          listItem:SetBackColor( Turbine.UI.Color( math.random(), math.random(), math.random() ) );
          listbox:AddItem( listItem );
        end
```

### `SetSelectedIndex()`

Sets the selected index.

```lua
function ListBox:SetSelectedIndex(index);
```

**Parameters:**

- `index` (`number`) — The index to select.

Sets the selected index. If the index is out of range, nothing will be selected.

### `SetSelectedItem()`

Sets the currently selected item.

```lua
function ListBox:SetSelectedItem(item);
```

**Parameters:**

- `item` ([Control](Turbine.UI.Control.md)) — The item to select.

### `SetWrapIndentAmount()`

Sets the number of pixels to indent wrapped rows in a horizontal listbox or wrapped columns in a vertical listbox.

```lua
function ListBox:SetWrapIndentAmount(value);
```

**Parameters:**

- `value` (`number`) — The number of pixels to indent wrapped rows or columns.

Sets the number of pixels to indent wrapped rows in a horizontal listbox or wrapped columns in a vertical listbox. The default value is 0, resulting in no indentation.

### `Sort()`

Sorts the elements in the list box.

```lua
function ListBox:Sort(sortMethod);
```

**Parameters:**

- `sortMethod` ([Object](Turbine.Object.md)) — The function used to sort the elements in the list box.

Sorts the elements in the list box using the given sort function. NOTE: The sort method must be consistent in its behavior. If a < b, then a must always be less than b. Failure to follow this rule can cause a client crash.

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

### `ItemAdded`

Event fired when an item is added.

```lua
function ListBox:ItemAdded(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ItemRemoved`

Event fired when an item is removed.

```lua
function ListBox:ItemRemoved(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `SelectedIndexChanged`

Event fired when the selected index has changed.

```lua
function ListBox:SelectedIndexChanged(sender, args);
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

