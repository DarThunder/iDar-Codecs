local Node = require("idar-cod.node")
local MinHeap = require("idar-cod.heap")

local Tree = {}
Tree.__index = Tree

function Tree.build(context)
    local nodes = MinHeap()

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