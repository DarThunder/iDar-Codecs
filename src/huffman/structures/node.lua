local Node = {}
Node.__index = Node

function Node.new(char, freq)
    return setmetatable({
        char = char,
        freq = freq,
        left = nil,
        right = nil
    }, Node)
end

function Node:isLeaf()
    return not self.left and not self.right
end

return Node