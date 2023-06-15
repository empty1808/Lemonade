local handlers = {};

local client_to_server = game:GetService('ReplicatedStorage'):WaitForChild('endpoints'):WaitForChild('client_to_server');

function handlers.onUsePortal(uuid, friends_only)
    local args = {
        [1] = uuid,
        [2] = {
            ['Friends_only'] = friends_only
        }
    }
    client_to_server:WaitForChild('use_portal'):InvokeServer(unpack(args));
end

function handlers.onRequestStartGame(lobby_id)
    local args = {
        [1] = lobby_id;
    }
    client_to_server:WaitForChild('request_start_game'):InvokeServer(unpack(args));
end

function handlers.onVoteStart()
    local args = {};
    client_to_server:WaitForChild('vote_start'):InvokeServer(unpack(args));
end

function handlers.onSpawnUnitInGame(uuid, position)
    local args = {
        [1] = uuid,
        [2] = CFrame.new(position.x, position.y, position.z);
    }
    client_to_server:WaitForChild('spawn_unit'):InvokeServer(unpack(args));
end

function handlers.onUpgradeUnitInGame(model)
    local args = {
        [1] = model
    }
    client_to_server:WaitForChild('upgrade_unit_ingame'):InvokeServer(unpack(args));
end

function handlers.onSellUnitInGame(model)
    local args = {
        [1] = model
    }
    client_to_server:WaitForChild('sell_unit_ingame'):InvokeServer(unpack(args));
end

function handlers.onFinishedVote(key, items)
    local args = {
        [1] = key,
        [2] = items
    }
    client_to_server:WaitForChild('set_game_finished_vote'):InvokeServer(unpack(args));
end

return handlers;