local modules = {};

function modules.getData() 
    return game.ReplicatedStorage.src.Data;
end

function modules.require(original)
    if (type(original) == 'string') then
        local object = modules.getData()[original];
        if (object) then
            return require(object);
        end
    end
    if (typeof(original) == 'Instance') then
        if (original.ClassName == 'ModuleScript') then
            return require(original);
        end
    end
end

return modules;