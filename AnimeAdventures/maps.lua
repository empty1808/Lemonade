local modules = {};

modules.maps = {
    ['Planet Namak'] = {
        id = 'namek'
    },
    ['Shinganshinu District'] = {
        id = 'aot'
    },
    ['Snowy Town'] = {
        id = 'demonslayer'
    },
    ['Hidden Sand Village'] = {
        id = 'naruto'
    },
    ["Marine's Ford"] = {
        id = 'marineford'
    },
    ['Ghoul City'] = {
        id = 'tokyoghoul'
    },
    ['Hollow World'] = {
        id = ''
    },
    ['Ant Kingdom'] = {
        id = ''
    },
    [''] = {
        id = ''
    },
    [''] = {
        id = ''
    },
    [''] = {
        id = ''
    },
    [''] = {
        id = ''
    },
    [''] = {
        id = ''
    },
    [''] = {
        id = ''
    },
}

function modules.get(key)
    if (modules.maps[key]) then
        return modules.maps[key];
    end
end

function modules.getMaps()
    local list = {}
    for k, _ in pairs (modules.maps) do
        table.insert(list, k);
    end
    return list;
end

return modules;