local Context = {}
Context.__index = Context

function Context.new()
    return setmetatable({
        original_data = nil,
        original_type = nil,

        frequency_table = {},
        frequency_list = {},

        huffman_tree = nil,
        root_node = nil,

        encoding_table = {},
        decoding_table = {},

        compressed_bits = "",
        compressed_bytes = "",
        total_bits = 0,

        compression_ratio = 0,
        time_taken = 0
    }, Context)
end

function Context:setData(data, dataType)
    self.original_data = data
    self.original_type = dataType or type(data)
    return self
end

function Context:getStats()
    return {
        compressed_bytes = self.compressed_bytes,
        encoding_table = self.encoding_table,
        total_bits = self.total_bits,
        original_type = self.original_type,

        original_size = self.original_size,
        compressed_size = self.compressed_size,
        compression_ratio = self.compression_ratio,
        time_taken = self.time_taken,
    }
end

return Context