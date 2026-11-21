## Post 1 — Garan 2025-06-16T20:26:04-0400

### Before You Begin

  
The tools you will need are fairly simple. First, you will need a language reference. I personally use <http://www.lua.org/manual/5.1/> which is fairly easy to understand and navigate.  
  
Second, you will want the Turbine API documentation. As of the time this guide was written, the lastest Official API docs are on the LoTROInterface.com website at <https://www.lotrointerface.com/downloads/info1054-OfficialUpdate25LuaDocumentation.html>. Additionally, there is an unofficial version at <https://www.lotrointerface.com/downloads/info1192-LotroDocumentationWIP.html>.  
  
You will need an editor, a simple text editor like Notepad will suffice but some users prefer syntax highlighting editors or project managers to organize their files (I generally just use Notepad). Note, if you are using an older version of Notepad (pre-Windows 11) you will have issues with saving special characters as the UTF8 encoding includes BOM (Byte Order Mark) and Lotro's Lua parser only reads UTF8 encoded files that are without BOM. In this case, you can either use escape sequences for special characters or use a different editor. Using escape sequences is fine if you only have a few special characters but if you are supporting something like Russian, then you will definitely want a text editor that saves UTF8 without BOM. In Lua strings, the "\" character is a special escape character that precedes a numeric value representing a decimal byte value (0-255). To represent a special character, you simply embed the byte values for it's UTF-8 encoding, for example the "â" character is byte values 195 130 (hex values 0xC3 0x82) so, in a Lua string, \195\130 represents the "â" character. Again, I would not recommend using the escaped character codes method if you need to have more than a dozen or so special characters as it makes the file harder to read and maintain. UTF-8 without BOM file encoding is much better.  
  
If you plan on using any custom graphics, you will want an image editor that can generate .jpg and/or .tga files as these are the only file formats that LoTRO Lua will display.  
  
The last thing you might want are some sample plugins to dissect and play around with. Turbine published a package of sample files which can be downloaded in a 7zip archive from <http://content.turbine.com/sites/lotro/lua/Beta_LuaPlugins.7z> You may also want to check out LoTROInterface.com or other plugin sources. One of the best ways to learn is to dig in, twist, pull, yank and turn and see what happens   
  
One rule to bear in mind, most things dealing with Lua are case sensitive so if you keep getting a nil value or an error that a function doesn't exist or any other mysterious error, always double check that you have the correct case.

---

## Post 2 — Garan 2025-06-16T20:26:37-0400

### Getting Started

  
Every plugin has at least two elements, a .plugin definition file and one or more .lua code files. The .plugin file must be in a subfolder of the "My Documents\The Lord of the Rings\Plugins" folder (there are slight variations on the path to My Documents based on operating system versions and use of online storage like OneDrive). The most common accepted standard for folder structure is:  
..\Plugins\  
AuthorName\  
PluginName\  
Resources  
  
"AuthorName" is a distinct folder used to group all plugins written by an author. The "AuthorName" folder usually contains only .plugin definition files and subfolders. Each plugin then generally has a subfolder with a name based on the plugin. The "PluginName" folder generally contains all of the .lua code files for a plugin unless the plugin uses files from a shared library. The major benefit of using a shared library for common classes is that code can be maintained in one location. The major drawback of using a shared library is that any changes to the shared code can potentially cause undesirable effects in plugins. I generally prefer to keep a separate copy of all .lua files in each plugin folder so that I will not run into compatibility issues (a distant cousin of that old plague called "DLL Hell") if someone wants to only update one of several plugins that might use a common class file.  
  
The .plugin file is an xml file with the structure:  

Code: 
    
    
    <?xml version="1.0"?>
    <Plugin>
        <Information>
            <Name>PluginName</Name>
            <Author>AuthorName</Author>
            <Version>VersionNumber</Version>
            <Description>YourPluginDescription</Description>
            <Image>ImagePath</Image>
        </Information>
        <Package>pathToMainLuaFile</Package>
        <Configuration Apartment="ApartmentName" />
    </Plugin>

  
"PluginName" is the name used to load the plugin with the "/plugins load PluginName" as well as how it will appear in game in the "/plugins list" and "/plugins refresh" commands. If you use a plugin manager (a plugin that controls loading other plugins) this is also the name that will be listed in the manager.  
  
"AuthorName" is the name of the plugin author and is only included for documentary/organizational purposes. This has no actual impact on the functioning of the plugin but can be accessed programmatically using the Plugins table.  
  
"VersionNumber" is the version that will be displayed in the "/plugins list", "/plugins refresh" and plugin manager lists. This value can also be used programmatically for tagging saved data and automatically processing data updates.  
  
"YourPluginDescription" is the text that will display in the Turbine Plugin Manager  
  
"ImagePath" is the path to a .JPG or .TGA file. Note, if the file is greater than 32x32 it will be cropped to 32x32. If the image is less than 32x32 it will be tiled. This image will be displayed in the Turbine Plugin Manager  
  
The "pathToMainLuaFile" value is the path relative to the Plugins folder to the main Lua code file. Note that the path uses "." as a folder separator instead of "\" or "/". This is usually the first file that will be loaded, parsed and processed. However, it is possible to supersede the processing of this file by including a "__init__.lua" file in the same folder as this file (this will be discussed further in the next section).  
  
The Configuration setting is optional and will allow a plugin to run in its own Apartment or address space, meaning that it will get its own copy of all Turbine objects and global environment. The most common reasons for including a Configuration setting are to allow a plugin to be unloaded without affecting other plugins or to prevent other plugins from interfering with global values and event handlers. If your plugin does not need to be unloaded and if it uses safe event handlers (discussed later) then you probably do not need a separate apartment. Note that using a separate apartment will significantly increase the amount of memory used by the Lua system since multiple copies of the environment and global objects must be created for each apartment.  
  
One important thing to remember, Plugins are not unloaded, Apartments are unloaded. That is, when you use the "/plugins unload ApartmentName" command you are unloading all of the plugins that share that apartment.

---

## Post 3 — Garan 2025-06-16T20:27:09-0400

### __init_.lua Files

  
Before processing any files in a folder, the Lua system will look for a __init__.lua file and if one is found it will be processed first. The __init__.lua file is used to "import" or include code from multiple files in the same folder. This eliminates the need to put separate "import" statements in the other .lua files as all files in the __init__.lua file will be automatically imported. It is important to note that the files will be processed in the order in which they are imported in the __init__.lua file so if any file depends on an object or function defined in another file the dependent file must be loaded after the one that defines the object or function. The __init__.lua file will be processed before the main Lua file in the Package setting of the .plugin file. The __init__.lua file should only import files that are in its own folder. Each folder or subfolder may have its own __init__.lua file.

---

## Post 4 — Garan 2025-06-16T20:27:40-0400

### Loading a Plugin

  
There are several ways to load a plugin. The user can use the Plugin Manager in the client, accessed from the system menu, System-> Plugin Manager and in the manager scroll down to _pluginName_ and click Load. The user can use a Lua plugin to programmatically load a plugin, using Turbine.PluginManager.LoadPlugin("_pluginName_ "). The user can use a chat command to load the plugin, "/plugins load _pluginName_ ". They all result in the same sequence of events when the plugin actually loads.  
  
No matter what mechanism starts the loading process, the first step is the .plugin file with a Name setting matching pluginName will be processed. If the .plugin file contains a Configuration setting with a distinct Apartment name and that Apartment does not yet exist, a new global environment is created, otherwise the default shared global environment is used. The Lua system looks in the folder containing the file pointed to by the Package setting for a __init__.lua file and if one is found it is processed. Once the __init__.lua file is processed, the file in the Package setting is loaded, parsed and executed. Since Lua is a scripting language, each statement (which may span multiple lines) is processed in sequence. The parser will continue reading the file until it reaches the end of an executable statement at which point that statement is executed - note, multiple statements may be in the same file line seperated by semi-colons. A semi-colon can be used to terminate a statement but is not required if there is nothing else on that line. If the parser detects an error prior to completing processing the main file an error message will be generated and the plugin will not complete loading (this behaviour can be overridden and will be discussed in a later exception). Code within functions is compiled but variables and external references are not evaluated until the function is called so it is possible for an error within a function to manifest well after the plugin is loaded and running.  
  
Note, until the plugin completes loading and the main file is fully parsed and executed, the plugin is in a special state I call the Loading state. This state enables two special features. First, the plugin can access .plugindata files without any delay - access to these files after the plugin is loaded but prior to being unloaded will be delayed and the results asynchronously returned to a callback function. This is further discussed in Plugin State and Saved Data. The second feature is the special temporary "plugin" variable (note it is all lowercase). While loading, the plugin can reference itself by simply referring to the temporary variable "plugin" in order to assign event handlers, etc. Once loaded though, the "plugin" variable is no longer available and the author must use the Plugins table which is indexed by the plugin name, so MoorMap would be Plugins["MoorMap"]. This simplifies assigning the unload event handler - prior to implementing the "plugins" variable, authors had to assign the unload handler in an Update event handler which fired during the first frame rendering after the plugin loaded which was an awkward and cumbersome mechanism.

---

## Post 5 — Garan 2025-06-16T20:28:13-0400

At this point, you are probably ready for your first plugin. Tradition demands that we start with a simple Hello World plugin. The first thing to do is create a .plugin file. We shall call this one, HelloWorld.plugin and it should be saved in the MyDocuments\The Lord of the Rings\Plugins\YourName folder:  

Code: 
    
    
    <?xml version="1.0"?>
    <Plugin>
     <Information>
      <Name>HelloWorld</Name>
      <Author>YourName</Author>
      <Version>1.00</Version>
     </Information>
     <Package>YourName.HelloWorld.Main</Package>
    </Plugin>

Note that there is no Configuration tag as this example hardly requires the need to be unloaded separately nor does it need to load or save data in real time and has no event handlers for shared objects.  
  
The next step is to create the Main.lua file which should be saved in the MyDocuments\The Lord of the Rings\Plugins\YourName\HelloWorld folder.  

Code: 
    
    
    import "Turbine.UI"; -- this will expose the label control that we will implement
    import "Turbine.UI.Lotro"; -- this will expose the standard window that we will implement
    HelloWindow=Turbine.UI.Lotro.Window(); -- we call the constructor of the standard window object to create an instance
    HelloWindow:SetSize(200,200); -- sets the window size to 200 by 200 pixels
    HelloWindow:SetPosition(Turbine.UI.Display:GetWidth()/2-100,Turbine.UI.Display:GetHeight()/2-100); -- centers the window in the display
    HelloWindow:SetText("Hello World Window"); -- assigns the title bar text
    HelloWindow.Message=Turbine.UI.Label(); -- create a label control to display our message
    HelloWindow.Message:SetParent(HelloWindow); -- sets the label as a child of the main window
    HelloWindow.Message:SetSize(180,20); -- sets the message size
    HelloWindow.Message:SetPosition(10,90); -- places the message control in the vertical middle of the window with a 10 pixel left and right border
    HelloWindow.Message:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter); -- centers the text in the message control both horizontally and vertically
    HelloWindow.Message:SetText("Hello World"); -- sets the actual message text
    HelloWindow:SetVisible(true); -- display the window (windows are not visible by default)

After creating the files, load the game and type "/plugins list". If you created the files in the correct location, you will see an entry for HelloWorld (1.00) in the list. This is a good first check to be sure that the files are in the correct location. If they are not, be sure to double check the path you are using is your documents folder, NOT the Program Files folder where the LoTRO programs are installed.  
  
Once you have verified that the plugin is in the list, enter "/plugins load HelloWorld". Note that while most things in Lua are case sensitive, the name of the plugin in the command is not. If you created the files correctly, you will be rewarded with a simple window displayed in the center of your display with the title, "Hello World", a border, a close button and most importantly the message "Hello World" in the middle of the window.

---

## Post 6 — Garan 2025-06-16T20:28:52-0400

Lua is not really an object oriented language, but by creating a 'Class' object, Turbine has created a wrapper that makes Lua feel a little more object oriented. The class.lua file can be found in the Turbine samples but you should not depend on end users having the Turbine samples installed so it is usually best to include a copy in your own project folder and reference it from there.  
  
In the HelloWorld sample, I created an instance of a window by simply calling the constructor of that class:  

Code: 
    
    
     HelloWindow=Turbine.UI.Lotro.Window()

By using the class function, you can create a new class which inherits from an existing class and then create instances as needed. To create a "hello world" window class you would instead use:  

Code: 
    
    
     import "YourName.HelloWorld.Class"
     HelloWindow=class(Turbine.UI.Lotro.Window)
     function HelloWindow:Constructor(x,y)
      if x==nil or y==nil then
       x=Turbine.UI.Display:GetWidth()/2-100;
       y=Turbine.UI.Display:GetHeight()/2-100;
      end
      Turbine.UI.Lotro.Window.Constructor(self);
      self:SetSize(200,200); -- sets the window size to 200 by 200 pixels
      self:SetPosition(x,y);
      self:SetText("Hello World Window"); -- assigns the title bar text
      self.Message=Turbine.UI.Label(); -- create a label control to display our message
      self.Message:SetParent(self); -- sets the label as a child of the main window
      self.Message:SetSize(180,20); -- sets the message size
      self.Message:SetPosition(10,90); -- places the message control in the vertical middle of the window with a 10 pixel left and right border
      self.Message:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter); -- centers the text in the message control both horizontally and vertically
      self.Message:SetText("Hello World"); -- sets the actual message text
      self:SetVisible(true); -- display the window (windows are not visible by default)
     end

Notice that I made a small modification by including optional x,y coordinates in the constructor. Now you can create as many instances of the class as you'd like, creating them at different screen coordinates.  

Code: 
    
    
     window1=HelloWindow(10,40);
     window2=HelloWindow(); -- will default to the screen center
     window3=HelloWindow(40,200);

The above code will result in 3 instances of the "Hello World" window class at 3 different locations on your screen.

---

## Post 7 — Garan 2025-06-16T20:29:27-0400

Functions can be referenced either as Object.Function() or Object:Function(). This can be a bit confusing at first, but the biggest difference is that when you call the function with the ":" the object making the call is automatically prepended to the parameter list. Functions can also be overridden. For instance a Window can over ride the :SetPosition() method if it needs functionality not handled by the base class Window:SetPosition() method (or any other method). For example:  

Code: 
    
    
     import "Turbine.UI"; -- this will expose the label control that we will implement
     import "Turbine.UI.Lotro"; -- this will expose the standard window that we will implement
     import "YourName.HelloWorld.Class" -- this will import Turbine's class function
     HelloWindow=class(Turbine.UI.Lotro.Window)
     function HelloWindow:Constructor(x,y)
      if x==nil or y==nil then
       x=Turbine.UI.Display:GetWidth()/2-100;
       y=Turbine.UI.Display:GetHeight()/2-100;
      end
      Turbine.UI.Lotro.Window.Constructor(self);
      -- override the built in SetPosition, adding a simple output statement. Obviously, there are many greater uses for this...
      self.SetPosition=function(sender, left, top)
       Turbine.UI.Window.SetPosition(self, left, top); -- pass the args on to the base class built in function
       Turbine.Shell.WriteLine("You positioned this instance at ("..tostring(left)..","..tostring(top)..")");
       -- perform some additional code here
      end
      self:SetSize(200,200); -- sets the window size to 200 by 200 pixels
      self:SetPosition(x,y);
      self:SetText("Hello World Window"); -- assigns the title bar text
      self.Message=Turbine.UI.Label(); -- create a label control to display our message
      self.Message:SetParent(self); -- sets the label as a child of the main window
      self.Message:SetSize(180,20); -- sets the message size
      self.Message:SetPosition(10,90); -- places the message control in the vertical middle of the window with a 10 pixel left and right border
      self.Message:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter); -- centers the text in the message control both horizontally and vertically
      self.Message:SetText("Hello World"); -- sets the actual message text
      self:SetVisible(true); -- display the window (windows are not visible by default)
     end
     window1=HelloWindow(10,40);
     window2=HelloWindow(); -- will default to the screen center
     window3=HelloWindow(40,200);

The above code will not only result in three windows being created, but their initial positions will be displayed in the Standard chat channel. Not a really thrilling example, but hopefully you get the idea that base class methods can be overridden in this way (you can suppress the base functionality by simply not calling the base class method inside the new function).  
  
Note that you could replace the line:  

Code: 
    
    
     self:SetPosition(x,y);

with  

Code: 
    
    
     self.SetPosition(self,x,y);

and get the same result.  
  
Now, once you have that mastered, there is one other similar bit. Similar to calling functions with a "." or ":" syntax, functions that are members of an object can be declared using a "." or ":" syntax. You can use the "." syntax, "object.functionName=function(argList)" to declare a function. However, you can also use the ":" syntax "function object:functionName(argList)" and a special variable, "self" is automatically created and assigned the first parameter of the called function. This is functionally equivalent to using the syntax "object.functionName=function(self,argList)".  
  
Example, two functions with the same exact code but different declaration syntax:  
mainWindow=Turbine.UI.Window() -- declare a simple window object  
\-- now, declare a function "test1" for that window using the "object.functionName=function(argsList)" syntax  
mainWindow.test1=function(arg)  
Turbine.Shell.WriteLine("self:"..tostring(self))  
Turbine.Shell.WriteLine("arg:"..tostring(arg))  
end  
\-- now, declare a function "test2" for the same window using the "function object:functionName(argsList)" syntax  
function mainWindow:test2(arg)  
Turbine.Shell.WriteLine("self:"..tostring(self))  
Turbine.Shell.WriteLine("arg:"..tostring(arg))  
end  
  
test1 will run as you expect but test2 has the additional quirk of passing the first parameter to the variable "self" which is automatically created and all additional parameters to the parameter list, in this case the variable arg.  
  
So, using the "." syntax to execute mainWindow.test1("hi") yields:  
self:nil  
arg:hi  
  
the "self" variable is nil and "arg" has the value "hi" that was passed  
However, using the ":" syntax will prepend the calling object, so executing mainWindow:test1("hi") yields:  
self:nil  
arg:table: 000002531B390C60  
  
the "self" variable is still nil but arg now holds the table reference to the mapWindow.test1 function itself  
Now, note the difference with test2. Using the "." syntax to execute mapwindow.test2("hi") yields:  
self:hi  
args:nil  
  
since the first parameter ("hi") is automatically assigned to the variable "self" due to the syntax of the function declaration  
Similarly, using the ":" syntax to execute mapWindow:test2("hi") yields  
self:table 000002531B390C60  
arg:hi  
  
in the last case, self is assigned the first parameter but since we called it using the ":" syntax, the calling object was automatically prepended to the argument list and the first argument was automatically assigned to the variable "self". This case is the most useful syntax for methods defined for a class, because the instance of the class tha calls it will automatically be assigned to the variable "self"  
  
Note, some may wonder about the declaration syntax "function object.functionName(argList)":  
function mainWindow.test3(arg)  
Turbine.Shell.WriteLine("self:"..tostring(self))  
Turbine.Shell.WriteLine("arg:"..tostring(arg))  
end  
but that is functionally equivalent to the "object.functionName=function(argList)" syntax. In order to get the automatically defined "self" variable you must use the ":" syntax in the declaration. You can, of course, use the syntax "object.functionName=function(self,argList)" to manually define the first parameter as the variable "self", it is just a tiny bit easier to use the "function object.functionName(argList)" syntax and let "self" be defined automatically.

---

## Post 8 — Garan 2025-06-16T20:30:14-0400

Functions can be referenced either as Object.Function() or Object:Function(). This can be a bit confusing at first, but the biggest difference is that when you call the function with the ":" the object making the call is automatically prepended to the parameter list. Functions can also be overridden. For instance a Window can over ride the :SetPosition() method if it needs functionality not handled by the base class Window:SetPosition() method (or any other method). For example:  

Code: 
    
    
     import "Turbine.UI"; -- this will expose the label control that we will implement
     import "Turbine.UI.Lotro"; -- this will expose the standard window that we will implement
     import "YourName.HelloWorld.Class" -- this will import Turbine's class function
     HelloWindow=class(Turbine.UI.Lotro.Window)
     function HelloWindow:Constructor(x,y)
      if x==nil or y==nil then
       x=Turbine.UI.Display:GetWidth()/2-100;
       y=Turbine.UI.Display:GetHeight()/2-100;
      end
      Turbine.UI.Lotro.Window.Constructor(self);
      -- override the built in SetPosition, adding a simple output statement. Obviously, there are many greater uses for this...
      self.SetPosition=function(sender, left, top)
       Turbine.UI.Window.SetPosition(self, left, top); -- pass the args on to the base class built in function
       Turbine.Shell.WriteLine("You positioned this instance at ("..tostring(left)..","..tostring(top)..")");
       -- perform some additional code here
      end
      self:SetSize(200,200); -- sets the window size to 200 by 200 pixels
      self:SetPosition(x,y);
      self:SetText("Hello World Window"); -- assigns the title bar text
      self.Message=Turbine.UI.Label(); -- create a label control to display our message
      self.Message:SetParent(self); -- sets the label as a child of the main window
      self.Message:SetSize(180,20); -- sets the message size
      self.Message:SetPosition(10,90); -- places the message control in the vertical middle of the window with a 10 pixel left and right border
      self.Message:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter); -- centers the text in the message control both horizontally and vertically
      self.Message:SetText("Hello World"); -- sets the actual message text
      self:SetVisible(true); -- display the window (windows are not visible by default)
     end
     window1=HelloWindow(10,40);
     window2=HelloWindow(); -- will default to the screen center
     window3=HelloWindow(40,200);

The above code will not only result in three windows being created, but their initial positions will be displayed in the Standard chat channel. Not a really thrilling example, but hopefully you get the idea that base class methods can be overridden in this way (you can suppress the base functionality by simply not calling the base class method inside the new function).  
  
Note that you could replace the line:  

Code: 
    
    
     self:SetPosition(x,y);

with  

Code: 
    
    
     self.SetPosition(self,x,y);

and get the same result.  
  
