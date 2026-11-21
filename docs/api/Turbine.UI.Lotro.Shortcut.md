# `Turbine.UI.Lotro.Shortcut`

Encapsulates information about a short cut.

**Inheritance:** `Turbine.Object` → **Turbine.UI.Lotro.Shortcut**

## Constructors

### `Shortcut()`

Initializes a new shortcut.

```lua
function Shortcut:Shortcut();
```

Initializes a new shortcut.

```lua
function Shortcut:Shortcut(type, data);
```

**Parameters:**

- `type` ([ShortcutType](Turbine.UI.Lotro.ShortcutType.md)) — The type of shortcut that will be created.
- `data` (`string`) — the data string associated with this shortcut.

Initializes a new shortcut.

```lua
function Shortcut:Shortcut(item);
```

**Parameters:**

- `item` ([Item](Turbine.Gameplay.Item.md)) — The item to create the shortcut from.


## Methods

### `GetData()`

Gets the data associated with the shortcut.

```lua
function Shortcut:GetData();
```

**Returns:** `string` — The shortcut data.

### `GetItem()`

Converts a Shortcut to an Item.

```lua
function Shortcut:GetItem();
```

**Returns:** [Item](Turbine.Gameplay.Item.md) — The Item that was create from the shortcut or NIL if the shortcut was not a valid Item.

If the shortcut is an item shortcut, return an Item representation of the shortcut.

### `GetType()`

Gets the type of the shortcut.

```lua
function Shortcut:GetType();
```

**Returns:** [ShortcutType](Turbine.UI.Lotro.ShortcutType.md) — The shortcut type.

### `SetData()`

Sets the data associated with the shortcut.

```lua
function Shortcut:SetData(value);
```

**Parameters:**

- `value` (`string`) — The shortcut data.

### `SetType()`

Sets the type of the shortcut.

```lua
function Shortcut:SetType(value);
```

**Parameters:**

- `value` ([ShortcutType](Turbine.UI.Lotro.ShortcutType.md)) — The new shortcut type.

