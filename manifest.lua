return {
    directory = "Codecs",
    files = {
        "src/huffman/helpers/codes.lua",
        "src/huffman/helpers/context.lua",
        "src/huffman/helpers/frequency.lua",
        "src/huffman/structures/node.lua",
        "src/huffman/structures/tree.lua",
        "src/huffman/utils/bitstream.lua",
        "src/huffman/utils/serialiazer.lua",
        "src/huffman/init.lua"
    },
    dependencies = {
        {name = "idar-structures", version = "latest"}
    }
}