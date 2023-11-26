local tables = {}

function tables.containsKey(table, key)
    if not (table) then
        return false;
    end
    for k, _ in pairs (table) do
        if (k == key) then
            return true;
        end
    end
    return false;
end

function tables.containsValue(table, value)
    if not (table) then
        return false;
    end
    for _, v in pairs (table) do
        if (v == value) then
            return true;
        end
    end
    return false;
end

function tables.containsStringValue(table, value)
    if not (table) then
        return false;
    end
    for _, v in pairs (table) do
        if (tostring(v) == value) then
            return true;
        end
    end
    return false;
end

function tables.replace(table, value, replaced)
    if not (table) then
        return;
    end
    for k, v in pairs (table) do
        if (v == value) then
            table[k] = replaced;
        end
    end
end

function tables.remove(table, value)
    if not (table) then
        return;
    end
    for k, v in pairs (table) do
        if (v == value) then
            table[k] = nil;
        end
    end
end

function tables.copyElement(table, copyTable) 
    if not (table) then
        return table;
    end
    for k, v in pairs (copyTable) do
        if (typeof(v) == 'table') then
            if not (table[k]) then
                table[k] = {};
            end
            tables.copyElement(table[k], v);
        else
            table[k] = v;
        end
    end
    return table;
end

function tables.getLength(table)
    local length = 0;
    for k,_ in pairs (table) do
        length+=1;
    end
    return length;
end

function tables.filter(original, condition)
    local results = {};
    for i, element in pairs (original) do
        local insert = condition and condition(element) or false;
        if (insert and (insert == true)) then
            results[i] = element;
        end
    end
    return results;
end

function tables.getIf(original, condition)
    local results = {};
    for i, element in pairs (original) do
        table.insert(results, condition and condition(element) or false);
    end
    return results;
end

function tables.print(original)
    if (type(original) ~= 'table') then
        print(original);
        return;
    end
    print('=================================== [Handlers] ===================================');
    for k, v in pairs (original) do
        print(tostring(k)..' | '..tostring(v));
    end
    print('==================================================================================')
end

return tables;