# `Turbine.Engine`

Provides engine level information to user plugins.

The engine class provides information about the current state of the game engine.

**Inheritance:** **Turbine.Engine**

## Methods

### `GetCallStack()`

Gets the current callstack.

```lua
function Engine.GetCallStack(arguments);
```

**Parameters:**

- `arguments` (`(Unrecognized type)`)

**Returns:** `string` — The current callstack.

This method is equivalent to debug.traceback, returning the callstack.

### `GetDate()`

Gets the current date.

```lua
function Engine.GetDate();
```

**Returns:** [Object](Turbine.Object.md) — Returns a table containing information about the current date. The following fields are available: Year, Month, Day, Hour, Minute, Second, DayOfWeek, DayOfYear, and IsDST.

### `GetGameTime()`

Gets the current relative game time.

```lua
function Engine.GetGameTime();
```

**Returns:** `number` — Returns a relative game time in seconds.

Gets the current game time as a relative value that can be used for delta time processing.

*Examples:*

This example demonstrates using GetGameTime to calculate the delta time over multiple updates for performing animations.

*Calculating Delta Time:*

```lua
        local currentGameTime = Turbine.Engine.GetGameTime();
        local delta = currentGameTime - previousGameTime;
        previousGameTime = currentGameTime;
     
        -- Performing a translation from one position to another over a 5
        -- second period.
        self:SetLeft( self.startLeft + ( self.endLeft - self.StartLeft ) * ( delta / 5 ) );
```

### `GetLanguage()`

Gets the language the client is using.

```lua
function Engine.GetLanguage();
```

**Returns:** `number` — The language the client is using.

### `GetLocale()`

Gets a string identify the locale the application is set to.

```lua
function Engine.GetLocale();
```

**Returns:** `string` — The locale identifier.

### `GetLocalTime()`

Gets the number of seconds since 1/1/1970.

```lua
function Engine.GetLocalTime();
```

**Returns:** `number` — The number of seconds since 1/1/1970.

### `GetScriptVersion()`

Gets the major and minor versions numbers for the Lua script system.

```lua
function Engine.GetScriptVersion();
```

**Returns:** `number, number`

The version information is returns as a major and minor version number. This number is not tied to the client build number and is only updated when changes to the API are made. These changes may include the addition of new APIs, the removal, changes to the functionality, or bug fixes. A new version does not necessarily mean incompatibility.

### `ScriptLog()`

Logs a message to the script log.

```lua
function Engine.ScriptLog(message);
```

**Parameters:**

- `message` (`string`) — The message to log.

Logs a message to the script log. This is a shared log for all scripts that can be used to write information for a running script.

