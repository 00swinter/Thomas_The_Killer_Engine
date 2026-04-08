local sounds = {}
for i = 0, 349 do
    table.insert(sounds, {
        type = "sound",
        name = string.format("thomas%03d", i),
        filename = string.format("__rasmusMod__/clips/%03d.wav", i),
        volume = 1.0
    })
end

data:extend(sounds)