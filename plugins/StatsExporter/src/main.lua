import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Turbine.Gameplay";
import "Common.ItemLinkDecode";


local function print(text)
    Turbine.Shell.WriteLine("<rgb=#00FFFF>StatsExporter:</rgb> "..tostring(text));
end

-- Imported files scope their globals under the package namespace, so the
-- decoder lives at Common.ItemLinkDecode.DecodeLinkData, not a bare global.
local DecodeLinkData = Common and Common.ItemLinkDecode and Common.ItemLinkDecode.DecodeLinkData or nil;

if type(DecodeLinkData) ~= "function" then
    print("WARNING: Common.ItemLinkDecode failed to provide DecodeLinkData - item links will not decode.");
end

-- Manifest of .plugindata filenames this plugin has saved. PluginData.Load
-- is synchronous while the plugin is loading, so this resolves instantly
-- here; at runtime the same call is delayed by seconds, which is why the
-- overwrite check consults this list before probing (see RequestSave).
local knownFiles = {};
local manifestData = Turbine.PluginData.Load(Turbine.DataScope.Character, "StatsExporter_SavedFiles");
if type(manifestData) == "table" and type(manifestData.Files) == "table" then
    for _, n in ipairs(manifestData.Files) do
        knownFiles[n] = true;
    end
end

local classNames = {
    [214] = "Beorning",
    [215] = "Brawler",
    [40]  = "Burglar",
    [24]  = "Captain",
    [172] = "Champion",
    [23]  = "Guardian",
    [162] = "Hunter",
    [185] = "LoreMaster",
    [216] = "Mariner",
    [31]  = "Minstrel",
    [193] = "RuneKeeper",
    [194] = "Warden",
    [71]  = "Reaver",
    [128] = "Defiler",
    [179] = "Blackarrow",
    [52]  = "Warleader",
    [127] = "Weaver",
    [126] = "Stalker",
    [192] = "Chicken"
};

-- ==== Window ====
-- Two sections: character stats on top, chat-captured items below.

local mainWindow = Turbine.UI.Lotro.Window();
mainWindow:SetSize(500, 390);
mainWindow:SetText("Stats Exporter");

local statsHeader = Turbine.UI.Label();
statsHeader:SetParent(mainWindow);
statsHeader:SetPosition(15, 32);
statsHeader:SetSize(470, 20);
statsHeader:SetText("Character Stats");
statsHeader:SetFontStyle(Turbine.UI.FontStyle.Outline);

local exportStatsButton = Turbine.UI.Lotro.Button();
exportStatsButton:SetParent(mainWindow);
exportStatsButton:SetText("Export Character Stats to File");
exportStatsButton:SetPosition(125, 60);
exportStatsButton:SetSize(250, 30);

local statsFileLabel = Turbine.UI.Label();
statsFileLabel:SetParent(mainWindow);
statsFileLabel:SetPosition(190, 32);
statsFileLabel:SetSize(55, 20);
statsFileLabel:SetText("File:");
statsFileLabel:SetFontStyle(Turbine.UI.FontStyle.Outline);

local statsFileBox = Turbine.UI.Lotro.TextBox();
statsFileBox:SetParent(mainWindow);
statsFileBox:SetPosition(250, 30);
statsFileBox:SetSize(235, 24);
statsFileBox:SetText("Stats");

local itemsHeader = Turbine.UI.Label();
itemsHeader:SetParent(mainWindow);
itemsHeader:SetPosition(15, 120);
itemsHeader:SetSize(470, 20);
itemsHeader:SetText("Items (chat links)");
itemsHeader:SetFontStyle(Turbine.UI.FontStyle.Outline);

local itemsFileLabel = Turbine.UI.Label();
itemsFileLabel:SetParent(mainWindow);
itemsFileLabel:SetPosition(190, 120);
itemsFileLabel:SetSize(55, 20);
itemsFileLabel:SetText("File:");
itemsFileLabel:SetFontStyle(Turbine.UI.FontStyle.Outline);

