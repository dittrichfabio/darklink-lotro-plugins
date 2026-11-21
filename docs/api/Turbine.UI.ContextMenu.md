# `Turbine.UI.ContextMenu`

Defines a menu that can be displayed to the user.

Context menus are popup menus that can be displayed anywhere on the screen. They contain a collection of menu items that represents choices the user can make.Only one context menu can be displayed at a time and any user input outside of the context menu will cause the menu to be closed.

## Examples

This example will display a context menu at the current mouse position. A message will be display in the chat window displaying which option was clicked.

*Context Menu Example:*

```lua
       contextMenu = Turbine.UI.ContextMenu();
   
       -- Populate the menu with some items.
       menuItems = contextMenu:GetItems();
       menuItems:Add( Turbine.UI.MenuItem( "Red" ) );
       menuItems:Add( Turbine.UI.MenuItem( "Orange" ) );
       menuItems:Add( Turbine.UI.MenuItem( "Yellow" ) );
       menuItems:Add( Turbine.UI.MenuItem( "Green" ) );
       menuItems:Add( Turbine.UI.MenuItem( "Blue" ) );
       menuItems:Add( Turbine.UI.MenuItem( "Purple" ) );
   
       -- Register event handlers with all the menu items.
       local i;
   
       -- Register an event handler to display what menu item was clicked
       -- in the chat window.
       for i = 1, menuItems:GetCount() do
         local menuItem = menuItems:Get( i );
   
         menuItem.Click = function( sender, args )
           Turbine.Shell.WriteLine( "You have selected " .. sender:GetText() .. "." );
         end
       end
   
       -- Display the menu at the current mouse location.
       contextMenu:ShowMenu();
```

**Inheritance:** `Turbine.Object` → **Turbine.UI.ContextMenu**

## Methods

### `Close()`

Closes the menu if it is displayed.

```lua
function ContextMenu:Close();
```

Forces the menu to close itself if it is currently being displayed. This will not close any other menu except for the menu reference by this object.

### `GetItems()`

Gets the menu items collection.

```lua
function ContextMenu:GetItems();
```

**Returns:** [MenuItemList](Turbine.UI.MenuItemList.md) — Returns the menu items collection.

Gets the menu items collection. This collection can be used to iterate over the list or to manipulate it, adding or removing items.

### `ShowMenu()`

Displays the menu.

```lua
function ContextMenu:ShowMenu();
```

Displays the context menu at the current mouse position. The menu position will be adjusted to be display on screen if either the bottom or right edge falls off the edge of the screen.If there was a context menu already being displayed, it will first be closed before this menu is displayed.

### `ShowMenuAt()`

Displays the menu.

```lua
function ContextMenu:ShowMenuAt(x, y);
```

**Parameters:**

- `x` (`number`) — The x coordinate to display the menu at.
- `y` (`number`) — The y coordinate to display the menu at.

Displays the context menu at the specified position. The menu position will be adjusted to be display on screen if either the bottom or right edge falls off the edge of the screen.If there was a context menu already being displayed, it will first be closed before this menu is displayed.

