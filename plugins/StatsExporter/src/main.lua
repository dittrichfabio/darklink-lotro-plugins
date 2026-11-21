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

local qualityNames = {
    [Turbine.Gameplay.ItemQuality.Common]       = "Common",
    [Turbine.Gameplay.ItemQuality.Uncommon]     = "Uncommon",
    [Turbine.Gameplay.ItemQuality.Rare]         = "Rare",
    [Turbine.Gameplay.ItemQuality.Incomparable] = "Incomparable",
    [Turbine.Gameplay.ItemQuality.Legendary]    = "Legendary",
};

-- Reverse-lookup tables built from the enum tables at load time, so
-- exported numbers resolve to readable names.
local function ReverseEnum(enumTable)
    local names = {};
    for name, value in pairs(enumTable) do
        names[value] = name;
    end
    return names;
end

local categoryNames = ReverseEnum(Turbine.Gameplay.ItemCategory);
local durabilityNames = ReverseEnum(Turbine.Gameplay.ItemDurability);

-- ==== Window ====

local mainWindow = Turbine.UI.Lotro.Window();
mainWindow:SetSize(500, 300);
mainWindow:SetText("Character Stats Exporter");

local exportStatsButton = Turbine.UI.Lotro.Button();
exportStatsButton:SetParent(mainWindow);
exportStatsButton:SetText("Export Character Stats to File");
exportStatsButton:SetPosition(125, 50);
exportStatsButton:SetSize(250, 30);

local itemSlot = Turbine.UI.Lotro.Quickslot();
itemSlot:SetParent(mainWindow);
itemSlot:SetPosition(232, 100);
itemSlot:SetSize(36, 36);
itemSlot:SetBackColor(Turbine.UI.Color(0.2, 0.2, 0.2));

local addItemButton = Turbine.UI.Lotro.Button();
addItemButton:SetParent(mainWindow);
addItemButton:SetText("Add Item");
addItemButton:SetPosition(125, 150);
addItemButton:SetSize(250, 30);

local exportItemsButton = Turbine.UI.Lotro.Button();
exportItemsButton:SetParent(mainWindow);
exportItemsButton:SetText("Export Items to File");
exportItemsButton:SetPosition(125, 200);
exportItemsButton:SetSize(250, 30);

-- ==== Item export ====

local pendingItems = {};

local function SlottedShortcut()
    return itemSlot:GetShortcut();
end

local function SlottedItem()
    local shortcut = SlottedShortcut();
    return shortcut and shortcut:GetItem() or nil;
end

-- Records the documented ItemInfo fields plus the image IDs (useful for
-- downstream icon rendering). The client exposes no item-stat getters —
-- chat-link records carry itemGID for database lookups instead.
local function ItemToTable(item, shortcut)
    local info = item:GetItemInfo();
    local entry = {
        Name = info:GetName(),
        Quality = qualityNames[info:GetQuality()] or info:GetQuality(),
        QualityID = info:GetQuality(),
        Category = categoryNames[info:GetCategory()] or info:GetCategory(),
        CategoryID = info:GetCategory(),
        Description = info:GetDescription(),
        Durability = durabilityNames[info:GetDurability()] or info:GetDurability(),
        Unique = info:IsUnique(),
        Magic = info:IsMagic(),
        IconImageID = info:GetIconImageID(),
        BackgroundImageID = info:GetBackgroundImageID(),
        ShadowImageID = info:GetShadowImageID(),
        UnderlayImageID = info:GetUnderlayImageID(),
        QualityImageID = info:GetQualityImageID(),
        MaxQuantity = info:GetMaxQuantity(),
        MaxStackSize = info:GetMaxStackSize(),
    };
    if shortcut then
        entry.ShortcutData = shortcut:GetData();
    end
    -- Item-level stack count; present on the live client though Item is
    -- sparsely documented, so call it defensively.
    local ok, quantity = pcall(function() return item:GetQuantity(); end);
    if ok then entry.Quantity = quantity; end
    return entry;
end

itemSlot.DragDrop = function(sender, args)
    local item = SlottedItem();
    if not item then
        print("Drop a valid item onto the slot.");
        return;
    end
    print("Item: "..item:GetItemInfo():GetName());
end

addItemButton.Click = function(sender, args)
    local item = SlottedItem();
    if not item then
        print("Drop an item onto the slot first.");
        return;
    end
    table.insert(pendingItems, ItemToTable(item, SlottedShortcut()));
    print("Queued "..item:GetItemInfo():GetName().." ("..#pendingItems.." pending)");
end

-- ==== Item links ====
-- Item links sent in chat (<ExamineItemInstance:ItemInfo:...> and
-- <ExamineIA:IAInfo:...> for legendary items) carry a compressed blob
-- with the full item record: instance + generic IDs, true item level,
-- armour value, worth, binding, crafter, and LI legacies/relics/stats.
-- Link an item in chat (or let loot messages produce one) and it is
-- captured and queued here. The raw link data is kept too, so data the
-- decoder doesn't understand yet can be analyzed downstream.

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
    print("Captured item link: "..name.." ("..#pendingItems.." pending)");
end

Turbine.Chat.Received = function(sender, args)
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
end

exportItemsButton.Click = function(sender, args)
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
            else
                print("Error saving file: "..tostring(errorMessage));
            end
        end);
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

exportStatsButton.Click = function(sender, args)
    local ok, statsTable = pcall(CollectStats);
    if not ok then
        print("Failed to collect stats: "..tostring(statsTable));
        return;
    end
    print("Saving information to file...");
    Turbine.PluginData.Save(Turbine.DataScope.Character, "Stats", statsTable, SaveComplete);
end

-- ==== Shell command: /statsexport toggles the window ====

local toggleCommand = Turbine.ShellCommand();
function toggleCommand:Execute(argumentText)
    mainWindow:SetVisible(not mainWindow:IsVisible());
end

function toggleCommand:GetHelp()
    return "Usage: /statsexport - toggles the Stats Exporter window.";
end

function toggleCommand:GetShortHelp()
    return "Toggles the Stats Exporter window.";
end

Turbine.Shell.AddCommand("statsexport", toggleCommand);

-- ==== Unload cleanup ====

plugin.Unload = function()
    Turbine.Shell.RemoveCommand(toggleCommand);
    Turbine.Chat.Received = nil;
    mainWindow:SetVisible(false);
end

mainWindow:SetVisible(true);