Now, once you have that mastered, there is one other similar bit. Similar to calling functions with a "." or ":" syntax, functions that are members of an object can be declared using a "." or ":" syntax. You can use the "." syntax, "object.functionName=function(argList)" to declare a function. However, you can also use the ":" syntax "function object:functionName(argList)" and a special variable, "self" is automatically created and assigned the first parameter of the called function. This is functionally equivalent to using the syntax "object.functionName=function(self,argList)".  
  
Example, two functions with the same exact code but different declaration syntax:  
mainWindow=Turbine.UI.Window() -- declare a simple window object  
\-- now, declare a function "test1" for that window using the "object.functionName=function(argsList)" syntax  
mainWindow.test1=function(arg)  
Turbine.Shell.WriteLine("self:"..tostring(self))  
Turbine.Shell.WriteLine("arg:"..tostring(arg))  
end  
\-- now, declare a function "test2" for the same window using the "function object:functionName(argsList)" syntax  
function mainWindow:test2(arg)  
Turbine.Shell.WriteLine("self:"..tostring(self))  
Turbine.Shell.WriteLine("arg:"..tostring(arg))  
end  
  
test1 will run as you expect but test2 has the additional quirk of passing the first parameter to the variable "self" which is automatically created and all additional parameters to the parameter list, in this case the variable arg.  
  
So, using the "." syntax to execute mainWindow.test1("hi") yields:  
self:nil  
arg:hi  
  
the "self" variable is nil and "arg" has the value "hi" that was passed  
However, using the ":" syntax will prepend the calling object, so executing mainWindow:test1("hi") yields:  
self:nil  
arg:table: 000002531B390C60  
  
the "self" variable is still nil but arg now holds the table reference to the mapWindow.test1 function itself  
Now, note the difference with test2. Using the "." syntax to execute mapwindow.test2("hi") yields:  
self:hi  
args:nil  
  
since the first parameter ("hi") is automatically assigned to the variable "self" due to the syntax of the function declaration  
Similarly, using the ":" syntax to execute mapWindow:test2("hi") yields  
self:table 000002531B390C60  
arg:hi  
  
in the last case, self is assigned the first parameter but since we called it using the ":" syntax, the calling object was automatically prepended to the argument list and the first argument was automatically assigned to the variable "self". This case is the most useful syntax for methods defined for a class, because the instance of the class tha calls it will automatically be assigned to the variable "self"  
  
Note, some may wonder about the declaration syntax "function object.functionName(argList)":  
function mainWindow.test3(arg)  
Turbine.Shell.WriteLine("self:"..tostring(self))  
Turbine.Shell.WriteLine("arg:"..tostring(arg))  
end  
but that is functionally equivalent to the "object.functionName=function(argList)" syntax. In order to get the automatically defined "self" variable you must use the ":" syntax in the declaration. You can, of course, use the syntax "object.functionName=function(self,argList)" to manually define the first parameter as the variable "self", it is just a tiny bit easier to use the "function object.functionName(argList)" syntax and let "self" be defined automatically.

---

## Post 9 — Garan 2025-06-16T20:30:54-0400

Many developers tend to forget that LoTRO is an international application supporting three client languages, English, German and French. When developing a plugin for the general public, it is a good idea to separate out all of the text strings. There are two basic approaches to this, one is to create one table and load it with only the currently selected language strings. The other is to use a table that has a separate index for the language. Either way, all references to static text should provide some means of translating them to each of the three client languages. If you aren't comfortable translating your interface, ask someone on the forums to assist you, there are many friendly multi-lingual people that will be glad to help you.  
  
A more troublesome problem arises when saving and reloading data. Since the user has the option to change which language his client is supporting and not only the character sets but the numeric formatting is different between English and German/French, this can cause some serious problems. The first problem of supporting the UTF-8 characters for non-English clients has several solutions, I have chosen to implement a variant of the patch originally published by Vindar. This patch creates a wrapper for the standard Tubine data save and load methods which encodes the data before saving it and decodes it when it is reloaded so that UTF-8 characters are properly saved and loaded. The Vindar Patch can be found on LoTROInterface.com at <http://www.lotrointerface.com/downloads/info456-afixfortheparseerrorforeuropeanclients.html>  
  
The Vindar Patch does not however solve the numeric formatting problem. Fortunately, there is a fairly simple solution to this. Create a global variable to track whether european formatting or english formatting is currently in use:  

Code: 
    
    
    euroFormat=(tonumber("1,000")==1); -- will be true if the number is formatted with a comma for decimal place, false otherwise
    -- now create a function for automatically converting a number in string format to its correct numeric value
    if euroFormat then
        function euroNormalize(value)
            return tonumber((string.gsub(value,"%.",",")));
        end
    else
        function euroNormalize(value)
            return tonumber((string.gsub(value,",",".")));
        end
    end

then whenever you load a saved numeric value, force it to the current number format. The following example assumes data was stored for the current character  

Code: 
    
    
     Opacity=1; -- default
     local settings=PatchDataLoad( Turbine.DataScope.Character, "Settings");
     if settings~=nil then
       Opacity=euroNormalize(settings.Opacity);
     end

Note that PatchDataLoad is the wrapper for the PluginData.Load method from the Vindar Patch.  
  
Another internationalization issue that can arise is automatically detecting the current client locale setting. The built in function GetLocale() returns the operating system locale, NOT the current client application locale. Lua authors developed a workaround but Turbine eventually responded by implementing the Turbine.Engine:GetLanguage() method which returns one of the Turbine.Language values:  
Turbine.Language.Invalid=0  
Turbine.Language.English=2  
Turbine.Language.EnglishGB=268435457 (0x10000001)  
Turbine.Language.French=268435459 (0x10000003)  
Turbine.Language.German=268435460 (0x10000004)  
Turbine.Language.Russian=268435463 (0x10000007)  
  
The different clients have different chat commands and chat messages - for instance in the french client, you don't use "/plugins load HelloWorld", you would instead use "/plugins charger HelloWorld". This can become a significant issue when creating quickslot alias commands or when using the Chat object to trap incomming messages. You can use the locale test above to determine the running client and then create the appropriate command.  
  
Another issue has to do with creating resource strings. Some people have created their .lua files with UTF8 encoding with success, but I prefer a slightly more "brute force" approach. Anywhere that I need a special character, I simply concatenate the appropriate character codes to generate the desired character. For instance to generate a cedilla (the french "c" with a squiggle under it which indicates a soft c) I use "\195\167" - see the example below. The "\" character escapes the character code and the cedilla is character code 195 + character code 167. This is essentially the same as string.char(195)..string.char(167).  
  
The last issue has to do with the lack of text metrics in LoTRO Lua. Different languages will need different amounts of space for their translation of a string. In most programming languages, you would simply use a function to determine how much space a string requires. Unfortunately, Turbine did not provide us with such a luxury. However, there is a workaround using the Visibility attribute of a bound scroll bar and a non-multiline label control. Set the label control's width to a small number (a good estimate for the 20 point fonts would be 8 pixels per character in the string) and then slowly increase the width of the label (I usually use increments of 8 to save time) until the scrollbar:IsVisible() returns false. Once the scrollbar detects that it no longer needs to be rendered, you will know that you have enough room for the text. Ideally, you create one such label with a bound scrollbar and re-use it as needed to test all strings. You should probably hide the label and the scrollbar off canvass by setting their top properties to a negative value. By obtaining the metrics, you will know if you need to increase the size of a control or possibly indicate that text has been cropped.  
  
This leads me to the last of the "Hello World" samples. This one will remember where it was loaded and will display the message in the correct client language (of course, you'll have to close and restart the client, selecting a different language to test it  )  

Code: 
    
    
     import "Turbine.UI"; -- this will expose the label control that we will implement
     import "Turbine.UI.Lotro"; -- this will expose the standard window that we will implement
     locale = "en";
     if Turbine.Shell.IsCommand("hilfe") then
      locale = "de";
     elseif Turbine.Shell.IsCommand("aide") then
      locale = "fr";
     end
     strings={}; -- create a table for the string resources - note, this would usually be generated in a separate .lua file
     strings["en"]={}; -- create the English resource string table
     strings["en"][1]="Hello World Window"
     strings["en"][2]="Hello World"
     strings["en"][3]="English"
     strings["de"]={}; -- create the German resource string table
     strings["de"][1]="Hallo Welt Fenster"
     strings["de"][2]="Hallo Welt"
     strings["de"][3]="Deutsch"
     strings["fr"]={}; -- create the French resource string table
     strings["fr"][1]="Fen\195\170tre Bonjour tout le monde"
     strings["fr"][2]="Bonjour tout le monde"
     strings["fr"][3]="Fran\195\167aise";
     function UnloadPlugin()
      if HelloWindow~=nil then
       local settings={}
       settings["top"]=HelloWindow:GetTop();
       settings["left"]=HelloWindow:GetLeft();
       Turbine.PluginData.Save(Turbine.DataScope.Account, "HelloWorld", settings);
      end
     end
     HelloWindow=Turbine.UI.Lotro.Window(); -- we call the constructor of the standard window object to create an instance
     local x,y=Turbine.UI.Display:GetWidth()/2-100,Turbine.UI.Display:GetHeight()/2-100;
     local settings=Turbine.PluginData.Load(Turbine.DataScope.Account, "HelloWorld");
     if settings~=nil then
      if settings["top"]~=nil then y=settings["top"] end
      if settings["left"]~=nil then x=settings["left"] end
     end
     HelloWindow.loaded=false;
     HelloWindow:SetWantsUpdates(false);
     HelloWindow.Update=function()
      if not HelloWindow.loaded then
       HelloWindow.loaded=true;
       Plugins["HelloWorld"].Unload = function(self,sender,args)
        UnloadPlugin();
       end
       HelloWindow:SetWantsUpdates(false);
      end
     end
     if locale=="fr" then
      HelloWindow:SetSize(350,200);
     elseif locale=="de" then
      HelloWindow:SetSize(260,200);
     else
      HelloWindow:SetSize(280,200);
     end
     HelloWindow:SetPosition(x,y);
     HelloWindow:SetText(strings[locale][1]); -- assigns the title bar text
     HelloWindow.Message=Turbine.UI.Label(); -- create a label control to display our message
     HelloWindow.Message:SetParent(HelloWindow); -- sets the label as a child of the main window
     HelloWindow.Message:SetSize(HelloWindow:GetWidth()-20,20); -- sets the message size
     HelloWindow.Message:SetPosition(10,90); -- places the message control in the vertical middle of the window with a 10 pixel left and right border
     HelloWindow.Message:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter); -- centers the text in the message control both horizontally and vertically
     HelloWindow.Message:SetText(strings[locale][2]); -- sets the actual message text
     HelloWindow:SetWantsUpdates(true);
     HelloWindow:SetVisible(true); -- display the window (windows are not visible by default)

---

## Post 10 — Garan 2025-06-16T20:31:29-0400

This is as good a spot as any to delve a bit into the basic elements of the Turbine API. There are currently four Turbine object libraries that form the API: Turbine, Turbine.Gameplay, Turbine.UI, and Turbine.UI.Lotro. These libraries must be "imported" before their objects can be accessed so any plugin that uses any of these libraries will import them as the first lines of their main file or the first file referenced in the __init__.lua file. I won't go into great detail on all of the API classes, there is a set of API docs available from LoTROInterface.com for that. However, each library contains some elements that deserve extra attention above and beyond what the API docs provide.  
  
The "Turbine" library exposes the Chat, Engine, base Object, Plugin, PluginData, PluginManager, Shell and ShellCommand objects - basically all the top level, generic stuff.  
The Chat object is one of the newest and most powerful elements for creating plugins that do more than just repaint the same old UI. By filtering and capturing the chat messages, Plugins can now interact between players. This is a HUGE step forward for Plugin usefulness. Unfortunately, the interaction isn't programatically bi-directional. That is, it requires user interaction in at least one of the directions to make anything happen. However, in many cases this is more than enough to make it useful. The Chat object has only one event, Received which is an event handler for all incoming chat messages.  
The Engine object is handy for debugging and timestamping. The GetCallStack method can be useful for debugging as can the ScriptLog method. The GetGameTime method is great for setting timers that can be checked in an object's Update event handler and GetLocalTime is great for timestamping things such as incoming chat messages.  
The Plugin object is great for accessing the current plugins settings from the .plugin definition file. Of particular interest is the GetVersion as this will allow authors to version stamp their saved data and automatically detect when a plugin has been updated.  
The PluginData object is how data is saved and loaded to and from .plugindata files  
The PluginManager is an incredibly useful object as it can control loading and unload plugins as well as listing the available plugins and loaded plugins. One point that deserves mentioning, a plugin can not commit suicide by unloading its own apartment - plugins can only unload another plugin's apartment.  
The Shell object is where plugins register the chat commands that they should respond to. This object also has a WriteLine method which can output messages to the Standard channel of the chat window. This is a GREAT debugging tool.  
The ShellCommand object is an instance of a shell command that was registered with the Shell object.  
  
The "Turbine.Gameplay" library exposes the Player and Party stuff such as LocalPlayer, Party, Actor, Backpack, Attributes, etc.  
Before accessing any of the characer attributes, you must first obtain a handle to an instance of the LocalPlayer using Turbine.Gameplay.LocalPlayer:GetInstance(). The other methods are called on that instance.  
The Actor class exposes many of the attributes of a character instance including morale, power, effects, level and name. This is the base class from which other classes like LocalPlayer inherit many of their properties. The effects are held in an EffectsList object.  
The Attributes class exposes information about entities.  
The Backpack object provide access to the items in the character's backpack. To access the backpack, you must first create an instance of the LocalPlayer object and then access that instance's backpack:  
player=Turbine.Gameplay.LocalPlayer:GetInstance();  
backpack=player:GetBackpack();  
The ClassAttributes is a base class for character class attributes.  
The Effect object represents an effect on an entity and is a member of an EffectsList. You can use this object to retrieve information about a specific effect such as the Category, Description, Duration, Icon, ID, Name, and StartTime as well as Curable, Debuff and Dispellable flags. To access the Name of the first Effect on a character you would use:  

Code: 
    
    
     player=Turbine.Gameplay.LocalPlayer:GetInstance();
     effectList=player:GetEffects();
     if effectList~=nil and effectList[1]~=nil then
      Turbine.Shell.WriteLine("first effect:"..tostring(effectList[1]:GetName()));
     end

The Entity class is a base class from which all entities such as Player inherit the GetName and RegisterForClickHandling methods. GetName is obvious enough. RegisterForClickHandling allows developers to register an entity to process the right mouse popup menu for its entity type.  
The Equipment object is similar in functionality to the Backpack with a very important limitation, you can not programatically drop an item into the Equipment collection (so plugins can not programmatically equip items at this time).  
NOTE: The current (as of November 12, 2011) API documentation incorrectly indicates that the enumeration of equipment slots is Turbine.Gameplay.EquipmentSlot when in fact it is Turbine.Gameplay.Equipment, so the "Back" equipment slot is "Turbine.Gameplay.Equipment.Back". If you try using the naming indicated in the API docs you will get an error.  
The Item object represents a distinct item stack, either in the Backpack or Equipment collections.  
The LocalPlayer object is how we access an instance of the current character. You must create an instance of the LocalPlayer before you can access any of the player methods or properties.  
The Party object represents a fellowship or Raid.  
The Player object represents one element of a Party collection.  
  
The "Turbine.UI" library exposes the fundamental UI elements such as Window, TextBox, Label, etc.  
BlendMode is an enumeration of the possible blend modes that can be used with a background or backcolor. These values will determine how the control visually interacts with its container.  
The Button object is a generic button which can be used to create custom buttons. For most uses, the Turbine.UI.Lotro.Button class is more useful in that it will inherit the current skin's background and border style.  
The Checkbox object is a generic checkbox control which can be used to create custom checkboxes. For most uses, the Turbine.UI.Lotro.Checkbox class is more useful.  
The Color object is used to represent any color object which can be assigned to a control. The color object has four members representing Alpha, Red, Green and Blue. Each member can have a value from 0 to 1. If you create a color but only pass 3 arguments they will define Red, Green and Blue and the Alpha channel will default to 1.  
Content alignment is an enumeration of the possible positioning values for the SetTextAlignment method  
The Context Menu object creates a popup menu  
The Control object is the most fundamental object class that can be instantiated. This basic UI element is very flexible and can act as a container or background. Any element that doesn't require text should probably be created as a control as this element can display images and/or colors and respond to mouse, keyboard and update events.  
The ControlList object represents the child objects of a container control.  
The Display object exposes the screen display properties and current mouse information.  
The DragDropInfo class is a virtual class, use the Turbine.UI.Lotro.DragDropInfo class instead.  
FontStyle is an enumeration of font styles. Currently only Outlined and default are defined.  
The Label object is a control that allows displaying text.  
The ListBox object is a very useful container control that creates horizontal or vertical element arrays.  
The MenuItem object represents an element of a Context Menu  
The MenuItemList object is the collection of menu items in a context menu  
MouseButton is the enumeration of possible values for the Button argument of mouse event handlers  
Orientation is the enumeration of possible layout orientation values  
The ScrollableControl is a subclass for the generic Control class. Do NOT directly instantiate an instance of this class as it will crash the client. This is a virtual class from which other scrollable classes inherit the scrolling methods and events.  
The ScrollBar object represents a scroll control which can either be bound to a scrollable control in which case it will automatically display and provide scrolling as needed, or it can be used as a stand alone control which can have minumum, maximum and current values programatically controlled and will respond to scroll events.  
The TextBox object is the basic control for entering and displaying user modifiable text. The Turbine.UI.Lotro.TextBox object is usually preferable as it will inherit skin attributes from the client.  
The TreeNode object represents a single node of a Tree View control  
The TreeNodeList object is the collection of nodes of a Tree View control  
The TreeView object is a tree style display control  
The Window object is a basic window control which can be used to create custom windows. The Turbine.UI.Lotro.Window object is usually preferable as it will inherit skin attributes from the client.  
  
The "Turbine.UI.Lotro" library exposes classes that can inherit the current skin attributes from the client. These are generally specialized versions of the fundamental elements that provide things such as borders.  
Action is a partial enumeration of the possible values of the key event arguments. For a more complete listing, see the Turbine forums thread: <http://forums.lotro.com/showthread.php?364427-Turbine.UI.Lotro.Action>  
The BaseItemControl is a virtual class from which the ItemControl class inherits members and properties  
The Button object will create a button object that will inherit the current skin attributes unless the developer overrides the background, color or font  
The CheckBox object will create a check box object that will inherit the current skin attributes unless the developer overrides the background, color or font  
The DragDropInfo object which represents the object being dropped in drag drop event handlers  
The EffectDisplay object will create a visual display element for an Effect object.  
The EquipmentSlot object creates a visual display element for an Equipment object - due to limited functionality, this is only really useful for creating a custom character panel  
Font is a partial enumeration of possible fonts. For a list of additional fonts see the Turbine forums thread: <http://forums.lotro.com/showthread.php?397086-Some-undocumented-fonts-and-problem-with-TrajanPro25>  
The GoldButton object is a somewhat custom "gold" button.  
The GoldWindow object is a somewhat custom "gold" window.  
The ItemContol object will create a visual display element for an Item object (this is basically a limited version of a QuickSlot control which can only contain items)  
The LotroUI class is a virtual class from which instances of the LotroUIElement class inherits the IsEnabled, Reset and SetEnabled methods.  
The LotroUIElement object represents a built-in UI element which Lua can override, currently only the 5 backpacks and the vitals display are supported  
The QuickSlot object is a multi-purpose container control which can contain an Alias, Hobby, Item, Pet, or Skill shortcut. Most of the user interactable "bars" plugins are built using these controls.  
The ScrollBar object will create a scroll control which can either be bound to a scrollable control in which case it will automatically display and provide scrolling as needed, or it can be used as a stand alone control which can have minimum, maximum and current values programmatically controlled and will respond to scroll events. This control will inherit the current skin attributes unless the developer overrides those attributes.  
The TextBox object will create an editable text display object that will inherit the current skin attributes unless the developer overrides the background, color or font  
The Window object will create a basic window with title bar, borders and "close" button using the current skin attributes unless the developer overrides the background, font or colors.  
  
The Turbine API docs cover most of the methods and events associated with the above objects. However, there are a couple of undocumented (or insufficiently documented) methods and events:  
Missing/incomplete enumerations  
The Turbine.Gameplay.Class and Turbine.Gameplay.Race enumerations are incomplete. Some additional values can be found at <http://forums.lotro.com/showthread.php?370289-A-few-more-missing-enumeration-values>...  
The Turbine.Gameplay.ItemClass enumeration is incomplete. Some additional values (currently also outdated) can be found at <http://forums.lotro.com/showthread.php?381143-Turbine.Gameplay.ItemCategory-enumeration>  
The Turbine.UI.Lotro.Action enumeration is incomplete. Some additional values can be found at <http://forums.lotro.com/showthread.php?364427-Turbine.UI.Lotro.Action>  
The Turbine.UI.Lotro.Font enumeration is incomplete. Some additional values can be found at <http://forums.lotro.com/showthread.php?397086-Some-undocumented-fonts-and-problem-with-TrajanPro25>  
  
There are a couple of quirks in the way backgrounds and colors work. Once a background is set, you can not set it back to the default "no background". The same holds true for background color, once you apply a background color, it will override the background unless you use the SetBackColorBlendMode() to blend the image with the color. There is no way to get back to the version that had the background image without a background color.  
  
