# `Turbine.UI.TreeNodeList`

Defines a list of controls.

This class is directly used by a Control class to maintain its list of child controls. From this list other controls can be added or removed as children of the owner control.

**Inheritance:** `Turbine.Object` → **Turbine.UI.TreeNodeList**

## Methods

### `Add()`

Adds a tree node.

```lua
function TreeNodeList:Add(node);
```

**Parameters:**

- `node` ([TreeNode](Turbine.UI.TreeNode.md)) — The tree node to add.

### `Clear()`

Clears the nodes from the list.

```lua
function TreeNodeList:Clear();
```

### `Contains()`

Test is the list contains a specific tree node.

```lua
function TreeNodeList:Contains(node);
```

**Parameters:**

- `node` ([TreeNode](Turbine.UI.TreeNode.md)) — The node to check for.

**Returns:** `boolean` — True if the node is contained in the list.

### `Get()`

Gets the node at the specified index.

```lua
function TreeNodeList:Get(index);
```

**Parameters:**

- `index` (`number`) — The index of the node to retrieve.

**Returns:** [TreeNode](Turbine.UI.TreeNode.md) — The tree node at the specified index.

### `GetCount()`

Gets the number of tree nodes.

```lua
function TreeNodeList:GetCount();
```

**Returns:** `number` — The number of tree nodes.

### `IndexOf()`

Gets the index of a tree node in the list.

```lua
function TreeNodeList:IndexOf(node);
```

**Parameters:**

- `node` ([TreeNode](Turbine.UI.TreeNode.md)) — The node to get the index of.

**Returns:** `number` — The index of the node in the list or -1 if it does not exist in the list.

### `Remove()`

Removes a tree node from the list.

```lua
function TreeNodeList:Remove(node);
```

**Parameters:**

- `node` ([TreeNode](Turbine.UI.TreeNode.md)) — The node to remove.

### `RemoveAt()`

Removes a tree node at the specified index.

```lua
function TreeNodeList:RemoveAt(index);
```

**Parameters:**

- `index` (`number`) — The index of the node to remove.

