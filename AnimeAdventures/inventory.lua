local modules = {}

local librarys = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/librarys.lua'))();
local tables = library.requires('tables.lua');
local loader = require(game.ReplicatedStorage.src.Loader);

local session = loader.load_client_service(script, 'ItemInventoryServiceClient').session;

function modules.getEquippedUnits()
    return session.collection['collection_profile_data']['equipped_units'];
end

function modules.getEquippedUnit(unit_id)
    local owned_units = modules.getOwnedUnits();
    for _, v in pairs (modules.getEquippedUnits()) do
        if (owned_units[v]['unit_id'] == unit_id) then
            return owned_units[v];
        end
    end
    return nil;
end

function modules.getOwnedUnits() 
    return session.collection['collection_profile_data']['owned_units'];
end

function modules.getOwnedUnitsIf(condition)
    local results = {};
    for i, element in pairs (modules.getOwnedUnits()) do
        local insert = condition and condition(element) or false;
        if (insert and (insert == true)) then
            results[i] = element;
        end
    end
    return results;
end

function modules.getNormalItems()
    return session.inventory['inventory_profile_data']['normal_items'];
end

function modules.getUniqueItems()
    return session.inventory['inventory_profile_data']['unique_items'];
end

function modules.getUniqueItemsIf(condition)
    local results = {};
    for i, element in pairs (modules.getUniqueItems()) do
        local insert = condition and condition(element) or false;
        if (insert and (insert == true)) then
            table.insert(results, element);
        end
    end
    return results;
end

function modules.getPortals(id)
    return modules.getUniqueItemsIf(function(item)
        if (item['item_id'] == 'portal_item__'..id) then
            return true;
        end
    end)
end

function modules.filterMadokaPortal(filters)
    for _, portal in pairs (modules.getPortals('madoka')) do
        local data = portal['_unique_item_data']['_unique_portal_data'];
        tables.replace(filters['ignore-challenge'], 'high_cost', 'double_cost');
        if ((not tables.containsValue(filters['ignore-tier'], data['portal_depth'])) and (not tables.containsValue(filters['ignore-challenge'], data['challenge'])) and (not tables.containsValue(filters['ignore-buff'], data['_weak_against'][1]['damage_type']))) then
            return portal;
        end
    end
end

return modules;