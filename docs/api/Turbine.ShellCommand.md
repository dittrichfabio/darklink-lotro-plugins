# `Turbine.ShellCommand`

A command that can be register for use in the chat window.

This class provides the ability to define custom chat window commands in a lua script. Commands are registers using the LuaShell class.

## Methods

### `Execute()`

Executes the command.

```lua
function ShellCommand:Execute(argumentText);
```

**Parameters:**

- `argumentText` (`string`) — The arguments string passed along with the command.

This method is called either by a script or execute when a user types a chat command registered for this shell command.

### `GetHelp()`

Gets the help information for the command.

```lua
function ShellCommand:GetHelp();
```

**Returns:** `string` — The help information for the command.

This method gets the extended help information for the command. It is suitable for this help text to contain newlines.

### `GetShortHelp()`

Gets a short help string for the command.

```lua
function ShellCommand:GetShortHelp();
```

**Returns:** `string` — A short help string for the command.

The short help text is the text display when a play displays the entire list of commands.

