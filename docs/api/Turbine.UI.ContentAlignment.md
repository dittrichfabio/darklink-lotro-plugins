# `Turbine.UI.ContentAlignment`

Specifies the alignment of content within a region.

## Fields

| Name | Description |
|---|---|
| **BottomCenter** | Position content at the bottom center of the region. |
| **BottomLeft** | Position content at the bottom left of the region. |
| **BottomRight** | Position content at the bottom right of the region. |
| **MiddleCenter** | Position content at the middle center of the region. |
| **MiddleLeft** | Position content at the middle left of the region. |
| **MiddleRight** | Position content at the middle right of the region. |
| **TopCenter** | Position content at the top center of the region. |
| **TopLeft** | Position content at the top left of the region. |
| **TopRight** | Position content at the top right of the region. |
| **Undefined** | Undefined positioning. |

Content alignment is used to position content within a rectangular region at one of the nine available positions.

## Examples

This example displays a TextBox with some text in it. Clicking on the button will cycle through the nine available content alignment positions.

*Content Alignment Example:*

```lua
      import "Turbine.UI";
      import "Turbine.UI.Lotro";
   
      -- Create a test window to display a status icon.
      window = Turbine.UI.Lotro.Window();
      window:SetPosition( 200, 200 );
      window:SetSize( 400, 220 );
      window:SetText( "Content Alignment Example" );
      window:SetVisible( true );
      
      -- Create a status icon and add it to the window.
      local textbox = Turbine.UI.Lotro.TextBox();
      textbox:SetParent( window );
      textbox:SetMultiline( true );
      textbox:SetPosition( 20, 40 );
      textbox:SetSize( 360, 140 );
      textbox:SetBackColor( Turbine.UI.Color( 1, 0.2, 0.2, 0.5 ) );
      textbox:SetTextAlignment( Turbine.UI.ContentAlignment.TopLeft );
      textbox:SetText( "The quick brown fox jumps over the lazy dog." );
      
      local switchAlignmentButton = Turbine.UI.Lotro.Button();
      switchAlignmentButton:SetParent( window );
      switchAlignmentButton:SetPosition( 70, 185 );
      switchAlignmentButton:SetSize( 300, 20 );
      switchAlignmentButton:SetText( "Change Alignment" );
      
      switchAlignmentButton.Click = function( sender, args )
      	-- Cycle through the content alignment on each click.
      	textbox:SetTextAlignment( ( textbox:GetTextAlignment() + 1 ) % 9 );
      end
```
