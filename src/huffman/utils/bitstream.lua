local BitStream = {}
BitStream.__index = BitStream

function BitStream.compress(context)
    local data = context.original_data
    local encoding_table = context.encoding_table
    local bit_string = ""

    for _, codepoint in utf8.codes(data) do
        local char = utf8.char(codepoint)
        local code = encoding_table[char]
        if not code then
            error("Carácter sin código: " .. char)
        end
        bit_string = bit_string .. code
    end

    local bytes = {}
    local buffer = 0
    local bit_count = 0

    for i = 1, #bit_string do
        buffer = bit.blshift(buffer, 1)
        if bit_string:sub(i, i) == "1" then
            buffer = bit.bor(buffer, 1)
        end

        bit_count = bit_count + 1
        if bit_count == 8 then
            table.insert(bytes, string.char(buffer))
            buffer = 0
            bit_count = 0
        end
    end

    if bit_count > 0 then
        buffer = bit.blshift(buffer, 8 - bit_count)
        table.insert(bytes, string.char(buffer))
    end

    context.compressed_bits = bit_string
    context.compressed_bytes = table.concat(bytes)
    context.total_bits = #bit_string

    return context
end

function BitStream.decompress(context)
    local compressed_bytes = context.compressed_bytes
    local total_bits = context.total_bits
    local decoding_table = context.decoding_table

    local bit_string = ""

    for i = 1, #compressed_bytes do
        local byte = string.byte(compressed_bytes, i)
        for j = 7, 0, -1 do
            if #bit_string < total_bits then
                local bit_val = bit.band(byte, bit.blshift(1, j))
                bit_string = bit_string .. (bit_val > 0 and "1" or "0")
            end
        end
    end

    local result = {}
    local current_code = ""

    for i = 1, #bit_string do
        current_code = current_code .. bit_string:sub(i, i)
        if decoding_table[current_code] then
            table.insert(result, decoding_table[current_code])
            current_code = ""
        end
    end

    context.decompressed_data = table.concat(result)
    return context
end

return BitStream