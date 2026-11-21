# `Turbine.Gameplay.WalletItem`

An item that is contained in a user's wallet.

This class represents an in-game wallet item that can be obtained and stored in a player's wallet.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.WalletItem**

## Methods

### `GetDescription()`

Gets the description of the wallet item.

```lua
function WalletItem:GetDescription();
```

**Returns:** `string` — The description of the wallet item.

### `GetImage()`

Gets the image used to identity the wallet item.

```lua
function WalletItem:GetImage();
```

**Returns:** `(Unrecognized type)` — The image used to identity the wallet item.

### `GetMaxQuantity()`

Gets the maximum quantity of this wallet item that a player can have.

```lua
function WalletItem:GetMaxQuantity();
```

**Returns:** `number` — The maximum quantity of this wallet item that a player can have.

### `GetName()`

Gets the name of the wallet item.

```lua
function WalletItem:GetName();
```

**Returns:** `string` — The name of the wallet item.

### `GetQuantity()`

Gets the quantity of the wallet item that the player has.

```lua
function WalletItem:GetQuantity();
```

**Returns:** `number` — The quantity of the wallet item that the player has.

### `GetSmallImage()`

Gets the small image used to identity the wallet item.

```lua
function WalletItem:GetSmallImage();
```

**Returns:** `(Unrecognized type)` — The small image used to identity the wallet item.

### `IsAccountItem()`

Gets a flag indicating if the item is shared across all characters of an account.

```lua
function WalletItem:IsAccountItem();
```

**Returns:** `boolean` — A flag indicating if the item is shared across all characters of an account.


## Events

### `MaxQuantityChanged`

Event fired when the max quantity of the wallet item changes.

```lua
function WalletItem:MaxQuantityChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `QuantityChanged`

Event fired when the quantity of the wallet item changes.

```lua
function WalletItem:QuantityChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

