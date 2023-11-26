local tables = loadstring(game:HttpGet('https://raw.githubusercontent.com/empty1808/Lemonade/main/AnimeAdventures/librarys/tables.lua'))();

if not (getgenv()['Lemonade']) then
    getgenv()['Lemonade'] = {
        executes = false;
    }
end

if not (getgenv()['Lemonade'].executes) then
    getgenv()['Lemonade'].executes = true;

    repeat wait() until game:IsLoaded();
    repeat wait() until game:GetService('Players').LocalPlayer;
    repeat wait() until game:GetService('Players').LocalPlayer:HasAppearanceLoaded();

    local LocalPlayer = game:GetService('Players').LocalPlayer;
    local CoreGui = game:GetService('CoreGui');

    LocalPlayer.OnTeleport:Connect(function(state)
        if state == Enum.TeleportState.InProgress then
            queue_on_teleport([[
                loadstring(readfile('Lemonade\\AnimeAdventures\\Loader.lua'))();
            ]])
        elseif state == Enum.TeleportState.Failed then
            wait(2.5);
            game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
        end
    end)

    LocalPlayer.Idled:connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame);
        wait(1);
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame);
    end);

    if (tables.containsStringValue(CoreGui.RobloxPromptGui.promptOverlay:GetChildren(), 'ErrorPrompt')) then
        game:GetService('TeleportService'):Teleport(8304191830, LocalPlayer);
    end

    loadstring(readfile('Lemonade\\AnimeAdventures\\script.lua'))();
end