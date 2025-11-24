local Node = require("iDar.src.huffman.structures.node")
local MinHeap = require("iDar.Structures.src.heap.init")

local Tree = {}
Tree.__index = Tree

function Tree.build(context)
    local nodes = MinHeap.new_min(context.frequency_list, function(a, b) return a.freq < b.freq end)

    for i = 1, #context.frequency_list do
        nodes:insert(context.frequency_list[i])
    end

    while nodes:size() > 1 do
        local left = nodes:extract_min()
        local right = nodes:extract_min()

        local internal_node = Node.new(nil, left.freq + right.freq)
        internal_node.left = left
        internal_node.right = right

        nodes:insert(internal_node)
    end

    context.root_node = nodes:extract_min()
    context.huffman_tree = context.root_node
    return context
end

return Tree