local profile = {}

local loader = require(game.ReplicatedStorage.src.Loader);
local StatsServiceClient = loader.load_client_service(script, "StatsServiceClient");
local profile_data = StatsServiceClient.session.profile_data;

function profile.getGemAmount()
    return profile_data.gem_amount;
end

function profile.getGoldAmount() 
    return profile_data.gold_amount;
end

function profile.getQuests() 
    return profile_data.quest_handler.quests;
end

function profile.getCastleFloorReached()
    return profile_data.level_data.infinite_tower.floor_reached;
end

return profile;