local HttpService = game:GetService("HttpService");

local librarys = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/librarys.lua'))();

local UI = librarys.requires('VenyxUI.lua');
local maps = librarys.requires('AnimeAdventures/maps.lua');
local inventory = librarys.requires('AnimeAdventures/inventory.lua');
local functions = librarys.requires('AnimeAdventures/functions.lua');
local numbers = librarys.requires('numbers.lua');
local handlers = librarys.requires('AnimeAdventures/handlers.lua');
local tables = librarys.requires('tables.lua');

local LocalPlayer = game.Players.LocalPlayer;

local ScriptSaved = {
    ['join'] = {
        ['default'] = {
            ['enable'] = false,
            ['selected'] = nil,
            ['stage'] = nil,
            ['difficult'] = nil
        },
        ['madoka-portal'] = {
            ['enable'] = false,
            ['ignore-tier'] = {},
            ['ignore-challenge'] = {},
            ['ignore-buff'] = {},
            ['replay'] = false
        }
    },
    ['macro'] = {
        ['select'] = nil;
    }
}

local macro = {
    macros = {},
    select = nil,
    record = false,
    play = false,
    cache = {
        length = 0,
        tables = {}
    }
}

local features = {
    ['join'] = false,
    ['replay'] = false,
    ['playing-macro'] = false
}

local Elements = {};

function onCreateGUI()
    Elements['GUI'] = UI.new('Lemonade [Anime Adventures]', 5013109572);

    Elements['JoinPage'] = Elements['GUI']:addPage('Join', 13630055077);
    Elements['MacroPage'] = Elements['GUI']:addPage('Macro', 5012544693);
    Elements['SettingPage'] = Elements['GUI']:addPage('Settings', 13710659541);

    onJoinPage(Elements['JoinPage']);
    onMacroPage(Elements['MacroPage']);
    onSettingPage(Elements['SettingPage']);
end

function onJoinPage(page)
    local Default = page:addSection('Default');
    --local Raid = page:addSection('Raid');
    --local Dungeon = page:addSection('Dungeon');
    --local Challenge = page:addSection('Challenge');
    local MadokaPortal = page:addSection('Madoka Portal');
    

    Default:addToggle('enabled', ScriptSaved.join.default.enable, function(toggle)
        
    end)
    Default:addDropdown('selected', maps.getMaps(), nil, function(text)
        
    end)
    Default:addDropdown('stage', {'infinite', 'act-1', 'act-2', 'act-3', 'act-4', 'act-5', 'act-6'}, nil, function(selected)
        print(selected)
    end)
    Default:addDropdown('difficult', {'easy', 'hard'}, nil, function(selected)
        
    end)

    onMadokaPortal(MadokaPortal);
end

function onDefault(section)
    section:addToggle('enabled', ScriptSaved.join.default.enable, function(toggle)
        
    end)
    section:addDropdown('selected', maps.getMaps(), nil, function(text)
        
    end)
    section:addDropdown('stage', {'infinite', 'act-1', 'act-2', 'act-3', 'act-4', 'act-5', 'act-6'}, nil, function(selected)
        print(selected)
    end)
    section:addDropdown('difficult', {'easy', 'hard'}, nil, function(selected)
        
    end)
end

function onMadokaPortal(section)
    local Features = ScriptSaved.join['madoka-portal'];
    local Enable = section:addToggle('enabled', Features.enable, function(toggle)
        ScriptSaved.join['madoka-portal'].enable = toggle;
    end)
    local Tier = section:addSelectDropdown('ign tier', {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}, Features['ignore-tier'], function(selected)
        ScriptSaved.join['madoka-portal']['ignore-tier'] = selected;
    end)
    local Challenge section:addSelectDropdown('ign challenge', {'tank_enemies', 'fast_enemies', 'shield_enemies', 'regen_enemies', 'short_range', 'high_cost'}, Features['ignore-challenge'], function(selected)
        ScriptSaved.join['madoka-portal']['ignore-challenge'] = selected;
    end)
    local Buff = section:addSelectDropdown('ign buff', {'physical', 'magic'}, Features['ignore-buff'], function(selected)
        ScriptSaved.join['madoka-portal']['ignore-buff'] = selected;
    end)
    local Replay = section:addToggle('replay', Features.replay, function(toggle)
        ScriptSaved.join['madoka-portal'].replay = toggle;
    end)
end

function onMacroPage(page)
    Elements['MacroSystem'] = page:addSection('Macro System');
    Elements['MacroTimings'] = page:addSection('Macro Timings');

    onMacroSystem(Elements['MacroSystem']);
    onMacroTimings(Elements['MacroTimings']);
