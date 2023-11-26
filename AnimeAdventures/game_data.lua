local game_data = {};

local librarys = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/AnimeAdventures/librarys.lua'))();

local maps = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/AnimeAdventures/maps.lua'))();

local tables = librarys.tables;

local data = game.ReplicatedStorage.src.Data;

function game_data.getWorlds()
    return require(data.Worlds);
end

function game_data.getInfiniteWorldId()
    local result = {};
    local unknown = 1;
    for k, v in pairs (game_data.getWorlds()) do
        if (v) and (typeof(v) == 'table') then
            if (tables.containsKey(v, 'infinite')) then
                if (maps.prioritize_maps[k]) then
                    result[maps.prioritize_maps[k]] = k;
                else
                    result[unknown + tables.getLength(maps.prioritize_maps)] = k;
                    unknown+=1;
                end
            end
        end
    end
    return result;
end

function game_data.getInfiniteWorldName()
    local result = {};
    
end

return game_data;