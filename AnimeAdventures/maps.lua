local modules = {};

modules.prioritize_maps = {
    ['namek'] = 1,
    ['aot'] = 2,
    ['demonslayer'] = 3,
    ['naruto'] = 4,
    ['marineford'] = 5,
    ['tokyo_ghoul'] = 6,
    ['hueco'] = 7,
    ['hxhant'] = 8,
    ['magnolia'] = 9,
    ['jjk'] = 10,
    ['clover'] = 11,
    ['jojo'] = 12,
    ['opm'] = 13,
    ['7ds'] = 14,
    ['mha'] = 15,
    ['dressrosa'] = 16,
    ['sao'] = 17
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