end

function onMacroSystem(section)
    local modules = {};
    modules['create'] = section:addTextbox('create', '', function(text, focusLost)
        if (focusLost) then
            if (text == '') then
                return
            end
            if not (tables.containsValue(macro.macros, text)) then
                table.insert(macro.macros, text);
                writefile('Lemonade\\AnimeAdventures\\Macros\\'..text..'.json', '{}');
                section:updateDropdown(modules['select'], nil, nil, ScriptSaved.macro.select);
                notify('Notification', 'Macro "'..text..'" has been created.', 1.5);
            else
                notify('Notification', 'Macro "'..text..'" already exists.', 1.5);
            end
        end
    end)

    modules['select'] = section:addDropdown('select', macro.macros, ScriptSaved.macro.select, function(text) 
        ScriptSaved.macro.select = text
    end)

    modules['remove'] = section:addButton('remove', function()
        print(macro.cache.length)
    end)

    modules['record'] = section:addToggle('record', false, function(toggle)
        if (toggle) and not (ScriptSaved.macro.select) then
            section:updateToggle(modules['record'], 'record', false);
            notify('Warning', 'You have not selected macro.', 1.5);
            return
        elseif not (toggle) and (ScriptSaved.macro.select) then
            writefile('Lemonade\\AnimeAdventures\\Macros\\'..ScriptSaved.macro.select..'.json', HttpService:JSONEncode(macro.cache.tables));
            macro.cache.length = 0;
            macro.cache.tables = {};
            notify('Notification', 'Macro "'..ScriptSaved.macro.select..'" has been recorded.', 1.5)
        end
        macro.record = toggle;
    end)

    modules['play'] = section:addToggle('play', ScriptSaved.macro.play, function(toggle)
        if (toggle) and not (ScriptSaved.macro.select) then
            section:updateToggle(modules['play'], 'record', false);
            notify('Warning', 'You have not selected macro.', 1.5);
            return
        end
        ScriptSaved.macro.play = toggle;
    end)
end

function onMacroTimings(section)
    Elements['MacroTimings-Wave'] = section:addTextLabel('WAVE', 'nothing');
    Elements['MacroTimings-Time'] = section:addTextLabel('TIMES', 'nothing');
end

function onSettingPage(page)
    local Default = page:addSection('Default');

    onSettingDefault(Default);
end

function onSettingDefault(section)
    section:addKeybind('Toggle Keybind', Enum.KeyCode.LeftControl, function()
        Elements['GUI']:toggle();
    end)
end

function notify(title, content, duration)
    coroutine.wrap(function()
        Elements['GUI']:Notify(title, content, duration);
    end)()
end

function remoteHandler()
    local OldFireServer;

    OldFireServer = hookmetamethod(game, "__namecall", newcclosure(function(...)
        local remote = ...;
    
        if (macro.record) then
            if typeof(remote) == 'Instance' then
                local method = getnamecallmethod();
                if method and (method == "FireServer" or method == "fireServer" or method == "InvokeServer" or method == "invokeServer") then
                    if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                        local args = {select(2,...)};
                        local cache = macro.cache.tables;
                        if (remote.Name == 'spawn_unit') then
                            local uuid, position = unpack(args);
                            local unit_id = inventory.getOwnedUnits()[uuid]['unit_id'];
                            local data = {
                                ['type'] = 'spawn_unit',
                                ['unit-id'] = unit_id,
                                ['wave'] = functions.getWave(),
                                ['time'] = functions.getWaveTime(),
                                ['position'] = {
                                    x = numbers.format('%.3f', position.X), 
                                    y = numbers.format('%.3f', position.Y), 
                                    z = numbers.format('%.3f', position.Z)
                                }
                            };
                            macro.cache.length = macro.cache.length + 1;
                            macro.cache.tables[tostring(macro.cache.length)] = data;
                        elseif (remote.Name == 'upgrade_unit_ingame') then
                            local model = unpack(args);
                            local unit_id = model['_stats'].id.Value;
                            local position = model.HumanoidRootPart.CFrame;
                            local data = {
                                ['type'] = 'upgrade_unit',
                                ['unit-id'] = unit_id,
                                ['wave'] = functions.getWave(),
                                ['time'] = functions.getWaveTime(),
                                ['position'] = {
                                    x = numbers.format('%.3f', position.X), 
                                    y = numbers.format('%.3f', position.Y), 
                                    z = numbers.format('%.3f', position.Z)
                                }
                            };
                            macro.cache.length = macro.cache.length + 1;
                            macro.cache.tables[tostring(macro.cache.length)] = data;
                        elseif (remote.Name == 'sell_unit_ingame') then
                            local model = unpack(args);
                            local unit_id = model['_stats'].id.Value;
                            local position = model.HumanoidRootPart.CFrame;
                            local data = {
                                ['type'] = 'sell_unit',
                                ['unit-id'] = unit_id,
                                ['wave'] = functions.getWave(),
                                ['time'] = functions.getWaveTime(),
                                ['position'] = {
                                    x = numbers.format('%.3f', position.X), 
                                    y = numbers.format('%.3f', position.Y), 
                                    z = numbers.format('%.3f', position.Z)
                                }
                            };
                            macro.cache.length = macro.cache.length + 1;
                            macro.cache.tables[tostring(macro.cache.length)] = data;
                        end
                    end
                end
                setnamecallmethod(method);
            end
        end
        return OldFireServer(...);
    end))