:SetStretchMode()  
There is an incredibly useful yet still undocumented method of the control object, SetStretchMode(). This method will allow dynamically scaling the display size of a control's background image. When applied to a container control, all of the control's child controls will resize with the control. This is SO incredibly useful, I find it hard to believe that Turbine has still not documented this method. There are five basic stretch modes, 0, 1, 2, 3 and 4.  
StretchMode=0 will turn off scaling of a control (and incidentally set the alpha to 0). Any background image will be cropped or tiled. This is the only setting where the image will be properly bounded by a parent control.  
StretchMode=1 will scale an image based on the size it had when the stretch mode was assigned and its current size. When using StretchMode=1 it is important to set the control to the image's original size BEFORE assigning StretchMode=1, then set the size to the desired stretched size after assigning StretchMode=1. This stretchmode can cause an image to exceed the bounds of its parent. If this happens, the control will only respond to mouse events within the bounds of its parent even though the control is rendered outside those bounds.  
StretchMode=2 will scale a control to the size of its background image. When StretchMode=2 is initially assigned, the control will resize to fit the image size. If the control is subsequently resized, the background will be stretched to fit the control. Note that in StretchMode=2, the control will not respond to any mouse events even if mouse visibility is true.  
StretchMode=3 is similar to StretchMode=0 and will turn off scaling of a control. Any background image will be tiled or cropped but if the control exceeds the bounds of its parent, the image will not be properly cropped by the parent's bounds.  
StretchMode=4 is similar to StretchMode=1 except the control will not receive mouse events even if mouse visibility is set true. This is likely an accidental glitch.  
SetStretchMode has some side effects that seem to be unintentional. First, it can allow a control to display outside the bounds of its parent control - usually after control1:SetParent(control2), control1 will have its origin relative to control2 AND will be bounded by (will not draw outside) control2. When using a StretchMode other than 0, the child control's origin will be based on its parent but it will not be bounded by its parent, it will draw beyond its parent's canvas. This can lead to some interesting effects. The second side effect is probably related to the first issue. When using SetStretchMode, the control may not respond correctly to SetBlendMode(). I haven't documented all of the combinations, but suffice it to say that if your control is not behaving as intended, try to avoid using SetBlendMode() with SetStretchMode() as it seems to simply interfere with the proper working of SetStretchMode(). SetStretchMode can impact a control's ability to receive mouse events, notably using modes 2 and 4 will disable mouse events for the control. Lastly, any StretchMode other than 0 will prevent the control from properly rotating with its parent Window when :SetRotation() is used. Any or all of these side effects may be accidental glitches that may be fixed in the future as this is an undocumented method. Using SetStretchMode on a Turbine.UI.Lotro.Window object will stretch the border and titlebar graphics so if you want the entire window to stretched, use a standard Turbine.UI.Window control.  
  
SetStretchMode Example1  
Retrieving the size of an image of unknown size (useful for properly resizing a control on the fly to fit its background). In this example we will size the control to the image's size and then retrieve that size. First, assign the background. Setting StretchMode=2 will resize the container to the size of its background allowing us to retrieve the image size if needed.  

Code: 
    
    
    Window1=Turbine.UI.Lotro.Window();
    Window1:SetText("SetStretchMode Example1");
    Window1:SetSize(200,200);
    Window1:SetPosition((Turbine.UI.Display:GetWidth()-Window1:GetWidth())/2,(Turbine.UI.Display:GetHeight()-Window1:GetHeight())/2);
    Control1=Turbine.UI.Control();
    Control1:SetParent(Window1);
    Control1:SetBackground(0x410f83cc); -- a built in resource that I happen to know is 54x62
    Control1:SetStretchMode(2); -- sizes window to image size so that we can determine the image dimensions
    local width, height=Control1:GetSize(); -- we can retrieve the image's actual size at this point if we desire it
    Turbine.Shell.WriteLine("Width="..tostring(width)..", height="..tostring(height));
    Control1:SetPosition((Window1:GetWidth()-width)/2,(Window1:GetHeight()-height)/2);
    Window1:SetVisible(true);

  
SetStretchMode Example2  
Scaling an image to a new size. This time we will pick on the Ettenmoors map, shrinking it down to 200x200 size. Now it looks as small as it sometimes feels   

Code: 
    
    
    Window1=Turbine.UI.Lotro.Window();
    Window1:SetText("SetStretchMode Example1");
    Window1:SetSize(200,200);
    Window1:SetPosition((Turbine.UI.Display:GetWidth()-Window1:GetWidth())/2,(Turbine.UI.Display:GetHeight()-Window1:GetHeight())/2);
    Control1=Turbine.UI.Control();
    Control1:SetParent(Window1);
    Control1:SetBackground(0x41008133);
    Control1:SetStretchMode(2); -- sizes window to image size so that we can determine the image dimensions
    Control1:SetSize(Window1:GetSize())
    Window1:SetVisible(true);

  
:SetRotation()  
Another wonderful but undocumented method is the Window:SetRotation() method. This method allows you to rotate a window around the X, Y, or Z axis. There are a few awkward glitches with this undocumented feature, but once you understand them you can easily adjust for them.  
  
The first thing to remember about the SetRotation method is that its arguments are expressed in Degrees even though all Lua standard math functions are based on Radians. If you wish to perform angular math and then use the results in the SetRotation method you will have to manually convert your values from Radians to Degrees (easily done once you know you have to do it). The second issue has to do with mouse event handling. When a window is rotated, it will respond to mouse events at its original unrotated coordinates, so if you plan on handling mouse events you will have to size your window large enough to capture mouse events. The child controls that get rotated will respond properly within those bounds, you just need to be sure the window is large enough to cover any area the child controls may get rotated to. This takes a bit of getting used to but can be dealt with easily enough once you know to account for it. A rather peculiar issue is that the rotation gets reset to all zeros when the window is hidden, so the window must be visible to set its rotation and if you ever hide and redisplay it you have to manually track its rotation and reapply it. I usually create a property Window.rotation and read/assign it in the VisibleChanged() event handler.

---

## Post 11 — Garan 2025-06-16T20:32:03-0400

Most programming languages implement a means of temporarily suspending processing or polling at intervals. LoTRO Lua allows elements to register an Update event handler which will fire once for each frame (so if you are getting 100 frames per second, the Update handler is called every 100th of a second). Simply define an .Update() function for the object and then execute the object:SetWantsUpdates(true) to register the event handler. It is fairly important from a performance standpoint to use object:SetWantsUpdates(false) when you do not need to poll for a state so that your even handler does not get called when there is nothing to process. Many plugins use an Update handler on their main window to process statements in the first frame after the plugin is loaded, such as assigning an Unload event handler. Note, since the introduction of the "plugin" temporary variable in the loading state this is no longer necessary but a lot of authors still follow this practice out of habit.  
  
A good example of the .Update handler is the event timer for the LotRO Alerts plugin. Another good example is the text box for the filter in AltInventory that only checks for updates when the control has focus.

---

## Post 12 — Garan 2025-06-16T20:32:36-0400

Whenever the plugin's apartment is unloaded, the Lua system will fire the Unload event for any plugin in that apartment. To handle the Unload event, you must assign an unload event handler. This is much simpler with the inclusion of the temporary "plugin" variable. The "plugin" variable is only defined while the plugin is in the loading state. If you define or redefine the Unload handler once the plugin is running, you will need to use the Plugins table referenced by your plugin name (ex. Plugins["MoorMap"].Unload  
Example:  

Code: 
    
    
    plugin.Unload = function()
      -- call your plugin data save handler
      -- remove any registered commands
      -- deactivate or unregister event handlers (especially handlers for shared objects like Chat, it is sufficient to call SetWantsUpdates(false) to deactivate Update handlers)
    end

  
As shown above, there are only three things you should really be concerned about, saving data, removing registered commands, and deactivating/unregistering event handlers. In days of yore, if you didn't clean up after yourself, it was possible to crash the client. Fortunately, much if not all of that is now automatically handled if you forget, but it is still a programming best practice to explicitly clean up after yourself.  
  
Do NOT assign directly to the generic object Turbine.Plugin.Unload as that will stomp on all other unload event handlers in your apartment and cause much gnashing of teeth. Always either reference the temporary variable, plugin, or the Plugins table entry for your plugin.

---

## Post 13 — Garan 2025-06-16T20:33:09-0400

The prior installment discussed one particular event, the Unload event. This installment will cover event handling in geneneral.  
  
Events are handled in Lua by defining a function and assigning it to the event that it should handle. When a Turbine event is fired, the function that you assigned will be called and passed two arguments, the handle to the object raising the event and a table of additional arguments. For example, if you have an object named Control1 and it needs to process mouse click events, you would create a function to handle this by:  
Control1.MouseClick = function(sender, args)  
\-- put code to handle event here  
end  
The sender parameter is particularly helpful if you are using a single function to respond to events for an array of controls. Turbine's API documents do not provide detailed information about the arguments but fortunately Lua provides a mechanism for examining tables. In the above example, all we know from the API is that there is a table that will be passed to our parameter "args". We can determine the list of arguments in the table by using the code:  

Code: 
    
    
    for k,v in pairs(args) do
        Turbine.Shell.WriteLine("name:"..tostring(k)..", value:"..tostring(v));
    end

There are several noteworthy things in this example. First, we can enumerate all of the name/value pairs of a table easily. Second, we can use the Turbine.Shell.WriteLine method to output debugging info to the Standard chat channel. Third, string concatenation is performed with the ".." operator. Fourth, when dealing with a value which might be nil or undefined, it is always safest to wrap it in a tostring() function to force the nil value into the string "nil" to avoid runtime errors. For this example, the output will be:  
name:X, value:1  
name:Y, value:1  
name:Button, value:1  
which indicates that for the MouseClick() event there are three arguments, named X, Y, and Button. You will then know that you can reference them in the event handler code as "args.X", "args.Y" and "args.Button".  
There are two basic types of objects that can register for event handling, I call them Private and Shared. The above example dealt with a private object, an instance of a control that we created. You can register event handlers for Private objects by simply assigning the function to the event. Shared objects however need to be treated with a bit more respect. In many cases, shared objects like the Backpack will have event handlers for several plugins simultaneously and all of those event handlers need to be processed. If you simply assign your function to the event, you will override the other plugins' event handlers or they will override yours. Fortunately, events can have a table of handlers. There was a good discussion on the old Turbine forums, that covered implementing event handlers without stepping on other plugins and the solution presented by Pengoros. The net result of that discussion is the convention of using the following functions to register/unregister event handlers for shared objects (you should define these functions in your main .lua file or the first code file listed in the __init__.lua file):  

Code: 
    
    
    function AddCallback(object, event, callback)
        if (object[event] == nil) then
            object[event] = callback;
        else
            if (type(object[event]) == "table") then
                table.insert(object[event], callback);
            else
                object[event] = {object[event], callback};
            end
        end
        return callback;
    end
    function RemoveCallback(object, event, callback)
        if (object[event] == callback) then
            object[event] = nil;
        else
            if (type(object[event]) == "table") then
                local size = table.getn(object[event]);
                for i = 1, size do
                    if (object[event][i] == callback) then
                        table.remove(object[event], i);
                        break;
                    end
                end
            end
        end
    end

For example, to register an event handler for the local player effects list you would use the code:  

Code: 
    
    
     player = Turbine.Gameplay.LocalPlayer.GetInstance();
     playerEffects=player:GetEffects();
     effectsHandler = function(sender, args)
      -- put event handling code here
     end
     AddCallback(playerEffects, "EffectAdded", effectsHandler);

when you no longer need to handle the event or in your plugins Unload event handler, you would unregister your event handler:  

Code: 
    
    
     RemoveCallback(playerEffects, "EffectAdded", effectsHandler);

The above example also illustrates how to properly get an instance of the LocalPlayer object before trying to access any of its elements.  
Note, in order to maintain the integrity of the event handler table of a shared object and allow garbage collection to process, you should always remove any callback that you added.  
  
**Getting All Fired Up** (or how to fire your own events)  
If you build your own reusable modules, you may eventually find it necessary to allow users to define event handlers that you fire. This is actually a lot simpler than it might first appear. The only mildly complicated part is allowing your events to have tables of handlers. This can be achieved very easily. In the following example, the event "SomethingHappened" can be assigned a single function or a table of functions just like Turbine allows. We create the FireEvent function to handle actually firing the events. Staying with the Turbine convention, we also pass the arguments in a table, you could alternately choose to pass them individually, or not have any arguments as you see fit.  

Code: 
    
    
    someModule.SomethingHappened = nil; -- unnecessary placeholder, I just put it in so that I remember that I have defined this event
    someModule.FireEvent=function(sender, event, args)
        -- allows us to fire events as functions or tables of functions
        if event~=nil then
            if type(event)=="function" then
                event(sender, args);
            else
                if type(event)=="table" then
    		for k,v in pairs(event) do
                        if type(v)=="function" then
                            v(sender, args)
                        end
                    end
                end
            end
        end
    end
    
    -- then somewhere else in the module where the condition for firing the event arises, you simply call FireEvent
        acorn.Name="Acorn"; -- just some bogus stuff that we use as an example of argument passing
        if acorn.state==state.falling then -- some sample condition that defines when to fire the event
            local args={}; -- this will pass our custom arguments to the event, in this example we will pass "Object" and "State" but you can assign anything you feel is relevant to a potential handler
            args.Object=acorn;
            args.State="Falling";
            someModule:FireEvent(someModule.SomethingHappened, args); -- fires the actual event
        end

  
When a user creates an instance of your module, they assign a function to SomethingHappened:  

Code: 
    
    
    chickenLittleEventHandler=function(sender, args)
        -- remember, we assigned ".Object" and ".State" as attributes of the parameter object in "someModule"
        if args.Object.Name()=="Acorn" and args.State=="Falling" then
            Turbine.Shell.WriteLine("The Sky Is Falling!");
        end
    end
    -- add a callback to the custom event just as you would for a Turbine event
    AddCallback(someModule, "SomethingHappened", chickenLittleEventHandler);
    
    -- and don't forget to remove your callback in your unload handler using RemoveCallback
    myUnloadHandler=function()
        RemoveCallback(someModule, "SomethingHappened", chickenLittleEventHandler);
        -- etc
    end

Now whenever the condition "acorn.state=state.falling" is evaluated as true in "someModule", it will fire the event which will write "The Sky Is Falling" to the standard channel.  
* there was something else that was supposed to go here but my daughter wanted to show me her latest crayon creation and I totally lost track of what I was writing... it may someday get added  *  
* as of 2025, my daughter has now graduated high school but for the life of me I still can't remember what I wanted to add here... *

---

## Post 14 — Garan 2025-06-16T20:33:40-0400

With a bit of planning, Lua can work very nicely with custom skins. The first step is to use the Turbine.UI.Lotro classes instead of the Turbine.UI classes when possible. The simple reason being that the .Lotro versions will automatically support skins unless the developer sets a custom background or color. If you simply must use the Turbine.UI classes, you can still include elements that are compatible with skins by using the built in graphic resources. These are assigned to a background the same way as custom resources (the object:SetBackground() method), you just use their Resource ID instead of a file path. Now comes the bad news. There is no Turbine documentation on the Lua Resource IDs for any of the skinnable graphical elements. However, there are a couple of plugins that can help with this. IRV, Image Resource Viewer, is one plugin that is sorely in need of updating but does have many of the older resources and basic Library functionality. If I find the time, I will try to update the UI and publish the more recent (and more functional) version. Once you have a resource's ID, you can use that to display the image in a Lua control. For example, if you want to create a Turbine.UI.Window but create a Turbine.UI.Control object for the "close" button, you can assign that object Resource ID 0x41000196 and it will display the close button icon from the current skin (to support clicked and rollover states, you would use 0x41000197=pressed and 0x41000198=highlighted, changing the background image in the MouseEnter, MouseDown, MouseUp, MouseLeave and MouseClick events).

---

## Post 15 — Garan 2025-06-16T20:34:11-0400

There is a great deal more to Lua and plugins. I would recommend that you learn about the pcall Lua command for error handling. I would also recommend that you learn what a Lua environment is as well as what metatables are. There are some fascinating things that you can do with Lua that are beyond the scope of this document. With any luck, Turbine will continue to expose more of the UI, allowing us to further enhance this wonderful game.

---

## Post 16 — Garan 2025-06-16T20:34:43-0400

It's been quite a while since I've added to this thread and someone was recently asking me about responding to keys. So I decided it was a good time to delve a bit into the mysterious and sometimes befuddling control:KeyDown and control:KeyUp events and Actions in general.  
  
To start with, you should be aware that the object.KeyDown() and object.KeyUp() events do NOT actually capture key presses, rather they are fired when an Action takes place. In some cases, these actions do not even have to be activated by a key, they can be activated by a mouse click. While it takes a bit of getting used to and has some significant limitations, it also has a great benefit. If the user changes their keymappings it won't affect your plugin since you are responding to the bound Action, not the key that caused it.  
  
There are two events, KeyDown and KeyUp that are fired in response to Actions. Not all Actions fire both events. For instance, opening your inventory only fires the KeyDown event but pressing the Delete key while editing text only fires the KeyUp event. Some Actions such as the quickslot visibility and the push to talk actions will fire both events. You will likely have to try trapping Actions in both KeyDown and KeyUp handlers until you find which one fires for the circumstance you are looking for.  
  
The event handlers for KeyDown and KeyUp are only fired for controls that are listening for KeyEvents. To enable key events you call control:SetWantsKeyEvents(true) and control:SetWantsKeyEvents(false) to turn those events off. This is particularly useful when handling things like cursor events in a textbox - there's no point in the textbox processing every event that occurs in the game so you can use the control:FocusGained() and control:FocusLost() events to enable and disable the key event handlers to save processing time. This can significantly impact the performance of the client.  
  
The KeyDown and KeyUp events will pass two arguments, the control firing the event and a table with the following members: Action, Alt, Control and Shift. You can use a simple handler to identify any particular action you are looking for:  

Code: 
    
    
    object.KeyDown=function(sender,args)
        Turbine.Shell.WriteLine("Action:"..tostring(args.Action));
    end

where object is a Control.  
  
To make handling Actions easier, Turbine started defining an enumeration for the available Actions. Unfortunately, they gave up after only defining a few:  

Code: 
    
    
    Turbine.UI.Lotro.Action.ToggleBags = 268435604;
    Turbine.UI.Lotro.Action.ToggleBag1 = 268435478;
    Turbine.UI.Lotro.Action.ToggleBag2 = 268435486;
    Turbine.UI.Lotro.Action.ToggleBag3 = 268435493;
    Turbine.UI.Lotro.Action.ToggleBag4 = 268435501;
    Turbine.UI.Lotro.Action.ToggleBag5 = 268435513;
    Turbine.UI.Lotro.Action.ToggleBag6 = 268436015;
    Turbine.UI.Lotro.Action.EscapeKey  = 145;
    Turbine.UI.Lotro.Action.Undefined = 0;

  
A couple of years ago, I started to fill in the gaps (or rather the enormous gaping holes) and posted a list of known Actions but that list is now woefully out of date. The list below was current back in 2014 but is also now missing a few actions. However, you can copy to a file (I named mine "action.lua") and include it in your projects:  

