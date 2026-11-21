# `Turbine.UI.TreeNode`

The base for any element that will be part of a tree view control.

This control is a container element that can be placed into a tree hierarchy. This base implementation has no built in functionality for expansion and collapsing. The programmer must explicitly call SetExpanded in response to mouse events.

**Inheritance:** `Turbine.Object` → `Turbine.UI.Control` → **Turbine.UI.TreeNode**

## Methods

### `Collapse()`

Collapses the node.

```lua
function TreeNode:Collapse();
```

### `CollapseAll()`

Collapses all the child tree nodes.

```lua
function TreeNode:CollapseAll();
```

### `EnsureVisible()`

Ensures that the node is visible within its tree.

```lua
function TreeNode:EnsureVisible();
```

This method will scroll the node into view.

### `Expand()`

Expands the node.

```lua
function TreeNode:Expand();
```

### `ExpandAll()`

Expands all the child tree nodes.

```lua
function TreeNode:ExpandAll();
```

### `GetChildNodes()`

Gets the child nodes list.

```lua
function TreeNode:GetChildNodes();
```

**Returns:** [TreeNodeList](Turbine.UI.TreeNodeList.md) — The list of child nodes.

Gets the child nodes list that can be used to manipulate the children of this node.

### `GetParentNode()`

Gets the parent node of this node.

```lua
function TreeNode:GetParentNode();
```

**Returns:** [TreeNode](Turbine.UI.TreeNode.md) — The parent TreeNode for this node. If this is a root node this will return nil.

### `IsExpanded()`

Gets a flag indicating if this node is currently expanded.

```lua
function TreeNode:IsExpanded();
```

**Returns:** `boolean` — True if this node is currently expanded.

### `IsSelected()`

Return true if this node is currently selected.

```lua
function TreeNode:IsSelected();
```

**Returns:** `boolean` — True if this node is currently selected.

### `SetExpanded()`

Sets the flag indicating if this node is currently expanded.

```lua
function TreeNode:SetExpanded(value);
```

**Parameters:**

- `value` (`boolean`) — True if this node should be expanded.

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

### `SelectedChanged`

Event fired when the selected state of the node has changed.

```lua
function TreeNode:SelectedChanged(sender, args);
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