local itemsFileBox = Turbine.UI.Lotro.TextBox();
itemsFileBox:SetParent(mainWindow);
itemsFileBox:SetPosition(250, 118);
itemsFileBox:SetSize(235, 24);
itemsFileBox:SetText("Items");

local startWatchButton = Turbine.UI.Lotro.Button();
startWatchButton:SetParent(mainWindow);
startWatchButton:SetText("Start Watching Chat");
startWatchButton:SetPosition(70, 145);
startWatchButton:SetSize(175, 30);

local stopWatchButton = Turbine.UI.Lotro.Button();
stopWatchButton:SetParent(mainWindow);
stopWatchButton:SetText("Stop Watching Chat");
stopWatchButton:SetPosition(255, 145);
stopWatchButton:SetSize(175, 30);

local exportItemsButton = Turbine.UI.Lotro.Button();
exportItemsButton:SetParent(mainWindow);
exportItemsButton:SetText("Export Items to File");
exportItemsButton:SetPosition(50, 190);
exportItemsButton:SetSize(195, 30);

local clearItemsButton = Turbine.UI.Lotro.Button();
clearItemsButton:SetParent(mainWindow);
clearItemsButton:SetText("Clear Items Queue");
clearItemsButton:SetPosition(255, 190);
clearItemsButton:SetSize(195, 30);

local itemsStatusLabel = Turbine.UI.Label();
itemsStatusLabel:SetParent(mainWindow);
itemsStatusLabel:SetPosition(15, 245);
itemsStatusLabel:SetSize(470, 40);
itemsStatusLabel:SetText("");

local hintLabel = Turbine.UI.Label();
hintLabel:SetParent(mainWindow);
hintLabel:SetPosition(15, 350);
hintLabel:SetSize(470, 20);
hintLabel:SetText("Link items in chat while watching; /statsexport for commands.");

-- Overwrite confirmation dialog, shown when the target .plugindata file
-- already exists. Centered over the main window when displayed.
local overwriteWindow = Turbine.UI.Lotro.Window();
overwriteWindow:SetSize(420, 130);
overwriteWindow:SetText("Overwrite File?");
overwriteWindow:SetVisible(false);

local overwriteFileLabel1 = Turbine.UI.Label();
overwriteFileLabel1:SetParent(overwriteWindow);
overwriteFileLabel1:SetPosition(15, 30);
overwriteFileLabel1:SetSize(390, 20);
overwriteFileLabel1:SetText("");

local overwriteFileLabel2 = Turbine.UI.Label();
overwriteFileLabel2:SetParent(overwriteWindow);
overwriteFileLabel2:SetPosition(15, 50);
overwriteFileLabel2:SetSize(390, 20);
overwriteFileLabel2:SetText("");

local overwriteQuestionLabel = Turbine.UI.Label();
overwriteQuestionLabel:SetParent(overwriteWindow);
overwriteQuestionLabel:SetPosition(15, 72);
overwriteQuestionLabel:SetSize(390, 20);
overwriteQuestionLabel:SetText("already exists. Overwrite it?");

local overwriteYesButton = Turbine.UI.Lotro.Button();
overwriteYesButton:SetParent(overwriteWindow);
overwriteYesButton:SetText("Yes, Overwrite");
overwriteYesButton:SetPosition(70, 98);
overwriteYesButton:SetSize(140, 28);

local overwriteNoButton = Turbine.UI.Lotro.Button();
overwriteNoButton:SetParent(overwriteWindow);
overwriteNoButton:SetText("Cancel");
overwriteNoButton:SetPosition(230, 98);
overwriteNoButton:SetSize(140, 28);

-- ==== Item export ====
-- Items are captured from chat links only (the Item/ItemInfo API exposes
-- no stats or usable IDs; the link blob decodes to itemGID + instance
-- data). Watching is off by default and toggled via the buttons or
-- /statsexport watch|stop.

local pendingItems = {};
local watchingChat = false;

