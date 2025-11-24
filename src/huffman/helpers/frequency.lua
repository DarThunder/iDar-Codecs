local Frequency = {}
Frequency.__index = Frequency

function Frequency.analyze(context)
    local data = context.original_data
    local freq_table = {}

    for _, codepoint in utf8.codes(data) do
        local char = utf8.char(codepoint)
        freq_table[char] = (freq_table[char] or 0) + 1
    end

    context.frequency_table = freq_table
    return context
end

function Frequency.buildNodeList(context)
    local Node = require("iDar.Codecs.src.huffman.structures.node")
    local nodes = {}

    for char, freq in pairs(context.frequency_table) do
        table.insert(nodes, Node.new(char, freq))
    end

    context.frequency_list = nodes
    return context
end

return Frequency