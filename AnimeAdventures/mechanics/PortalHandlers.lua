local modules = {};

local tables = loadstring(readfile('Lemonade/AnimeAdventures/librarys/tables.lua'))();

local Items = require(game.ReplicatedStorage.src.Data.Items);
local Portals = tables.filter(Items, function(item)
    if (item.item_group) and (item.item_group == 'Portals') then
        return true;
    end
end);

Portals.disc_final.avaliable = true;
Portals.portal_boros_g.avaliable = true;
Portals.portal_zeldris.avaliable = true;
Portals.portal_item__dressrosa.avaliable = true;
Portals.portal_item__eclipse.avaliable = true;
Portals.portal_item__fate.avaliable = true;
Portals.portal_item__gilgamesh.avaliable = true;

function modules.getPortals()
    return tables.filter(Portals, function(element)
        return element.avaliable;
    end);
end

function modules.getSinglePortals() 
    return tables.filter(Portals, function(element)
        return not (element.tier) and (element.avaliable);
    end);
end

function modules.getTierPortals() 
    return tables.filter(Portals, function(element)
        return element.tier and (element.avaliable);
    end);
end

function modules.getByName(displayname)
    for k, v in pairs (modules.getPortals()) do
        if (v.name == displayname) then
            return v;
        end
    end
end

function modules.getById(id)
    for k, v in pairs (modules.getPortals()) do
        if (v.id == displayname) then
            return v;
        end
    end
end

return modules;