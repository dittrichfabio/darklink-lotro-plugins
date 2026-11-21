# `Turbine.Shell`

Provides programmer extensibility to the chat window.

This class enables plugins to access the chat window shell, allowing them to register their own commands and query the list of commands available. The ability to execute commands is protected and not available to user mods.

## Examples

This example demonstrates how to test if a command is available.

*Checking for a command:*

```lua
      local canDance = Turbine.Shell.IsCommand("dance");
      Turbine.Shell.WriteLine("Does the dance command exist? " .. canDance );
```

## Methods

### `AddCommand()`

Adds a command that can be executed.

```lua
function Shell.AddCommand(name, shellCommand);
```

**Parameters:**

- `name` (`string`) — The name of the command that can be execute. Multiple names can be specified by separating them using a semicolon ';'.
- `shellCommand` ([ShellCommand](Turbine.ShellCommand.md)) — The shell command to bind to the names.

**Returns:** `number` — The number of names from the name argument that were successful registered.

This method will attempt to register the shell command specified for each of the names specified in the semicolon separated list of names passed into the name argument.The return value indicates how many of the names were successful registered. This may be less than the number of names specified if some of the names are already bound to other commands in the shell.

### `GetCommands()`

Gets the list of commands available by the shell.

```lua
function Shell.GetCommands();
```

**Returns:** `string` — The list of available commands that can be executed.

This method will return a list of strings that identifies all the commands that can be executed from a user's chat window. This list includes all aliases for commands as well.

### `IsCommand()`

Test if the specified name is a registered shell command.

```lua
function Shell.IsCommand(name);
```

**Parameters:**

- `name` (`string`) — The name of the command to check for the existence of.

**Returns:** `boolean` — True if the command is registered.

This method can be used to see if a shell command already exists. Attempts to add a shell command when there is already a command registered will fail to register.

### `RemoveCommand()`

Removes a command that has been added using AddCommand.

```lua
function Shell.RemoveCommand(shellCommand);
```

**Parameters:**

- `shellCommand` ([ShellCommand](Turbine.ShellCommand.md)) — The shell command to unregister. This removes the registration from all the names that use the shell command.

**Returns:** `number`

This method will remove all the references to the shell command that were registered using AddCommand.

### `WriteLine()`

Writes a line of text to the chat window.

```lua
function Shell.WriteLine(text);
```

**Parameters:**

- `text` (`string`) — The text to display.

This method takes in a string and displays the text in the chat window. This text is marked as standard text for chat filtering purposes.

