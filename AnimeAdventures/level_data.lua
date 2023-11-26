local level = {};

local loader = require(game.ReplicatedStorage.src.Loader);
local data = loader.LevelData;

function level.getData()
    return data;
end

function level.getMap()
    return data.map;
end

function level.getWorld()
    return data.world;
end

function level.getGamemode() 
    return data._gamemode;
end

return level;