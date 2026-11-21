# `Turbine.Gameplay.Wallet`

Provides access to a player's wallet.

The wallet is a container for various currency based items.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.Wallet**

## Methods

### `GetItem()`

Gets a wallet item from the player's wallet.

```lua
function Wallet:GetItem(index);
```

**Parameters:**

- `index` (`number`) — The index of the item to get.

**Returns:** [WalletItem](Turbine.Gameplay.WalletItem.md) — The WalletItem at the specified index..

This method will return a WalletItem out of the player's wallet at the specified index. The index must be in the range of 1 to GetSize.

### `GetSize()`

Gets the number of items in the player's wallet.

```lua
function Wallet:GetSize();
```

**Returns:** `number` — The number of items in the player's wallet.

This returns the number of items in the player's wallet.


## Events

### `ItemAdded`

Event fired when an item is added to the wallet.

```lua
function Wallet:ItemAdded(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `ItemRemoved`

Event fired when an item is removed from the wallet.

```lua
function Wallet:ItemRemoved(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

