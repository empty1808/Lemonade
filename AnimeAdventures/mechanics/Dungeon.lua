local modules = {};

local Dungeons = {
    ['nightmare_hunt'] = {
        avaliable = true,
        name = 'Nightmare Hunt',
        lobby_id = '_lobbytemplate_event321',
        match = true
    },
    ['cursed_parade'] = {
        avaliable = true,
        name = 'Cursed Parade',
        lobby_id = '_lobbytemplate_event23',
        key = 'key_jjk_map'
    },
    ['cursed_womb'] = {
        avaliable = true,
        name = 'Cursed Womb',
        lobby_id = '_lobbytemplate_event222',
        key = 'key_jjk_finger'
    }
};

function modules.getDungeons()
    return Dungeons;
end

return modules;
