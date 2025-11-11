local Serializer = {}

function Serializer.serialize(t, indent)
    indent = indent or ""
    local result = "{\n"
    for key, value in pairs(t) do
        local key_str = key
        local value_str = value
        if type(value) == "string" then
            value_str = '"' .. value .. '"'
        end

        result = result .. indent .. "  " .. key_str .. " = " .. value_str .. ",\n"
    end
    result = result:sub(1, -2)
    result = result .. "\n" .. indent .. "}"
    return result
end

function Serializer.deserialize(str)
    local func = load("return " .. str)
    if not func then return end
    return func()
end

return Serializer