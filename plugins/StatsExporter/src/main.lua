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

local function SaveComplete(success, errorMessage)
    if success then
        print("Successfully saved data!");
    else
        print("Error saving file: "..tostring(errorMessage));
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

local itemsHeader = Turbine.UI.Label();
itemsHeader:SetParent(mainWindow);
itemsHeader:SetPosition(15, 120);
itemsHeader:SetSize(470, 20);
itemsHeader:SetText("Items (chat links)");
itemsHeader:SetFontStyle(Turbine.UI.FontStyle.Outline);

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

local function ExportItems()
    if #pendingItems == 0 then
        print("No items queued to export.");
        return;
    end
    print("Saving items to file...");
    Turbine.PluginData.Save(Turbine.DataScope.Character, "Items", pendingItems,
        function(success, errorMessage)
            if success then
                print("Successfully saved "..#pendingItems.." items!");
                pendingItems = {};
                UpdateItemsStatus();
            else
                print("Error saving file: "..tostring(errorMessage));
            end
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
    print("Saving information to file...");
    Turbine.PluginData.Save(Turbine.DataScope.Character, "Stats", statsTable, SaveComplete);
end

exportStatsButton.Click = function(sender, args)
    ExportStats();
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
end

UpdateItemsStatus();
mainWindow:SetVisible(true);