end

function loadScriptSaved()
    local fileName = 'Lemonade/AnimeAdventures/'..LocalPlayer.Name..'.json';
    if (isfile(fileName)) then
        local jsonString = readfile(fileName);
        if (jsonString and (jsonString ~= '')) then
            ScriptSaved = HttpService:JSONDecode(jsonString);
        end
    end
end

function saveScriptSaved()
    local jsonString = HttpService:JSONEncode(ScriptSaved);
    if (jsonString and jsonString ~= 'null') then
        writefile('Lemonade/AnimeAdventures/'..LocalPlayer.Name..'.json', jsonString);
    end
end

function endswith(str, ending)
    return ending == "" or string.sub(str, -string.len(ending)) == ending
end

function loadMacro()
    if not (isfile('Lemonade\\AnimeAdventures\\Macros')) then
        makefolder('Lemonade\\AnimeAdventures\\Macros');
    end
    local files = listfiles('Lemonade\\AnimeAdventures\\Macros');

    for i, element in pairs (files) do
        if (endswith(element, '.json')) then
            local newString = element:gsub('Lemonade\\AnimeAdventures\\Macros\\', ''):gsub('.json', '');
            table.insert(macro.macros, newString);
        end
    end
end

function onJoinEvent()
    if (ScriptSaved.join['madoka-portal'].enable) then
        local portal = inventory.filterMadokaPortal({
            ['ignore-tier'] = ScriptSaved.join['madoka-portal']['ignore-tier'],
            ['ignore-challenge'] = ScriptSaved.join['madoka-portal']['ignore-challenge'],
            ['ignore-buff'] = ScriptSaved.join['madoka-portal']['ignore-buff']
        });
        if (portal) then
            features.join = true;
            handlers.onUsePortal(portal['uuid'], true);
            local lobby_id = functions.findLobbyOwner(LocalPlayer);
            if (lobby_id and (lobby_id ~= '')) then
                wait(0.25);
                handlers.onRequestStartGame(lobby_id);
            else
                features.join = false;
            end
        end
    end
end

function checkWave(wave, time)
    if (wave < functions.getWave()) then
        return true;
    end
    if (wave == functions.getWave() and (time >= functions.getWaveTime())) then
        return true;
    end
    return false;
end

