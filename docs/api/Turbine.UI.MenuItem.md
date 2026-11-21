# `Turbine.UI.MenuItem`

Defines a menu item.

Menu items can be added to context menus and other menu items as submenu items that can then be displayed to the user to provide lists of actions.

**Inheritance:** `Turbine.Object` → **Turbine.UI.MenuItem**

## Constructors

### `MenuItem()`

Constructs a new menu item.

```lua
function MenuItem:MenuItem(text);
```

**Parameters:**

- `text` (`string`) — The text to use for the menu item.

Constructs a new menu item with the specified text.

Constructs a new menu item.

```lua
function MenuItem:MenuItem(text, enabled);
```

**Parameters:**

- `text` (`string`) — The text to use for the menu item.
- `enabled` (`boolean`) — Flag indicating if the menu item is enabled.

Constructs a new menu item with the specified text and enabled state.

Constructs a new menu item.

```lua
function MenuItem:MenuItem(text, enabled, checked);
```

**Parameters:**

- `text` (`string`) — The text to use for the menu item.
- `enabled` (`boolean`) — Flag indicating if the menu item is enabled.
- `checked` (`boolean`) — Flag indicating if the menu item is checked.

Constructs a new menu item with the specified text, enabled state and checked state.


## Methods

### `GetText()`

Gets the text of the menu item.

```lua
function MenuItem:GetText();
```

**Returns:** `string` — The text displayed for the item.

Gets the text display for the menu item.

### `IsChecked()`

Gets a flag indicating if the menu item is checked.

```lua
function MenuItem:IsChecked();
```

**Returns:** `boolean` — True if the menu item is checked.

### `IsEnabled()`

Gets a flag indicating if the menu item is enabled.

```lua
function MenuItem:IsEnabled();
```

**Returns:** `boolean` — True if the menu item is enabled.

### `SetChecked()`

Sets a flag indicating if the menu item is checked.

```lua
function MenuItem:SetChecked(value);
```

**Parameters:**

- `value` (`boolean`) — True if the menu item is checked.

### `SetEnabled()`

Sets a flag indicating if the menu item is enabled.

```lua
function MenuItem:SetEnabled(value);
```

**Parameters:**

- `value` (`boolean`) — True if the menu item is enabled.

### `SetText()`

Sets the text of the menu item.

```lua
function MenuItem:SetText(value);
```

**Parameters:**

- `value` (`string`) — The text displayed for the item.

Sets the text display for the menu item.


## Events

### `Click`

Event fired when a user clicks on the menu item.

```lua
function MenuItem:Click(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

