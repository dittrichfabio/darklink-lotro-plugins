# `Turbine.UI.Display`

Provides display information.

This class provides information about the current game display. This includes information like the current game resolution.

## Examples

This example will display a window that has been centered within the screen.

*Centering a Window:*

```lua
      import "Turbine.UI.Lotro";
      
      window = Turbine.UI.Lotro.Window();
      window:SetSize( 200, 200 );
      window:SetText( "Hello!" );
      window:SetVisible( true );
      
      local displayWidth, displayHeight = Turbine.UI.Display.GetSize();
      local windowWidth, windowHeight = window:GetSize();
      
      window:SetPosition( ( displayWidth - windowWidth ) / 2, ( displayHeight - windowHeight ) / 2 );
```

## Methods

### `GetHeight()`

Gets the height of the display.

```lua
function Display.GetHeight();
```

**Returns:** `number` — The display height.

This methods gets the current display height.

### `GetMousePosition()`

Gets the position of the mouse.

```lua
function Display.GetMousePosition();
```

**Returns:** `number, number` — The position of the mouse in screen coordinates.

Gets the position of the mouse in screen coordinates.

### `GetMouseX()`

Gets the X position of the mouse.

```lua
function Display.GetMouseX();
```

**Returns:** `number` — The X position of the mouse in screen coordinates.

Gets the X position of the mouse in screen coordinates.

### `GetMouseY()`

Gets the Y position of the mouse.

```lua
function Display.GetMouseY();
```

**Returns:** `number` — The Y position of the mouse in screen coordinates.

Gets the Y position of the mouse in screen coordinates.

### `GetSize()`

Gets the size of the display window for the game.

```lua
function Display.GetSize();
```

**Returns:** `number, number` — The horizontal and vertical resolution as two values.

This method gets the resolution the game is being displayed in as a pair of numbers that correspond to the horizontal and vertical resolution.

### `GetWidth()`

Gets the width of the display.

```lua
function Display.GetWidth();
```

**Returns:** `number` — The display width.

This methods gets the current display width.

