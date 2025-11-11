local MinHeap = {}
MinHeap.__index = MinHeap

function MinHeap.new(list)
    return setmetatable({ nodes = type(list) == "table" and list or {} }, MinHeap)
end

function MinHeap:size()
    return # self.nodes
end

function MinHeap:insert(node)
    table.insert(self.nodes, node)
    local i = #self.nodes
    local parent_i = math.floor(i / 2)

    while i > 1 and self.nodes[parent_i].freq > self.nodes[i].freq do
        self.nodes[i], self.nodes[parent_i] = self.nodes[parent_i], self.nodes[i]
        i = parent_i
        parent_i = math.floor(i / 2)
    end
end

function MinHeap:extract_min()
    local min_node = self.nodes[1]

    local last_node = table.remove(self.nodes)

    if #self.nodes == 0 then
        return min_node
    end

    self.nodes[1] = last_node
    local i = 1

    while true do
        local left_i = i * 2
        local right_i = i * 2 + 1
        local smallest_i = i

        if left_i <= #self.nodes and self.nodes[left_i].freq < self.nodes[smallest_i].freq then
            smallest_i = left_i
        end

        if right_i <= #self.nodes and self.nodes[right_i].freq < self.nodes[smallest_i].freq then
            smallest_i = right_i
        end

        if smallest_i == i then
            break
        end

        local temp = self.nodes[i]
        self.nodes[i] = self.nodes[smallest_i]
        self.nodes[smallest_i] = temp
        i = smallest_i
    end

    return min_node
end

return function(n)
    return MinHeap.new(n)
end