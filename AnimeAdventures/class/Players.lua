local modules = {};

function modules.respawn(player)
    if not (modules.isPlayer(player)) then
        return;
    end

end

function modules.to(player, position)
    if not (modules.isPlayer(player)) then
        return;
    end
    local character = player.Character;
    local humanoid = character.HumanoidRootPart;
    humanoid.CFrame = CFrame.new(position[1], position[2], position[3]);
end

function modules.move(player, position)
    if not (modules.isPlayer(player)) then
        return;
    end
    local character = player.Character;
    local humanoid = character.HumanoidRootPart;
    local cframe = humanoid.CFrame;
    humanoid.CFrame = CFrame.new(cframe.X + position[1], cframe.Y + position[2], cframe.Z + position[3]);
end

function modules.isPlayer(player) 
    if not (player) or (player.ClassName ~= 'Player') then
        return false;
    end
    return true;
end

return modules;