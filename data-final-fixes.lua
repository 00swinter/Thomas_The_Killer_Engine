local table_util = require("util")

-- 1. Create the custom smoke
local base_smoke = data.raw["trivial-smoke"]["train-smoke"]
if base_smoke then
    local heavy_smoke = table_util.table.deepcopy(base_smoke)
    heavy_smoke.name = "thomas_heavy_smoke"
    heavy_smoke.color = {r = 0.375, g = 0.375, b = 0.375, a = 1.0}
    heavy_smoke.duration = 5 * 60
    heavy_smoke.spread_duration = 4 * 60
    heavy_smoke.fade_away_duration = 3 * 60
    heavy_smoke.end_scale = 4
    
    data:extend({heavy_smoke})
end

-- 2. Create the custom train
local base_loco = data.raw["locomotive"]["locomotive"]
if base_loco then
    local custom_loco = table_util.table.deepcopy(base_loco)
    custom_loco.name = "thomas_locomotive"
   
    -- Apply custom smoke
    if custom_loco.energy_source and custom_loco.energy_source.smoke then
        for _, smoke_source in pairs(custom_loco.energy_source.smoke) do
            if smoke_source.name == "train-smoke" then
                smoke_source.name = "thomas_heavy_smoke"
                smoke_source.position = {0, -1.5}
                smoke_source.frequency = 100
                smoke_source.starting_frame_deviation = 500
                smoke_source.starting_vertical_speed = 0.5
                smoke_source.starting_vertical_speed_deviation = 0.2
            end
        end
        if custom_loco.energy_source.effectivity then
            custom_loco.energy_source.effectivity = 0.2
        end
    end

    if custom_loco.max_power then
        custom_loco.max_power = "2000kW"
    end
    
    data:extend({custom_loco})
end