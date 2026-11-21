# `Turbine.Gameplay.Party`

This class provides access to party information. This is either your fellowship or your tribe depending on your alliance.

**Inheritance:** `Turbine.Object` → **Turbine.Gameplay.Party**

## Methods

### `GetAssistTarget()`

Gets the specified assist target.

```lua
function Party:GetAssistTarget(index);
```

**Parameters:**

- `index` (`number`) — The index of the assist target to get.

**Returns:** [Player](Turbine.Gameplay.Player.md) — The assist target at the specified index.

### `GetAssistTargetCount()`

Gets the number of assist targets for the party.

```lua
function Party:GetAssistTargetCount();
```

**Returns:** `number` — Returns the numbers of assist targets for the party.

### `GetLeader()`

Gets the leader of the fellowship.

```lua
function Party:GetLeader();
```

**Returns:** [Player](Turbine.Gameplay.Player.md) — The leader of the fellowship.

### `GetMember()`

Gets the specified member.

```lua
function Party:GetMember(index);
```

**Parameters:**

- `index` (`number`) — The index of the member to get.

**Returns:** [Player](Turbine.Gameplay.Player.md) — The member at the specified index.

### `GetMemberCount()`

Gets the number of members in the party.

```lua
function Party:GetMemberCount();
```

**Returns:** `number` — Returns the numbers of members in the party.

### `IsAssistTarget()`

Test if the given play is an assist target of this party.

```lua
function Party:IsAssistTarget(player);
```

**Parameters:**

- `player` ([Player](Turbine.Gameplay.Player.md)) — The player to test.

**Returns:** `boolean` — True if the player is an assist target of this party.

### `IsMember()`

Test if the given play is a member of this party.

```lua
function Party:IsMember(player);
```

**Parameters:**

- `player` ([Player](Turbine.Gameplay.Player.md)) — The player to test.

**Returns:** `boolean` — True if the player is a member of this party.


## Events

### `AssistTargetAdded`

Event fired when an assist target has been added.

```lua
function Party:AssistTargetAdded(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `AssistTargetRemoved`

Event fired when an assist target has been removed.

```lua
function Party:AssistTargetRemoved(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `LeaderChanged`

Event fired when the leader of the fellowship has changed.

```lua
function Party:LeaderChanged(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MemberAdded`

Event fired when a member has joined the party.

```lua
function Party:MemberAdded(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

### `MemberRemoved`

Event fired when a member has been removed from the party.

```lua
function Party:MemberRemoved(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

