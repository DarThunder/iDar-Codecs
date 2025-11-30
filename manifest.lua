return {
    directory = "Codecs",
    files = {
        ["src"] = {
            ["huffman"] = {
                ["helpers"] = {
                    "codes.lua",
                    "context.lua",
                    "frequency.lua"
                },
                ["structures"] = {
                    "node.lua",
                    "tree.lua"
                },
                ["utils"] = {
                    "bitstream.lua",
                    "serialiazer.lua"
                },
                "init.lua"
            }
        }
    },
    dependencies = {
        {name = "idar-structures", version = "latest"}
    }
}