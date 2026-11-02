-- Portable Reagent Bank item (entry 900000).
-- Right-clicking the item opens the reagent bank from anywhere; the use is
-- handled by the 'item_reagent_bank' ItemScript (modules/mod-reagent-bank).
--
-- spellid_1 8690 (Hearthstone spell) is used as a dummy on-use trigger. It is
-- an instant self-cast that the WoW 3.3.5a client recognises as a draggable
-- use-item; without a valid use spell the item cannot be placed on action bars.
-- The item_reagent_bank ItemScript returns true from OnUse so the spell never
-- resolves and the Hearthstone teleport does not fire.

SET @ItemEntry = 900000;

DELETE FROM `item_template` WHERE `entry` = @ItemEntry;
INSERT INTO `item_template`
    (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`, `Flags`,
     `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`,
     `AllowableRace`, `ItemLevel`, `RequiredLevel`, `maxcount`, `stackable`,
     `bonding`, `description`, `spellid_1`, `spelltrigger_1`, `Material`,
     `ScriptName`) VALUES
    (@ItemEntry, 15, 0, 'Portable Reagent Bank', 1246, 3, 64,
     1, 0, 0, 0, -1,
     -1, 1, 1, 1, 1,
     1, 'Right-click to access your personal reagent bank from anywhere.', 8690, 0, 1,
     'item_reagent_bank');

-- Grant the item to every newly created character (race/class pair), mirroring
-- the starter-supplies pattern. INSERT IGNORE keeps existing rows untouched.
INSERT IGNORE INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `Note`)
SELECT DISTINCT `RaceID`, `ClassID`, @ItemEntry, 1, 'Portable Reagent Bank starter item'
FROM `charstartoutfit_dbc`;
