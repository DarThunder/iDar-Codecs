local Context = require("idar-cod.huffman.helpers.context")
local Frequency = require("idar-cod.huffman.helpers.frequency")
local Tree = require("idar-cod.huffman.structures.tree")
local Codes = require("idar-cod.huffman.helpers.codes")
local BitStream = require("idar-cod.huffman.utils.bitstream")
local Serializer = require("idar-cod.huffman.utils.serialiazer")

local Huffman = {}

function Huffman.compress(data)
    local ctx = Context.new():setData(data)

    if type(data) == "table" then
        ctx.original_data = Serializer.serialize(data)
    elseif type(data) == "number" then
        ctx.original_data = tostring(data)
    end

    Frequency.analyze(ctx)
    Frequency.buildNodeList(ctx)
    Tree.build(ctx)
    Codes.generate(ctx)
    BitStream.compress(ctx)

    local original_size = #data
    local compressed_size = #ctx.compressed_bytes
    ctx.compression_ratio = compressed_size / original_size

    return ctx:getStats()
end

function Huffman.decompress(state)
    local ctx = Context.new()

    ctx.compressed_bytes = state.compressed_bytes
    ctx.encoding_table = state.encoding_table
    ctx.total_bits = state.total_bits

    ctx.decoding_table = {}
    for char, code in pairs(ctx.encoding_table) do
        ctx.decoding_table[code] = char
    end

    BitStream.decompress(ctx)

    if state.original_type == "table" then
        return Serializer.deserialize(ctx.decompressed_data)
    elseif state.original_type == "number" then
        return tonumber(ctx.decompressed_data)
    end

    return ctx.decompressed_data
end

function Huffman.createContext(data)
    return Context.new():setData(data)
end

return Huffman