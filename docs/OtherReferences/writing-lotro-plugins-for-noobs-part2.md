## Post 1 — Garan 2025-06-16T20:36:47-0400

It's about time!  
  
It's been quite a while since I published any new examples here and since at least one budding author had a question about using a timer in Lua I figured this was as good a time as any to add a new sample. This installment is a fairly simple but robust timer class, originally published in response to the question, "[how to write a timer?](http://forums.lotro.com/showthread.php?468944-how-to-write-a-timer)".  
  
There are three time related methods in the Turbine engine, Turbine.Engine.GetDate(), Turbine.Engine.GetGameTime() and Turbine.Engine.GetLocalTime(). The first, GetDate() returns a table with values for "Day", "DayOfWeek", "DayOfYear", "Hour", "IsDST", "Minute", "Month", "Second" and "Year". This can be quite handy for creating plugins that implement real life event scheduling, such as an alert that flashes "Hurry up and log out, your wife is almost home!"  The second, GetGameTime() returns the number of seconds since the servers went live which is very useful for in-game timing. The third, GetLocalTime() returns the number of seconds since Jan 1st, 1970 which is also handy for real life timers. Note that GetGameTime() will include a fractional component valid to at least 4 decimals (it may be valid to 5 places and is just thrown off in formatting, I haven't really needed anything beyond 10000ths of a second so I never checked that fifth decimal) whereas GetLocalTime() will only return an integer thus only allowing timing to the nearest second.  
  
The sample I will provide here is a fairly simple use of the GetGameTime() method combined with an Update event handler to create a simple but useful Timer class.  
  

Code: 
    
    
    -- This is a basic, reusable timer class
    -- To set the timer, call Timer:SetTime(numberOfSeconds, repeat)
    -- -- where numberOfSeconds is the number of seconds before the timer event will fire and repeat is an optional argument that will set whether the timer will automatically repeat (any non-nil, non-false value is considered true)
    -- When the timer reaches the set time, it will fire the event, Timer.TimeReached which you implement the same as any other event handler
    
    -- This class handles multiple events assigned to the TimeReached event, supported by the AddCallback/RemoveCallback mechanism.
    
    Timer = class( Turbine.UI.Control ); -- base the class on a generic control so that we can use an Update handler
    function Timer:Constructor()
        Turbine.UI.Control.Constructor( self ); -- generic control constructor
        self.EndTime=Turbine.Engine.GetGameTime(); -- default the EndTime value
        self.Repeat=false; -- default the Repeat value
        -- this is the function which users will call on an instance of the class to set a timer
        self.SetTime=function(sender, numSeconds, setRepeat)
            numSeconds=tonumber(numSeconds); -- force the "type" of the numSeconds parameter
            if numSeconds==nil or numSeconds<=0 then
                numSeconds=0; -- force the numSeconds to a 0 or positive value (negative time is a baaadd thing, Marty...)
            end
            self.EndTime=Turbine.Engine.GetGameTime()+numSeconds; -- set the end time based on current time + the provided number of seconds
            -- note, numSeconds can contain a fractions of a second
            self.Repeat=false; -- default repeat
            self.NumSeconds=numSeconds; -- store the number of seconds internally for use with Repeat
            if setRepeat~=nil and setRepeat~=false then
                -- any non-false value will trigger a repeat
                self.Repeat=true;
            end
            self:SetWantsUpdates(true); -- we set updates to true AFTER we have established the end time and repeat settings (lua uses a single thread so this is kind of overkill, but again, a good practice)
        end
        -- this is the Update handler that will handle checking the time and firing the event(s) if needed
        self.Update=function()
            if self.EndTime~=nil and Turbine.Engine.GetGameTime()>=self.EndTime then
                -- we have a valid timer and it the end time has been reached
                self:SetWantsUpdates(false); -- turn off timer to avoid firing again while we are processing (not likely but it's a good practice)
                -- fire whatever event you are trying to trigger
                if self.TimeReached~=nil then
                    -- we account for both a single "function" as well as a possible table of functions
                    if type(self.TimeReached)=="function" then
                        self.TimeReached();
                    elseif type(self.TimeReached)=="table"  then
                        for k,v in pairs(self.TimeReached) do
                            if type(v)=="function" then
                                v();
                            end
                        end
                    end
                end
                -- last but not least, if we are set to repeat then we need to calculate the next time to fire and reenable the Update handler
                if self.Repeat then
                    self.EndTime=Turbine.Engine.GetGameTime()+self.NumSeconds;
                    self:SetWantsUpdates(true);
                end
            end
        end
    end

  
To use the timer, just include the above code or copy it to a file and include that file, then create an instance of the timer, set an event and set the timer:  
  

Code: 
    
    
    timer1=Timer();
    -- then set the TimeReached event handler
    myEvent=function()
        Turbine.Shell.WriteLine("Timer Just Fired!");
    end
    AddCallback(timer1,"TimeReached",myEvent); -- note, you have to include the definition for the AddCallback function which of course all good authors already do... ;)
    -- and finally, set the timer
    timer1:SetTime(60, true); -- cause the timer to fire every 60 seconds, auto repeating
    
    In addition to the built-in time functions, I use a number of time functions to help with certain time features of plugins. One of the problems I have encountered with several plugins is determining the difference in local time and server time in order to determine when events reset on the servers. Determining the local time is easy since we can use Turbine.GetLocalTime() to determine the current time as well as whether daylight savings time is in effect. All of the servers, no matter where they are physically located, are set to US Eastern time zone. The only problem is knowing whether daylight savings time is in effect for the servers. Fortunately, the rules for daylight savings time in US East are fairly simple to implement in Lua. Below are a number of the time functions I find handy:
    isLeapYear(year) returns a Boolean indicating if the passed year is a leap year
    getDayOfWeek(date) returns the DoW for a given date, 1 based starting on Sunday
    getFirstMonthDay(month,year) returns the DoW for the first day of any given month/year
    isServerDST(dateTime) determines if the servers are using DST for the given dateTime
    getLocalEpochTime(dateTime,useCurrent) determines the number of seconds since 01/01/1970 for the given dateTime in the local time zone
    getTimeZone() determines the time zone offset from UTC
    
    isLeapYear=function(year)
    	-- returns a Boolean that indicates if the passed year is a leap year
    	if year==nil then year=Turbine.Engine:GetDate().Year end
    	ret=({math.modf(year/4)})[2]==0
    	if ret and (({math.modf(year/100)})[2]==0 and ({math.modf(year/400)})[2]~=0) then ret=false end
    	return ret
    end
    getDayOfWeek=function(date) -- date is a dateTime value but time component is irrelevant and ignored
    	if date==nil or date.Year==nil or date.Month==nil or date.Day==nil then
    		date=Turbine.Engine:GetDate()
    	end
    	local int,year=math.modf(date.Year/100)
    	year=math.floor(year*100+.001)
    	local yearAdj=math.floor(year/4)
    	local monthAdj={1,4,4,0,2,5,0,3,6,1,4,6}
    	if isLeapYear then
    		monthAdj={0,3,4,0,2,5,0,3,6,1,4,6}
    	end
    	local sum=year+yearAdj+date.Day+monthAdj[date.Month]
    	-- note, only good for 1700-2099
    	if date.Year<1800 then
    		sum=sum+4
    	elseif date.Year<1900 then
    		sum=sum+2
    	elseif date.Year<2000 then
    	else
    		sum=sum-1
    	end
    	local int2,ret=math.modf(sum/7)
    	ret=math.floor(ret*7+.001)
    	if ret==0 then ret=7 end -- 0 is really saturday, thus 7
    	return ret
    end
    getFirstMonthDay=function(month,year)
    	-- returns the DoW for the first of any given month/year
    	local tmpDow
    	if year<1970 or month<1 or month>12 then
    		if Settings.Debug then error("Invalid month/year") end
    	else
    		-- determine number of days from 1/1/1970 (thursday)
    		days=0
    		local monthDays={31,28,31,30,31,30,31,31,30,31,30,31}
    		if isLeapYear(year) then
    			monthDays={31,29,31,30,31,30,31,31,30,31,30,31}
    		end
    		for tmpYear=1970,year-1 do
    			if isLeapYear(tmpYear) then
    				days=days+366
    			else
    				days=days+365
    			end
    		end
    		for tmpMonth=1,month-1 do
    			days=days+monthDays[tmpMonth]
    		end
    		_,tmpDow=math.modf((days+4)/7)
    	end
    	return math.floor(tmpDow*7+.5)+1
    end
    isServerDST=function(currentDateTime)
    	-- we can only determine this because ALL servers follow US East time zone, so we only need to follow the DST rules for US East time zone
    	-- Note, to test if the server is DST, we MUST pass the dateTime in Server Time, NOT Local Time (only the date and hour matter, minutes and seconds become irrelevant)
    	-- currentDateTime will normally be nil, it is only passed for debugging
    	if currentDateTime==nil or currentDateTime.Year==nil or currentDateTime.Month==nil or currentDateTime.Day==nil then
    		currentDateTime=Turbine.Engine:GetDate()
    	end
    	-- we only set the hour if it wasn't passed, that allows passing a test dateTime without the local hour, filling in the local hour automatically
    	if currentDateTime.Hour==nil then currentDateTime.Hour=Turbine.Engine:GetDate().Hour end
    
    	local monthDays={31,28,31,30,31,30,31,31,30,31,30,31}
    	if isLeapYear(currentDateTime.Year) then
    		monthDays={31,29,31,30,31,30,31,31,30,31,30,31}
    	end
    	-- determine difference in seconds from client date to UTC
    	local secondsDifference=getLocalEpochTime()-Turbine.Engine:GetLocalTime() -- will  be negative for US timezones
    	-- divide by 3600 to get hour difference
    	local hoursDifference=math.floor((secondsDifference+1)/3600) -- we add a second just in case the timing is off a fraction of a second, the math.floor will still work
    	-- add difference to current client dateTime to get current utc dateTime
    	currentDateTime.Hour=currentDateTime.Hour-hoursDifference
    	-- currentDateTime is now in UTC time zone, subtract 4 hours to adjust to default server time zone (EDT) - this will create a potential overlap between 1:00 and 1:59 on first Sunday in November which will be assumed to be DST when it might no longer be but we have no way of knowing.
    	currentDateTime.Hour=currentDateTime.Hour-4
    	-- now check for rollovers
    	if currentDateTime.Hour>23 then
    		currentDateTime.Hour=currentDateTime.Hour-24
    		currentDateTime.Day=currentDateTime.Day+1
    		-- check if the day rolled over
    		if currentDateTime.Day>monthDays[currentDateTime.Month] then
    			-- note, we never add or subtract more than 14 hours, so can only roll over 1 day
    			currentDateTime.Day=1
    			currentDateTime.Month=currentDateTime.Month+1
    			if currentDateTime.Month>12 then
    				currentDateTime.Month=1
    				currentDateTime.Year=currentDateTime.Year+1
    			end
    		end
    	end
    	if currentDateTime.Hour<0 then
    		currentDateTime.Hour=currentDateTime.Hour+24
    		currentDateTime.Day=currentDateTime.Day-1
    		if currentDateTime.Day<1 then
    			currendDateTime.Month=currentDateTime.Month-1
    			if currentDateTime.Month<1 then
    				currentDateTime.Month=12
    				currentDateTime.Year=currentDateTime.Year-1
    			end
    			currentDateTime.Day=monthDays[currentDateTime.Month]
    		end
    	end
    	-- currentDateTime is now a DateTime adjusted to US East EDT time zone - this will work with the one exception noted above
    	return isUSEastDST(currentDateTime)
    end
    getLocalEpochTime=function(dateTime,useCurrentTime)
    	-- name is funny, but returns the number of seconds since 1/1/1970 IN LOCAL TIMEZONE
    	-- only Month, Day, Year are required. if Hour, Minute, or Second are nil they will be replaced with current values
    	if dateTime==nil then dateTime=Turbine.Engine:GetDate() end
    	if useCurrentTime==nil then useCurrentTime=true end
    	local currentDate=Turbine.Engine:GetDate()
    	local seconds=0
    	dateTime.Year=tonumber(dateTime.Year)
    	dateTime.Month=tonumber(dateTime.Month)
    	dateTime.Day=tonumber(dateTime.Day)
    	if dateTime.Year==nil or dateTime.Year~=math.floor(dateTime.Year) or dateTime.Year<1970 then
    		if Settings.Debug then error("Invalid date.Year:"..tostring(dateTime.Year)) end
    	elseif dateTime.Month==nil or dateTime.Month~=math.floor(dateTime.Month) or dateTime.Month<1 or dateTime.Month>12 then
    		if Settings.Debug then error("Invalid date.Month:"..tostring(dateTime.Month)) end
    	elseif dateTime.Day==nil or dateTime.Day~=math.floor(dateTime.Day) or dateTime.Day<1 then
    		if Settings.Debug then error("Invalid date.Day:"..tostring(dateTime.Day)) end
    	else
    		local monthDays={31,28,31,30,31,30,31,31,30,31,30,31}
    		if isLeapYear(dateTime.Year) then
    			monthDays={31,29,31,30,31,30,31,31,30,31,30,31}
    		end
    		if dateTime.Day>monthDays[dateTime.Month] then
    			if Settings.Debug then error("Invalid date.Day:"..tostring(dateTime.Day)) end
    		else
    			if dateTime.Hour==nil then
    				if useCurrentTime then
    					dateTime.Hour=currentDate.Hour
    				else
    					dateTime.Hour=0
    				end
    			end
    			if dateTime.Minute==nil then
    				if useCurrentTime then
    					dateTime.Minute=currentDate.Minute
    				else
    					dateTime.Minute=0
    				end
    			end
    			if dateTime.Second==nil then
    				if useCurrentTime then
    					dateTime.Second=currentDate.Second
    				else
    					dateTime.Second=0
    				end
    			end
    			if dateTime.Hour~=math.floor(dateTime.Hour) or dateTime.Hour<0 or dateTime.Hour>23 then
    				if Settings.Debug then error("Invalid date.Hour:"..tostring(dateTime.Hour)) end
    			elseif dateTime.Minute~=math.floor(dateTime.Minute) or dateTime.Minute<0 or dateTime.Minute>59 then
    				if Settings.Debug then error("Invalid date.Minute:"..tostring(dateTime.Minute)) end
    			elseif dateTime.Second~=math.floor(dateTime.Second) or dateTime.Second<0 or dateTime.Second>59 then
    				if Settings.Debug then error("Invalid date.Second:"..tostring(dateTime.Second)) end
    			else
    				seconds=dateTime.Hour*3600+dateTime.Minute*60+dateTime.Second
    				-- we have a valid date, now calculate number of seconds
    				for tmpYear=1970,dateTime.Year-1 do
    					if isLeapYear(tmpYear) then
    						seconds=seconds+31622400
    					else
    						seconds=seconds+31536000
    					end
    				end
    				for tmpMonth=1,dateTime.Month-1 do
    					seconds=seconds+monthDays[tmpMonth]*86400
    				end
    				for tmpDay=1,dateTime.Day-1 do
    					seconds=seconds+86400
    				end
    			end
    		end
    	end
    	return seconds
    	-- returns seconds since 1/1/1970 for the specified dateTime
    	-- calling it with a nil dateTime is similar to Turbine.Engine:GetLocalTime() except getEpochTime is local, not UTC, so adjusted for timezone (and DST)
    end
    getTimeZone=function()
    	-- returns offset from UTC
    	local timeZone=(getLocalEpochTime()-Turbine.Engine:GetLocalTime())/3600
    	return timeZone
    end

---

## Post 2 — Garan 2025-06-16T20:37:17-0400

This installment covers one of the greatest challenges to Lua UI - Font Metrics. Particularly knowing what size to make a control to accommodate a particular string value. The LotRO Lua API does not have any support for font metrics. There is no way provided to determine how much space is needed for text based on the font and characters used. This becomes even more challenging when trying to design a plugin that can support EN, FR and DE clients. It would be best if controls could automatically resize and even reposition based on the current font and text. The plugin Delving Digest is a great example of a plugin that dynamically adjusts its layout to accommodate different font sizes and text. This is accomplished by means of my FontSupport.lua. Feel free to use it in your own plugins as long as you include a note about the original author.  
  
FontSupport.lua includes a couple of things. First it adds to the Turbine.UI.Lotro table a subtable for FontInfo which includes values for Name, Size and Bold for every font currently available in the client (with the exception of the broken TrajanPro25 font). This table is indexed by the font enumeration in the Turbine.UI.Lotro.Font table, so the Verdana 20 point font is 0x. The function GetLargerFont(font) will get the next larger font in the same family if one is available. Similarly GetSmallerFont(font) will get the next smaller font in the same family. Finally, there are two classes, FontMetric and FontSelect and one control, FontSelectList.  
  
FontMetric will create a control used to determine the size of text for a particular font and string. You set the font using .SetFont(font) and then call GetTextWidth(text,height,limit) where text is the source string, height is the max height of the control (allowing for word wrap) and limit is used to impose a limit on how wide the control tries to expand to accommodate the text - you can safely leave limit nil and it will automatically assume a safe limit. GetTextWidth will return two values, the first is the width of the text and the second is a Boolean which is true if there was an error (if the limit was encountered prior to determining a width). Similar to GetTextWidth, there is a GetTextHeight(text,width,limit) which will determine how high a control must be to fit the text string in the passed width.  
  
The way that FontMetric determines the width (or height) is to use the visible property of a bound scrollbar control to determine if the assigned string fits into a control that is of the specified height (or width) and slowly expanding the control until the string fits and the scrollbar is no longer visible. This isn't a very efficient method but it is the only practical method allowed with the tools provided and fortunately it is quick enough in most instances. You may have to limit automatically resizing controls if you have a lot of controls on a window and allow the user to resize the window dynamically.  
  
The FontSelectList is basically just what it sounds like. It is a popup window that can be displayed to allow the user to select a font. It is used internally by the FontSelect class but can be added directly by the user as a control if desired.  
  
The FontSelect class creates an icon that the user can add to their windows and it will automatically pop up a FontSelectList control and has a user assignable callback, FontChanged, that fires when the user picks an entry from the FontSelectList.  
  
Below is the source of FontSupport.lua as of U42:  

Code: 
    
    
    -- this file includes several font enhancements:
    -- the undocumented fonts are added to the Turbine.UI.Lotro.Fonts enumeration
    -- a new Turbine.UI.Lotro.FontInfo extended font information table
    -- a FontMetric class is added to allow determining required text display widths and heights
    -- a FontSelect class is added with a font selection list control
    --	the FontSelectList object is strictly for internal use and should not be accessed directly)
    --	just create an instanceof the FontSelect object and remember to include the FontSelect.tga file in your Resources folder
    --	set a font using FontSelect.SetFont() or accept the default Verdana20
    --	then assign an event handler to the FontSelect.FontChanged event
    --	or use FontSelect.GetFont() to retrieve the currently selected font
    
    if importPath==nil then importPath=string.gsub(getfenv(1)._.Name,"%.FontSupport","").."." end
    if resourcePath==nil then resourcePath=string.gsub(importPath,"%.","/").."Resources/" end
    
    if Turbine==nil then
    	import "Turbine"
    end
    if Turbine.UI==nil then
    	import "Turbine.UI"
    end
    if Turbine.UI.Lotro==nil then
    	import "Turbine.UI.Lotro"
    end
    
    -- as of update U24 there are no longer any identified but undocumented fonts. :)
    
    Turbine.UI.Lotro.FontInfo={} -- table for extended font information
    for k,v in pairs(Turbine.UI.Lotro.Font) do
    	if k~="TrajanPro25" then
    		local name=tostring(k)
    		local i=string.find(name,"%d")
    		if i~=nil then
    			local size=tonumber(string.sub(name,i))
    			name=string.sub(name,0,i-1)
    			i=string.find(name,"%u",2)
    			while i~=nil do
    				name=string.sub(name,0,i-1).." "..string.sub(name,i)
    				i=string.find(name,"%u",i+2) -- increment by 2 since we just added a padding space
    			end
    			local bold=not(string.find(name," Bold",1,true)==nil)
    			Turbine.UI.Lotro.FontInfo[v]={["name"]=name,["size"]=size,["bold"]=bold}
    		end
    	end
    end
    function GetLargerFont(font)
    	local retVal
    	if font~=nil then
    		local tmpFont={}
    		local fontName,size
    		local tmpInfo=Turbine.UI.Lotro.FontInfo[font]
    		fontName=tmpInfo.name
    		size=tmpInfo.size
    		for k,v in pairs(Turbine.UI.Lotro.FontInfo) do
    			if v.name==fontName and v.size>size then
    				table.insert(tmpFont,{k,v.size})
    			end
    		end
    		if #tmpFont==0 then
    			-- return nil
    		else
    			if #tmpFont>1 then
    				table.sort(tmpFont,function(arg1,arg2) if arg1[2]<arg2[2] then return true end end)
    			end
    			-- first font that is larger than font is now in element 1
    			retVal=tmpFont[1][1]
    		end
    	end	
    	return retVal
    end
    function GetSmallerFont(font)
    	local retVal	
    	if font~=nil then
    		local tmpFont={}
    		local fontName,size
    		local tmpInfo=Turbine.UI.Lotro.FontInfo[font]
    		fontName=tmpInfo.name
    		size=tmpInfo.size
    		for k,v in pairs(Turbine.UI.Lotro.FontInfo) do
    			if v.name==fontName and v.size<size then
    				table.insert(tmpFont,{k,v.size})
    			end
    		end
    		if #tmpFont==0 then
    			-- return nil
    		else
    			if #tmpFont>1 then
    				table.sort(tmpFont,function(arg1,arg2) if arg1[2]>arg2[2] then return true end end)
    			end
    			-- first font that is smaller than font is now in element 1
    			retVal=tmpFont[1][1]
    		end
    	end
    	return retVal
    end
    
    FontMetric = class( Turbine.UI.Label );
    function FontMetric:Constructor()
    	Turbine.UI.Control.Constructor( self );
    	self.Text=Turbine.UI.Label();
    	self.Text:SetParent(self);
    	self.VScroll=Turbine.UI.Lotro.ScrollBar();
    	self.VScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
    	self.VScroll:SetParent(self);
    	self.Text:SetVerticalScrollBar(self.VScroll);
    	self.HScroll=Turbine.UI.Lotro.ScrollBar();
    	self.HScroll:SetOrientation(Turbine.UI.Orientation.Horizontal);
    	self.HScroll:SetParent(self);
    	self.Text:SetHorizontalScrollBar(self.HScroll);
    	self.fontHeight=12;
    	self.SetFont=function(sender,font)
    		self.Text:SetFont(font);
    		if Turbine.UI.Lotro.FontInfo[font]~=nil then
    			self.fontHeight=Turbine.UI.Lotro.FontInfo[font].size
    		else
    			self.fontHeight=self:GetHeight()
    		end
    	end
    	self.GetTextWidth=function(sender,text,height,limit)
    		local isError=false
    		if height==nil or height<self.fontHeight then height=self.fontHeight end
    		local width=0
    		if text~=nil and text~="" then
    			self.Text:SetHeight(height);
    			self.Text:SetMultiline(false);
    			self.Text:SetText(text);
    			self.Text:SetWidth(width);
    	-- need a limit to prevent inifinite loop with large fonts in small spaces
    			self.testWidth=string.len(text)
    			-- what is a reasonable default limit? text count * twice font height
    			if limit==nil then
    				limit=self.testWidth*Turbine.UI.Lotro.FontInfo[self.Text:GetFont()].size*2
    			end
    			local count=0
    			while count<limit and self.HScroll:IsVisible() do
    				count=count+1
    				width=width+1;
    				self.Text:SetWidth(width);
    			end
    			if count==limit then
    				isError=true
    				--Error
    			end
    		end
    		return width,isError;
    	end
    	self.GetTextHeight=function(sender,text,width,limit)
    		-- what is a reasonable default limit? screen height? times some multiple? for now say twice screen height
    		if limit==nil then limit=Turbine.UI.Display:GetHeight()*2 end
    		local isError=false
    		if width~=nil then
    			-- since we don't actually have a minimum width for a single character, use the point size as a good estimate - this is needed to prevent possible infinite loop issues
    			if width<self.fontHeight then width=self.fontHeight end
    			self.Text:SetWidth(width)
    		end
    		local height=self.fontHeight
    		self.Text:SetMultiline(true);
    		if text~=nil and text~="" then
    			self.Text:SetText(text);
    			self.Text:SetHeight(height);
    			local count=0
    			while count<limit and self.HScroll:IsVisible() or self.VScroll:IsVisible() do
    				count=count+1
    				height=height+1;
    				self.Text:SetHeight(height);
    			end
    			if count==limit then
    				isError=true
    			end
    		end
    		return height,isError;
    	end
    end
    --FontSelectList=Turbine.UI.Control()
    FontSelectList=Turbine.UI.Window()
    FontSelectList:SetSize(342,202)
    FontSelectList:SetBackColor(Turbine.UI.Color(0,0,.4))
    FontSelectList.ListData=Turbine.UI.ListBox()
    FontSelectList.ListData:SetParent(FontSelectList)
    FontSelectList.ListData:SetSize(FontSelectList:GetWidth()-12,FontSelectList:GetHeight()-2)
    FontSelectList.ListData:SetPosition(1,1)
    FontSelectList.ListData:SetBackColor(Turbine.UI.Color.Black)
    FontSelectList.ListVScroll=Turbine.UI.Lotro.ScrollBar();
    FontSelectList.ListVScroll:SetOrientation(Turbine.UI.Orientation.Vertical);
    FontSelectList.ListVScroll:SetParent(FontSelectList);
    FontSelectList.ListVScroll:SetBackColor(Turbine.UI.Color.Black);
    FontSelectList.ListVScroll:SetPosition(FontSelectList:GetWidth()-11,0);
    FontSelectList.ListVScroll:SetWidth(10);
    FontSelectList.ListVScroll:SetHeight(FontSelectList:GetHeight());
    FontSelectList.ListData:SetVerticalScrollBar(FontSelectList.ListVScroll);
    FontSelectList.ListData.SelectedIndexChanged=function(sender,args)
    	if FontSelectList.SelectedItem~=nil then
    		FontSelectList.SelectedItem:SetBackColor(FontSelectList.ListData:GetBackColor())
    		FontSelectList.SelectedItem.MouseClick=nil
    
    	end
    	FontSelectList.SelectedItem=FontSelectList.ListData:GetSelectedItem()
    	FontSelectList.SelectedItem:SetBackColor(FontSelectList:GetBackColor())
    	FontSelectList.SelectedItem.MouseClick=function(sender,args)
    		-- needed to allow closing the window without a change
    		if FontSelectList.SelectionChanged~=nil then
    -- enabling this line causes double calls to FontSelectList.SelectionChanged when an actual change is selected
    --			FontSelectList.SelectionChanged()
    		end
    		FontSelectList:SetVisible(false)
    	end
    
    	if FontSelectList.SelectionChanged~=nil then
    		FontSelectList.SelectionChanged(sender,args)
    	end
    end
    FontSelectList.ListData:SetSelectedIndex(24) -- verdana20
    local defaultIndex=1
    local fontList={}
    
    for k,v in pairs(Turbine.UI.Lotro.Font) do
    	if Turbine.UI.Lotro.FontInfo[v]~=nil then
    		table.insert(fontList,{Turbine.UI.Lotro.FontInfo[v].name,Turbine.UI.Lotro.FontInfo[v].size,v})
    	end
    end
    table.sort(fontList,function(arg1,arg2) if arg1[1]<arg2[1] then return true else if arg1[1]==arg2[1] and arg1[2]<arg2[2] then return true end end end)
    for k,v in ipairs(fontList) do
    	local tmpItem=Turbine.UI.Label()
    	tmpItem:SetParent(FontSelectList.ListData)
    	tmpItem:SetSize(FontSelectList.ListData:GetWidth(),v[2])
    	tmpItem:SetFont(v[3])
    	tmpItem:SetText("("..tostring(v[2])..") "..v[1]);
    	if v[3]==Turbine.UI.Lotro.Font.Verdana20 then defaultIndex=k end
    	FontSelectList.ListData:AddItem(tmpItem);
    end
    FontSelectList.SetFont=function(sender,newFont)
    	-- set the currently selected item to the one matching the font
    	local index=1
    	for k=1,FontSelectList.ListData:GetItemCount() do
    		if FontSelectList.ListData:GetItem(k):GetFont()==newFont then
    			index=k
    			break
    		end
    	end
    	FontSelectList.ListData:SetSelectedIndex(index)
    end
    FontSelectList.ListData:SetSelectedIndex(defaultIndex)
    FontSelectList.SizeChanged=function(sender,args)
    	local width,height=FontSelectList:GetSize()
    	FontSelectList.ListData:SetSize(width-12,height-2)
    	FontSelectList.ListVScroll:SetLeft(width-12)
    	FontSelectList.ListVScroll:SetHeight(height-2)
    
    	local tmpItem
    	for k=1,FontSelectList.ListData:GetItemCount() do
    		tmpItem=FontSelectList.ListData:GetItem(k)
    		tmpItem:SetWidth(width-2)
    	end
    end
    FontSelectList.Click=function(sender,args)
    	FontSelectList:SetVisible(false)
    end
    FontSelectList:SetVisible(false)
    FontSelect=class(Turbine.UI.Button)
    -- an icon with a pop-up font selection list
    function FontSelect:Constructor()
    	Turbine.UI.Button.Constructor( self );
    	self:SetSize(20,20)
    	self:SetBlendMode(Turbine.UI.BlendMode.Overlay)
    	self:SetBackground(resourcePath.."FontSelect.tga")
    	self.MouseClick=function(sender,args)
    		--display FontSelectList
    		local zOrder=sender:GetZOrder()+1
    		local parent=sender:GetParent()
    		local controlList=parent:GetControls()
    		for k=1,controlList:GetCount() do
    			local child=controlList:Get(k)
    			if child~=FontSelectList and type(child)=="table" and child.GetZOrder then
    				local tmpOrder=child:GetZOrder()
    				if tmpOrder>=zOrder then zOrder=tmpOrder+1 end
    			end
    		end
    --		FontSelectList:SetParent(parent)
    		FontSelectList:SetVisible(true)
    		FontSelectList:SetZOrder(zOrder) -- force it topmost within it's parent
    		FontSelectList.SelectionChanged=nil
    
    --		local top=self:GetTop()
    --		local left=self:GetLeft()
    		local left,top=self:PointToScreen(0,0)
    		local top=top-FontSelectList:GetHeight()
    --		if parent:GetHeight()-FontSelectList:GetHeight()<top then top=parent:GetHeight()-FontSelectList:GetHeight() end
    		if top<0 then top=0 end
    		if top+FontSelectList:GetHeight()>displayHeight then top=displayHeight-FontSelectList:GetHeight() end
    --		if parent:GetWidth()-FontSelectList:GetWidth()<left then left=parent:GetWidth()-FontSelectList:GetWidth() end
    		if left<0 then left=0 end
    		if left+FontSelectList:GetWidth()>displayWidth then left=displayWidth-FontSelectList:GetWidth() end
    		FontSelectList:SetPosition(left,top)
    		FontSelectList:SetFont(self.Font)
    		self:SetWantsUpdates(true)
    	end
    	self.Update=function()
    		FontSelectList.SelectionChanged=function(sender,args)
    			if FontSelectList:IsVisible() then
    				self.Font=FontSelectList.SelectedItem:GetFont()
    				if self.FontChanged~=nil then
    					self.FontChanged(self,args)
    				end
    			end
    		end
    		self:SetWantsUpdates(false)
    	end
    	self.Font=Turbine.UI.Lotro.Font.Verdana20
    	self.SetFont=function(sender,newFont)
    		if newFont~=nil then
    			-- set the selected index to the new font
    			self.Font=newFont
    		end
    	end
    	self.GetFont=function()
    		return self.Font
    	end
    end

