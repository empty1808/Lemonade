local modules = {};

local loader = require(game.ReplicatedStorage.src.Loader);
local data = loader.LevelData;

function modules.getData()
    return data;
end

function modules.getMap()
    return data.map;
end

function modules.getWorld()
    return data.world;
end

function modules.getGamemode() 
    return data._gamemode;
end

return modules;