Code: 
    
    
    import "Turbine.UI.Lotro";
    -- Predefined by Turbine
    -- Turbine.UI.Lotro.Action.ToggleBags = 268435604;
    -- Turbine.UI.Lotro.Action.ToggleBag1 = 268435478;
    -- Turbine.UI.Lotro.Action.ToggleBag2 = 268435486;
    -- Turbine.UI.Lotro.Action.ToggleBag3 = 268435493;
    -- Turbine.UI.Lotro.Action.ToggleBag4 = 268435501;
    -- Turbine.UI.Lotro.Action.ToggleBag5 = 268435513;
    -- Turbine.UI.Lotro.Action.ToggleBag6 = 268436015;
    -- Turbine.UI.Lotro.Action.EscapeKey  = 145;
    -- Turbine.UI.Lotro.Action.Undefined = 0;
    
    if _G.Turbine.UI.Lotro.Action==nil then _G.Turbine.UI.Lotro.Action={} end
    
    --if _G.Turbine.UI.Lotro.Action.DismountRemount==nil then _G.Turbine.UI.Lotro.Action.DismountRemount = 268435916 end -- DismountRemount
    -- MOVEMENT
    -- none of the normal movement actions appear to be available at this time
    
    -- QUICKSLOTS
    if _G.Turbine.UI.Lotro.Action.QuickslotPageUp==nil then _G.Turbine.UI.Lotro.Action.QuickslotPageUp=268436022 end
    if _G.Turbine.UI.Lotro.Action.QuickslotPageDown==nil then _G.Turbine.UI.Lotro.Action.QuickslotPageDown=268436021 end
    
    if _G.Turbine.UI.Lotro.Action.Quickslot_1==nil then _G.Turbine.UI.Lotro.Action.Quickslot_1=268435498 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_2==nil then _G.Turbine.UI.Lotro.Action.Quickslot_2=268435506 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_3==nil then _G.Turbine.UI.Lotro.Action.Quickslot_3=268435518 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_4==nil then _G.Turbine.UI.Lotro.Action.Quickslot_4=268435527 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_5==nil then _G.Turbine.UI.Lotro.Action.Quickslot_5=268435536 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_6==nil then _G.Turbine.UI.Lotro.Action.Quickslot_6=268435543 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_7==nil then _G.Turbine.UI.Lotro.Action.Quickslot_7=268435551 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_8==nil then _G.Turbine.UI.Lotro.Action.Quickslot_8=268435559 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_9==nil then  _G.Turbine.UI.Lotro.Action.Quickslot_9=268435569 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_10==nil then _G.Turbine.UI.Lotro.Action.Quickslot_10=268435535 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_11==nil then _G.Turbine.UI.Lotro.Action.Quickslot_11=268435542 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_12==nil then _G.Turbine.UI.Lotro.Action.Quickslot_12=268435550 end
    
    -- QUICKSLOT BAR 1
    if _G.Turbine.UI.Lotro.Action.Quickbar1Visibility==nil then _G.Turbine.UI.Lotro.Action.Quickbar1Visibility=268435575 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_13==nil then _G.Turbine.UI.Lotro.Action.Quickslot_13=268435558 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_14==nil then _G.Turbine.UI.Lotro.Action.Quickslot_14=268435568 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_15==nil then _G.Turbine.UI.Lotro.Action.Quickslot_15=268435576 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_16==nil then _G.Turbine.UI.Lotro.Action.Quickslot_16=268435586 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_17==nil then _G.Turbine.UI.Lotro.Action.Quickslot_17=268435598 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_18==nil then _G.Turbine.UI.Lotro.Action.Quickslot_18=268435606 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_19==nil then _G.Turbine.UI.Lotro.Action.Quickslot_19=268435614 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_20==nil then _G.Turbine.UI.Lotro.Action.Quickslot_20=268435473 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_21==nil then _G.Turbine.UI.Lotro.Action.Quickslot_21=268435481 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_22==nil then _G.Turbine.UI.Lotro.Action.Quickslot_22=268435490 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_23==nil then _G.Turbine.UI.Lotro.Action.Quickslot_23=268435497 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_24==nil then _G.Turbine.UI.Lotro.Action.Quickslot_24=268435505 end
    
    -- QUICKSLOT BAR 2
    if _G.Turbine.UI.Lotro.Action.Quickbar2Visibility==nil then _G.Turbine.UI.Lotro.Action.Quickbar2Visibility=268435556 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_25==nil then _G.Turbine.UI.Lotro.Action.Quickslot_25=268435517 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_26==nil then _G.Turbine.UI.Lotro.Action.Quickslot_26=268435526 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_27==nil then _G.Turbine.UI.Lotro.Action.Quickslot_27=268435534 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_28==nil then _G.Turbine.UI.Lotro.Action.Quickslot_28=268435541 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_29==nil then _G.Turbine.UI.Lotro.Action.Quickslot_29=268435549 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_30==nil then _G.Turbine.UI.Lotro.Action.Quickslot_30=268435461 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_31==nil then _G.Turbine.UI.Lotro.Action.Quickslot_31=268435467 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_32==nil then _G.Turbine.UI.Lotro.Action.Quickslot_32=268435472 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_33==nil then _G.Turbine.UI.Lotro.Action.Quickslot_33=268435480 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_34==nil then _G.Turbine.UI.Lotro.Action.Quickslot_34=268435489 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_35==nil then _G.Turbine.UI.Lotro.Action.Quickslot_35=268435496 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_36==nil then _G.Turbine.UI.Lotro.Action.Quickslot_36=268435504 end
    
    -- QUICKSLOT BAR 3
    if _G.Turbine.UI.Lotro.Action.Quickbar3Visibility==nil then _G.Turbine.UI.Lotro.Action.Quickbar3Visibility=268435458 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_37==nil then _G.Turbine.UI.Lotro.Action.Quickslot_37=268435516 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_38==nil then _G.Turbine.UI.Lotro.Action.Quickslot_38=268435525 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_39==nil then _G.Turbine.UI.Lotro.Action.Quickslot_39=268435533 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_40==nil then _G.Turbine.UI.Lotro.Action.Quickslot_40=268435597 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_41==nil then _G.Turbine.UI.Lotro.Action.Quickslot_41=268435605 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_42==nil then _G.Turbine.UI.Lotro.Action.Quickslot_42=268435613 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_43==nil then _G.Turbine.UI.Lotro.Action.Quickslot_43=268435619 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_44==nil then _G.Turbine.UI.Lotro.Action.Quickslot_44=268435629 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_45==nil then _G.Turbine.UI.Lotro.Action.Quickslot_45=268435632 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_46==nil then _G.Turbine.UI.Lotro.Action.Quickslot_46=268435641 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_47==nil then _G.Turbine.UI.Lotro.Action.Quickslot_47=268435460 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_48==nil then _G.Turbine.UI.Lotro.Action.Quickslot_48=268435466 end
    
    -- QUICKSLOT BAR 4
    if _G.Turbine.UI.Lotro.Action.Quickbar4Visibility==nil then _G.Turbine.UI.Lotro.Action.Quickbar4Visibility=268435485 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_49==nil then _G.Turbine.UI.Lotro.Action.Quickslot_49=268435471 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_50==nil then _G.Turbine.UI.Lotro.Action.Quickslot_50=268435488 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_51==nil then _G.Turbine.UI.Lotro.Action.Quickslot_51=268435495 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_52==nil then _G.Turbine.UI.Lotro.Action.Quickslot_52=268435503 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_53==nil then _G.Turbine.UI.Lotro.Action.Quickslot_53=268435515 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_54==nil then _G.Turbine.UI.Lotro.Action.Quickslot_54=268435524 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_55==nil then _G.Turbine.UI.Lotro.Action.Quickslot_55=268435532 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_56==nil then _G.Turbine.UI.Lotro.Action.Quickslot_56=268435540 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_57==nil then _G.Turbine.UI.Lotro.Action.Quickslot_57=268435548 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_58==nil then _G.Turbine.UI.Lotro.Action.Quickslot_58=268435557 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_59==nil then _G.Turbine.UI.Lotro.Action.Quickslot_59=268435567 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_60==nil then _G.Turbine.UI.Lotro.Action.Quickslot_60=268435628 end
    
    -- QUICKSLOT BAR 5
    if _G.Turbine.UI.Lotro.Action.Quickbar5Visibility==nil then _G.Turbine.UI.Lotro.Action.Quickbar5Visibility=268435539 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_61==nil then _G.Turbine.UI.Lotro.Action.Quickslot_61=268435631 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_62==nil then _G.Turbine.UI.Lotro.Action.Quickslot_62=268435640 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_63==nil then _G.Turbine.UI.Lotro.Action.Quickslot_63=268435459 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_64==nil then _G.Turbine.UI.Lotro.Action.Quickslot_64=268435465 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_65==nil then _G.Turbine.UI.Lotro.Action.Quickslot_65=268435470 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_66==nil then _G.Turbine.UI.Lotro.Action.Quickslot_66=268435479 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_67==nil then _G.Turbine.UI.Lotro.Action.Quickslot_67=268435487 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_68==nil then _G.Turbine.UI.Lotro.Action.Quickslot_68=268435494 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_69==nil then _G.Turbine.UI.Lotro.Action.Quickslot_69=268435502 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_70==nil then _G.Turbine.UI.Lotro.Action.Quickslot_70=268435612 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_71==nil then _G.Turbine.UI.Lotro.Action.Quickslot_71=268435618 end
    if _G.Turbine.UI.Lotro.Action.Quickslot_72==nil then _G.Turbine.UI.Lotro.Action.Quickslot_72=268435627 end
    
    -- SELECTION
    if _G.Turbine.UI.Lotro.Action.SelectionSelf==nil then _G.Turbine.UI.Lotro.Action.SelectionSelf=268435508 end -- SELECTION_SELF
    if _G.Turbine.UI.Lotro.Action.SelectionNearestFoe==nil then _G.Turbine.UI.Lotro.Action.SelectionNearestFoe=268435607 end
    if _G.Turbine.UI.Lotro.Action.SelectionNextFoe==nil then _G.Turbine.UI.Lotro.Action.SelectionNextFoe=268435622 end --SELECTION_NEXT_FOE
    if _G.Turbine.UI.Lotro.Action.SelectionPreviousFoe==nil then _G.Turbine.UI.Lotro.Action.SelectionPreviousFoe=268435491 end --SELECTION_PREVIOUS_FOE
    if _G.Turbine.UI.Lotro.Action.SelectionNextTracked==nil then _G.Turbine.UI.Lotro.Action.SelectionNextTracked=268435684 end
    if _G.Turbine.UI.Lotro.Action.SelectionPreviousTracked==nil then _G.Turbine.UI.Lotro.Action.SelectionPreviousTracked=268435685 end
    if _G.Turbine.UI.Lotro.Action.SelectFellowOne==nil then _G.Turbine.UI.Lotro.Action.SelectFellowOne=268435500 end -- SelectFellowOne
    if _G.Turbine.UI.Lotro.Action.SelectFellowTwo==nil then _G.Turbine.UI.Lotro.Action.SelectFellowTwo=268435596 end -- SelectFellowTwo
    if _G.Turbine.UI.Lotro.Action.SelectFellowThree==nil then _G.Turbine.UI.Lotro.Action.SelectFellowThree=268435538 end -- SelectFellowThree
    if _G.Turbine.UI.Lotro.Action.SelectFellowFour==nil then _G.Turbine.UI.Lotro.Action.SelectFellowFour=268435595 end -- SelectFellowFour
    if _G.Turbine.UI.Lotro.Action.SelectFellowFive==nil then _G.Turbine.UI.Lotro.Action.SelectFellowFive=268435464 end -- SelectFellowFive
    if _G.Turbine.UI.Lotro.Action.SelectFellowSix==nil then _G.Turbine.UI.Lotro.Action.SelectFellowSix=268435523 end -- SelectFellowSix
    if _G.Turbine.UI.Lotro.Action.AssistFellowTwo==nil then _G.Turbine.UI.Lotro.Action.AssistFellowTwo=268435689 end -- AssistFellowTwo
    if _G.Turbine.UI.Lotro.Action.AssistFellowThree==nil then _G.Turbine.UI.Lotro.Action.AssistFellowThree=268435688 end -- AssistFellowThree
    if _G.Turbine.UI.Lotro.Action.AssistFellowFour==nil then _G.Turbine.UI.Lotro.Action.AssistFellowFour=268435692 end -- AssistFellowFour
    if _G.Turbine.UI.Lotro.Action.AssistFellowFive==nil then _G.Turbine.UI.Lotro.Action.AssistFellowFive=268435691 end -- AssistFellowFive
    if _G.Turbine.UI.Lotro.Action.AssistFellowSix==nil then _G.Turbine.UI.Lotro.Action.AssistFellowSix=268435690 end -- AssistFellowSix
    if _G.Turbine.UI.Lotro.Action.SelectionNearestFellow==nil then _G.Turbine.UI.Lotro.Action.SelectionNearestFellow=268435544 end -- SELECTION_NEAREST_FELLOW
    if _G.Turbine.UI.Lotro.Action.SelectionNearestPlayer==nil then _G.Turbine.UI.Lotro.Action.SelectionNearestPlayer=268435469 end -- SELECTION_NEAREST_PC
    if _G.Turbine.UI.Lotro.Action.SelectionNextPlayer==nil then _G.Turbine.UI.Lotro.Action.SelectionNextPlayer=268435475 end -- SELECTION_NEXT_PC
    if _G.Turbine.UI.Lotro.Action.SelectionPreviousPlayer==nil then _G.Turbine.UI.Lotro.Action.SelectionPreviousPlayer=268435608 end -- SELECTION_PREVIOUS_PC
    if _G.Turbine.UI.Lotro.Action.SelectionNearestCreature==nil then _G.Turbine.UI.Lotro.Action.SelectionNearestCreature=268435577 end -- SELECTION_NEAREST_CREATURE
    if _G.Turbine.UI.Lotro.Action.SelectionNextCreature==nil then _G.Turbine.UI.Lotro.Action.SelectionNextCreature=268435588 end -- SELECTION_NEXT_CREATURE
    if _G.Turbine.UI.Lotro.Action.SelectionPreviousCreature==nil then _G.Turbine.UI.Lotro.Action.SelectionPreviousCreature=268435507 end -- SELECTION_PREVIOUS_CREATURE
    if _G.Turbine.UI.Lotro.Action.SelectionNearestItem==nil then _G.Turbine.UI.Lotro.Action.SelectionNearestItem=268435633 end -- SELECTION_NEAREST_ITEM
    if _G.Turbine.UI.Lotro.Action.SelectionNextItem==nil then _G.Turbine.UI.Lotro.Action.SelectionNextItem=268435634 end
    if _G.Turbine.UI.Lotro.Action.SelectionPreviousItem==nil then _G.Turbine.UI.Lotro.Action.SelectionPreviousItem=268435519 end
    if _G.Turbine.UI.Lotro.Action.PreviousSelection==nil then _G.Turbine.UI.Lotro.Action.PreviousSelection=268435599 end
    if _G.Turbine.UI.Lotro.Action.PreviousAttacker==nil then _G.Turbine.UI.Lotro.Action.PreviousAttacker=268435474 end
    if _G.Turbine.UI.Lotro.Action.SelectionAssist==nil then _G.Turbine.UI.Lotro.Action.SelectionAssist=268435468 end -- SELECTION_ASSIST
    
    -- PANELS
    if _G.Turbine.UI.Lotro.Action.ToggleSkillPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleSkillPanel=268435483 end -- ToggleSkillPanel
    if _G.Turbine.UI.Lotro.Action.ToggleTraitPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleTraitPanel=268435510 end -- ToggleTraitPanel
    if _G.Turbine.UI.Lotro.Action.HousingPanel==nil then _G.Turbine.UI.Lotro.Action.HousingPanel=268435707 end
    if _G.Turbine.UI.Lotro.Action.ToggleCraftingPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleCraftingPanel=268435520 end -- ToggleCraftingPanel
    if _G.Turbine.UI.Lotro.Action.MapPanel==nil then _G.Turbine.UI.Lotro.Action.MapPanel=268435521 end -- ToggleMapPanel
    if _G.Turbine.UI.Lotro.Action.ToggleJournalPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleJournalPanel=268435529 end -- ToggleJournalPanel
    if _G.Turbine.UI.Lotro.Action.TitlesPanel==nil then _G.Turbine.UI.Lotro.Action.TitlesPanel=268435528 end
    if _G.Turbine.UI.Lotro.Action.ToggleSocialPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleSocialPanel=268435509 end -- ToggleSocialPanel
    if _G.Turbine.UI.Lotro.Action.TogglePendingLoot==nil then _G.Turbine.UI.Lotro.Action.TogglePendingLoot=268436023 end
    
    -- Dressing Room not available
    -- Link Item to Chat not available
    if _G.Turbine.UI.Lotro.Action.ToggleOptionsPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleOptionsPanel=268435512 end -- ToggleOptionsPanel
    if _G.Turbine.UI.Lotro.Action.ToggleAssistancePanel==nil then _G.Turbine.UI.Lotro.Action.ToggleAssistancePanel=268435637 end -- ToggleAssistancePanel (Help Panel)
    if _G.Turbine.UI.Lotro.Action.ToggleRadar==nil then _G.Turbine.UI.Lotro.Action.ToggleRadar=268435476 end
    if _G.Turbine.UI.Lotro.Action.ToggleQuestPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleQuestPanel=268435530 end -- ToggleQuestPanel
    if _G.Turbine.UI.Lotro.Action.ToggleAccomplishmentPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleAccomplishmentPanel=268435562 end -- ToggleAccomplishmentPanel (Deed Panel)
    if _G.Turbine.UI.Lotro.Action.ToggleItemAdvancementPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleItemAdvancementPanel=268435754 end -- ToggleItemAdvancementPanel
    if _G.Turbine.UI.Lotro.Action.ToggleMountsPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleMountsPanel=268435901 end
    if _G.Turbine.UI.Lotro.Action.ToggleWorldJoin==nil then _G.Turbine.UI.Lotro.Action.ToggleWorldJoin=268435888 end -- ToggleWorldJoin
    if _G.Turbine.UI.Lotro.Action.ToggleSkirmishPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleSkirmishPanel=268435854 end -- ToggleSkirmishPanel
    if _G.Turbine.UI.Lotro.Action.ToggleInstanceFinderPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleInstanceFinderPanel=268435924 end
    if _G.Turbine.UI.Lotro.Action.ToggleInstanceFinderSimplePanel==nil then _G.Turbine.UI.Lotro.Action.ToggleInstanceFinderSimplePanel=268436014 end
    if _G.Turbine.UI.Lotro.Action.ToggleInstanceFinderAdvancedPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleInstanceFinderAdvancedPanel=268436013 end
    if _G.Turbine.UI.Lotro.Action.ToggleMountedCombatUI==nil then _G.Turbine.UI.Lotro.Action.ToggleMountedCombatUI=268436016 end -- ToggleMountedCombatUI
    if _G.Turbine.UI.Lotro.Action.MyLOTROPanel==nil then _G.Turbine.UI.Lotro.Action.MyLOTROPanel=268435499 end
    
    if _G.Turbine.UI.Lotro.Action.ToggleWebStore==nil then _G.Turbine.UI.Lotro.Action.ToggleWebStore=268435889 end -- ToggleWebStore
    if _G.Turbine.UI.Lotro.Action.ReputationPanel==nil then _G.Turbine.UI.Lotro.Action.ReputationPanel=268435696 end
    if _G.Turbine.UI.Lotro.Action.HobbyPanel==nil then _G.Turbine.UI.Lotro.Action.HobbyPanel=268435910 end
    if _G.Turbine.UI.Lotro.Action.DestinyPointPerksPanel==nil then _G.Turbine.UI.Lotro.Action.DestinyPointPerksPanel=268435913 end
    if _G.Turbine.UI.Lotro.Action.ToggleFellowshipMakerUI==nil then _G.Turbine.UI.Lotro.Action.ToggleFellowshipMakerUI=268435907 end -- ToggleFellowshipMakerUI
    if _G.Turbine.UI.Lotro.Action.FriendsPanel==nil then _G.Turbine.UI.Lotro.Action.FriendsPanel=268435909 end
    if _G.Turbine.UI.Lotro.Action.KinshipPanel==nil then _G.Turbine.UI.Lotro.Action.KinshipPanel=268435905 end
    if _G.Turbine.UI.Lotro.Action.RaidPanel==nil then _G.Turbine.UI.Lotro.Action.RaidPanel=268435908 end
    if _G.Turbine.UI.Lotro.Action.GroupStagePanel==nil then _G.Turbine.UI.Lotro.Action.GroupStagePanel=268435906 end
    if _G.Turbine.UI.Lotro.Action.TogglePaperItemPanel==nil then _G.Turbine.UI.Lotro.Action.TogglePaperItemPanel=268435917 end -- TogglePaperItemPanel (Wallet)
    
    -- CHAT
    if _G.Turbine.UI.Lotro.Action.ChatModeReply==nil then _G.Turbine.UI.Lotro.Action.ChatModeReply=268435546 end-- ChatModeReply
    if _G.Turbine.UI.Lotro.Action.Start_Command==nil then _G.Turbine.UI.Lotro.Action.Start_Command=268435578 end -- START_COMMAND
    
    -- MISCELLANEOUS
    if _G.Turbine.UI.Lotro.Action.QuickSlot_SkillMode==nil then _G.Turbine.UI.Lotro.Action.QuickSlot_SkillMode=268435639 end -- QUICKSLOT_SKILLMODE (auto attack)
    if _G.Turbine.UI.Lotro.Action.Use==nil then _G.Turbine.UI.Lotro.Action.Use=268435589 end -- USE
    if _G.Turbine.UI.Lotro.Action.FollowSelection==nil then _G.Turbine.UI.Lotro.Action.FollowSelection=268436029 end
    if _G.Turbine.UI.Lotro.Action.FindItems==nil then _G.Turbine.UI.Lotro.Action.FindItems=268436030 end
    if _G.Turbine.UI.Lotro.Action.Show_Names==nil then _G.Turbine.UI.Lotro.Action.Show_Names=268435642 end -- SHOW_NAMES
    if _G.Turbine.UI.Lotro.Action.ShowDamage==nil then _G.Turbine.UI.Lotro.Action.ShowDamage=268435561 end
    if _G.Turbine.UI.Lotro.Action.CaptureScreenshot==nil then _G.Turbine.UI.Lotro.Action.CaptureScreenshot=116 end -- CaptureScreenshot
    if _G.Turbine.UI.Lotro.Action.Tooltip_Detach==nil then _G.Turbine.UI.Lotro.Action.Tooltip_Detach=268435482 end -- TOOLTIP_DETACH
    if _G.Turbine.UI.Lotro.Action.ToggleHiddenDragBoxes==nil then _G.Turbine.UI.Lotro.Action.ToggleHiddenDragBoxes=268435579 end -- ToggleHiddenDragBoxes
    if _G.Turbine.UI.Lotro.Action.ToggleQuickslotLock==nil then _G.Turbine.UI.Lotro.Action.ToggleQuickslotLock=268435462 end
    if _G.Turbine.UI.Lotro.Action.UI_Toggle==nil then _G.Turbine.UI.Lotro.Action.UI_Toggle=268435635 end -- UI_TOGGLE
    if _G.Turbine.UI.Lotro.Action.Logout==nil then _G.Turbine.UI.Lotro.Action.Logout=268435552 end -- LOGOUT
    if _G.Turbine.UI.Lotro.Action.VoiceChat_Talk==nil then _G.Turbine.UI.Lotro.Action.VoiceChat_Talk=268435555 end -- VOICECHAT_TALK
    if _G.Turbine.UI.Lotro.Action.ToggleItemSellLock==nil then _G.Turbine.UI.Lotro.Action.ToggleItemSellLock=268435590 end -- ToggleItemSellLock
    -- auto loot all doesn't seem to be available, may have to test while looting
    if _G.Turbine.UI.Lotro.Action.DismountRemount==nil then _G.Turbine.UI.Lotro.Action.DismountRemount=268435916 end
    if _G.Turbine.UI.Lotro.Action.ShowRemoteQuestActions==nil then _G.Turbine.UI.Lotro.Action.ShowRemoteQuestActions=268436019 end
    if _G.Turbine.UI.Lotro.Action.TrackNearbyQuests==nil then _G.Turbine.UI.Lotro.Action.TrackNearbyQuests=268435929 end
    if _G.Turbine.UI.Lotro.Action.ClearAllFilters==nil then _G.Turbine.UI.Lotro.Action.ClearAllFilters=268435918 end
    
    -- MUSIC (many of these actions can only occur during Music Mode)
    -- Note, the naming using flats comes from Turbine in the Keymap file so I retained it for the Action names
    if _G.Turbine.UI.Lotro.Action.ToggleMusicMode==nil then _G.Turbine.UI.Lotro.Action.ToggleMusicMode=268435683 end
    if _G.Turbine.UI.Lotro.Action.MusicEndSong==nil then _G.Turbine.UI.Lotro.Action.MusicEndSong=268435695 end -- MusicEndSong
    if _G.Turbine.UI.Lotro.Action.Music_A2==nil then _G.Turbine.UI.Lotro.Action.Music_A2=268435659 end
    if _G.Turbine.UI.Lotro.Action.Music_Bb2==nil then _G.Turbine.UI.Lotro.Action.Music_Bb2=268435659 end
    if _G.Turbine.UI.Lotro.Action.Music_B2==nil then _G.Turbine.UI.Lotro.Action.Music_B2=268435649 end -- MUSIC_B2
    if _G.Turbine.UI.Lotro.Action.Music_C2==nil then _G.Turbine.UI.Lotro.Action.Music_C2=268435676 end
    if _G.Turbine.UI.Lotro.Action.Music_Db2==nil then _G.Turbine.UI.Lotro.Action.Music_Db2=268435656 end -- 
    if _G.Turbine.UI.Lotro.Action.Music_D2==nil then _G.Turbine.UI.Lotro.Action.Music_D2=268435666 end
    if _G.Turbine.UI.Lotro.Action.Music_Eb2==nil then _G.Turbine.UI.Lotro.Action.Music_Eb2=268435662 end
    if _G.Turbine.UI.Lotro.Action.Music_E2==nil then _G.Turbine.UI.Lotro.Action.Music_E2=268435674 end
    if _G.Turbine.UI.Lotro.Action.Music_F2==nil then _G.Turbine.UI.Lotro.Action.Music_F2=268435661 end
    if _G.Turbine.UI.Lotro.Action.Music_Gb2==nil then _G.Turbine.UI.Lotro.Action.Music_Gb2=268435671 end
    if _G.Turbine.UI.Lotro.Action.Music_G2==nil then _G.Turbine.UI.Lotro.Action.Music_G2=268435652 end
    if _G.Turbine.UI.Lotro.Action.Music_Ab3==nil then _G.Turbine.UI.Lotro.Action.Music_Ab3=268435680 end
    if _G.Turbine.UI.Lotro.Action.Music_A3==nil then _G.Turbine.UI.Lotro.Action.Music_A3=268435660 end -- MUSIC_A3
    if _G.Turbine.UI.Lotro.Action.Music_Bb3==nil then _G.Turbine.UI.Lotro.Action.Music_Bb3=268435648 end -- MUSIC_Bb3
    if _G.Turbine.UI.Lotro.Action.Music_B3==nil then _G.Turbine.UI.Lotro.Action.Music_B3=268435651 end -- MUSIC_B3
    if _G.Turbine.UI.Lotro.Action.Music_C3==nil then _G.Turbine.UI.Lotro.Action.Music_C3=268435678 end -- MUSIC_C3
    if _G.Turbine.UI.Lotro.Action.Music_Db3==nil then _G.Turbine.UI.Lotro.Action.Music_Db3=268435657 end -- MUSIC_Db3
    if _G.Turbine.UI.Lotro.Action.Music_D3==nil then _G.Turbine.UI.Lotro.Action.Music_D3=268435669 end -- MUSIC_D3
    if _G.Turbine.UI.Lotro.Action.Music_Eb3==nil then _G.Turbine.UI.Lotro.Action.Music_Eb3=268435665 end -- MUSIC_Eb3
    if _G.Turbine.UI.Lotro.Action.Music_E3==nil then _G.Turbine.UI.Lotro.Action.Music_E3=268435675 end -- MUSIC_E3
    if _G.Turbine.UI.Lotro.Action.Music_F3==nil then _G.Turbine.UI.Lotro.Action.Music_F3=268435664 end -- MUSIC_F3
    if _G.Turbine.UI.Lotro.Action.Music_Gb3==nil then _G.Turbine.UI.Lotro.Action.Music_Gb3=268435672 end -- MUSIC_Gb3
    if _G.Turbine.UI.Lotro.Action.Music_G3==nil then _G.Turbine.UI.Lotro.Action.Music_G3=268435654 end -- MUSIC_G3
    if _G.Turbine.UI.Lotro.Action.Music_Ab4==nil then _G.Turbine.UI.Lotro.Action.Music_Ab4=268435682 end --MUSIC_Ab4
    if _G.Turbine.UI.Lotro.Action.Music_A4==nil then _G.Turbine.UI.Lotro.Action.Music_A4=268435663 end -- MUSIC_A4
    if _G.Turbine.UI.Lotro.Action.Music_Bb4==nil then _G.Turbine.UI.Lotro.Action.Music_Bb4=268435650 end
    if _G.Turbine.UI.Lotro.Action.Music_B4==nil then _G.Turbine.UI.Lotro.Action.Music_B4=268435653 end -- MUSIC_B4
    if _G.Turbine.UI.Lotro.Action.Music_C4==nil then _G.Turbine.UI.Lotro.Action.Music_C4=268435679 end -- MUSIC_C4
    if _G.Turbine.UI.Lotro.Action.Music_Db4==nil then _G.Turbine.UI.Lotro.Action.Music_Db4=268435658 end
    if _G.Turbine.UI.Lotro.Action.Music_D4==nil then _G.Turbine.UI.Lotro.Action.Music_D4=268435670 end -- MUSIC_D4
    if _G.Turbine.UI.Lotro.Action.Music_Eb4==nil then _G.Turbine.UI.Lotro.Action.Music_Eb4=268435668 end
    if _G.Turbine.UI.Lotro.Action.Music_E4==nil then _G.Turbine.UI.Lotro.Action.Music_E4=268435677 end -- MUSIC_E4
    if _G.Turbine.UI.Lotro.Action.Music_F4==nil then _G.Turbine.UI.Lotro.Action.Music_F4=268435667 end -- MUSIC_F4
    if _G.Turbine.UI.Lotro.Action.Music_Gb4==nil then _G.Turbine.UI.Lotro.Action.Music_Gb4=268435673 end
    if _G.Turbine.UI.Lotro.Action.Music_G4==nil then _G.Turbine.UI.Lotro.Action.Music_G4=268435655 end -- MUSIC_G4
    if _G.Turbine.UI.Lotro.Action.Music_Ab5==nil then _G.Turbine.UI.Lotro.Action.Music_Ab5=268435646 end
    if _G.Turbine.UI.Lotro.Action.Music_C5==nil then _G.Turbine.UI.Lotro.Action.Music_C5=268435681 end -- MUSIC_C5
    
    -- FELLOWSHIP MANOEUVRES
    if _G.Turbine.UI.Lotro.Action.FellowshipSkillAssist==nil then _G.Turbine.UI.Lotro.Action.FellowshipSkillAssist=268435686 end
    if _G.Turbine.UI.Lotro.Action.TopFellowshipManoeuvre==nil then _G.Turbine.UI.Lotro.Action.TopFellowshipManoeuvre=268435609 end
    if _G.Turbine.UI.Lotro.Action.BottomFellowshipManoeuvre==nil then _G.Turbine.UI.Lotro.Action.BottomFellowshipManoeuvre=268435615 end
    if _G.Turbine.UI.Lotro.Action.LeftFellowshipManoeuvre==nil then _G.Turbine.UI.Lotro.Action.LeftFellowshipManoeuvre=268435624 end
    if _G.Turbine.UI.Lotro.Action.RightFellowshipManoeuvre==nil then _G.Turbine.UI.Lotro.Action.RightFellowshipManoeuvre=268435630 end
    
    -- FELLOWSHIP TARGET MARKING
    if _G.Turbine.UI.Lotro.Action.ShieldMark==nil then _G.Turbine.UI.Lotro.Action.ShieldMark=268435706 end
    if _G.Turbine.UI.Lotro.Action.SpearMark==nil then _G.Turbine.UI.Lotro.Action.SpearMark=268435697 end
    if _G.Turbine.UI.Lotro.Action.ArrowMark==nil then _G.Turbine.UI.Lotro.Action.ArrowMark=268435698 end
    if _G.Turbine.UI.Lotro.Action.SunMark==nil then _G.Turbine.UI.Lotro.Action.SunMark=268435699 end
    if _G.Turbine.UI.Lotro.Action.SwordsMark==nil then _G.Turbine.UI.Lotro.Action.SwordsMark=268435700 end
    if _G.Turbine.UI.Lotro.Action.MoonMark==nil then _G.Turbine.UI.Lotro.Action.MoonMark=268435701 end
    if _G.Turbine.UI.Lotro.Action.StarMark==nil then _G.Turbine.UI.Lotro.Action.StarMark=268435702 end
    if _G.Turbine.UI.Lotro.Action.ClawMark==nil then _G.Turbine.UI.Lotro.Action.ClawMark=268435703 end
    if _G.Turbine.UI.Lotro.Action.SkullMark==nil then _G.Turbine.UI.Lotro.Action.SkullMark=268435704 end
    if _G.Turbine.UI.Lotro.Action.LeafMark==nil then _G.Turbine.UI.Lotro.Action.LeafMark=268435705 end
    
    -- COSMETIC OUTFIT SELECTION
    if _G.Turbine.UI.Lotro.Action.PresentMainInventory==nil then _G.Turbine.UI.Lotro.Action.PresentMainInventory=268435710 end
    if _G.Turbine.UI.Lotro.Action.PresentOutfit1==nil then _G.Turbine.UI.Lotro.Action.PresentOutfit1=268435708 end
    if _G.Turbine.UI.Lotro.Action.PresentOutfit2==nil then _G.Turbine.UI.Lotro.Action.PresentOutfit2=268435709 end
    if _G.Turbine.UI.Lotro.Action.PresentOutfit3==nil then _G.Turbine.UI.Lotro.Action.PresentOutfit3=268435921 end
    if _G.Turbine.UI.Lotro.Action.PresentOutfit4==nil then _G.Turbine.UI.Lotro.Action.PresentOutfit4=268435922 end
    if _G.Turbine.UI.Lotro.Action.PresentOutfit5==nil then _G.Turbine.UI.Lotro.Action.PresentOutfit5=268435923 end
    if _G.Turbine.UI.Lotro.Action.PresentOutfit6==nil then _G.Turbine.UI.Lotro.Action.PresentOutfit6=268435925 end
    if _G.Turbine.UI.Lotro.Action.PresentOutfit7==nil then _G.Turbine.UI.Lotro.Action.PresentOutfit7=268435926 end
    
    -- CAMERA
    if _G.Turbine.UI.Lotro.Action.RotateCamera==nil then _G.Turbine.UI.Lotro.Action.RotateCamera=92 end
    -- no other Camera actions seem to be available at this time
    
    -- MOUSE
    if _G.Turbine.UI.Lotro.Action.RightMouseDown==nil then _G.Turbine.UI.Lotro.Action.RightMouseDown=19 end
    
    if _G.Turbine.UI.Lotro.Action.CutText==nil then _G.Turbine.UI.Lotro.Action.CutText=8 end -- Ctrl+X
    if _G.Turbine.UI.Lotro.Action.CopyText==nil then _G.Turbine.UI.Lotro.Action.CopyText=170 end -- Ctrl+C
    if _G.Turbine.UI.Lotro.Action.PasteText==nil then _G.Turbine.UI.Lotro.Action.PasteText=100 end -- Ctrl+V
    if _G.Turbine.UI.Lotro.Action.ToggleDebugHUD==nil then _G.Turbine.UI.Lotro.Action.ToggleDebugHUD=42 end -- ToggleDebugHUD (oddly named since it is the FPS display)
    if _G.Turbine.UI.Lotro.Action.SystemMenu==nil then _G.Turbine.UI.Lotro.Action.SystemMenu=268435900 end
    if _G.Turbine.UI.Lotro.Action.MainMenu==nil then _G.Turbine.UI.Lotro.Action.MainMenu=268435899 end
    if _G.Turbine.UI.Lotro.Action.ExitGame==nil then _G.Turbine.UI.Lotro.Action.ExitGame=268435570 end -- not sure this one is really worth knowing but you never know
    
    if _G.Turbine.UI.Lotro.Action.Admin_Light==nil then _G.Turbine.UI.Lotro.Action.Admin_Light=268435623 end -- ADMIN_LIGHT
    if _G.Turbine.UI.Lotro.Action.Accept_Input==nil then _G.Turbine.UI.Lotro.Action.Accept_Input=162 end -- ACCEPT_INPUT
    if _G.Turbine.UI.Lotro.Action.CursorPreviousPage==nil then _G.Turbine.UI.Lotro.Action.CursorPreviousPage=146 end
    if _G.Turbine.UI.Lotro.Action.CursorNextPage==nil then _G.Turbine.UI.Lotro.Action.CursorNextPage=49 end
    if _G.Turbine.UI.Lotro.Action.CursorStartOfLine==nil then _G.Turbine.UI.Lotro.Action.CursorStartOfLine=58 end
    if _G.Turbine.UI.Lotro.Action.CursorEndOfLine==nil then _G.Turbine.UI.Lotro.Action.CursorEndOfLine=57 end
    
    if _G.Turbine.UI.Lotro.Action.CursorCharLeft==nil then _G.Turbine.UI.Lotro.Action.CursorCharLeft=127 end
    if _G.Turbine.UI.Lotro.Action.CursorCharRight==nil then _G.Turbine.UI.Lotro.Action.CursorCharRight=108 end
    if _G.Turbine.UI.Lotro.Action.CursorPreviousLine==nil then _G.Turbine.UI.Lotro.Action.CursorPreviousLine=29 end
    if _G.Turbine.UI.Lotro.Action.CursorNextLine==nil then _G.Turbine.UI.Lotro.Action.CursorNextLine=113 end
    if _G.Turbine.UI.Lotro.Action.CursorWordLeft==nil then _G.Turbine.UI.Lotro.Action.CursorWordLeft=163 end
    if _G.Turbine.UI.Lotro.Action.CursorWordRight==nil then _G.Turbine.UI.Lotro.Action.CursorWordRight=37 end
    if _G.Turbine.UI.Lotro.Action.BackspaceKey==nil then _G.Turbine.UI.Lotro.Action.BackspaceKey=99 end
    if _G.Turbine.UI.Lotro.Action.DeleteKey==nil then _G.Turbine.UI.Lotro.Action.DeleteKey=75 end
    
    -- Vendor quantity selection
    if _G.Turbine.UI.Lotro.Action.ToggleStackDisplay==nil then _G.Turbine.UI.Lotro.Action.ToggleStackDisplay=268435836 end -- ToggleStackDisplay
    if _G.Turbine.UI.Lotro.Action.VendorFullStack==nil then _G.Turbine.UI.Lotro.Action.VendorFullStack=268435463 end
    if _G.Turbine.UI.Lotro.Action.VendorQuantity==nil then _G.Turbine.UI.Lotro.Action.VendorQuantity=268435835 end
    
    -- The following are only valid for Turbine's internal version of the client and can theoretically be used to attach actions to keystrokes since they do nothing in the player version of the client
    -- the default key binding is in parenthesis
    if _G.Turbine.UI.Lotro.Action.ToggleDebugConsole==nil then _G.Turbine.UI.Lotro.Action.ToggleDebugConsole=43 end -- ToggleDebugConsole (Ctrl+`)
    if _G.Turbine.UI.Lotro.Action.ToggleStringTokenDebugger==nil then _G.Turbine.UI.Lotro.Action.ToggleStringTokenDebugger=17 end -- ToggleStringTokenDebugger (Alt+`)
    if _G.Turbine.UI.Lotro.Action.ToggleMemoryGraph==nil then _G.Turbine.UI.Lotro.Action.ToggleMemoryGraph=184 end -- ToggleMemoryGraph (Shift+Alt+Ctrl+F8)
    if _G.Turbine.UI.Lotro.Action.ToggleBlockUI==nil then _G.Turbine.UI.Lotro.Action.ToggleBlockUI=173 end -- ToggleBlockUI (Shift+Alt+Ctrl+F9)
    if _G.Turbine.UI.Lotro.Action.TogglePerfGraph==nil then _G.Turbine.UI.Lotro.Action.TogglePerfGraph=139 end -- TogglePerfGraph (Shift+Alt+Ctrl+F10)
    if _G.Turbine.UI.Lotro.Action.ToggleProfiler==nil then _G.Turbine.UI.Lotro.Action.ToggleProfiler=140 end -- ToggleProfiler (Shift+Alt+Ctrl+F11)
    if _G.Turbine.UI.Lotro.Action.ToggleEntityNodeLabels==nil then _G.Turbine.UI.Lotro.Action.ToggleEntityNodeLabels=174 end -- ToggleEntityNodeLabels (Shift+Alt+Ctrl+F12)
    
    -- The following do not appear to be tied to in-game actions at this time but may be at some future time
    if _G.Turbine.UI.Lotro.Action.ToggleTraitTreeUI==nil then _G.Turbine.UI.Lotro.Action.ToggleTraitTreeUI=268436027 end -- ToggleTraitTreeUI (Ctrl+S)
    if _G.Turbine.UI.Lotro.Action.ToggleAdminPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleAdminPanel=268435571 end -- ToggleAdminPanel (Ctrl+A)
    if _G.Turbine.UI.Lotro.Action.ToggleThreatTrackerPanel==nil then _G.Turbine.UI.Lotro.Action.ToggleThreatTrackerPanel=268435853 end -- ToggleThreatTrackerPanel (Ctrl+H)

  