local function UpdateItemsStatus()
    itemsStatusLabel:SetText(
        (watchingChat and "Watching chat for item links."
                       or "Chat watching is off.")
        .." "..#pendingItems.." item(s) queued.");
end

local function SetWatching(watch)
    watchingChat = watch;
    UpdateItemsStatus();
    print(watch and "Watching chat for item links."
                  or "Stopped watching chat.");
end

-- ==== Item links ====
-- Item links sent in chat (<ExamineItemInstance:ItemInfo:...> and
-- <ExamineIA:IAInfo:...> for legendary items) carry a compressed blob
-- with the full item record: instance + generic IDs, true item level,
-- armour value, worth, binding, crafter, essence slots, and LI
-- legacies/relics/stats. Link an item in chat (or let loot messages
-- produce one) and it is captured and queued here. The raw link data is
-- kept too, so data the decoder doesn't understand yet can be analyzed
-- downstream.

local function QueueLinkedItem(data, bracketedName, isLI)
    local name = bracketedName:sub(2, -2);
    local ok, result = pcall(DecodeLinkData, data, isLI);
    local entry = {
        Name = name,
        Source = isLI and "ChatLinkLI" or "ChatLink",
        LinkData = data,
    };
    if ok and result ~= nil then
        entry.Decoded = result;
    else
        entry.DecodeError = ok and "decoder returned nil" or tostring(result);
    end
    table.insert(pendingItems, entry);
    UpdateItemsStatus();
    print("Captured item link: "..name.." ("..#pendingItems.." pending)");
end

-- Link IDs in <Examine:IIDDID:...> tags are hex (0x7002B018) or decimal.
local function ParseLinkID(id)
    local s = tostring(id);
    local hex = s:match("^0[xX](%x+)$");
    if hex then
        return tonumber(hex, 16);
    end
    return tonumber(s);
end

-- <Examine:IIDDID:uniqueID:genericID>[Name]<\Examine>
-- Plain-ID link format for items without an item instance - vendor and
-- barter stock the player does not own, generic links. genericID is the
-- itemGID itself, so no blob decode is needed; uniqueID is a 64-bit
-- instance ID (usually 0 for non-owned items) split into the same
-- IIDLow/IIDHigh pair the blob decoder produces.
local function QueueExamineLink(uniqueID, genericID, displayText)
    local name = displayText;
    if name:sub(1, 1) == "[" and name:sub(-1) == "]" then
        name = name:sub(2, -2);
    end
    local entry = {
        Name = name,
        Source = "ChatLinkExamine",
        LinkData = "Examine:IIDDID:"..tostring(uniqueID)..":"..tostring(genericID),
        UniqueID = tostring(uniqueID),
        GenericID = tostring(genericID),
    };
    local gid = ParseLinkID(genericID);
    if gid ~= nil then
        entry.Decoded = { itemGID = gid };
        local hex = tostring(uniqueID):match("^0[xX](%x+)$");
        if hex and #hex <= 16 then
            hex = string.rep("0", 16 - #hex)..hex;
            entry.Decoded.itemIIDHigh = tonumber(hex:sub(1, 8), 16);
            entry.Decoded.itemIIDLow = tonumber(hex:sub(9, 16), 16);
        end
    end
    table.insert(pendingItems, entry);
    UpdateItemsStatus();
    print("Captured item link: "..name.." ("..#pendingItems.." pending)");
end

Turbine.Chat.Received = function(sender, args)
    if not watchingChat then
        return;
    end
    if type(args) ~= "table" or type(args.Message) ~= "string" then
        return;
    end
    for data, name in string.gmatch(args.Message,
            "<ExamineItemInstance:ItemInfo:(.-)>(%b[])<\\ExamineItemInstance>") do
        QueueLinkedItem(data, name, false);
    end
    for data, name in string.gmatch(args.Message,
            "<ExamineIA:IAInfo:(.-)>(%b[])<\\ExamineIA>") do
        QueueLinkedItem(data, name, true);
    end
    for uniqueID, genericID, displayText in string.gmatch(args.Message,
            "<Examine:IIDDID:([%w]+):([%w]+)>(.-)<\\Examine>") do
        QueueExamineLink(uniqueID, genericID, displayText);
    end
    -- Surface any other <Examine...> link formats we do not handle yet,
    -- so new link types (e.g. vendor/barter items) can be identified.
    for tag in string.gmatch(args.Message, "<(Examine[^>]*)>") do
        if not (tag:sub(1, 20) == "ExamineItemInstance:"
                or tag:sub(1, 10) == "ExamineIA:"
                or tag:sub(1, 15) == "Examine:IIDDID:") then
            print("Unhandled item link tag: <"..tag..">");
        end
    end
end

local function ClearItems()
    if #pendingItems == 0 then
        print("Item queue is already empty.");
    else
        pendingItems = {};
        UpdateItemsStatus();
        print("Item queue cleared.");
    end
end

-- ==== File saving ====
-- Exports write .plugindata files named by the per-section text boxes.
-- PluginData keys are capped at 63 characters and reject some
-- characters, so input is sanitized; anything outside [A-Za-z0-9-_.]
-- (including spaces) becomes an underscore.

local function SanitizeFilename(raw, defaultName)
    local name = tostring(raw or ""):gsub("^%s+", ""):gsub("%s+$", "");
    if name:lower():sub(-11) == ".plugindata" then
        name = name:sub(1, -12);
    end
    name = name:gsub("[^%w%-%._]", "_");
    name = name:gsub("_+", "_"):gsub("^[%.]+", ""):gsub("[%.]+$", "");
    name = name:gsub("^_+", ""):gsub("_+$", "");
    if name == "" then
        name = defaultName;
    end
    if #name > 63 then
        name = name:sub(1, 63);
    end
    return name;
end

local pendingSave = nil;      -- overwrite confirmed, waiting for dialog choice
local saveCheckPending = nil; -- PluginData.Load probe in flight

local function SetExportButtonsEnabled(enabled)
    exportStatsButton:SetEnabled(enabled);
    exportItemsButton:SetEnabled(enabled);
end

local function SavePlugindata(name, data, onSaved)
    print("Saving '"..name..".plugindata' to file...");
    Turbine.PluginData.Save(Turbine.DataScope.Character, name, data,
        function(success, errorMessage)
            SetExportButtonsEnabled(true);
            if success then
                if not knownFiles[name] then
                    knownFiles[name] = true;
                    local list = {};
                    for n in pairs(knownFiles) do
                        table.insert(list, n);
                    end
                    Turbine.PluginData.Save(Turbine.DataScope.Character,
                        "StatsExporter_SavedFiles", { Files = list });
                end
                onSaved();
            else
                print("Error saving file: "..tostring(errorMessage));
            end
        end);
end

local function ShowOverwriteDialog(name)
    -- Split "name.plugindata" across two lines so long filenames stay
    -- inside the dialog instead of overflowing the label bounds.
    local displayName = "\""..name..".plugindata\"";
    local line1 = displayName:sub(1, 44);
    local line2 = displayName:sub(45);
    overwriteFileLabel1:SetText(line1);
    overwriteFileLabel2:SetText(line2);
    local wx, wy = mainWindow:GetPosition();
    overwriteWindow:SetPosition(wx + 40, wy + 130);
    overwriteWindow:SetZOrder(1000);
    overwriteWindow:SetVisible(true);
end

local function FinishSaveCheck(exists)
    local pending = saveCheckPending;
    if pending == nil then
        return;
    end
    saveCheckPending = nil;
    mainWindow:SetWantsUpdates(false);
    if exists then
        pendingSave = pending;
        ShowOverwriteDialog(pending.name);
    else
        SavePlugindata(pending.name, pending.data, pending.onSaved);
    end
end

-- Checks whether <name>.plugindata already exists before saving. Names in
-- the saved-files manifest are known to exist, so they prompt immediately.
-- Unknown names are probed with PluginData.Load, which at runtime returns
-- nil immediately and reports through the callback after Turbine's built-in
-- multi-second delay (observed >5s). A missing file may not invoke the
-- callback on every client version, so a tick timeout in mainWindow.Update
-- forces a decision either way.
local function RequestSave(name, data, onSaved)
    if saveCheckPending ~= nil or pendingSave ~= nil then
        print("Another export is still in progress; please wait.");
        return;
    end
    print("Exporting to '"..name..".plugindata'...");
    SetExportButtonsEnabled(false);
    if knownFiles[name] then
        pendingSave = { name = name, data = data, onSaved = onSaved };
        ShowOverwriteDialog(name);
        return;
    end
    saveCheckPending = { name = name, data = data, onSaved = onSaved, ticks = 0 };
    mainWindow:SetWantsUpdates(true);
    local ok, immediate = pcall(Turbine.PluginData.Load,
        Turbine.DataScope.Character, name,
        function(loaded)
            FinishSaveCheck(loaded ~= nil);
        end);
    if not ok then
        print("Could not check for an existing file: "..tostring(immediate));
        FinishSaveCheck(false);
    elseif immediate ~= nil then
        FinishSaveCheck(true);
    end
end

local function ExportItems()
    if #pendingItems == 0 then
        print("No items queued to export.");
        return;
    end
    local name = SanitizeFilename(itemsFileBox:GetText(), "Items");
    local data = pendingItems;
    RequestSave(name, data, function()
        pendingItems = {};
        UpdateItemsStatus();
        print("Successfully saved "..#data.." items to '"..name..".plugindata'!");
    end);
end

startWatchButton.Click = function(sender, args)
    SetWatching(true);
end

stopWatchButton.Click = function(sender, args)
    SetWatching(false);
end

exportItemsButton.Click = function(sender, args)
    ExportItems();
end

clearItemsButton.Click = function(sender, args)
    ClearItems();
end

-- ==== Character stats export ====
-- Note: several attribute getters used below (crit/mastery/mitigation/
-- regen/finesse/healing ratings) were added to the API after the last
-- official docs and are not covered there. They are collected inside a
-- pcall so a missing getter reports an error instead of failing silently.

local function CollectStats()
    local character = Turbine.Gameplay.LocalPlayer.GetInstance();
    local characterAttributes = character:GetAttributes();
    return {
        Class = classNames[character:GetClass()],
        Level = character:GetLevel(),
        Morale = character:GetMaxMorale(),
        InCombatMoraleRegeneration = characterAttributes:GetInCombatMoraleRegeneration() * 60,
        NonCombatMoraleRegeneration = characterAttributes:GetOutOfCombatMoraleRegeneration() * 60,
        Power = character:GetMaxPower(),
        InCombatPowerRegeneration = characterAttributes:GetInCombatPowerRegeneration() * 60,
        NonCombatPowerRegeneration = characterAttributes:GetOutOfCombatPowerRegeneration() * 60,
        Armour = characterAttributes:GetArmor(),
        Might = characterAttributes:GetMight(),
        Agility = characterAttributes:GetAgility(),
        Vitality = characterAttributes:GetVitality(),
        Will = characterAttributes:GetWill(),
        Fate = characterAttributes:GetFate(),
        CriticalRatingMelee = characterAttributes:GetMeleeCriticalHitChance(),
        CriticalRatingRange = characterAttributes:GetRangeCriticalHitChance(),
        CriticalRatingTactical = characterAttributes:GetTacticalCriticalHitChance(),
        FinesseRating = characterAttributes:GetFinesse(),
        PhysicalMasteryRatingMelee = characterAttributes:GetMeleeDamage(),
        PhysicalMasteryRatingRange = characterAttributes:GetRangeDamage(),
        TacticalMasteryRating = characterAttributes:GetTacticalDamage(),
        OutgoingHealingRating = characterAttributes:GetOutgoingHealing(),
        ResistanceRating = characterAttributes:GetBaseResistance(),
        CriticalDefenceRating = characterAttributes:GetBaseCriticalHitAvoidance(),
        IncomingHealingRating = characterAttributes:GetIncomingHealing(),
        BlockChanceRating = characterAttributes:GetBlock(),
        PartialBlockChanceRating = characterAttributes:GetBlock(),
        PartialBlockMitigationRating = characterAttributes:GetBlock(),
        ParryChanceRating = characterAttributes:GetParry(),
        PartialParryChanceRating = characterAttributes:GetParry(),
        PartialParryMitigationRating = characterAttributes:GetParry(),
        EvadeChanceRating = characterAttributes:GetEvade(),
        PartialEvadeChanceRating = characterAttributes:GetEvade(),
        PartialEvadeMitigationRating = characterAttributes:GetEvade(),
        PhysicalMitigationRating = characterAttributes:GetPhysicalMitigation(),
        TacticalMitigationRating = characterAttributes:GetTacticalMitigation(),
    };
end

local function ExportStats()
    local ok, statsTable = pcall(CollectStats);
    if not ok then
        print("Failed to collect stats: "..tostring(statsTable));
        return;
    end
    local name = SanitizeFilename(statsFileBox:GetText(), "Stats");
    RequestSave(name, statsTable, function()
        print("Successfully saved character stats to '"..name..".plugindata'!");
    end);
end

exportStatsButton.Click = function(sender, args)
    ExportStats();
end

overwriteYesButton.Click = function(sender, args)
    local pending = pendingSave;
    pendingSave = nil;
    overwriteWindow:SetVisible(false);
    if pending ~= nil then
        SavePlugindata(pending.name, pending.data, pending.onSaved);
    end
end

overwriteNoButton.Click = function(sender, args)
    pendingSave = nil;
    overwriteWindow:SetVisible(false);
    SetExportButtonsEnabled(true);
    print("Export cancelled; existing file kept.");
end

-- Failsafe for the PluginData.Load existence probe: if the load callback
-- never fires (possible for missing files on some client versions), the
-- pending check is resolved as "does not exist" after ~2400 update ticks
-- (~40s at 60fps). The observed PluginData delay exceeded 300 ticks, so
-- this must stay well above it.
mainWindow.Update = function(sender, args)
    local pending = saveCheckPending;
    if pending == nil then
        mainWindow:SetWantsUpdates(false);
        return;
    end
    pending.ticks = pending.ticks + 1;
    if pending.ticks > 2400 then
        print("Timed out checking for an existing file; saving anyway.");
        FinishSaveCheck(false);
    end
end

-- ==== Shell command ====
-- /statsexport [watch|stop|stats|items|toggle]
-- No argument toggles the window. Execute may receive the arguments as
-- its only parameter (documented) or as the second of two parameters
-- (seen in the wild), so accept both forms.

local toggleCommand = Turbine.ShellCommand();
function toggleCommand:Execute(commandOrArgs, maybeArgs)
    local arg = string.lower(tostring(maybeArgs or commandOrArgs or ""));
    arg = arg:gsub("^%s*/?statsexport%s*", "");
    arg = arg:gsub("^%s+", ""):gsub("%s+$", "");
    if arg == "" or arg == "toggle" then
        mainWindow:SetVisible(not mainWindow:IsVisible());
    elseif arg == "watch" then
        SetWatching(true);
    elseif arg == "stop" or arg == "nowatch" then
        SetWatching(false);
    elseif arg == "stats" then
        ExportStats();
    elseif arg == "items" then
        ExportItems();
    elseif arg == "clear" then
        ClearItems();
    else
        print("Unknown argument '"..arg.."'. Usage: /statsexport [watch|stop|stats|items|clear|toggle]");
    end
end

function toggleCommand:GetHelp()
    return "Usage: /statsexport [watch|stop|stats|items|clear|toggle]\n\n"..
        "watch/stop - start/stop capturing item links from chat\n"..
        "stats - export character stats to file\n"..
        "items - export queued items to file\n"..
        "clear - empty the item queue without exporting\n"..
        "toggle - show/hide this window (default)";
end

function toggleCommand:GetShortHelp()
    return "StatsExporter: watch|stop chat links, export stats/items, toggle window.";
end

Turbine.Shell.AddCommand("statsexport", toggleCommand);

-- ==== Unload cleanup ====

plugin.Unload = function()
    Turbine.Shell.RemoveCommand(toggleCommand);
    Turbine.Chat.Received = nil;
    mainWindow:SetVisible(false);
    overwriteWindow:SetVisible(false);
end

UpdateItemsStatus();
mainWindow:SetVisible(true);
