-- Portable Reagent Bank item (entry 900000).
-- Right-clicking the item opens the reagent bank from anywhere; the use is
-- handled by the 'item_reagent_bank' ItemScript (modules/mod-reagent-bank).
--
-- The dummy on-use spell (836 = LOGINEFFECT) exists only so the client shows a
-- "Use" button and sends CMSG_USE_ITEM. The script intercepts the use and
-- returns true, so the spell never actually resolves. If "Use" does not appear
-- in-game, swap spellid_1 for any other instant, self-cast on-use spell.

SET @ItemEntry = 900000;

DELETE FROM `item_template` WHERE `entry` = @ItemEntry;
INSERT INTO `item_template`
    (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`, `Flags`,
     `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`,
     `AllowableRace`, `ItemLevel`, `RequiredLevel`, `maxcount`, `stackable`,
     `bonding`, `description`, `spellid_1`, `spelltrigger_1`, `Material`,
     `ScriptName`) VALUES
    (@ItemEntry, 15, 0, 'Portable Reagent Bank', 6418, 3, 0,
     1, 0, 0, 0, -1,
     -1, 1, 1, 1, 1,
     1, 'Right-click to access your personal reagent bank from anywhere.', 836, 0, 1,
     'item_reagent_bank');

-- Grant the item to every newly created character (race/class pair), mirroring
-- the starter-supplies pattern. INSERT IGNORE keeps existing rows untouched.
INSERT IGNORE INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `Note`)
SELECT DISTINCT `RaceID`, `ClassID`, @ItemEntry, 1, 'Portable Reagent Bank starter item'
FROM `charstartoutfit_dbc`;
