-- Portable Reagent Bank item (entry 900000).
-- Right-clicking the item opens the reagent bank from anywhere; the use is
-- handled by the 'item_reagent_bank' ItemScript (modules/mod-reagent-bank).
--
-- spellid_1 836 (LOGINEFFECT) is a benign dummy on-use trigger: it makes the
-- client show a "Use" button and send CMSG_USE_ITEM, which the item_reagent_bank
-- ItemScript intercepts (returns true) to open the bank. The spell itself is inert.
--
-- displayid 1246 (INV_Misc_Book_06) is a book icon; pair it with the client patch
-- that adds entry 900000 to Item.dbc (client_patch/item-display) or the client
-- shows a red "?".
--
-- Do NOT use the real Hearthstone spell (8690) as the on-use trigger to make the
-- item action-bar draggable: on a custom 3.3.5a client it crashed with ERROR #132
-- decoding the Hearthstone spell-visual texture. Drive it from a
-- `/use Portable Reagent Bank` macro instead if an action-bar button is wanted.

SET @ItemEntry = 900000;

DELETE FROM `item_template` WHERE `entry` = @ItemEntry;
INSERT INTO `item_template`
    (`entry`, `class`, `subclass`, `name`, `displayid`, `Quality`, `Flags`,
     `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`,
     `AllowableRace`, `ItemLevel`, `RequiredLevel`, `maxcount`, `stackable`,
     `bonding`, `description`, `spellid_1`, `spelltrigger_1`, `Material`,
     `ScriptName`) VALUES
    (@ItemEntry, 15, 0, 'Portable Reagent Bank', 1246, 3, 0,
     1, 0, 0, 0, -1,
     -1, 1, 1, 1, 1,
     1, 'Right-click to access your personal reagent bank from anywhere.', 836, 0, 1,
     'item_reagent_bank');

-- Grant the item to every newly created character (race/class pair), mirroring
-- the starter-supplies pattern. INSERT IGNORE keeps existing rows untouched.
INSERT IGNORE INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `Note`)
SELECT DISTINCT `RaceID`, `ClassID`, @ItemEntry, 1, 'Portable Reagent Bank starter item'
FROM `charstartoutfit_dbc`;
