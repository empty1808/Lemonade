local modules = {};

function modules.replace(original, search, replacement)
    return string.gsub(original, search, replacement);
end

function modules.contains(original, search)
    return string.match(original, search) ~= nil;
end

return modules;