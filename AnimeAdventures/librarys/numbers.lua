local numbers = {};

function numbers.format(format, number)
    return tonumber(string.format(format, number));
end

return numbers;