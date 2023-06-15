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

return tables;