---

## Post 3 — Garan 2025-06-16T20:37:49-0400

The code sample in Press my Buttons demonstrated basic button functionality as well as creating a button that masks a quickslot. This installment will go beyond the Turbine.UI.Lotro.Button and create a button class that has decorations (graphical borders and background) but also supports larger sizes and larger fonts. This button class will also support a masked quickslot control.  
  
placeholder

---

## Post 4 — Garan 2025-06-16T20:38:18-0400

Placeholder for example using SetStetchmode to scale controls

---

## Post 5 — Garan 2025-06-16T20:38:49-0400

Links placeholder

---

## Post 6 — Garan 2025-06-16T21:02:57-0400

That concludes the original Writing LotRO Lua Plugins for Noobs thread from the Turbine forums plus the few code samples I've been working on since (a few are not done yet). The placeholders will be replaced in the near future with finished content and the existing content will get another review for typos, accuracy and a bit of 'prettying up'.

---

## Post 7 — Hoppendi 2025-06-16T21:11:43-0400

> [Garan said:](/index.php?goto/post&id=190747)
> 
> This is a revised post of the original "Writing LotRO Lua Plugins for Noobs" that was published on the old Turbine LotRO forums. The content has been revised for the changes to the Lua API (and for a few error corrections) - Links to PDFs of the original thread and comments will be posted at the end once I find an appropriate place to host them.  
>    
> 
> 
> **Table of Contents**  
> ---  
> [Before you begin](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190748)  
> [Getting Started](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190749)  
> [__init__.lua Files](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190750)  
> [Loading a plugin](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190751)  
> [Hello World](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190752)  
> [Programming with Class](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190753)  
> [Function Calling or Method to the Madness](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190754)  
> [Plugin State and Saved Data](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190755)  
> [Internationalization](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190756)  
> [Turbine API intro](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190757)  
> [Asynchronous Processing](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190758)  
> [The Unload Event Handler](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190759)  
> [Event Handling](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190760)  
> [Lua is only skin deep...](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190761)  
> [Where to go from here?](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190762)  
> [Lights, Camera, ACTION](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190763)  
>  _**Code Samples**_  
> [Press my buttons... I dare ya.](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190764)  
> [It's my party and I'll cry if I want to...](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190765)  
> [Slip Sliding Away...](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/#post-190766)  
> [It's about time!](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/page-2#post-190767)  
> [My God, It's Huge!](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/page-2#post-190768)  
> [Beyond Buttons](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/page-2#post-190769)  
> [Stretching the Limits](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/page-2#post-190770)  
>  _**Additional Resources**_  
> [Links](https://forums.lotro.com/index.php?threads/writing-lotro-lua-plugins-for-noobs.21919/page-2#post-190771)  
>   
> Click to expand...

Thank you for all the work so far on so many great plugins! I will probably read through all of this here around the end of they year but already know it's of great value. Thanks for giving others this overview and also for the time it took you to create and present this

---

## Post 8 — Garan 2025-06-18T01:14:12-0400

### Putting It Out There

  
Or, how to publish your masterpiece...  
  
Publishing your plugin can be as simple as posting it on a website and sharing it with a few friends. However, the more conventional approach is to pack it up in a zip file and post it to an online hosting service. The most common (and reliable) service for LotRO plugins is lotrointerface.com. lotrointerface has a number of benefits, first it has a great reputation and many LotRO players recommend it to their friends. All posts to lotrointerface are automatically virus scanned so they are pretty safe as long as they do not contain an external executable - downloading and running any executable comes with risks, especially if it is not digitally signed by a trusted publisher. Fortunately, plugins that are strictly Lua will not have any external executables and will run in the Lua sandbox provided by SSG and are totally safe. The last benefit to lotrointerface has to do with one of the more common means of installing plugins, Plugin Compendium. Plugin Compendium is a small application written by lunarwtr that comes in two flavors, one for PCs and one for Linux/Mac clients. Now, I know that I just got done saying that external applications can be risky, but every rule has an exception and this is the exception to my not recommending external applications.  
PC Version of Plugin Compendium:<https://www.lotrointerface.com/downloads/fileinfo.php?id=663>  
Linux/Max Version:<https://www.lotrointerface.com/downloads/info689-LOTROPluginCompendiumMacLinux.html>  
  
To publish on lotrointerface.com, you will need to register. It is free and pretty straightforward. On the left side bar of the main page, there is a link "Register Now!". Click the link, fill out the form and submit it. Be sure to use a valid email address that you have access to.  
  
Before you package your plugin for upload, you need to be sure that you are including all of the necessary files. One thing I tend to do is rename my Plugins folder to something like Plugins_bak, create a new Plugins folder, copy all of the files I believe I will need and then try launching the client and load the plugin and look for any errors launching or running it. One of the common pitfalls here is failure to include shared files such as the Turbine utilities - this is one of the reasons I recommend making your own copy in your plugin's folder and importing from there. This also helps avoid conflicts since there are actually a couple versions of the Turbine utilities. Typically, you should have an author folder, in my case, GaranStuff, directly below the Plugins folder. Inside the GaranStuff folder I have any .plugin files that are part of the plugin - some plugins will actually have multiple .plugin files if they have multiple components such as reloaders. There should also be a subfolder which contains all of the .lua files and any resources such as .jpg and .tga files (I typically include images in a folder named Resources beneath the .lua files folder. Any plugin that is intended to be installed via Plugin Compendium will also have a .plugincompendium file which will be discussed later.  
  
Before zipping your file, also make sure you have updated the version number in the .plugin file(s) as well as the .plugincompendium file. Here is the .plugin file for version 1.58 of MoorMap:  

Code: 
    
    
    <?xml version="1.0"?>
    <Plugin>
        <Information>
            <Name>MoorMap</Name>
            <Author>Garan</Author>
            <Version>1.58</Version>
            <Description>This plugin displays a resizable and customizable map that also has most of the default data locations.</Description>
            <Image>GaranStuff/MoorMap/Resources/map_up.jpg</Image>
        </Information>
        <Package>GaranStuff.MoorMap.Main</Package>
        <Configuration Apartment="MoorMap" />
    </Plugin>

The Name element will be the plugin's name which shows in the Plugin Manager as well as the Plugins[] table within Lua and is also used to load it programmatically. The Author element typically contains your name (or pen name). The Version element will be the version number shown in the Plugin Manager. The Description element contains a brief description of the plugin which is shown in the Plugin Manager. The Image element is a path relative to the Plugins folder of an icon which will be shown in the Plugin Manager. The Package element is the path to the main .lua file that is initially loaded and executed.  
Note that MoorMap includes an optional Configuration element because it runs in a custom apartment due to its need to be reloaded. If your plugin does not need to be reloaded and does not use shared elements that may cause conflicts with other plugins then it is recommended to run it in the shared apartment and no Configuration element is needed.  
  
The .plugincompendium file contains all of the information necessary for the Plugin Compendium java application to install your plugin correctly, including any dependencies (shared files that are not explicitly contained with in your zip file).  
Here is the .plugincompendium file for MoorMap:  

Code: 
    
    
    <?xml version="1.0" encoding="utf-8"?>
    <PluginConfig xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
      <Id>532</Id>
      <Name>MoorMap</Name>
      <Version>1.58</Version>
      <Author>Garan</Author>
      <InfoUrl>http://www.lotrointerface.com/downloads/info532</InfoUrl>
      <DownloadUrl>http://www.lotrointerface.com/downloads/download532</DownloadUrl>
      <Descriptors>
        <descriptor>GaranStuff\MoorMap.plugin</descriptor>
        <descriptor>GaranStuff\MoorMapLoader.plugin</descriptor>
        <descriptor>GaranStuff\MMSearch.plugin</descriptor>
        <descriptor>GaranStuff\MMCust.plugin</descriptor>
        <descriptor>GaranStuff\MMExport.plugin</descriptor>
      </Descriptors>
      <Dependencies />
    </PluginConfig>

The first two lines will be the same for every plugin as they are just meta information about the .plugincompendium file type and schema.  
The Id element is a bit of a catch-22. This is the Id assigned by lotrointerface.com which will not be available until you have uploaded the plugin at least once. So, to include a .plugincompendium file, you must first upload a zip file, basically a placeholder, but it is safest to include everything except the .plugincompendium file so that there are no problems when the file gets examined prior to acceptance by the site moderators. Once it is accepted, the Id will be in the URL of the download page - for example, the URL for MoorMap is:<https://www.lotrointerface.com/downloads/info532-MoorMap.html> and the Id is right after the word info, in this case, 532. So, to get the Id, just upload your version without the .plugincompendium file, you will be redirected to your portal page (I bookmark this page) and it will list all of your uploads, wait for your upload to be accepted (it will stop showing as awaiting approval), click on the uploaded interface to get to the download page and make note of the URL. The Id in the URL is then used in the .plugincompendium file.  
The Name, Version and Author elements should match the .plugin file.  
The InfoUrl should be the URL of the plugin's page that you got by clicking on the interface list of your portal page above.  
The DownloadUrl should be the same format as above but with your Id in place of MoorMap's 532. This is the Url that Plugin Compendium uses to actually download the zip file.  
The Descriptors element will contain one or more descriptor elements which contain the path names of each .plugin file in your zip file. Note that MoorMap has several .plugin files as it is made up of several plugins, the main one, a reloader and several helper plugins that perform special functions that are controlled by the main plugin.  
The Dependencies element would contain any interfaces that are needed for this plugin to work. Moormap has no dependencies so this tag is empty. If it did have dependencies it would look something like:  

Code: 
    
    
    <Dependencies>
        <dependency>0</dependency>
        <dependency>367</dependency>
        <dependency>575</dependency>
      </Dependencies>

where each dependency element contains the Id of an interface that this depends on, in the example, 0, 367 and 575.  
The Plugin Compendium download page contains additional information about Plugin Compendium and creating .plugincompendium files  
  
Once you are sure you have all of the necessary files in the author folder, all you need to do is zip up the author folder to a .zip file. On windows that is as simple as right clicking on the author folder and clicking 'Compress to...' and selecting "ZIP File" from the menu. This will compress the author folder and all of its contents, preserving the folder structure to a new zip file under the Plugins folder. I typically rename the zip file by adding a version number to the zip file that matches the version in the .plugin file.  
  
Assuming that there are no problems with your file, it will eventually show as available (doesn't say Awaiting Approval), congratulations! Now you can start dreading your first users breaking your lovingly crafted code  Seriously, expect the unexpected. Users will find ways to make your code do odd, totally unexpected things. Remember to thank users for their feedback and patiently work through any quirks and if you can't figure out what went wrong, don't be afraid to ask in the lotrointerface forums or any of the various discord servers. Welcome to the ranks of the published plugins authors!
