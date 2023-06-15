local functions = {};

local loader = require(game.ReplicatedStorage.src.Loader);

local Workspace = game:GetService("Workspace");
local LocalPlayer = game:GetService('Players').LocalPlayer;

function functions.isGameStarted()
    return Workspace['_DATA'].GameStarted.Value;
end

function functions.isGameFinished()
    return Workspace['_DATA'].GameFinished.Value;
end

function functions.getCostScale()
    return Workspace['_DATA'].LevelModifiers['player_cost_scale'].Value;
end

function functions.getWave()
    return Workspace['_wave_num'].Value;
end

function functions.getWaveTime()
    return Workspace['_wave_time'].Value;
end

function functions.isLobby()
    return Workspace['_MAP_CONFIG'].IsLobby.Value;
end

function functions.getMoneyInGame()
    return LocalPlayer:WaitForChild('_stats'):WaitForChild('resource').Value;
end

function functions.getPortalLobbies()
    return Workspace:WaitForChild('_PORTALS'):WaitForChild('Lobbies'):GetChildren();
end

function functions.findLobbyOwner(player)
    for _, v in pairs (functions.getPortalLobbies()) do
        local owner = v:WaitForChild('Owner');
        if (tostring(owner.Value) == player.Name) then
            return v.Name;
        end
    end
end

function functions.findModel(unit_id, position)
    local args = {
        [1] = CFrame.new(position.x, position.y, position.z),
        [2] = Vector3.new(1.5, 1.5, 1.5)
    }
    local objects = workspace:GetPartBoundsInBox(unpack(args));
    for _, v in pairs (objects) do
        if (tostring(v) == 'HumanoidRootPart') then
            local model = v.Parent;
            if (model['_stats'].id.Value == unit_id) then
                return model;
            end
        end
    end
    return nil;
end

function functions.getLevelData()
    return loader.LevelData;
end

function functions.getDataUnits()
    return require(game.ReplicatedStorage.src.Data.Units);
end

-- return the Data units
function functions.getDataUnit(unit_id)
    return functions.getDataUnits()[unit_id];
end

--return current unit upgrade stage
function functions.getUpgradeStage(model)
    return model['_stats'].upgrade.Value;
end

function functions.getUnitUpgradeScale(model)
    return model['_stats']['upgrade_cost_multiplier'].Value;
end

return functions;