Once imported, you can refer to the actions by the names rather than the codes to make maintenance a bit easier. You can also simply use the above definitions to look up the particular codes you wish to handle.  
  
At the bottom of these definitions are a series of particularly interesting codes. Most keystrokes that are bound to an Action will activate some in-game action. The entries at the bottom of the definitions will NOT actually cause any in-game action in the live client and are thus noteworthy. Lua applications can respond to these Actions without any other in-game action occurring. There are two big downsides to this, first, there is no way to know if another plugin is responding to the Action and second, Turbine could theoretically remove the Actions from the game at any time.  
  
So, what is needed to actually make use of an Action? Let's suppose for some reason that we want to create a window that will display whenever the user turns their in-game light on or off. I know this isn't terribly useful, but it will suffice for a good example. First, we will need a basic window with some incredibly important message, like "It is pitch black. You are likely to be eaten by a grue.". For this sample, we will assume that the light is off by default and will only display the window when the light is off (so the message is visible as soon as we load the plugin).  

Code: 
    
    
    import "Turbine.UI"
    import "Turbine.UI.Lotro"
    ZorkWindow=Turbine.UI.Lotro.Window();
    ZorkWindow:SetSize(320,140);
    ZorkWindow:SetPosition(Turbine.UI.Display:GetWidth()/2-100,Turbine.UI.Display:GetHeight()/2-100);
    ZorkWindow:SetText("Turn on your light!");
    
    ZorkWindow.Message=Turbine.UI.Label();
    ZorkWindow.Message:SetParent(ZorkWindow);
    ZorkWindow.Message:SetSize(300,60);
    ZorkWindow.Message:SetPosition(10,40);
    ZorkWindow.Message:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    ZorkWindow.Message:SetMultiline(true);
    ZorkWindow.Message:SetFont(Turbine.UI.Lotro.Font.Verdana26);
    ZorkWindow.Message:SetText("It is pitch black. You are likely to be eaten by a grue.");
    
    ZorkWindow.KeyDown=function(sender,args)
        if args.Action==268435623 then -- if we had imported the above code we could have used Turbine.UI.Lotro.Action.Admin_Light instead of the constant, 268435623
            ZorkWindow:SetVisible(not ZorkWindow:IsVisible());
        end
    end
    
    ZorkWindow:SetVisible(true);
    ZorkWindow:SetWantsKeyEvents(true);

  
Now, whenever you press Alt+F10 (or whatever key your light has been bound to if you changed it) the message will toggle off and on in response to the Admin_Light Action. As it happens, the light actually has three states, two on and one off so the message gets out of sync with the actual light and you are destined to be eaten but you get the general idea.

---

## Post 17 — Garan 2025-06-16T20:35:16-0400

**Press my Buttons - I dare ya!**  
  
This section is really targeted at beginners who may not be familiar with creating buttons and may need a bit of help getting started. The final code example does include a nifty trick for displaying a Quickslot control as if it were a button that more advanced users may find useful.  
  
As you can imagine, a plugin without buttons has limited use. There are some, like Wallet, which are solely there to provide a display of existing data, but most plugins at some point or other require interaction from a user. There are many ways to generate a UI element which the user can interact with by clicking the mouse. I will only cover three of them here, the Lotro Button, the standard Button and the generic Control. Each has it's benefits and it's drawbacks:  
  
Lotro Button - instance of Turbine.UI.Lotro.Button  
Advantages - automatically works with user skins. Handles text. Has good default functionality  
Drawbacks - will automatically generate graphics whether you need them or not, not as easy to use for mixing graphics and text. Minor unnecessary overhead if all you need is to catch a mouse click.  
  
standard Button - instance of Turbine.UI.Button  
Advantages - has all of the necessary default functionality of a button and allows easy use of custom button graphics or text.  
Drawbacks - you must provide your own graphics if you want them. Minor unnecessary overhead if all you need is to catch a mouse click. Will only work with skins if your graphics use in-game resource IDs instead of custom images that you provide  
  
generic Control - instance of Turbine.UI.Control  
Advantages - customizable graphic container with the least amount of overhead.  
Drawbacks - does not support text without inclusion of a child control. Developer must provide all graphics. Will only work with skins if your graphics use in-game resource IDs instead of custom images that you provide  
  
As you can see, as you add capability such as supporting text and user skins, you also inherit more overhead. This usually isn't an issue unless you are making an array with many (hundreds?) of buttons but it's still a good practice to use the least complicated tool for the job (less chance of incorporating bugs and other unwanted behaviors).  
  
So, how do we create a button and what can we do with it? In it's simplest form, a button is an area on the UI which will respond to mouse clicks by performing an action. We normally also consider buttons to have the behavior of looking as though they have been "pressed" when the mouse clicks on them. Lastly, we usually expect buttons to highlight or otherwise indicate when the mouse is moved over them. All of these behaviors can be achieved with all three types of buttons, it just requires a bit more work with the more generic ones. To start with, just create a standard button that says "Press Me". To do this, we will want to use either the Lotro Button or the standard Button since the generic Control does not support text without some additional help. We will create a window with two buttons and you can see how they differ, especially if you switch user skins.  

