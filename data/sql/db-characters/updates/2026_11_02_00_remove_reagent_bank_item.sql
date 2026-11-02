-- Portable Reagent Bank (item 900000) is retired in favour of the ".reagentbank"
-- command. Remove existing copies from character inventories (the starter grant
-- also reached playerbots) so no one is left holding the now-unused item.
-- item_instance.itemEntry identifies the item; character_inventory.item
-- references the instance guid.
DELETE FROM `character_inventory`
    WHERE `item` IN (SELECT `guid` FROM `item_instance` WHERE `itemEntry` = 900000);
DELETE FROM `item_instance` WHERE `itemEntry` = 900000;
