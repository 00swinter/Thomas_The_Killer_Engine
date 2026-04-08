---@diagnostic disable: undefined-global

local vector2 = require("vector2")



local musicProgressCounter = 0

local config = {
    musicDistanceFactor = 2,

    debug = true
}

local function tick()

    -- update loop
    --local spu = 3
    --if game.tick % (60 * spu) ~= 0 then
    --    return
    --end

    local trainFilter = {
        surface = "nauvis"
    }
    local trains = game.train_manager.get_trains(trainFilter)
    --game.print("Trains on surface nauvis: " .. #trains)

    local player = game.players[1]
    local playerPosition = player.position
    
    local train = trains[1]
    local trainSpeedVolumeFactor = train.speed / train.max_forward_speed
    local trainPosition = train.carriages[1].position

    if trainSpeedVolumeFactor < 0.1 then
        musicProgressCounter = 0 --scrap
    end


    if trains == nil or #trains == 0 then
        --game.print("No trains found on surface nauvis.")
        return
    end
    if config.debug then
        rendering.draw_line{
            color = {r = 1, g = 0, b = 0},   -- Red color
            width = 3,                       -- Line width
            from = playerPosition,
            to = trainPosition,  -- Draw to the first train's first carriage
            surface = game.surfaces[1],      -- Draw on the first surface (usually 'nauvis')
            time_to_live = 1                 -- Line will last for 600 ticks (10 seconds) 
        }
    end
    

    if game.tick % 12 == 0 then
            play(player, trains[1].carriages[1].position, 0.4, trainSpeedVolumeFactor)
            if config.debug then
                rendering.draw_circle{
                    color = {1,1,1,1},   -- Red color
                    width = 3,
                    radius = 1,
                    target = trainPosition,
                    surface = game.surfaces[1],
                    time_to_live = 120,
                }
            end
    end
end



function play(player, pos, vol, trainSpeedVolumeFactor)
    player.play_sound({
        path = string.format("thomas%03d", musicProgressCounter),
        position = pos,
        volume_modifier = vol * trainSpeedVolumeFactor
    })
    
    musicProgressCounter = musicProgressCounter + 1
    musicProgressCounter = musicProgressCounter % 350  -- Reset to 0 after reaching 350
end





--local function findThomas()
--
--end



--rendering.draw_line{
--    color = {r = 1, g = 0, b = 0},   -- Red color
--    width = 1,                       -- Line width
--    from = playerPosition,
--    to = finalPos,
--    surface = game.surfaces[1],      -- Draw on the first surface (usually 'nauvis')
--    time_to_live = 2                 -- Line will last for 600 ticks (10 seconds)
--}
















script.on_event(defines.events.on_tick, tick)











--local vector2 = require("vector2")
--
--
--
--
----script.on_event(defines.events.on_tick, function(event)
----    game.print("tick")
----  end)
--
--
--local thomasCounter = 1
--thomas = nil
--storage.thomasExists = false;
--
--local volume = 0.3
--local playerNear = false
--local lastPlayerPos = {0,0}
--
--local function print_table(t, indent)
--    if not indent then indent = 0 end
--    local toprint = string.rep(" ", indent) .. "{\n"
--    indent = indent + 2 
--    for key, value in pairs(t) do
--        toprint = toprint .. string.rep(" ", indent)qawqwa
--        if (type(key) == "number") then
--        toprint = toprint .. "[" .. key .. "] = "
--        elseif (type(key) == "string") then
--        toprint = toprint .. key ..  "= "   
--        end
--
--        if (type(value) == "table") then
--        toprint = toprint .. print_table(value, indent + 2) .. ",\n"
--        else
--        toprint = toprint .. tostring(value) .. ",\n"
--        end
--    end
--    toprint = toprint .. string.rep(" ", indent-2) .. "}"   
--    return toprint
--end
--
--
--function findThomas()
--    --local test = game.get_trains();
--    local trainFilter = {
--        surface = "nauvis"
--    }
--    local trains = game.train_manager.get_trains(trainFilter);
--    
--    local tom = nil
--    local kills = 0
--    if #trains > 0 then
--        for _, train in pairs(trains) do
--            local t_kills = train.kill_count
--            if t_kills > kills then
--                kills = t_kills
--                tom = train
--            end
--        end
--    end
--    if(thomas ~= nil)then
--        printTrainPos(thomas)
--    end
--    thomas = tom
--end
--
--function playerDeath(event)
--    findThomas()
--end
--
--function clamp(value, min, max)
--    if value < min then
--        return min
--    elseif value > max then
--        return max
--    else
--        return value
--    end
--end
--
--function tick(event)
--    findThomas()
--    --game.print(thomas.carriages[1].position.x)
--    --local posX = game.players[1].position[1]
--    --local posY = game.players[1].position[2]
--    if thomas ~= nil then
--        local player = game.players[1]
--        --thomas = game.get_surface(1).get_trains()[2]
--
--        local distanceFactor = 2
--        local playerPosition = {0,0}--
--
--        if player.vehicle == nil then

--            playerPosition = vector2.posToTab(player.position)
--        else
--            playerPosition = vector2.posToTab(player.vehicle.position)
--        end
--        if type(playerPosition[1]) ~= "number" then
--            playerPosition = lastPlayerPos
--            game.print("NAN")
--        else
--            lastPlayerPos = playerPosition
--        end
--
--        local trainPosition = vector2.posToTab(thomas.carriages[1].position)
--        local playerTrainVec = vector2.sub(trainPosition, vector2.posToTab(player.position))
--        local trainDistance = vector2.length(playerTrainVec)
--        local playerTrainVecNorm = vector2.normalize(playerTrainVec)
--        local soundDistance = trainDistance/distanceFactor
--        local playerTrainVecMulti = vector2.multi(playerTrainVecNorm, soundDistance)
--        local finalPos = vector2.add(playerPosition, playerTrainVecMulti) 
--        local trainMaxSpeed = thomas.max_forward_speed
--        local trainSpeed = thomas.speed
--        local train0_1 = trainSpeed / trainMaxSpeed
--        local trainVolume = clamp((train0_1*1),0,1)
--        
--        game.print(posTblToString(playerPosition))
--        game.print(player.vehicle  ~= nil)
--        --game.print(player.vehicle)
--        --game.print("player  "..posTblToString(playerPosition))
--        --game.print("train   "..posTblToString(trainPosition))
--
--        --rendering.draw_line{
--        --    color = {r = 1, g = 0, b = 0},   -- Red color
--        --    width = 1,                       -- Line width
--        --    from = playerPosition,
--        --    to = finalPos,
--        --    surface = game.surfaces[1],      -- Draw on the first surface (usually 'nauvis')
--        --    time_to_live = 2               -- Line will last for 600 ticks (10 seconds)
--        --}d
--        if player.vehicle == nil then
--            rendering.draw_text{
--            text = string.format("%.2f", trainDistance),
--            surface = game.surfaces[1],
--            target = vector2.add(playerPosition, vector2.multi(playerTrainVecMulti, 0.5)),
--            color = {r = 0.7, g = 0.7, b = 1},
--            time_to_live = 2
--            }
--        end
--        
--
--        if game.tick % 12 == 0 then
--            play(player, finalPos, trainVolume)
--        end
--
--
--    end
--
--    
--    
--    
--    --[[]
--    rendering.draw_line{
--        color = {r = 1, g = 0, b = 0},   -- Red color
--        width = 1,                       -- Line width
--        from = {0,0},
--        to = game.players[1].position,
--        surface = game.surfaces[1],      -- Draw on the first surface (usually 'nauvis')
--        time_to_live = 2               -- Line will last for 600 ticks (10 seconds)
--    }
--    if playerNear then
--        if game.tick % 12 == 0 then
--            game.print("playerNear")
--            --play()
--        end
--    else
--        if game.tick % 120 == 0 then
--            game.print("checking for player")
--            --updatePlayerDistance()
--        end
--    end
--    if game.tick % 60 == 0 then
--        --my_function()
--        --local tom = getThomas()
--        if tom.valid then
--            game.print("valid")
--            game.print(tom.carriages[1].gps_tag)
--        else
--            game.print("invalid")
--        end
--    end
--    ]]
--end
--
--function posTblToString(tbl)
--        return "x:"..string.format("%.1f", tbl[1]).."  y:"..string.format("%.1f", tbl[2])
--end
--
--function getPlayerTrainDistanceVector(player, train)
--    game.print("p")
--    game.print(player.valid)
--    game.print("t")
--    game.print(train.valid)
--    return {train.carriages[1].position[1] - player.position[1], train.carriages[1].position[2] - player.position[2]}
--end
--
--function updatePlayerDistance()
--    
--end
--
--function printTrainPos(train)
--    --game.print(train.carriages[1].gps_tag)
--end
--
--function play(player, pos, vol)
--    if thomas ~= nil then
--        player.play_sound({
--            path = string.format("thomas%03d", thomasCounter),
--            position = pos,
--            volume_modifier = settings.get_player_settings(game.players[1])["thomas-music-volume"].value * vol
--        })
--    end
--    
--    thomasCounter = thomasCounter + 1
--    if thomasCounter > 350 then
--        thomasCounter = 1
--    end
--end
--
--
--function myInit()
--    --thomas = getThomas()
--    game.print("world has loaded")
--end
--
--script.on_init(myInit)
--script.on_init(function()
--    game.print("World has loaded!")
--end)
--script.on_init(function()
--    game.print("saksjdhkajsk")
--    global.valid_players = 0
--    global.some_data = {}
--end)
--script.on_event(defines.events.on_player_died, playerDeath)
--script.on_event(defines.events.on_tick, tick)









