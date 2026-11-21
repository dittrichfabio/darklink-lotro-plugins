# `Turbine.UI.Graphic`

Represents a graphic resources that is loaded from the DAT files or from disk.

**Inheritance:** `Turbine.Object` → **Turbine.UI.Graphic**

## Constructors

### `Graphic()`

Constructs an empty graphics.

```lua
function Graphic:Graphic();
```

Constructs a graphic from a game asset by its ID.

```lua
function Graphic:Graphic(dataId);
```

**Parameters:**

- `dataId` (`(Unrecognized type)`)

Constructs a graphic from a file.

```lua
function Graphic:Graphic(filename);
```

**Parameters:**

- `filename` (`string`)

