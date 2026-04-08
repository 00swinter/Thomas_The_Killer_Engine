vector2 = {}


function vector2.new(x,y)
    return{x,y}
end

function vector2.add(vecA, vecB)
    return {vecA[1] + vecB[1], vecA[2] + vecB[2]}
end

function vector2.sub(vecA, vecB)
    return {vecA[1] - vecB[1], vecA[2] - vecB[2]}
end

function vector2.scale(vec, scale)
    return {vec[1] * scale, vec[2] * scale}
end

function vector2.length(vec)
    return math.sqrt((vec[1]*vec[1]) + (vec[2]*vec[2]))
end

function vector2.normalize(vec)
    return vector2.multi(vec, 1/vector2.length(vec))
end

function vector2.posToTab(position)
    return {position.x, position.y}
end

return vector2