function onPlayMacro()
    local json_cache = readfile('Lemonade\\AnimeAdventures\\Macros\\'..ScriptSaved.macro.select..'.json');
    if (json_cache) and (json_cache ~= '') and (json_cache ~= '{}') then
        local macro_cache = HttpService:JSONDecode(json_cache);
        if (macro_cache) then
            features['playing-macro'] = true;
            
            local stream_index = 1;
            while((features['playing-macro']) and (task.wait(0.1))) do
                if not (ScriptSaved.macro.play) then
                    features['playing-macro'] = false;
                    break;
                end
                local macro_data = macro_cache[tostring(stream_index)];
                if (macro_data) then
                    local types = macro_data['type'];
                    local unit_id = macro_data['unit-id'];
                    local position = macro_data['position'];
    
                    local wave = macro_data['wave'];
                    local time = macro_data['time'];
    
                    local current_money = numbers.format('%.0f', functions.getMoneyInGame());
    
                    local unit_data = functions.getDataUnit(unit_id);
                    
                    local cost_scale = functions.getCostScale();
    
                    if (types == 'spawn_unit') then
                        local unit = inventory.getEquippedUnit(unit_id);
    
                        if (unit) and (current_money >= numbers.format('%.0f', unit_data.cost*cost_scale)) and (checkWave(wave, time)) then
                            handlers.onSpawnUnitInGame(unit['uuid'], position);
                            stream_index += 1;
                        end
                    elseif (types == 'upgrade_unit') then
                        local model = functions.findModel(unit_id, position);
    
                        if (model) then
                            local current_upgrade = functions.getUpgradeStage(model);
                            local unit_upgrade_scale = functions.getUnitUpgradeScale(model);
                            
                            local upgrade_stage = unit_data.upgrade[current_upgrade+1];

                            if (upgrade_stage) then
                                local cost = unit_data.upgrade[current_upgrade+1].cost;
                                if (current_money >= numbers.format('%.0f', (cost*cost_scale*unit_upgrade_scale))) and (checkWave(wave, time)) then
                                    handlers.onUpgradeUnitInGame(model);
                                    stream_index += 1;
                                end
                            else
                                stream_index += 1;
                            end
                        else
                            print('upgrade-failed');
                            print('model:', model);
                            print('unit-id:', unit_id);
                            print('stream:', stream_index);
                        end
                    elseif (types == 'sell_unit') then
                        local model = functions.findModel(unit_id, position);
    
                        if (model) and (checkWave(wave, time)) then
                            handlers.onSellUnitInGame(model);
                            stream_index += 1;
                        end
                    end
                end
            end
        end
    else
        notify('Warning', 'Macro "'..ScriptSaved.macro.select..'" is empty', 1.5);
    end
end

local function onFinished()
    if (ScriptSaved.join['madoka-portal'].replay) then
        local level_data = functions.getLevelData();
        if (level_data['portal_group'] == 'madoka') then
            local portal = inventory.filterMadokaPortal({
                ['ignore-tier'] = ScriptSaved.join['madoka-portal']['ignore-tier'],
                ['ignore-challenge'] = ScriptSaved.join['madoka-portal']['ignore-challenge'],
                ['ignore-buff'] = ScriptSaved.join['madoka-portal']['ignore-buff']
            });
            if (portal) then
                features.replay = true;

                local args = {
                    [1] = 'replay',
                    [2] = {
                        ['item_uuid'] = portal['uuid']
                    }
                }

                wait(5);
                handlers.onFinishedVote(unpack(args));
                coroutine.wrap(function()
                    wait(180);
                    --game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
                end)()
                return;
            end
        end
    end
    wait(5);
    game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
end

function onEvents()
    game:GetService('NetworkClient').ChildRemoved:Connect(function()
        saveScriptSaved();

        local CoreGui = game:GetService('CoreGui');

        print(tables.containsStringValue(CoreGui.RobloxPromptGui.promptOverlay:GetChildren(), 'ErrorPrompt'));

        if (tables.containsStringValue(CoreGui.RobloxPromptGui.promptOverlay:GetChildren(), 'ErrorPrompt')) then
            game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
        end
    end);
end

local ScriptCore = coroutine.create(function()
    while(task.wait(0.1)) do
        if not (functions.isLobby()) and not (functions.isGameStarted()) then
            handlers.onVoteStart();
        end

        if not (functions.isLobby()) and (functions.isGameStarted()) then
            local timings = coroutine.create(function()
                while(wait(0.2)) do
                    local wave = functions.getWave() and functions.getWave() or 'nothing';
                    local time = functions.getWaveTime() and functions.getWaveTime() or 'nothing';

                    Elements['MacroTimings']:updateTextLabel(Elements['MacroTimings-Wave'], nil, tostring(wave));
                    Elements['MacroTimings']:updateTextLabel(Elements['MacroTimings-Time'], nil, tostring(time));
                end
            end)
            if (coroutine.status(timings) ~= 'running') then
                coroutine.resume(timings);
            end
        end

        if not (features.join) and (functions.isLobby()) then
            coroutine.wrap(onJoinEvent)();
        end

        if (ScriptSaved.macro.play) and not (features['playing-macro']) and not (functions.isLobby()) and not (functions.isGameFinished()) then
            coroutine.wrap(onPlayMacro)();
        end

        if not (features.replay) and not (functions.isLobby()) and (functions.isGameFinished()) and (game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled) then
            coroutine.wrap(onFinished)();
        end
    end
end)

function onEnable()
    loadScriptSaved();
    loadMacro();
    onCreateGUI();
    remoteHandler();
    onEvents();

    Elements['GUI']:SelectPage(Elements['GUI'].pages[1], true);

    coroutine.resume(ScriptCore);
end

coroutine.wrap(onEnable)();