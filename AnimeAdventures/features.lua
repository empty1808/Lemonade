local features = {};

function features.onPlaceAnyWhere()
    local services = require(game.ReplicatedStorage.src.Loader)
    local placement_service = services.load_client_service(script, "PlacementServiceClient")

    task.spawn(function()
        while task.wait() do
            placement_service.can_place = true;
        end
    end)
end

function placeunittwin() 
    if game.Workspace:WaitForChild("_UNITS") then
        for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
            repeat task.wait() until v:WaitForChild("_stats")
            if v.Name == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v.Name:FindFirstChild("_hitbox") then
                v:Destroy();
            end
        end
    end
end


return features;