Code: 
    
    
    import "Turbine" -- needed for the Shell.WriteLine
    import "Turbine.UI" -- needed for the standard Button
    import "Turbine.UI.Lotro" -- needed for the Lotro.Window and the Lotro.Button
    myWindow=Turbine.UI.Lotro.Window(); -- we will simply create an instance of the base class since we don't need more than one window and only need the default functionality
    myWindow:SetSize(400,400); -- give ourselves lots of room to play in ;)
    myWindow:SetPosition((Turbine.UI.Display:GetWidth()-myWindow:GetWidth())/2,(Turbine.UI.Display:GetHeight()-myWindow:GetHeight())/2); -- center window (I don't hardcode the height and width so that I can change them easier as I modify the project)
    myWindow:SetText("BUTTONS!"); -- set window title
    -- create labels for our buttons (I use an array just to save typing)
    local tmpIndex;
    myWindow.ButtonLabels={};
    for tmpIndex=1,2 do
        myWindow.ButtonLabels[tmpIndex]=Turbine.UI.Label();
        myWindow.ButtonLabels[tmpIndex]:SetParent(myWindow);
        myWindow.ButtonLabels[tmpIndex]:SetSize(190,20);
        myWindow.ButtonLabels[tmpIndex]:SetPosition(5,tmpIndex*25+20); -- position the labels in a column down the left of the window
    end
    myWindow.ButtonLabels[1]:SetText("Lotro.Button");
    myWindow.ButtonLabels[2]:SetText("Standard Button");
    -- here's the Lotro.Button
    myWindow.SampleButton1=Turbine.UI.Lotro.Button();
    myWindow.SampleButton1:SetParent(myWindow);
    myWindow.SampleButton1:SetSize(190,20); --note that the height & width of a Lotro.Button will automatically correct itself to fit the minimum decorations
    myWindow.SampleButton1:SetPosition(200,myWindow.ButtonLabels[1]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton1:SetText("Press Me!");
    -- provide a simplistic click handler
    myWindow.SampleButton1.MouseClick=function()
        Turbine.Shell.WriteLine("You pressed the Lotro.Button!");
    end
    myWindow.SampleButton2=Turbine.UI.Button();
    myWindow.SampleButton2:SetParent(myWindow);
    myWindow.SampleButton2:SetSize(147,20); -- the graphic we are using happen to be 147x20. if you use custom graphics you would set the button size to whatever size the graphic is
    myWindow.SampleButton2:SetPosition(200,myWindow.ButtonLabels[2]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton2:SetText("Press Me Too!");
    -- provide a simplistic click handler
    myWindow.SampleButton2.MouseClick=function()
        Turbine.Shell.WriteLine("You pressed the standard Button!");
    end
    myWindow:SetVisible(true); -- display the window

  
The first thing you should notice is that the standard button doesn't look like a button at all. The reason is that it has no default "decorations", that is there's no border. Additionally, when the mouse moves over the Lotro.Button it highlights and when the mouse is pressed it appears to "press" while the standard button does not. In order to provide the standard button with this kind of functionality, we would have to provide three background images and manually control setting the background. I happen to know the resource IDs for some in-game button backgrounds that we can use instead of creating our own images so I will use them, but you could easily replace them with custom images by providing the path to SetBackground() instead of a resource ID.  
  
So, let's modify our sample to allow the standard button to behave a bit more like a Lotro.Button:  

Code: 
    
    
    import "Turbine" -- needed for the Shell.WriteLine
    import "Turbine.UI" -- needed for the standard Button
    import "Turbine.UI.Lotro" -- needed for the Lotro.Window and the Lotro.Button
    myWindow=Turbine.UI.Lotro.Window(); -- we will simply create an instance of the base class since we don't need more than one window and only need the default functionality
    myWindow:SetSize(400,400); -- give ourselves lots of room to play in ;)
    myWindow:SetPosition((Turbine.UI.Display:GetWidth()-myWindow:GetWidth())/2,(Turbine.UI.Display:GetHeight()-myWindow:GetHeight())/2); -- center window (I don't hardcode the height and width so that I can change them easier as I modify the project)
    myWindow:SetText("BUTTONS!"); -- set window title
    -- create labels for our buttons (I use an array just to save typing)
    local tmpIndex;
    myWindow.ButtonLabels={};
    for tmpIndex=1,2 do
        myWindow.ButtonLabels[tmpIndex]=Turbine.UI.Label();
        myWindow.ButtonLabels[tmpIndex]:SetParent(myWindow);
        myWindow.ButtonLabels[tmpIndex]:SetSize(190,20);
        myWindow.ButtonLabels[tmpIndex]:SetPosition(5,tmpIndex*25+20); -- position the labels in a column down the left of the window
    end
    myWindow.ButtonLabels[1]:SetText("Lotro.Button");
    myWindow.ButtonLabels[2]:SetText("Standard Button");
    -- here's the Lotro.Button
    myWindow.SampleButton1=Turbine.UI.Lotro.Button();
    myWindow.SampleButton1:SetParent(myWindow);
    myWindow.SampleButton1:SetSize(190,20); --note that the height & width of a Lotro.Button will automatically correct itself to fit the minimum decorations
    myWindow.SampleButton1:SetPosition(200,myWindow.ButtonLabels[1]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton1:SetText("Press Me!");
    -- provide a simplistic click handler
    myWindow.SampleButton1.MouseClick=function()
        Turbine.Shell.WriteLine("You pressed the Lotro.Button!");
    end
    myWindow.SampleButton2=Turbine.UI.Button();
    myWindow.SampleButton2:SetParent(myWindow);
    myWindow.SampleButton2:SetSize(190,20);
    myWindow.SampleButton2:SetPosition(200,myWindow.ButtonLabels[2]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton2:SetText("Press Me Too!");
    -- provide a simplistic click handler
    myWindow.SampleButton2.MouseClick=function()
        Turbine.Shell.WriteLine("You pressed the standard Button!");
    end
    -- this is the code that handles the background
    myWindow.SampleButton2:SetBlendMode(Turbine.UI.BlendMode.Overlay); -- this will cause any transparent parts of the background image to display your window's background instead of being completely transparent and displaying the game UI display
    myWindow.SampleButton2:SetBackground(0x410001a5)
    myWindow.SampleButton2.MouseEnter=function()
        myWindow.SampleButton2:SetBackground(0x410001a6)
    end
    myWindow.SampleButton2.MouseLeave=function()
        myWindow.SampleButton2:SetBackground(0x410001a5)
    end
    myWindow.SampleButton2.MouseDown=function()
        myWindow.SampleButton2:SetBackground(0x410001aa)
    end
    myWindow.SampleButton2.MouseUp=function()
        myWindow.SampleButton2:SetBackground(0x410001a6)
    end
    myWindow:SetVisible(true); -- display the window

  
This time, the standard button has a background and will highlight and press with the mouse as expected. The only difference you should have noticed is the size - we had to set the button to the fixed size of the graphic - and the font color. The Lotro.Button inherited the font color of the skin, while our standard button has to have it's font color set by the developer.  
  
So far, we have wanted to display text on our buttons. If we want to display both text and a graphic, then the standard Button is probably the best way to go since it supports text and you can assign your own graphics easily. If you only want to display a graphic, then you should probably use a generic Control object since you do not need text support. Here's a sample showing each of the three options, text only, text and graphic, and graphic only. This sample will use other built in image resources, in this case the "left arrow" button:  

Code: 
    
    
    import "Turbine" -- needed for the Shell.WriteLine
    import "Turbine.UI" -- needed for the standard Button
    import "Turbine.UI.Lotro" -- needed for the Lotro.Window and the Lotro.Button
    myWindow=Turbine.UI.Lotro.Window(); -- we will simply create an instance of the base class since we don't need more than one window and only need the default functionality
    myWindow:SetSize(400,400); -- give ourselves lots of room to play in ;)
    myWindow:SetPosition((Turbine.UI.Display:GetWidth()-myWindow:GetWidth())/2,(Turbine.UI.Display:GetHeight()-myWindow:GetHeight())/2); -- center window (I don't hardcode the height and width so that I can change them easier as I modify the project)
    myWindow:SetText("BUTTONS!"); -- set window title
    -- create labels for our buttons (I use an array just to save typing)
    local tmpIndex;
    myWindow.ButtonLabels={};
    for tmpIndex=1,3 do
        myWindow.ButtonLabels[tmpIndex]=Turbine.UI.Label();
        myWindow.ButtonLabels[tmpIndex]:SetParent(myWindow);
        myWindow.ButtonLabels[tmpIndex]:SetSize(190,20);
        myWindow.ButtonLabels[tmpIndex]:SetPosition(5,tmpIndex*25+20); -- position the labels in a column down the left of the window
    end
    myWindow.ButtonLabels[1]:SetText("Lotro.Button");
    myWindow.ButtonLabels[2]:SetText("Standard Button");
    myWindow.ButtonLabels[3]:SetText("Generic Control");
    -- here's the Lotro.Button
    myWindow.SampleButton1=Turbine.UI.Lotro.Button();
    myWindow.SampleButton1:SetParent(myWindow);
    myWindow.SampleButton1:SetSize(190,20); --note that the height & width of a Lotro.Button will automatically correct itself to fit the minimum decorations
    myWindow.SampleButton1:SetPosition(200,myWindow.ButtonLabels[1]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton1:SetText("Press Me!");
    -- provide a simplistic click handler
    myWindow.SampleButton1.MouseClick=function()
        Turbine.Shell.WriteLine("You pressed the Lotro.Button!");
    end
    myWindow.SampleButton2=Turbine.UI.Button();
    myWindow.SampleButton2:SetParent(myWindow);
    myWindow.SampleButton2:SetSize(190,20);
    myWindow.SampleButton2:SetPosition(200,myWindow.ButtonLabels[2]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton2:SetText("Press Me Too!");
    -- provide a simplistic click handler
    myWindow.SampleButton2.MouseClick=function()
        Turbine.Shell.WriteLine("You pressed the standard Button!");
    end
    -- this is the code that handles the background
    myWindow.SampleButton2:SetBlendMode(Turbine.UI.BlendMode.Overlay); -- this will cause any transparent parts of the background image to display your window's background instead of being completely transparent and displaying the game UI display
    myWindow.SampleButton2:SetBackground(0x410001c8)
    myWindow.SampleButton2.MouseEnter=function()
        myWindow.SampleButton2:SetBackground(0x410001c9)
    end
    myWindow.SampleButton2.MouseLeave=function()
        myWindow.SampleButton2:SetBackground(0x410001c8)
    end
    myWindow.SampleButton2.MouseDown=function()
        myWindow.SampleButton2:SetBackground(0x410001ca)
    end
    myWindow.SampleButton2.MouseUp=function()
        myWindow.SampleButton2:SetBackground(0x410001c9)
    end
    -- the generic button control
    myWindow.SampleButton3=Turbine.UI.Control();
    myWindow.SampleButton3:SetParent(myWindow);
    myWindow.SampleButton3:SetSize(20,20);
    myWindow.SampleButton3:SetPosition(200,myWindow.ButtonLabels[3]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    -- provide a simplistic click handler
    myWindow.SampleButton3.MouseClick=function()
        Turbine.Shell.WriteLine("You pressed the generic Control!");
    end
    -- this is the code that handles the background
    myWindow.SampleButton3:SetBlendMode(Turbine.UI.BlendMode.Overlay); -- this will cause any transparent parts of the background image to display your window's background instead of being completely transparent and displaying the game UI display
    myWindow.SampleButton3:SetBackground(0x410001c8)
    myWindow.SampleButton3.MouseEnter=function()
        myWindow.SampleButton3:SetBackground(0x410001c9)
    end
    myWindow.SampleButton3.MouseLeave=function()
        myWindow.SampleButton3:SetBackground(0x410001c8)
    end
    myWindow.SampleButton3.MouseDown=function()
        myWindow.SampleButton3:SetBackground(0x410001ca)
    end
    myWindow.SampleButton3.MouseUp=function()
        myWindow.SampleButton3:SetBackground(0x410001c9)
    end
    myWindow:SetVisible(true); -- display the window

  
Now that you know how to create buttons that perform basic interactions, let's look at something slightly different. Suppose you want to have a button that performs the same functionality as a quickslot. You can't assign an image to a Quickslot control and you can't programmatically use Items, Skills or Aliases in a button event handler. The solution is to be sneaky. What we do is hide a Quickslot under a Control and let the mouse events pass through to the Quickslot:  

Code: 
    
    
    import "Turbine" -- needed for the Shell.WriteLine
    import "Turbine.UI" -- needed for the standard Button
    import "Turbine.UI.Lotro" -- needed for the Lotro.Window and the Lotro.Button
    import "Turbine.Gameplay" -- needed for the player name
    myWindow=Turbine.UI.Lotro.Window(); -- we will simply create an instance of the base class since we don't need more than one window and only need the default functionality
    myWindow:SetSize(400,400); -- give ourselves lots of room to play in ;)
    myWindow:SetPosition((Turbine.UI.Display:GetWidth()-myWindow:GetWidth())/2,(Turbine.UI.Display:GetHeight()-myWindow:GetHeight())/2); -- center window (I don't hardcode the height and width so that I can change them easier as I modify the project)
    myWindow:SetText("BUTTONS!"); -- set window title
    -- create labels for our buttons (I use an array just to save typing)
    local tmpIndex;
    myWindow.ButtonLabels={};
    for tmpIndex=1,4 do
        myWindow.ButtonLabels[tmpIndex]=Turbine.UI.Label();
        myWindow.ButtonLabels[tmpIndex]:SetParent(myWindow);
        myWindow.ButtonLabels[tmpIndex]:SetSize(190,20);
        myWindow.ButtonLabels[tmpIndex]:SetPosition(5,tmpIndex*25+20); -- position the labels in a column down the left of the window
    end
    myWindow.ButtonLabels[1]:SetText("Lotro.Button");
    myWindow.ButtonLabels[2]:SetText("Standard Button");
    myWindow.ButtonLabels[3]:SetText("Generic Control");
    myWindow.ButtonLabels[4]:SetText("Quickslot button");
    -- here's the Lotro.Button
    myWindow.SampleButton1=Turbine.UI.Lotro.Button();
    myWindow.SampleButton1:SetParent(myWindow);
    myWindow.SampleButton1:SetSize(190,20); --note that the height & width of a Lotro.Button will automatically correct itself to fit the minimum decorations
    myWindow.SampleButton1:SetPosition(200,myWindow.ButtonLabels[1]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton1:SetText("Press Me!");
    -- provide a simplistic click handler
    myWindow.SampleButton1.MouseClick=function()
        Turbine.Shell.WriteLine("You pressed the Lotro.Button!");
    end
    myWindow.SampleButton2=Turbine.UI.Button();
    myWindow.SampleButton2:SetParent(myWindow);
    myWindow.SampleButton2:SetSize(190,20);
    myWindow.SampleButton2:SetPosition(200,myWindow.ButtonLabels[2]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton2:SetText("Press Me Too!");
    -- provide a simplistic click handler
    myWindow.SampleButton2.MouseClick=function()
        Turbine.Shell.WriteLine("You pressed the standard Button!");
    end
    -- this is the code that handles the background
    myWindow.SampleButton2:SetBlendMode(Turbine.UI.BlendMode.Overlay); -- this will cause any transparent parts of the background image to display your window's background instead of being completely transparent and displaying the game UI display
    myWindow.SampleButton2:SetBackground(0x410001c8)
    myWindow.SampleButton2.MouseEnter=function()
        myWindow.SampleButton2:SetBackground(0x410001c9)
    end
    myWindow.SampleButton2.MouseLeave=function()
        myWindow.SampleButton2:SetBackground(0x410001c8)
    end
    myWindow.SampleButton2.MouseDown=function()
        myWindow.SampleButton2:SetBackground(0x410001ca)
    end
    myWindow.SampleButton2.MouseUp=function()
        myWindow.SampleButton2:SetBackground(0x410001c9)
    end
    -- the generic button control
    myWindow.SampleButton3=Turbine.UI.Control();
    myWindow.SampleButton3:SetParent(myWindow);
    myWindow.SampleButton3:SetSize(20,20);
    myWindow.SampleButton3:SetPosition(200,myWindow.ButtonLabels[3]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    -- provide a simplistic click handler
    myWindow.SampleButton3.MouseClick=function()
        Turbine.Shell.WriteLine("You pressed the generic Control!");
    end
    -- this is the code that handles the background
    myWindow.SampleButton3:SetBlendMode(Turbine.UI.BlendMode.Overlay); -- this will cause any transparent parts of the background image to display your window's background instead of being completely transparent and displaying the game UI display
    myWindow.SampleButton3:SetBackground(0x410001c8)
    myWindow.SampleButton3.MouseEnter=function()
        myWindow.SampleButton3:SetBackground(0x410001c9)
    end
    myWindow.SampleButton3.MouseLeave=function()
        myWindow.SampleButton3:SetBackground(0x410001c8)
    end
    myWindow.SampleButton3.MouseDown=function()
        myWindow.SampleButton3:SetBackground(0x410001ca)
    end
    myWindow.SampleButton3.MouseUp=function()
        myWindow.SampleButton3:SetBackground(0x410001c9)
    end
    -- get the localPlayerName for later...
    local localPlayerName=Turbine.Gameplay.LocalPlayer:GetInstance():GetName();
    
    -- and now, the button you've all been waiting for... the Quickslot button!
    myWindow.SampleButton4=Turbine.UI.Lotro.Quickslot();
    myWindow.SampleButton4:SetParent(myWindow);
    myWindow.SampleButton4:SetSize(20,20);
    myWindow.SampleButton4:SetPosition(200,myWindow.ButtonLabels[4]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton4:SetShortcut(Turbine.UI.Lotro.Shortcut(Turbine.UI.Lotro.ShortcutType.Alias,"/tell "..localPlayerName.." OUCH, that HURT! :p"))
    myWindow.SampleButton4.ShortcutData="/tell "..localPlayerName.." OUCH, that HURT! :p"; --save the alias text for later
    myWindow.SampleButton4:SetAllowDrop(false); -- turn off drag and drop so the user doesn't accidentally modify our button action
    myWindow.SampleButton4.DragDrop=function()
        -- even though we turned off drop operations, there is a bug that allows the quickslot to drop on itself effectively wiping out the shortcut
        local sc=Turbine.UI.Lotro.Shortcut(Turbine.UI.Lotro.ShortcutType.Alias,"");
        sc:SetData(myWindow.SampleButton4.ShortcutData);
        myWindow.SampleButton4:SetShortcut(sc);
    end
    myWindow.SampleButton4.Backdrop=Turbine.UI.Control(); -- note, if the icon has no transparencies then this backdrop is not needed
    myWindow.SampleButton4.Backdrop:SetParent(myWindow);
    myWindow.SampleButton4.Backdrop:SetSize(20,20);
    myWindow.SampleButton4.Backdrop:SetPosition(200,myWindow.ButtonLabels[4]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton4.Backdrop:SetZOrder(myWindow.SampleButton4:GetZOrder()+1); -- force the icon to be displayed above the quickslot
    myWindow.SampleButton4.Backdrop:SetBackColor(Turbine.UI.Color(1,0,0,0));
    myWindow.SampleButton4.Backdrop:SetMouseVisible(false); -- prevent the icon from interacting with the mouse so that all mouse events fall through to the quickslot behind it
    myWindow.SampleButton4.Icon=Turbine.UI.Control();
    myWindow.SampleButton4.Icon:SetParent(myWindow);
    myWindow.SampleButton4.Icon:SetSize(20,20);
    myWindow.SampleButton4.Icon:SetPosition(200,myWindow.ButtonLabels[4]:GetTop()); --yeah, I got lazy and hardcoded the left side ;)
    myWindow.SampleButton4.Icon:SetZOrder(myWindow.SampleButton4:GetZOrder()+2); -- force the icon to be displayed above the quickslot
    myWindow.SampleButton4.Icon:SetMouseVisible(false); -- prevent the icon from interacting with the mouse so that all mouse events fall through to the quickslot behind it
    myWindow.SampleButton4.Icon:SetBlendMode(Turbine.UI.BlendMode.Overlay); -- this will cause any transparent parts of the background image to display your window's background instead of being completely transparent and displaying the game UI display
    -- this is the code that handles the background, note that the handles are assigned to the quickslot but they manipulate the icon
    myWindow.SampleButton4.Icon:SetBackground(0x410001c8)
    myWindow.SampleButton4.MouseEnter=function()
        myWindow.SampleButton4.Icon:SetBackground(0x410001c9)
    end
    myWindow.SampleButton4.MouseLeave=function()
        myWindow.SampleButton4.Icon:SetBackground(0x410001c8)
    end
    myWindow.SampleButton4.MouseDown=function()
        myWindow.SampleButton4.Icon:SetBackground(0x410001ca)
    end
    myWindow.SampleButton4.MouseUp=function()
        myWindow.SampleButton4.Icon:SetBackground(0x410001c9)
    end
    myWindow:SetVisible(true); -- display the window

One important aspect of the Quickslot button is that we have to prevent the user from accidentally dragging another shortcut onto our button or accidentally wiping out our shortcut by dragging it out of the quickslot. We protect it by turning off Drag/Drop operations and then fixing the glitch that allows it to drop on itself by reassigning the shortcut in the DragDrop event handler.  
  
Now you know lots of fun ways to make things go Click. Bear in mind that any object that is derived from the base Control object will inherit the ability to display a graphic and respond to mouseclicks so there are many, many more ways to create buttons, but hopefully you have a better idea now of how to create one of the basic UI elements.  
  
A follow up installment, Beyond Buttons, will demonstrate how to create a scalable button that can handle larger fonts and automatically size to text.

---

## Post 18 — Garan 2025-06-16T20:35:47-0400

**...or An Introduction to Apartments and Child Plugins with a smattering of Chat monitoring.  
  
**This (rather large) installment covers some advanced functionality but hopefully in a simple enough format for even Noobs to follow. The sample plugin discussed here can be downloaded from LoTROInterface at <http://www.lotrointerface.com/downloads/fileinfo.php?id=652>  
  
So... we were all excited to learn that we now had an object that we could use to access our Party. Then we found that it didn't quite work as advertised :( Specifically, the MemberAdded and MemberRemoved events don't always fire and the member list gets corrupted. To get around this, we will delve into two interesting and useful concepts, child plugins and cross Apartment communication.  
  
Although there isn't really any parent/child relationship, I call a plugin a Child Plugin when it is programmatically loaded and unloaded to help with some specific task that requires a new environment or access to the loading/unloading state. This can be particularly helpful when working around a built-in object like the Party or Backpack that gets corrupted or out of sync. By using a new Apartment, the child has access to a brand new, synchronized version of the object. Additionally, when you need to get real-time access to your own data, a Child Plugin can do that (or your "main" plugin can act like a child and be loaded/unloaded as needed by a handler or parent plugin).  
  
Cross Apartment communication is a bit tricky, but can be successfully achieved in several ways. The first is using the very existence of a plugin in the Plugins[] collection to signify that its loading is complete and some process can now safely continue - we will use this in this example. Another form of communication can be achieved using specially encoded shell commands. By creating a shell command with a specific name, information can be encoded and sent to another plugin in any apartment - this sample will show how to achieve this with party member names. A third form of communication can be achieved not only cross Apartment, but also cross client with the help of a user click. Simply create a quickslot that generates a chat message, usually a tell to a specific client, and have a plugin monitoring the chat messages on the recipient end and with the help of a user click, the plugins can send messages to each other via the in-game chat (the multi-player Cards game client uses this functionality in its Elevenses game - not yet published). There is a fourth option which is fairly easy to implement but can be intrusive/disruptive to the user. Anything written by the Turbine.Shell.WriteLine method will appear in the Standard chat channel and any plugin in any Apartment will receive this message if it has a Chat event handler monitoring the Standard channel. As mentioned though, if you are passing a lot of data or doing it frequently, this method can be very disruptive as it will flood the chat window (if the user has the Standard channel selected in their filters).  
  
So, how does a child plugin help get around the corruption of the Party object? Well, as I mentioned, each time a new environment is loaded, a whole new Party object is created and it is in synch with the game (basically the same as unloading and reloading our plugin to get back in synch). If a child plugin can be loaded in a new Apartment and the Party object information retrieved, it will be in synch without having to unload and reload ourselves. Once we retrieve the Party info, we can then unload the child apartment to save resources and then it can be loaded again as needed. Retrieving the Party info is where the cross-apartment communication comes in. Since we can't share global data (in this case, a good thing) we have to find another way of letting our parent know what we've found. To do this, we use two of the methods already mentioned, using the existance of the child in the Plugins[] collection to indicate that the data is available and using a shell command to publish and receive the actual data.  
  
To get started, we will need to create an author folder, plugin folder and two plugins, our main plugin and our child plugin, I will name them PartySample and MyParty respectively. For simplicity, I will literally call the author folder "YourName". Feel free to substitute your actual name wherever YourName appears in the following code. The plugin folder we will call "PartySample".  
  
In your "Plugins" folder, create a folder named "YourParty". In your "Plugins/YourParty" folder, create a folder named "PartySample". In your "Plugins/YourParty/PartySample" folder, create a folder named "Resources". This last folder will hold any images we need, in this case just a pair of 32x32 icons for the plugins.  
  
Use your favorite image editor to create two 32x32 images, one for the main plugin icon, one for the child plugin icon, and save them as "main.jpg" and "child.jpg" in the "Plugins/YourParty/PartySample/Resources" folder. These will be used by the Plugin Manager available in Update 5 or currently live on Bullroarer.  
  
In your "Plugins/YourName" folder, create the following two .plugin files:  
PartySample.plugin  

Code: 
    
    
    <?xml version="1.0"?>
    <Plugin>
     <Information>
      <Name>PartySample</Name>
      <Author>Garan</Author>
      <Version>1.0</Version>
      <Description>This plugin sample displays the list of party name. This is just a sample to show how to use the MyParty plugin.</Description>
      <Image>YourName/PartySample/Resources/main.jpg</Image>
     </Information>
     <Package>YourName.PartySample.Main</Package>
    </Plugin>

  
MyParty.plugin  

Code: 
    
    
    <?xml version="1.0"?>
    <Plugin>
     <Information>
      <Name>MyParty</Name>
      <Author>Garan</Author>
      <Version>1.0</Version>
      <Description>This plugin is used internally by PartySample and should NOT be loaded by the user or plugin manager.</Description>
      <Image>YourName/PartySample/Resources/child.jpg</Image>
     </Information>
     <Package>YourName.PartySample.MyParty</Package>
     <Configuration Apartment="MyParty" />
    </Plugin>

  
Note that the MyParty plugin includes a Configuration element with a distinct Apartment attribute, "MyParty". This will cause the MyParty plugin to get its own new environment when it is loaded.  
  
Now, create the MyParty.lua file in the "Plugins/YourName/PartySample" folder:  

Code: 
    
    
    import "Turbine"
    import "Turbine.UI"
    import "Turbine.Gameplay"
    -- all this plugin does is provide a snapshot of the party names.
    -- Party Plugin loads this plugin, reads the party names and once complete it unloads this plugin.
    -- This helps alleviate some of the bugs in the Turbine Party object.
    local party=Turbine.Gameplay.LocalPlayer:GetInstance():GetParty();
    local lIndex;
    local shellCommand=Turbine.ShellCommand();
    local shellString="";
    local loaded=false;
    local member;
    if party~=nil then
     member=party:GetLeader(); -- retrieve the leader name
     -- the prefix starts with a "0" so that it will sort alphabetically to the beginning of the command list
     -- then next two letters "MP" just signify that it is from MyParty
     -- the "L" signifies the "Leader" name
     -- the second "0" is a placeholder to be consistent with the Member records that have an Index value
     -- the underscore is just a separator to make debugging easier
     -- the last part is the actual name
     -- this will match the string pattern "0MP([LM])%d+_(.+)" which has two "captures", the first is "[LM]" which indicates either an "L" or an "M" and the second, ".+", is one or more of any non-control character
     -- captures are used with the string.match command to fill variables with the portion of a string matching their pattern
     shellString="0MPL0_"..member:GetName();
     for lIndex=1,party:GetMemberCount() do
      -- we build a string with semi-colon separated "command" names, each command can have many names (I haven't found an upper limit) so we can generate all of our entries with a single actual shell command
      member=party:GetMember(lIndex);
      -- the only differences in these records is that the "L" is replaced with an "M" which will indicate a "Member" name and the second "0" is replaced with the actual index
      -- note that we don't actually use the index, but it is encoded anyway in case we find a future use for it
      shellString=shellString..";0MPM"..tostring(lIndex).."_"..tostring(member:GetName());
     end
     -- now we use that string with all of the encoded values to create shell commands entries tied to a single shell command object
     Turbine.Shell.AddCommand(shellString,shellCommand);
    end
    tmpWindow=Turbine.UI.Window()
    tmpWindow.Update=function()
     if (Plugins["MyParty"] ~= nil) and (not loaded) then
      loaded=true;
      Plugins["MyParty"].Unload = function(self,sender,args)
       -- after the plugin completes loading, we create the "Unload" event and use it to remove our one shell command
       Turbine.Shell.RemoveCommand(shellCommand)
      end
      tmpWindow:SetWantsUpdates(false);
     end
    end

Read through the comments to see how the plugin actually encodes the Party member names and creates the shell commands.  
  
Now, create the lua file that provides the party wrapper functionality for the main plugin. This file is purposely written to be reusable in other plugins, so you can create copies of it in your own projects if you so desire. The party wrapper will create an object that gets initialized by loading the MyParty plugin, processing the shell commands that contain the Party member names, and then unloading the MyParty plugin, avoiding any ties to the environment that had the Party object. Once initialized, it uses a Chat event handler to watch for any messages pertaining to a party and updates it's membership list accordingly. If the character joins a party after the plugin is loaded, it simply resets the flags for the MyParty plugin and reprocesses it. If the character leaves their party or is dismissed, it clears all of the party info.  
  
This wrapper is locale aware, that is, it accounts for the different client messages based on whether you are running the EN,DE or FR client. The message patterns are stored in the ResStr table and are generated depending on the existence of the various versions of the "help" command.  
  
Another interesting point is that the wrapper can support multiple host applications - the wrapper's events can hold tables of functions the same way that Turbines events do so it supports the AddCallback and RemoveCallback functions.  
  
This file should be saved in the "Plugins/YourName/PartySample" folder as PartyWrapper.lua  

Code: 
    
    
    import "Turbine";
    import "Turbine.UI";
    import "Turbine.Gameplay";
    -- the generic AddCallback and RemoveCallback functions that allow supporting multiple handlers for each event.
    function AddCallback(object, event, callback)
        if (object[event] == nil) then
            object[event] = callback;
        else
            if (type(object[event]) == "table") then
                table.insert(object[event], callback);
            else
                object[event] = {object[event], callback};
            end
        end
        return callback;
    end
    function RemoveCallback(object, event, callback)
        if (object[event] == callback) then
            object[event] = nil;
        else
            if (type(object[event]) == "table") then
                local size = table.getn(object[event]);
                local i;
                for i = 1, size do
                    if (object[event][i] == callback) then
                        table.remove(object[event], i);
                        break;
                    end
                end
            end
        end
    end
    -- This is the default locale and ResStr settings representing the "EN" client
    -- We create the ResStr table to hold all of the resource strings used in the plugin. In this case they happen to only be the patterns used to match the client chat messages.
    locale = "en";
    ResStr={};
    ResStr[1]="You have joined a .+%.";
    ResStr[2]="You leave your .+%.";
    ResStr[3]="Your .+ has been disbanded%.";
    ResStr[4]="You have been dismissed from your .+%.";
    ResStr[5]="You are now the leader of the .+%.";
    ResStr[6]="(.+) is now the leader of the .+%.";
    ResStr[7]="You dismiss (.+) from the .+%.";
    ResStr[8]="(.+) has joined your .+%.";
    ResStr[9]="(.+) has left your .+%.";
    ResStr[10]="(.+) has been dismissed from your .+%.";
    -- this tests for the "DE" client by checking for the existance of the German version of the Help command
    if Turbine.Shell.IsCommand("hilfe") then
     -- if the German Help command, Hilfe, exists then override the locale and ResStr table with the "DE" values
     locale = "de";
     ResStr[1]="Ihr habt Euch einer .+ angeschlossen%.";
     ResStr[2]="Ihr verlasst .+%.";
     ResStr[3]=".+ wurde aufgel"..string.char(195)..string.char(182).."st%.";
     ResStr[4]="Ihr wurdet aus .+ ausgeschlossen%.";
     ResStr[5]="Ihr f"..string.char(195)..string.char(188).."hrt jetzt die .+ an%.";
     ResStr[6]="(.+) f"..string.char(195)..string.char(188).."hrt jetzt die Gruppe von Gef"..string.char(195)..string.char(164).."hrten an%.";
     ResStr[7]="Ihr schlie"..string.char(195)..string.char(159).."t (.+) aus .+ aus%.";
     ResStr[8]="(.+) hat sich .+ angeschlossen%.";
     ResStr[9]="(.+) hat .+ verlassen%.";
     ResStr[10]="(.+) wurde aus.+ausgeschlossen%.";
    elseif Turbine.Shell.IsCommand("aide") then
     locale = "fr";
     ResStr[1]="Vous avez rejoint .+%."
     ResStr[2]="Vous quittez votre .+%."
     ResStr[3]="Votre .+ s'est rompue."
     ResStr[4]="Vous avez "..string.char(195)..string.char(169).."t"..string.char(195)..string.char(169).." renvoy"..string.char(195)..string.char(169).." de votre .+%."
     ResStr[5]="Vous "..string.char(195)..string.char(170).."tes "..string.char(195)..string.char(160).." pr"..string.char(195)..string.char(169).."sent le chef d.+%."
     ResStr[6]="(.+) est "..string.char(195)..string.char(160).." pr"..string.char(195)..string.char(169).."sent le chef d.+%."
     ResStr[7]="Vous renvoyez (.+) d.+%."
     ResStr[8]="(.+) a rejoint votre .+%."
     ResStr[9]="(.+) a quitt"..string.char(195)..string.char(169).." votre .+%."
     ResStr[10]="(.+) ne fait plus partie de votre .+%."
    end
    -- This is the function that handles the actual firing of events
    -- When called, we pass the object raising the event, "sender", the name of the event being raised, and the "args" parameter which contains either a single argument or a table of arguments to be passed to the event handlers
    function FireEvent(sender,event,args)
     -- allows us to fire events as functions or tables of functions
     if type(event)=="function" then
      -- if the event only has a single function assigned, then we call that function passing it the sender and args arguments
      event(sender,args);
     else
      if type(event)=="table" then
       -- if the event has a table of functions assigned to it, then we call each function passing it the sender and args arguments
       local size = table.getn(event);
       local i;
       for i=1,size do
        if type(event[i])=="function" then
         event[i](sender,args);
        end
       end
      end
     end
    end
    -- This creates the generic control that we use to represent the partywrapper - we use a control since we need to have an Update event handler
    PartyWrapper=Turbine.UI.Control();
    -- chat handle
    PartyWrapper.chat=Turbine.Chat;
    -- This is the event handler for the chat object - this handler will keep the party names synchronized by processing any messages dealing with the Party
    ChatReceived=function(sender, args)
     message=args.Message
     -- we are only interested in messages in the "Standard" channel
     if args.ChatType==Turbine.ChatType.Standard then
      -- Now compare the message to each of the possible Party messages and if a match is found, either take the appropriate action and/or fire the appropriate event
      if string.find(message,ResStr[1]) then
       FireEvent(PartyWrapper,PartyWrapper.JoinedParty,nil);
      elseif string.find(message,ResStr[2]) or string.find(message,ResStr[3]) or string.find(message,ResStr[4]) then
       PartyWrapper.leaderName="";
       while #PartyWrapper.memberName>0 do
        table.remove(PartyWrapper.memberName);
       end
       FireEvent(PartyWrapper,PartyWrapper.LeftParty,nil);
      elseif string.find(message,ResStr[5])~=nil then
       local args={};
       args.OldLeader=PartyWrapper.leaderName;
       PartyWrapper.leaderName=Turbine.Gameplay.LocalPlayer:GetInstance():GetName();
       args.NewLeader=PartyWrapper.leaderName;
       FireEvent(PartyWrapper,PartyWrapper.LeaderChanged,args);
      else
       local member=string.match(message,ResStr[6]);
       if member~=nil then
        local args={};
        args.OldLeader=PartyWrapper.leaderName;
        PartyWrapper.leaderName=member;
        args.NewLeader=PartyWrapper.leaderName;
        FireEvent(PartyWrapper,PartyWrapper.LeaderChanged,args);
       else
        member=string.match(message,ResStr[7]);
        if member==nil then
         member=string.match(message,ResStr[9]);
        end
        if member==nil then
         member=string.match(message,ResStr[10]);
        end
        if member~=nil then
         local memberIndex;
         for memberIndex=1,#PartyWrapper.memberName do
          if PartyWrapper.memberName[memberIndex]==member then
           table.remove(PartyWrapper.memberName,memberIndex);
           local args={};
           args.MemberName=member;
           FireEvent(PartyWrapper,PartyWrapper.MemberRemoved,args);
           break;
          end
         end
         if #PartyWrapper.memberName==1 then
          -- we dismissed the only other member of the party, effectively disbanding
          PartyWrapper.leaderName="";
          table.remove(PartyWrapper.memberName);
          FireEvent(PartyWrapper,PartyWrapper.LeftParty,nil);
         end
        else
         member=string.match(message,ResStr[8]);
         if member~=nil then
          local memberIndex;
          local found=false;
          for memberIndex=1,#PartyWrapper.memberName do
           if PartyWrapper.memberName[memberIndex]==member then
            found=true;
            break;
           end
          end
          if not found then
           PartyWrapper.memberName[#PartyWrapper.memberName+1]=member;
           local args={};
           args.MemberName=member;
           FireEvent(PartyWrapper,PartyWrapper.MemberAdded,args);
          end
         else
         end
        end
       end
      end
     end
    end
    -- This is the unload event handler. Since we only process this when our apartment is being unloaded we know the wrapper will be unloaded too, so all we have to clean up is our own chat event handler
    PartyWrapper.Unload=function(sender)
     RemoveCallback(PartyWrapper.chat, "Received", ChatReceived)
    end
    -- Set the name of the plugin specific child party plugin - you could theoretically have more than one plugin with distinct apartments depending on how you reuse the plugin. We called this one "MyParty"
    PartyWrapper.childPlugin="MyParty";
    PartyWrapper.loaded=false; -- this will be set to true once the Lua file is fully parsed and processed and the Plugin[] entry is created
    PartyWrapper.initialized=false; -- this will be set to true once the Child plugin has been detected, indicating that the initial party data has been generated and processed
    PartyWrapper.leaderName=""; -- this is our internal storage for the party leader's name
    PartyWrapper.memberName={}; -- this table will hold our replica of the party member's names
    PartyWrapper.Update=function()
     if not PartyWrapper.loaded then
      -- if we are not yet flagged as loaded, the first time Update get's called we load the child plugin and set the loaded flag
      Turbine.PluginManager.LoadPlugin(PartyWrapper.childPlugin);
      PartyWrapper.loaded=true;
     elseif PartyWrapper.loaded then
      for tmpIndex=1,#Turbine.PluginManager:GetLoadedPlugins() do
       -- once we start loading the child plugin, we have to wait until it finishes intializing before we can retrieve the names
       if Turbine.PluginManager:GetLoadedPlugins()[tmpIndex].Name==PartyWrapper.childPlugin then
        -- turn off updates as soon as possible so that we don't waste machine cycles and don't accidentally process the names twice
        PartyWrapper:SetWantsUpdates(false);
        -- at this point, we know that the data (if any) is available so we get the list of shell command names
        cmds=Turbine.Shell.GetCommands();
        if cmds~=nil and type(cmds)=="table" then
         local cmdIndex;
         -- now we do an alphabetic asort on the command names so that we can limit the number of commands that we compare to our data pattern
         table.sort(cmds,function(arg1,arg2)if arg1<arg2 then return(true) end end);
         -- clear out the local replica since we're loading it from scratch with data from the child plugin
         while #PartyWrapper.memberName>0 do
          table.remove(PartyWrapper.memberName);
         end
         -- now iterate through the alphabetic list of command names
         for cmdIndex=1,#cmds do
          -- if we get to the chat command for user channel 1, we know that there are no more encoded data values since they all start with a "0"
          if cmds[cmdIndex]>="1" then
           break
          else
           -- try to match the command to our encoded pattern, loading the variables if the patten matches
           local leader,index,name=string.match(cmds[cmdIndex],"0MP([LM])(%d+)_(.+)");
           index=tonumber(index);
           --if we got data, process it
           if leader~=nil then
            if leader=="L" then
             -- this command name contained the party leaders name
             PartyWrapper.leaderName=name;
            else
             -- this command name contained a party member record
             PartyWrapper.memberName[index]=name;
            end
           end
          end
         end
        end
        -- once we've processed all of the potential commands, flag the wrapper as initialized
        PartyWrapper.initialized=true;
        -- we're done with the encoded commands, so unload the child plugin and let it clean up the command names
        Turbine.PluginManager.UnloadScriptState(PartyWrapper.childPlugin);
        -- now that we're initialized, add the Chat event handler that will keep us synchronized
        AddCallback(PartyWrapper.chat,"Received",ChatReceived)
       end
      end
     end
    end
    -- The wrapper is ready to get initialized, turn on update event handling
    PartyWrapper:SetWantsUpdates(true);
    -- This method exposes the number of Party Members
    PartyWrapper.GetMemberCount=function()
     return #PartyWrapper.memberName;
    end
    -- This method exposes the Party Leader Name
    PartyWrapper.GetLeaderName=function()
     return PartyWrapper.leaderName;
    end
    -- This method exposes the name of the member at the specified index
    PartyWrapper.GetMemberName=function(sender,index)
     local name=nil;
     index=tonumber(index);
     if index~=nil then
      index=math.floor(index)
      if index>0 and index<=#PartyWrapper.memberName then
       name=PartyWrapper.memberName[index];
      end
     end
     return name;
    end

Finally, we need some basic plugin to make use of this reusable wrapper. The following code creates a simple party member list display - it isn't fancy and doesn't hide with the Esc or F12 keys, but it will give a decent example of using the Party Wrapper.  
  
This file should be saved as "main.lua" in the "Plugins/YourName/PartySample" folder.  

Code: 
    
    
    import "Turbine"
    import "Turbine.UI"
    import "Turbine.UI.Lotro"
    import "YourName.PartySample.PartyWrapper"
    -- the generic AddCallback and RemoveCallback functions that allow supporting multiple handlers for each event.
    function AddCallback(object, event, callback)
        if (object[event] == nil) then
            object[event] = callback;
        else
            if (type(object[event]) == "table") then
                table.insert(object[event], callback);
            else
                object[event] = {object[event], callback};
            end
        end
        return callback;
    end
    function RemoveCallback(object, event, callback)
        if (object[event] == callback) then
            object[event] = nil;
        else
            if (type(object[event]) == "table") then
                local size = table.getn(object[event]);
                local i;
                for i = 1, size do
                    if (object[event][i] == callback) then
                        table.remove(object[event], i);
                        break;
                    end
                end
            end
        end
    end
    -- Create a window to hold the list of names
    sampleWindow=Turbine.UI.Lotro.Window();
    sampleWindow:SetBackColor(Turbine.UI.Color(0,0,0,0));
    sampleWindow:SetSize(400,400);
    sampleWindow:SetText("Party Sample")
    -- Create the actual listbox that will display the list of names
    sampleWindow.PartyList=Turbine.UI.ListBox();
    sampleWindow.PartyList:SetParent(sampleWindow);
    sampleWindow.PartyList:SetSize(sampleWindow:GetWidth()-32,sampleWindow:GetHeight()-110);
    sampleWindow.PartyList:SetPosition(10,50);
    sampleWindow.PartyList:SetBackColor(Turbine.UI.Color(.1,.1,.1));
    -- Bind a vertical scrollbar to the listbox
    sampleWindow.VScroll=Turbine.UI.Lotro.ScrollBar();
    sampleWindow.VScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
    sampleWindow.VScroll:SetParent(sampleWindow);
    sampleWindow.VScroll:SetPosition(sampleWindow:GetWidth()-22,50);
    sampleWindow.VScroll:SetWidth(12);
    sampleWindow.VScroll:SetHeight(sampleWindow.PartyList:GetHeight());
    sampleWindow.PartyList:SetVerticalScrollBar(sampleWindow.VScroll);
    -- create a label to display the count of the players currently in the Fellowship/Raid
    sampleWindow.Count=Turbine.UI.Label();
    sampleWindow.Count:SetParent(sampleWindow);
    sampleWindow.Count:SetSize(200,20);
    sampleWindow.Count:SetPosition(sampleWindow:GetWidth()/2-100,sampleWindow:GetHeight()-55);
    sampleWindow.Count:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    sampleWindow.Count:SetText("Count:0");
    -- Create a button that allows forcing a refresh if the display ever got out of synch (so far has never been used)
    sampleWindow.RefreshButton=Turbine.UI.Lotro.Button();
    sampleWindow.RefreshButton:SetParent(sampleWindow);
    sampleWindow.RefreshButton:SetSize(150,20);
    sampleWindow.RefreshButton:SetPosition(sampleWindow:GetWidth()/2-75,sampleWindow:GetHeight()-30);
    sampleWindow.RefreshButton:SetText("Force Refresh");
    sampleWindow.RefreshButton.MouseClick=function()
     -- force a refresh of the wrapper
     PartyWrapper.loaded=false;
     PartyWrapper.initialized=false;
     PartyWrapper:SetWantsUpdates(true);
     sampleWindow:SetWantsUpdates(true);
    end
    -- This is where we query the wrapper for the count, leader name and member names
    sampleWindow.RefreshList=function()
     -- start by clearing any old data
     sampleWindow.PartyList:ClearItems();
     local count=PartyWrapper:GetMemberCount();
     -- update the count display
     sampleWindow.Count:SetText("Count:"..tonumber(count));
     if count>0 then
      -- store the leader name so that we can set the matching member name to a different color
      local leader=PartyWrapper:GetLeaderName();
      local tmpIndex;
      for tmpIndex=1,count do
       -- iterate through the membernames, creating a label for each one and adding it to the listbox
       local tmpRow=Turbine.UI.Label();
       tmpRow:SetParent(sampleWindow.PartyList);
       tmpRow:SetSize(sampleWindow.PartyList:GetWidth(),20);
       local name=PartyWrapper:GetMemberName(tmpIndex);
       if name==leader then
        tmpRow:SetForeColor(Turbine.UI.Color(0,1,0));
       else
        tmpRow:SetForeColor(Turbine.UI.Color(0,.2,1));
       end
       tmpRow:SetText(name);
       sampleWindow.PartyList:AddItem(tmpRow);
      end
     end
    end
    sampleWindow.loaded=false;
    sampleWindow.Update=function()
     if Plugins["PartySample"]~=nil and sampleWindow.loaded==false then
      -- when we first load we want to create our unload handler
      sampleWindow.loaded=true;
      Plugins["PartySample"].Unload=function()
       -- when we unload we want to be sure to remove all of our event handlers and shell commands
       RemoveCallback(PartyWrapper, "LeaderChanged", LeaderChanged);
       RemoveCallback(PartyWrapper, "MemberAdded", MemberAdded);
       RemoveCallback(PartyWrapper, "MemberRemoved", MemberRemoved);
       RemoveCallback(PartyWrapper, "JoinedParty", JoinedParty);
       RemoveCallback(PartyWrapper, "LeftParty", LeftParty);
       PartyWrapper:Unload(); -- this will unregister the chat event handler - this assumes we are the only plugin using the wrapper... should change this to allow for other plugins
       Turbine.Shell.RemoveCommand(sampleWindow.shellCommand);
      end
     end
     if PartyWrapper.initialized then
      -- if the wrapper is flagged as initialized, the we want to refresh our list and stop handling updates until the wrapper raises an event
      sampleWindow.loaded=true;
      sampleWindow:SetWantsUpdates(false);
      sampleWindow:RefreshList();
     end
    end
    -- These are the event handlers that will be assigned to the possible events that the wrapper can raise. 
    LeaderChanged=function(sender,args)
     sampleWindow:RefreshList();
    end
    MemberAdded=function()
     sampleWindow:RefreshList();
    end
    MemberRemoved=function()
     sampleWindow:RefreshList();
    end
    JoinedParty=function()
     PartyWrapper.loaded=false;
     PartyWrapper.initialized=false;
     PartyWrapper:SetWantsUpdates(true);
     sampleWindow:SetWantsUpdates(true);
    end
    LeftParty=function()
     sampleWindow:RefreshList();
    end
    -- add the handlers to the wrappers events
    AddCallback(PartyWrapper, "LeaderChanged", LeaderChanged);
    AddCallback(PartyWrapper, "MemberAdded", MemberAdded);
    AddCallback(PartyWrapper, "MemberRemoved", MemberRemoved);
    AddCallback(PartyWrapper, "JoinedParty", JoinedParty);
    AddCallback(PartyWrapper, "LeftParty", LeftParty);
    --  create a "/PartySample toggle" shell command to allow the user to redisplay the window if they close it
    sampleWindow.shellCommand=Turbine.ShellCommand();
    sampleWindow.shellCommand.Execute = function(sender, cmd, args)
     if string.lower(args)=="toggle" then
      sampleWindow:SetVisible(not sampleWindow:IsVisible());
     end
    end
    Turbine.Shell.AddCommand("partySample",sampleWindow.shellCommand);
    -- turn on updates so that we can get initialized
    sampleWindow:SetWantsUpdates(true);
    -- display the window
    sampleWindow:SetVisible(true);

While the "Main" plugin in this sample isn't terribly useful, it serves as a good example of how to perform cross apartment communication, how to programmatically load and unload a plugin, how to fire custom events, using the Chat event handler to monitor the chat channels and even a bit of internationalization.  
  
The MyParty plugin and the PartyWrapper files should lend themselves quite nicely for reuse in any plugin that wants to track the party member names and leader but doesn't want to get caught up in the possible client crash issues currently surrounding the Party object and the failures to fire MemberAdded/MemberRemoved events.

---

## Post 19 — Garan 2025-06-16T20:36:17-0400

This installment deals with one of the mildly confusing UI elements for new developers, the ScollBar control. This control can either be used as a stand alone slider control or can be bound to any class that is derived from a Turbine class derived from the ScrollableControl. The reason the previous sentence seems redundant by specifying "derived from" twice is that user classes should not derive directly from the ScrollableControl class, since using the SetParent() method of an instance of this class directly will cause the client to crash, so instead either derive from or create instances of any of the controls listed in the API documentation as being derived from ScrollableControl, such as Label, Button, CheckBox, TextBox, etc.  
  
There are three common ways in which I tend to use a scrollbar. First as a stand alone scrollbar to generate a scrollable value, such as an opacity setting in an options dialog. Second as an unbound scrolling control for a viewport. Third as a bound control for scrolling one of Turbines scrollable controls. We will explore examples of each.  
  
When a scrollbar is unbound, the user has to set the limits, value and scroll event handlers for the control. When a control is bound, the limits, value and scroll event handlers are unavailable programmatically and attempting to set them or read them will generate errors. The Members and Methods affected by this are:  
GetMaximum(), GetMinimum(), GetValue(), SetMaximum(), SetMinimum(), SetValue() and ValueChanged.  
  
Our first sample is an unbound slider that will control the Opacity of it's parent window. This example is very common for option panels as unbound scrollbars can be used to control or set just about any numeric value. There is one minor issue with the current Turbine implementation, it doesn't properly support negative bounds so if your lower limit represents a negative, use an offset for the bounds and adjust the value accordingly. For instance, to generate -10 to 10, you would actually set the bounds to 0 to 20 and then subtract 10 when reading the value and add 10 when setting the value.  

Code: 
    
    
    import "Turbine"
    import "Turbine.UI"
    import "Turbine.UI.Lotro"
    scrollWindow=Turbine.UI.Lotro.Window();
    scrollWindow:SetSize(400,400);
    scrollWindow:SetPosition((Turbine.UI.Display:GetWidth()-scrollWindow:GetWidth())/2,(Turbine.UI.Display:GetHeight()-scrollWindow:GetHeight())/2);
    scrollWindow:SetText("Scrollbar Sample");
    -- create a caption for our scrollable value
    opacityCaption=Turbine.UI.Label();
    opacityCaption:SetParent(scrollWindow);
    opacityCaption:SetSize(120,20);
    opacityCaption:SetPosition(10,45);
    opacityCaption:SetText("Opacity");
    -- create the actual scrollbar and initialize it
    scrollbar1=Turbine.UI.Lotro.ScrollBar();
    scrollbar1:SetParent(scrollWindow);
    scrollbar1:SetOrientation(Turbine.UI.Orientation.Horizontal);
    scrollbar1:SetPosition(opacityCaption:GetLeft()+opacityCaption:GetWidth()+5,opacityCaption:GetTop()+4);
    scrollbar1:SetSize(scrollWindow:GetWidth()-10-scrollbar1:GetLeft(),12); -- set width to window-border-left, 12 pixel height is standard for "Lotro" style horizontal scrollbars
    scrollbar1:SetBackColor(Turbine.UI.Color(.1,.1,.2)); -- just to give it a little style
    scrollbar1:SetMinimum(10);
    scrollbar1:SetMaximum(100); -- we will divide the value by 100 to get our 0-1 scale with 2 decimal places
    local initValue=scrollWindow:GetOpacity()*100; -- retrieve the initial value and convert it to our scroll scale
    if initValue<10 then initValue=10 end; -- it's good practice to make sure you initialize your control to a valid value based on the min/max values you set
    scrollbar1:SetValue(initValue);
    -- set the ValueChanged event handler to take an action when our value changes, in this case, change the current window's opacity
    scrollbar1.ValueChanged=function()
        scrollWindow:SetOpacity(scrollbar1:GetValue()/100); -- we divide the 0-100 scrollbar scale to get our 0-1 opacity scale with 2 decimal places
    end
    scrollWindow:SetVisible(true);

Note, I set the minimum opacity to .1 so that you wouldn't accidentally scroll your window to invisibility and then lose it    
  
That's about all there is to a simple scrollable value control. Our next sample is a bit more complex because it will provide a scrollable viewport - a fairly common need. For this example, we will create a grid of some of the compass map 200x200 images and allow the user to scroll around them with a 200x200 viewport. This will demonstrate how to use both a horizontal and a vertical scrollbar.  

Code: 
    
    
    import "Turbine"
    import "Turbine.UI"
    import "Turbine.UI.Lotro"
    scrollWindow=Turbine.UI.Lotro.Window();
    scrollWindow:SetSize(400,400);
    scrollWindow:SetPosition((Turbine.UI.Display:GetWidth()-scrollWindow:GetWidth())/2,(Turbine.UI.Display:GetHeight()-scrollWindow:GetHeight())/2);
    scrollWindow:SetText("Scrollbar Sample");
    -- create a caption for our viewport
    viewportCaption=Turbine.UI.Label();
    viewportCaption:SetParent(scrollWindow);
    viewportCaption:SetSize(120,20);
    viewportCaption:SetPosition(10,45);
    viewportCaption:SetText("Viewport:");
    -- create the viewport control all it needs is size and position as it is simply used to create viewable bounds for our map
    viewport=Turbine.UI.Control();
    viewport:SetParent(scrollWindow);
    viewport:SetSize(200,200);
    viewport:SetPosition(viewportCaption:GetLeft()+viewportCaption:GetWidth()+5,viewportCaption:GetTop());
    -- create the map content for our viewport, again, it only needs size and position as it is just a container for the grid of images
    viewport.map=Turbine.UI.Control();
    viewport.map:SetParent(viewport); -- set the map as a child of the viewport so that it will be bounded by it for drawing purposes
    viewport.map:SetSize(1000,800); -- we'll use a 5x4 grid but this obviously could be expanded, or even set up as a recycled array of controls
    viewport.map:SetPosition(0,0); -- we'll start off in the upper left
    -- create the grid of map tiles
    mapTiles={}
    local hIndex,vIndex;
    for hIndex=1,5 do
        mapTiles[hIndex]={};
        for vIndex=1,4 do
            mapTiles[hIndex][vIndex]=Turbine.UI.Control()
            mapTiles[hIndex][vIndex]:SetParent(viewport.map);
            mapTiles[hIndex][vIndex]:SetPosition((hIndex-1)*200,(vIndex-1)*200)
            mapTiles[hIndex][vIndex]:SetSize(200,200);
        end
    end
    -- set the tile images to a group of images I happen to know from the misty mountains area...
    mapTiles[1][1]:SetBackground(0x4101db9d);
    mapTiles[1][2]:SetBackground(0x4101db9c);
    mapTiles[1][3]:SetBackground(0x4101db9b);
    mapTiles[1][4]:SetBackground(0x4101db9a);
    mapTiles[2][1]:SetBackground(0x4101dba2);
    mapTiles[2][2]:SetBackground(0x4101dba1);
    mapTiles[2][3]:SetBackground(0x4101dba0);
    mapTiles[2][4]:SetBackground(0x4101db9f);
    mapTiles[3][1]:SetBackground(0x4101dba7);
    mapTiles[3][2]:SetBackground(0x4101dba6);
    mapTiles[3][3]:SetBackground(0x4101dba5);
    mapTiles[3][4]:SetBackground(0x4101dba4);
    mapTiles[4][1]:SetBackground(0x4101dbab);
    mapTiles[4][2]:SetBackground(0x4101dbaa);
    mapTiles[4][3]:SetBackground(0x4101dba9);
    mapTiles[4][4]:SetBackground(0x4101dba8);
    mapTiles[5][1]:SetBackground(0x4101dbaf);
    mapTiles[5][2]:SetBackground(0x4101dbae);
    mapTiles[5][3]:SetBackground(0x4101dbad);
    mapTiles[5][4]:SetBackground(0x4101dbac);
    -- create the vertical scrollbar for our viewport
    vscroll=Turbine.UI.Lotro.ScrollBar();
    vscroll:SetParent(scrollWindow);
    vscroll:SetOrientation(Turbine.UI.Orientation.Vertical);
    vscroll:SetPosition(viewport:GetLeft()+viewport:GetWidth(),viewport:GetTop());
    vscroll:SetSize(12,viewport:GetHeight()); -- set width to 12 since it's a "Lotro" style scrollbar and the height is set to match the control that we will be scrolling
    vscroll:SetBackColor(Turbine.UI.Color(.1,.1,.2)); -- just to give it a little style
    vscroll:SetMinimum(0);
    vscroll:SetMaximum(viewport.map:GetHeight()-viewport:GetHeight()); -- we will allow scrolling the height of the map-the viewport height
    vscroll:SetValue(0); -- set the initial value
    -- set the ValueChanged event handler to take an action when our value changes, in this case, change the map position relative to the viewport
    vscroll.ValueChanged=function()
        viewport.map:SetTop(0-vscroll:GetValue());
    end
    -- create the horizontal scrollbar for our viewport
    hscroll=Turbine.UI.Lotro.ScrollBar();
    hscroll:SetParent(scrollWindow);
    hscroll:SetOrientation(Turbine.UI.Orientation.Horizontal);
    hscroll:SetPosition(viewport:GetLeft(),viewport:GetTop()+viewport:GetHeight());
    hscroll:SetSize(viewport:GetWidth(),12);
    hscroll:SetBackColor(Turbine.UI.Color(.1,.1,.2)); -- just to give it a little style
    hscroll:SetMinimum(0);
    hscroll:SetMaximum(viewport.map:GetWidth()-viewport:GetWidth()); -- we will allow scrolling the width of the map-the viewport width
    hscroll:SetValue(0); -- set the initial value
    -- set the ValueChanged event handler to take an action when our value changes, in this case, change the map position relative to the viewport
    hscroll.ValueChanged=function()
        viewport.map:SetLeft(0-hscroll:GetValue());
    end
    scrollWindow:SetVisible(true);

  
Now we will recreate that same viewport using a pair of bound controls and a listbox.  

Code: 
    
    
    import "Turbine"
    import "Turbine.UI"
    import "Turbine.UI.Lotro"
    scrollWindow=Turbine.UI.Lotro.Window();
    scrollWindow:SetSize(400,400);
    scrollWindow:SetPosition((Turbine.UI.Display:GetWidth()-scrollWindow:GetWidth())/2,(Turbine.UI.Display:GetHeight()-scrollWindow:GetHeight())/2);
    scrollWindow:SetText("Scrollbar Sample");
    -- create a caption for our viewport
    viewportCaption=Turbine.UI.Label();
    viewportCaption:SetParent(scrollWindow);
    viewportCaption:SetSize(120,20);
    viewportCaption:SetPosition(10,45);
    viewportCaption:SetText("Viewport:");
    -- create the viewport control all it needs is size and position as it is simply used to create viewable bounds for our map
    viewport=Turbine.UI.ListBox();
    viewport:SetParent(scrollWindow);
    viewport:SetSize(200,200);
    viewport:SetPosition(viewportCaption:GetLeft()+viewportCaption:GetWidth()+5,viewportCaption:GetTop());
    -- this time we create the map content as rows in the listbox
    -- create the grid of map tiles
    mapTiles={}; -- now, if we only wanted to use this as a display, there's really no need to maintain the mapTiles outside of their rows, but it's easier to set/manipulate the background images if we do
    local hIndex,vIndex;
    for vIndex=1,4 do
        mapTiles[vIndex]={}; -- note, this time we have to use the vIndex as the first index since the row item gets created first and contains the column items
        local tmpRow=Turbine.UI.Control(); -- we will use a control as a container for each row
        tmpRow:SetParent(viewport);
        tmpRow:SetSize(1000,200);
        for hIndex=1,5 do
            mapTiles[vIndex][hIndex]=Turbine.UI.Control()
            mapTiles[vIndex][hIndex]:SetParent(tmpRow);
            mapTiles[vIndex][hIndex]:SetPosition((hIndex-1)*200,0)
            mapTiles[vIndex][hIndex]:SetSize(200,200);
        end
        viewport:AddItem(tmpRow);
    end
    -- set the tile images to a group of images I happen to know from the misty mountains area...
    mapTiles[1][1]:SetBackground(0x4101db9d);
    mapTiles[2][1]:SetBackground(0x4101db9c);
    mapTiles[3][1]:SetBackground(0x4101db9b);
    mapTiles[4][1]:SetBackground(0x4101db9a);
    mapTiles[1][2]:SetBackground(0x4101dba2);
    mapTiles[2][2]:SetBackground(0x4101dba1);
    mapTiles[3][2]:SetBackground(0x4101dba0);
    mapTiles[4][2]:SetBackground(0x4101db9f);
    mapTiles[1][3]:SetBackground(0x4101dba7);
    mapTiles[2][3]:SetBackground(0x4101dba6);
    mapTiles[3][3]:SetBackground(0x4101dba5);
    mapTiles[4][3]:SetBackground(0x4101dba4);
    mapTiles[1][4]:SetBackground(0x4101dbab);
    mapTiles[2][4]:SetBackground(0x4101dbaa);
    mapTiles[3][4]:SetBackground(0x4101dba9);
    mapTiles[4][4]:SetBackground(0x4101dba8);
    mapTiles[1][5]:SetBackground(0x4101dbaf);
    mapTiles[2][5]:SetBackground(0x4101dbae);
    mapTiles[3][5]:SetBackground(0x4101dbad);
    mapTiles[4][5]:SetBackground(0x4101dbac);
    -- create the vertical scrollbar for our viewport
    vscroll=Turbine.UI.Lotro.ScrollBar();
    vscroll:SetParent(scrollWindow);
    vscroll:SetOrientation(Turbine.UI.Orientation.Vertical);
    vscroll:SetPosition(viewport:GetLeft()+viewport:GetWidth(),viewport:GetTop());
    vscroll:SetSize(12,viewport:GetHeight()); -- set width to 12 since it's a "Lotro" style scrollbar and the height is set to match the control that we will be scrolling
    vscroll:SetBackColor(Turbine.UI.Color(.1,.1,.2)); -- just to give it a little style
    viewport:SetVerticalScrollBar(vscroll);
    --note the complete lack of setting minimum, maximum values, initializing the value or creating an action.
    -- create the horizontal scrollbar for our viewport
    hscroll=Turbine.UI.Lotro.ScrollBar();
    hscroll:SetParent(scrollWindow);
    hscroll:SetOrientation(Turbine.UI.Orientation.Horizontal);
    hscroll:SetPosition(viewport:GetLeft(),viewport:GetTop()+viewport:GetHeight());
    hscroll:SetSize(viewport:GetWidth(),12);
    hscroll:SetBackColor(Turbine.UI.Color(.1,.1,.2)); -- just to give it a little style
    viewport:SetHorizontalScrollBar(hscroll);
    --note the complete lack of setting minimum, maximum values, initializing the value or creating an action.
    hscroll.ValueChanged=function()
        Turbine.Shell.WriteLine("value:"..hscroll:GetValue())
    end
    scrollWindow:SetVisible(true);

The only difference to the end user is that the scrollbars have a smaller scale since you are scrolling the entire control and not pixel by pixel. So, if the built in controls can create the same effect with less code, why would we ever want to create our own custom scrollable controls? Well, there are some limitations to the built in scrollable controls, for instance there are situations where it might be desirable to manipulate the scroll position of the control programmatically, which you can not do with the built in controls. In other cases, you might want to be able to respond to the value changes but the ValueChanged event will not fire when bound and the GetValue method is not valid when bound (it generates an error when bound). So for simply displaying data to the user, the built-in scrollable controls and bound scrollbars are just fine, but for controls that need to interact with other UI elements, you will need to use unbound scrollbars and control the limits, values and actions yourself.  
  
The code for this sample is available as a single window plugin on LoTROInterface:  
<http://www.lotrointerface.com/downloads/fileinfo.php?id=659>
