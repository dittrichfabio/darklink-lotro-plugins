# `Turbine.UI.TreeView`

A control to display data in a tree.

This control display a hierarchy of nodes that can be expanded and collapsed. This base control does not automatically expand or collapse nodes. It is the responsibility of the scripter to invoke the SetExpanded method on the nodes in response to user input.

## Examples

This example demonstrates creating a tree view control and populating it with nodes.

*Using a TreeView:*

```lua
   
    -- Define a tree node class to put into the tree.
    MyTreeNode = class( Turbine.UI.TreeNode );
    
    function MyTreeNode:Constructor()
    	Turbine.UI.TreeNode.Constructor( self );
    	
    	self:SetBackColor( Turbine.UI.Color( math.random(), math.random(), math.random() ) );
    	self:SetSize( 100, 18 );
    end
    
    -- Create the container window.
    window = Turbine.UI.Lotro.Window();
    window:SetSize( 400, 400 );
    window:SetPosition( 100, 100 );
    window:SetText( "Treeview test" );
    window:SetVisible( true );
    
    -- Create the tree view control.
    treeView = Turbine.UI.TreeView();
    treeView:SetParent( window );
    treeView:SetPosition( 10, 50 );
    treeView:SetSize( 300, 200 );
    treeView:SetBackColor( Turbine.UI.Color( 0.2, 0.2, 0.2 ) );
    treeView:SetIndentationWidth( 15 );
    
    -- Give the tree view a scroll bar.
    scriptTextScrollBar = Turbine.UI.Lotro.ScrollBar();
    scriptTextScrollBar:SetOrientation( Turbine.UI.Orientation.Vertical );
    scriptTextScrollBar:SetParent( window );
    scriptTextScrollBar:SetPosition( 300, 50 );
    scriptTextScrollBar:SetSize( 10, 200 );
    
    treeView:SetVerticalScrollBar( scriptTextScrollBar );
    
    -- Populate the test nodes.
    rootNodes = treeView:GetNodes();
    
    local i;
    local j;
    
    for i = 1, 5 do
    	local node = MyTreeNode();
    	rootNodes:Add( node );
    
    	local subNodes = node:GetChildNodes();
    
    	for j = 1, 5 do
    		local node = MyTreeNode();
    		subNodes:Add( node );
    
    		local subNodes = node:GetChildNodes();
    
    		for k = 1, 5 do
    			local node = MyTreeNode();
    			subNodes:Add( node );
    
    			local subNodes = node:GetChildNodes();
    
    			for l = 1, 5 do
    				local node = MyTreeNode();
    				subNodes:Add( node );
    /// 			end
    		end
    	end
    end
```

**Inheritance:** `Turbine.Object` → `Turbine.UI.Control` → `Turbine.UI.ScrollableControl` → **Turbine.UI.TreeView**

## Methods

### `CollapseAll()`

Collapses all nodes in the tree view.

```lua
function TreeView:CollapseAll();
```

### `ExpandAll()`

Expands all nodes in the tree view.

```lua
function TreeView:ExpandAll();
```

### `GetFilter()`

Gets a filter used to filter tree items.

```lua
function TreeView:GetFilter();
```

**Returns:** [Object](Turbine.Object.md) — The filter used to filter tree items.

### `GetIndentationWidth()`

Gets the width of the indentation insert prefer nodes at each level in the tree.

```lua
function TreeView:GetIndentationWidth();
```

**Returns:** `number` — The width in pixels to indent nested levels of tree nodes.

### `GetNodes()`

Gets the root nodes in the tree view control.

```lua
function TreeView:GetNodes();
```

**Returns:** [TreeNodeList](Turbine.UI.TreeNodeList.md) — The collection of root nodes in the tree view.

### `GetSelectedNode()`

Gets the currently selected node.

```lua
function TreeView:GetSelectedNode();
```

**Returns:** [TreeNode](Turbine.UI.TreeNode.md) — The currently selected node.

### `GetSortMethod()`

Gets a function that is used to sort tree elements.

```lua
function TreeView:GetSortMethod();
```

**Returns:** [Object](Turbine.Object.md) — The function to sort tree elements.

### `Refresh()`

Causes the tree view to refilter and resort.

```lua
function TreeView:Refresh();
```

### `SetFilter()`

Sets a filter used to filter tree items.

```lua
function TreeView:SetFilter(value);
```

**Parameters:**

- `value` ([Object](Turbine.Object.md)) — The filter used to filter tree items.

### `SetIndentationWidth()`

Sets the width of the indentation insert prefer nodes at each level in the tree.

```lua
function TreeView:SetIndentationWidth(value);
```

**Parameters:**

- `value` (`number`) — The width in pixels to indent nested levels of tree nodes.

### `SetSelectedNode()`

Sets the currently selected node.

```lua
function TreeView:SetSelectedNode(value);
```

**Parameters:**

- `value` ([TreeNode](Turbine.UI.TreeNode.md)) — The node to select.

### `SetSortMethod()`

Sets a function that is used to sort tree elements. This function needs to enforce consistent ordering or there is a potential for a client crash.

```lua
function TreeView:SetSortMethod(value);
```

**Parameters:**

- `value` ([Object](Turbine.Object.md)) — The function to sort tree elements.

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

### `SelectedNodeChanged`

Event fired when the selected node has changed.

```lua
function TreeView:SelectedNodeChanged(sender, args);
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

