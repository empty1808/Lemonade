local HttpService = game:GetService("HttpService");
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/AnimeAdventures/VenyxUI.lua'))();

local librarys = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/AnimeAdventures/librarys.lua'))();

local maps = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/AnimeAdventures/maps.lua'))();
local inventory = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/AnimeAdventures/inventory.lua'))();
local handlers = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/AnimeAdventures/handlers.lua'))();
local game_data = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/AnimeAdventures/game_data.lua'))();
local level_data = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/AnimeAdventures/level_data.lua'))();

local functions = librarys.functions;
local portals = librarys.portals;

local strings = librarys.strings;
local tables = librarys.tables;
local numbers = librarys.numbers;

local LocalPlayer = game.Players.LocalPlayer;

local ScriptSaved = {
    ['main'] = {
        ['default'] = {
            ['enable'] = false,
            ['selected'] = nil,
            ['stage'] = nil,
            ['difficult'] = nil,
            ['replay'] = false
        },
        ['portal'] = {
            ['enable'] = false,
            ['selected'] = {},
            ['replay'] = false
        },
        ['tier-portal'] = {
            ['enable'] = false,
            ['selected'] = {},
            ['ignore-tier'] = {},
            ['ignore-challenge'] = {},
            ['replay'] = false
        },
        ['misc'] = {
            ['auto-leave'] = false,
            ['auto-stack-wendy'] = false,
            ['auto-stack-erwin'] = false
        }
    },
    ['lobby'] = {
        ['delete-tier-portals'] = {
            ['enable'] = false,
            ['selected'] = {},
            ['tier'] = {},
            ['challenge'] = {}
        },

    },
    ['macro'] = {
        ['select'] = nil,
        ['infinite_tower'] = {}
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
    ['playing-macro'] = false,
    ['stack-wendy'] = {
        enabled = false,
        models = {};
    },
    ['stack-erwin'] = {
        enabled = false,
        models = {};
    },
    ['stack-leafa_evolved'] = {
        enabled = false,
        models = {};
    }
}

local Elements = {};

function onCreateGUI()
    Elements['GUI'] = library.new('Lemonade [Anime Adventures]', 5013109572);

    Elements['MainPage'] = Elements['GUI']:addPage('Main', 13630055077);
    Elements['LobbyPage'] = Elements['GUI']:addPage('Lobby');
    Elements['MacroPage'] = Elements['GUI']:addPage('Macro', 5012544693);
    Elements['TimingsPage'] = Elements['GUI']:addPage('Timings');
    Elements['SettingPage'] = Elements['GUI']:addPage('Settings', 13710659541);

    onMainPage(Elements['MainPage']);
    onLobbyPage(Elements['LobbyPage']);
    onMacroPage(Elements['MacroPage']);
    onSettingPage(Elements['SettingPage']);
end

function onMainPage(page)
    --local Raid = page:addSection('Raid');
    --local Dungeon = page:addSection('Dungeon');
    --local Challenge = page:addSection('Challenge');

    onDefault(page:addSection('Default'));
    onPortal(page:addSection('Portal'));
    onTierPortal(page:addSection('Tier Portal'));
    onMiscSection(page:addSection('Misc'));
end

function onDefault(section)
    section:addToggle('Enable', ScriptSaved.main.default.enable, function(toggle)
        ScriptSaved.main.default.enable = toggle;
    end)
    section:addDropdown('selected', game_data.getInfiniteWorldId(), nil, function(text)
        
    end)
    section:addDropdown('stage', {'infinite', 'act-1', 'act-2', 'act-3', 'act-4', 'act-5', 'act-6'}, nil, function(selected)
        print(selected)
    end)
    section:addDropdown('difficult', {'easy', 'hard'}, nil, function(selected)
        
    end)
    section:addToggle('Next/Replay', ScriptSaved.main.default.replay, function(toggle)
        ScriptSaved.main.default.replay = toggle;
    end)
end

function onPortal(section)
    local portals_name = tables.getIf(portals.getSinglePortals(), function(element)
        return element.name;
    end);
    local features = ScriptSaved.main['portal'];
    section:addToggle('Enable', features['enable'], function(toggle)
        ScriptSaved.main['portal'].enable = toggle;
    end)
    local selected = section:addSelectDropdown('Select', portals_name, features['selected'], function(selected)
        ScriptSaved.main['portal']['selected'] = selected;
    end)
    local replay = section:addToggle('Replay', features['replay'], function(toggle)
        ScriptSaved.main['portal'].replay = toggle;
    end)
end

function onTierPortal(section)
    local portals_name = tables.getIf(portals.getTierPortals(), function(element)
        return element.name;
    end);
    local Features = ScriptSaved.main['tier-portal'];
    local Enable = section:addToggle('Enable', Features.enable, function(toggle)
        ScriptSaved.main['tier-portal'].enable = toggle;
    end)
    local selected = section:addSelectDropdown('Select', portals_name, features['selected'], function(selected)
        ScriptSaved.main['tier-portal']['Selected'] = selected;
    end)
    local Tier = section:addSelectDropdown('Ign Tier', {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}, Features['ignore-tier'], function(selected)
        ScriptSaved.main['tier-portal']['ignore-tier'] = selected;
    end)
    local Challenge section:addSelectDropdown('Ign Challenge', {'tank_enemies', 'fast_enemies', 'shield_enemies', 'regen_enemies', 'short_range', 'high_cost'}, Features['ignore-challenge'], function(selected)
        ScriptSaved.main['tier-portal']['ignore-challenge'] = selected;
    end)
    local Replay = section:addToggle('Replay', Features.replay, function(toggle)
        ScriptSaved.main['tier-portal'].replay = toggle;
    end)
end

function onMiscSection(section)
    section:addToggle('Auto leave', ScriptSaved.main.misc['auto-leave'], function(toggle)
        ScriptSaved.main.misc['auto-leave'] = toggle;
    end)

    section:addToggle('Auto Wenda', ScriptSaved.main.misc['auto-wendy'], function(toggle)
        ScriptSaved.main.misc['auto-wendy'] = toggle;
        if not (toggle) then 
            features['stack-wendy'].enabled = false;
        end
    end)

    section:addToggle('Auto Orwin', ScriptSaved.main.misc['auto-erwin'], function(toggle)
        ScriptSaved.main.misc['auto-erwin'] = toggle;
        if not (toggle) then 
            features['stack-erwin'].enabled = false;
        end
    end)

    section:addToggle('Auto Leafy', ScriptSaved.main.misc['auto-leafa_evolved'], function(toggle)
        ScriptSaved.main.misc['auto-leafa_evolved'] = toggle;
        if not (toggle) then 
            features['stack-leafa_evolved'].enabled = false;
        end
    end)

    section:addToggle('Teleport to Top [FPS Boost]', ScriptSaved.main.misc['teleport-to-top'], function(toggle)
        ScriptSaved.main.misc['teleport-to-top'] = toggle;
        if not (toggle) then
            features['teleport-to-top'] = false;
        end
    end)
end

function onLobbyPage(page)
    local Misc = page:addSection('Misc');
    Misc:addButton('back to lobby', function()
        game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
    end);
    local AutoDeleteTierPortals = page:addSection('Auto Delete Tier Portals');
    onAutoDeleteTierPortals(AutoDeleteTierPortals);
end

function onAutoDeleteTierPortals(section)
    local portals_name = tables.getIf(portals.getTierPortals(), function(element)
        return element.name;
    end);
    
    local Features = ScriptSaved.lobby['delete-tier-portals'];
    local Enable = section:addToggle('Enable', Features.enable, function(toggle)
        ScriptSaved.lobby['delete-tier-portals'].enable = toggle;
    end)
    local Selected = section:addSelectDropdown('Select', portals_name, Features['selected'], function(selected)
        ScriptSaved.lobby['delete-tier-portals'].selected = selected;
    end)
    local Tier = section:addSelectDropdown('Tier', {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}, Features['tier'], function(selected)
        ScriptSaved.lobby['delete-tier-portals']['tier'] = selected;
    end)
    local Challenge section:addSelectDropdown('Challenge', {'tank_enemies', 'fast_enemies', 'shield_enemies', 'regen_enemies', 'short_range', 'high_cost'}, Features['challenge'], function(selected)
        ScriptSaved.lobby['delete-tier-portals']['challenge'] = selected;
    end)
end

function onMacroPage(page)
    Elements['MacroSystem'] = page:addSection('System');
    Elements['CastleMacros'] = page:addSection('Castle Macros');
    Elements['MacroTimings'] = page:addSection('Macro Timings');

    onMacroSystem(Elements['MacroSystem']);
    onCastleMacros(Elements['CastleMacros']);
    onMacroTimings(Elements['MacroTimings']);
end

function onMacroSystem(section)
    local modules = {};
    modules['create'] = section:addTextbox('create', '', function(text, focusLost)
        if (focusLost) then
            if (text == '') then
                return
            end
            if not (librarys.tables.containsValue(macro.macros, text)) then
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

    modules['clean-up'] = section:addButton('clean-up macro', function()
        if (ScriptSaved.macro.select) then
            writefile('Lemonade\\AnimeAdventures\\Macros\\'..ScriptSaved.macro.select..'.json', '{}');
            notify('Notification', 'Macro "'..ScriptSaved.macro.select..'" has been cleaned up.', 1.5);
        end
    end)

    modules['remove'] = section:addButton('remove macro', function()
        if (ScriptSaved.macro.select) then
            delfile('Lemonade\\AnimeAdventures\\Macros\\'..ScriptSaved.macro.select..'.json');
            librarys.tables.remove(macro.macros, ScriptSaved.macro.select);
            ScriptSaved.macro.select = nil;
            section:updateDropdown(modules['select'], nil, nil, 'nil');
            notify('Notification', 'Macro "'..ScriptSaved.macro.select..'" has been removed.', 1.5)
        end
    end)

    modules['record'] = section:addToggle('record', false, function(toggle)
        if (toggle) and (functions.isLobby()) then
            section:updateToggle(modules['record'], 'record', false);
            notify('Warning', 'You cant record macro in lobby.', 1.5);
            return;
        end
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
        if (readfile('Lemonade\\AnimeAdventures\\Macros\\'..ScriptSaved.macro.select..'.json') ~= '{}') then
            section:updateToggle(modules['record'], 'record', false);
            notify('Warning', 'Macro "'..ScriptSaved.macro.select..'" not empty.', 1.5)
            return;
        end
        notify('Notification', 'Recording macro "'..ScriptSaved.macro.select..'".', 1.5);
        macro.record = toggle;
    end)

    modules['play'] = section:addToggle('Play', ScriptSaved.macro.play, function(toggle)
        if (toggle) and not (ScriptSaved.macro.select) then
            section:updateToggle(modules['play'], 'Play', false);
            notify('Warning', 'You have not selected macro.', 1.5);
            return
        end
        ScriptSaved.macro.play = toggle;
    end)
end

function onCastleMacros(section)
    local worlds = game_data.getWorlds();
    local properties = {
        TitleSize = UDim2.new(0.38, 0, 0, 30),
        ContainerPosition = UDim2.new(0.4, 0, 0, 0),
        ContainerSize = UDim2.new(0.6, 0, 1, 0)
    }
    for k, v in pairs (game_data.getInfiniteWorldId()) do
        section:addCustomDropdown(properties, worlds[v].name, macro.macros, ScriptSaved.macro.infinite_tower[v], function(text)
            ScriptSaved.macro.infinite_tower[v] = text;
        end)
    end
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
    section:addKeybind('Toggle Keybind', Enum.KeyCode.RightBracket, function()
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
                            local position = model._shadow.CFrame;
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
            --ScriptSaved = HttpService:JSONDecode(jsonString);
            librarys.tables.copyElement(ScriptSaved, HttpService:JSONDecode(jsonString));
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

function onAutoDeleteTierPortalsEvent()
    local results = {};
    if (ScriptSaved.lobby['delete-tier-portals'].enable) and (tables.getLength(ScriptSaved.lobby['delete-tier-portals'].selected) > 0) then
        for _, portal_name in pairs (ScriptSaved.lobby['delete-tier-portals'].selected) do
            local portal_info = portals.getByName(portal_name);
            local portals = inventory.filterTierPortals(portal_info.id, {
                ['tier'] = ScriptSaved.lobby['delete-tier-portals']['tier'],
                ['challenge'] = ScriptSaved.lobby['delete-tier-portals']['challenge'],
            })
            if (portals) then
                for k, v in pairs (portals) do
                    table.insert(results, v['uuid']);
                end
            end
            if (#results > 0) then
                handlers.onDeleteUniqueItems(results);
            end
        end
    end
end

local function onJoinPortal(uuid)
    features.main = true;
    handlers.onUsePortal(uuid, true);
    local lobby_id = functions.findLobbyOwner(LocalPlayer);
    if (lobby_id and (lobby_id ~= '')) then
        wait(0.25);
        handlers.onRequestStartGame(lobby_id);
    else
        features.main = false;
    end
    wait(60);
    features.main = false;
end

function onJoinEvent()
    if (ScriptSaved.main['portal'].enable) and (tables.getLength(ScriptSaved.main['portal'].selected) > 0) then
        for _, portal_name in pairs (ScriptSaved.main['portal'].selected) do
            local portal_info = portals.getByName(portal_name);
            local portal = inventory.getUniqueItemIf(function(item)
                return item.item_id == portal_info.id;
            end)
            if (portal) then
                onJoinPortal(portal.uuid);
            end
        end
    end
    if (ScriptSaved.main['tier-portal'].enable) and (tables.getLength(ScriptSaved.main['tier-portal'].selected) > 0) then
        for _, portal_name in pairs (ScriptSaved.main['tier-portal'].selected) do
            local portal_info = portals.getByName(portal_name);
            local portal = inventory.filterIgnorePortal(portal_info.id, {
                ['ignore-tier'] = ScriptSaved.main['tier-portal']['ignore-tier'],
                ['ignore-challenge'] = ScriptSaved.main['tier-portal']['ignore-challenge']
            });
            if (portal) then
                onJoinPortal(portal.uuid);
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
    local _gamemode = level_data.getGamemode();
    local _world = level_data.getWorld();

    local _waves = level_data.getData().waves;

    local local_macro;

    if (_waves) and (strings.contains(_waves, '_infinite')) then
        local_macro = ScriptSaved.macro['infinite_tower'][strings.replace(_waves, '_infinite', '')];
    end

    if (ScriptSaved.macro[_gamemode]) then
        local_macro = ScriptSaved.macro[_gamemode][_world];
    end

    local _macro_playing = local_macro and local_macro or ScriptSaved.macro.select;

    if (_macro_playing) then
        local json_cache = readfile('Lemonade\\AnimeAdventures\\Macros\\'.._macro_playing..'.json');
        if (json_cache) and (json_cache ~= '') and (json_cache ~= '{}') then
            local macro_cache = HttpService:JSONDecode(json_cache);
            if (macro_cache) then
                features['playing-macro'] = true;
                notify('Notification', 'Playing macro "'.._macro_playing..'".', 1.5);
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
                                print('position:', '{x='..position.x..',y='..position.y..',z='..position.z..'}');
                                print('stream:', stream_index);
                            end
                        elseif (types == 'sell_unit') then
                            local model = functions.findModel(unit_id, position);
        
                            if (model) and (checkWave(wave, time)) then
                                handlers.onSellUnitInGame(model);
                                stream_index += 1;
                            end
                        end
                    else
                        stream_index += 1;
                    end
                end
            end
        else
            notify('Warning', 'Macro "'.._macro_playing..'" is empty', 1.5);
        end
    end
end

local function onReplayPortal(uuid)
    features.replay = true;

    local args = {
        [1] = 'replay',
        [2] = {
            ['item_uuid'] = uuid
        }
    }

    wait(5);
    handlers.onFinishedVote(unpack(args));
    
    coroutine.wrap(function()
        wait(900);
        game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
    end)()
end

function onFinished()
    local _gamemode = level_data.getGamemode();

    if (_gamemode == 'story') and (ScriptSaved.main.default.replay) then
        local ResultsUI = librarys.LocalPlayer.PlayerGui.ResultsUI;
        features.replay = true;
        if (ResultsUI.Finished.NextLevel.Visible) then

        else
            local args = {
                [1] = 'replay'
            }

            wait(10);
            handlers.onFinishedVote(unpack(args));
            coroutine.wrap(function()
                wait(900);
                game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
            end)()
            return;
        end
    end

    if (_gamemode == 'infinite') and (ScriptSaved.main.default.replay) then
        local ResultsUI = librarys.LocalPlayer.PlayerGui.ResultsUI;
        features.replay = true;
        if (ResultsUI.Finished.NextLevel.Visible) then
            
        else
            local args = {
                [1] = 'replay'
            }

            wait(10);
            handlers.onFinishedVote(unpack(args));
            coroutine.wrap(function()
                wait(900);
                game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
            end)()
            return;
        end
    end

    if (ScriptSaved.main['portal'].replay) then
        if (tables.getLength(ScriptSaved.main['portal'].selected) > 0) then
            for _, displayname in pairs (ScriptSaved.main['portal'].selected) do
                local portal_info = portals.getByName(displayname);
                local portal = inventory.getUniqueItemIf(function(item)
                    return item.item_id == portal_info.id;
                end)
                if (portal) then
                    onReplayPortal(portal.uuid);
                end
            end
        end
    end

    if (ScriptSaved.main['tier-portal'].replay) then
        if (tables.getLength(ScriptSaved.main['portal'].selected) > 0) then
            for _, displayname in pairs (ScriptSaved.main['tier-portal'].selected) do
                local portal_info = portals.getByName(displayname);
                local portal = inventory.filterIgnorePortal(portal_info.id, {
                    ['ignore-tier'] = ScriptSaved.main['tier-portal']['ignore-tier'],
                    ['ignore-challenge'] = ScriptSaved.main['tier-portal']['ignore-challenge']
                });
                if (portal) then
                    onReplayPortal(portal.uuid);
                end
            end
        end
    end
    if (ScriptSaved.main.misc['auto-leave']) then
        wait(5);
        game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
    end
end

function onEvents()
    game:GetService('NetworkClient').ChildRemoved:Connect(function()
        saveScriptSaved();

        local CoreGui = game:GetService('CoreGui');

        if (librarys.tables.containsStringValue(CoreGui.RobloxPromptGui.promptOverlay:GetChildren(), 'ErrorPrompt')) then
            game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
        end
    end);
end

function onUseActive()
    if (ScriptSaved.main.misc['auto-wendy']) then
        onAbility('wendy');
    end
    if (ScriptSaved.main.misc['auto-erwin']) then
        onAbility('erwin');
    end
    if (ScriptSaved.main.misc['auto-leafa_evolved']) then
        onAbility('leafa_evolved');
    end
end

function onAbility(uuid)
    if (ScriptSaved.main.misc['auto-'..uuid]) then
        local abilitys = {}
        repeat task.wait() until game.Workspace:WaitForChild("_UNITS");
        for k, v in pairs (game.Workspace['_UNITS']:GetChildren()) do
            if (v:FindFirstChild('_stats')) and (tostring(v._stats.player.Value) == LocalPlayer.Name) then
                if (v._stats.id.Value == uuid) then
                    table.insert(abilitys, v);
                end
            end
        end
        if (#abilitys < 4) and (features['stack-'..uuid].enabled) then
            features['stack-'..uuid].enabled = false;
        end
        if (#abilitys >= 4) and not (features['stack-'..uuid].enabled) then
            features['stack-'..uuid].enabled = true;
            coroutine.wrap(onStackBuffs)(uuid, abilitys);
        end
    end
end

local function onUseBuffs(buffs)
    handlers.onUseActive(buffs[1]);
    task.wait(2);
    handlers.onUseActive(buffs[2]);
end

function onStackBuffs(uuid, buffs)
    print((features['stack-'..uuid].enabled));
    while(ScriptSaved.main.misc['auto-'..uuid] and (features['stack-'..uuid].enabled)) do 
        boolean = not boolean;
        local success = pcall(onUseBuffs, (boolean and {buffs[1], buffs[2]} or {buffs[3], buffs[4]}));
        if not (success) then
            return;
        end
        task.wait(28);
    end
end

local ScriptCore = coroutine.create(function()
    while(task.wait(0.15)) do
        if not (functions.isLobby()) and not (functions.isGameStarted()) then
            handlers.onVoteStart();
        end

        if not (functions.isLobby()) and (functions.isGameStarted()) and not (features['teleport-to-top']) and (ScriptSaved.main.misc['teleport-to-top']) then
            features['teleport-to-top'] = true;
            functions.teleportTop();
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

        if (functions.isLobby()) then
            if (ScriptSaved.lobby['delete-tier-portals'].enable) then
                onAutoDeleteTierPortalsEvent();
            end
        end

        if not (features.main) and (functions.isLobby()) then
            coroutine.wrap(onJoinEvent)();
        end

        if (ScriptSaved.macro.play) and not (features['playing-macro']) and not (functions.isLobby()) and not (functions.isGameFinished()) then
            coroutine.wrap(onPlayMacro)();
        end

        if not (features.replay) and not (functions.isLobby()) and (functions.isGameFinished()) and (game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled) then
            coroutine.wrap(onFinished)();
        end

        if not (functions.isLobby()) then
            coroutine.wrap(onUseActive)();
        end
    end
end)

function onEnable()
    print('Script core loading... [Lemonade]')
    loadScriptSaved();
    loadMacro();
    onCreateGUI();
    remoteHandler();
    onEvents();

    Elements['GUI']:SelectPage(Elements['GUI'].pages[1], true);

    coroutine.resume(ScriptCore);
    print('Script core loaded! [Lemonade]')
end

coroutine.wrap(onEnable)();