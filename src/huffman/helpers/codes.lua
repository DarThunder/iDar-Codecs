local Codes = {}
Codes.__index = Codes

function Codes.generate(context, node, currentCode)
    node = node or context.root_node
    currentCode = currentCode or ""

    if node:isLeaf() then
        context.encoding_table[node.char] = currentCode
        context.decoding_table[currentCode] = node.char
        return
    end

    if node.left then
        Codes.generate(context, node.left, currentCode .. "0")
    end

    if node.right then
        Codes.generate(context, node.right, currentCode .. "1")
    end

    return context
end

return Codes