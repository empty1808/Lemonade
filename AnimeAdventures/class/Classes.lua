local modules = {};

local function loadClass(class_name)
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/AnimeAdventures/class'..tostring(class_name)))();
end

modules.Players = loadClass('Players.lua');

return modules;