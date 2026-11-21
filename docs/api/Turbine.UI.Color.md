# `Turbine.UI.Color`

Represents a 4 channel color with red, green, blue, and alpha.

A simple color class with the following fields directly accessible in lua script: R, G, B, and A. The color components are number values in the range of 0.0 to 1.0.The red component.The green component.The blue component.The alpha component.

## Examples

This example demonstrates the Color class.

*Demonstrates a Color:*

```lua
      newColor = Turbine.UI.Color();
      newColor.R = 1.0;
      newColor.G = 1.0;
      newColor.B = 0.0;
      newColor.A = 1.0;
   
      blue = Turbine.UI.Color( 0, 0, 1 );
   
      -- Pass the colors to any control to set their colors.
```

**Inheritance:** `Turbine.Object` → **Turbine.UI.Color**

## Constructors

### `Color()`

Initializes a new color.

```lua
function Color:Color();
```

Initializes a new color set to black.

*Examples:*

Creates a new color.

*Creating a Color:*

```lua
        -- Creates a new color that defaults to transparent.
        local color = Turbine.UI.Color();
```

Initializes a new color from r, g, b components.

```lua
function Color:Color(r, g, b);
```

**Parameters:**

- `r` (`number`) — The red component.
- `g` (`number`) — The green component.
- `b` (`number`) — The blue component.

Initializes a new color from the specified color components. The color components should all be number values in the range of 0.0 to 1.0. The alpha of the new color is set to 1.0.

*Examples:*

Creates a new color.

*Creating a Color:*

```lua
        -- Creates a new color that is blue.
        local color = Turbine.UI.Color( 0.0, 0.0, 1.0 );
```

Initializes a new color from a, r, g, b components.

```lua
function Color:Color(a, r, g, b);
```

**Parameters:**

- `a` (`number`) — The alpha component.
- `r` (`number`) — The red component.
- `g` (`number`) — The green component.
- `b` (`number`) — The blue component.

Initializes a new color from the specified color components. The color components should all be number values in the range of 0.0 to 1.0.

*Examples:*

Creates a new color.

*Creating a Color:*

```lua
        -- Creates a new color that is a semitransparent blue.
        local color = Turbine.UI.Color( 0.5, 0.0, 0.0, 1.0 );
```

