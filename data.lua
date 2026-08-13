local def = require("defines")

local sounds = {}

for i = 0, 349 do
    table.insert(sounds, {
        type = "sound",
        name = string.format("thomas%03d", i),
        filename = string.format(def.MOD_ROOT_PATH .. "/sound/clips/%03d.wav", i),
        volume = 1.0,
        audible_distance_modifier = 5.0
    })
end

data:extend(sounds)