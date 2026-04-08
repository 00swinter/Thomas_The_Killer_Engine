vector2 = {}

function vector2.new(x, y)
    return {x, y}
end

function vector2.add(vecA, vecB)
    local ax = vecA.x or vecA[1]
    local ay = vecA.y or vecA[2]
    local bx = vecB.x or vecB[1]
    local by = vecB.y or vecB[2]
    return {ax + bx, ay + by}
end

function vector2.sub(vecA, vecB)
    local ax = vecA.x or vecA[1]
    local ay = vecA.y or vecA[2]
    local bx = vecB.x or vecB[1]
    local by = vecB.y or vecB[2]
    return {ax - bx, ay - by}
end

function vector2.scale(vec, scale)
    local x = vec.x or vec[1]
    local y = vec.y or vec[2]
    return {x * scale, y * scale}
end

function vector2.length(vec)
    local x = vec.x or vec[1]
    local y = vec.y or vec[2]
    return math.sqrt((x * x) + (y * y))
end

function vector2.normalize(vec)
    return vector2.scale(vec, 1 / vector2.length(vec))
end

return vector2