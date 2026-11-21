# `Turbine.Chat`

This class provides events for when messages are received through the game. This includes player chat, tells, in game messages, and announcements.

**Inheritance:** `Turbine.Object` → **Turbine.Chat**

## Events

### `Received`

This event is fired whenever a chat message is received.

```lua
function Chat:Received(sender, args);
```

**Parameters:**

- `sender` (`table`) — The event sender.
- `args` (`table`) — The event arguments

This event is fired whenever any chat message is received from the game or other users. The arguments for this event will contain a combination of a Sender, a ChatType, and the Message itself. The ChatType enumeration can be used to determine what kind of message was received.

