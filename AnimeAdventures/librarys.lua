local modules = {};

local function loadlibrary(original)
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/AnimeAdventures/'..tostring(original)..'.lua'))();
end

modules.LocalPlayer = game.Players.LocalPlayer;

modules.tables = loadlibrary('librarys/tables.lua');
modules.strings = loadlibrary('librarys/strings.lua');
modules.numbers = loadlibrary('librarys/numbers.lua');

modules.functions = loadlibrary('mechanics/functions.lua');
modules.handlers = loadlibrary('mechanics/handlers.lua');
modules.portals = loadlibrary('mechanics/PortalHandlers.lua');

return modules;