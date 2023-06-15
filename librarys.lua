local librarys = {};

local url = 'https://raw.githubusercontent.com/empty1808/Lemonade/main/';

function librarys.requires(library)
    return loadstring(game:HttpGet(url..library))();
end


return librarys;