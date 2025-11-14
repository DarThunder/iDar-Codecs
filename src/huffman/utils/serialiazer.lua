local Serializer = {}

function Serializer.serialize(value)
    if type(value) == "table" then
        local result = "{"
        local first = true

        local keys = {}
        for k in pairs(value) do
            table.insert(keys, k)
        end

        table.sort(keys, function(a, b)
            return tostring(a) < tostring(b)
        end)

        for _, k in ipairs(keys) do
            local v = value[k]
            if not first then
                result = result .. ","
            end
            first = false
            if type(k) == "string" then
                result = result .. '"' .. k .. '":'
            else
                result = result .. '"' .. tostring(k) .. '":'
            end
            result = result .. Serializer.serialize(v)
        end
        result = result .. "}"
        return result
    elseif type(value) == "string" then
        return '"' .. value .. '"'
    elseif type(value) == "number" or type(value) == "boolean" then
        return tostring(value)
    else
        return nil
    end
end

local readValue

function Serializer.deserialize(json)
    local pos = 1

    local function nextChar()
        local c = json:sub(pos, pos)
        pos = pos + 1
        return c
    end

    local function skipWhitespace()
        while true do
            local c = json:sub(pos, pos)
            if c == " " or c == "\t" or c == "\n" or c == "\r" then
                nextChar()
            else
                break
            end
        end
    end

    local function readString()
        local str = ""
        nextChar()
        while true do
            local c = nextChar()
            if c == '"' then
                break
            elseif c == "\\" then
                local nextC = nextChar()
                if nextC == '"' then
                    str = str .. '"'
                elseif nextC == "\\" then
                    str = str .. '\\'
                else
                    str = str .. nextC
                end
            else
                str = str .. c
            end
        end
        return str
    end

    local function readNumber()
        local num = ""
        while true do
            local c = json:sub(pos, pos)
            if c:match("%d") or c == "." then
                num = num .. c
                pos = pos + 1
            else
                break
            end
        end
        return tonumber(num)
    end

    local function readBoolean()
        local bool = json:sub(pos, pos + 3) == "true" and true or false
        pos = pos + (bool and 4 or 5)
        return bool
    end

    local function readTable()
        local tbl = {}
        nextChar()
        while true do
            skipWhitespace()
            local c = json:sub(pos, pos)
            if c == "}" then
                nextChar()
                break
            end

            local key = readString()
            skipWhitespace()
            nextChar()
            skipWhitespace()
            local value = readValue()

            tbl[key] = value

            skipWhitespace()
            c = json:sub(pos, pos)
            if c == "," then
                nextChar()
            end
        end
        return tbl
    end

    function readValue()
        skipWhitespace()
        local c = json:sub(pos, pos)
        if c == "{" then
            return readTable()
        elseif c == "\"" then
            return readString()
        elseif c:match("%d") then
            return readNumber()
        elseif c == "t" or c == "f" then
            return readBoolean()
        else
            error("Unspected character: " .. c)
        end
    end

    return readValue()
end

return Serializer