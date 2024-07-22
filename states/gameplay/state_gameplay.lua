GameObject = require "states.gameplay.game_object"
Sheep = require "states.gameplay.sheep"
Player = require "states.gameplay.player"
Box = require "states.gameplay.box"
Camera = require "lib.hump.camera"

local sti = require "lib.sti"

local game_canvas = love.graphics.newCanvas(rs.get_game_size())

local state_gameplay = {}

local objects = {}

function state_gameplay:enter()
    love.graphics.setBackgroundColor(0, 1, 0)
    camera = Camera(0, 0)
    camera:zoom(2)

    table.insert(objects,Player(0, 0, camera))
    --table.insert(objects,Sheep(240, 200))
    
    map = sti("maps/map_object_test.lua")

    -- Load Map Objects
    for i,v in ipairs(map.layers.Objects.objects) do
        if v.name == "Box" then
            table.insert(objects,Box(v.x, v.y)) -- TODO: Tiled assumes it's at 0,0 but it's not so idk what to do zzz
            print(v.x, v.y)
            -- table.insert(objects,Box(0, 0))
        end
    end
    map:removeLayer("Objects")
end

function state_gameplay:update(dt)
    map:update(dt)
    for i, obj in ipairs(objects) do
        obj:update(dt)
    end
end

function state_gameplay:draw()
    if rs.scale_mode == rs.NO_SCALING_MODE then
        camera:attach(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
      else
        camera:attach(0, 0, rs.game_width, rs.game_height)
    end

    love.graphics.setCanvas(camera_canvas)
    love.graphics.clear(1, 1, 1, 0)

    map:drawLayer(map.layers["Tile Layer 1"])
    
    for i, obj in ipairs(objects) do
        obj:draw()
    end
    love.graphics.setCanvas()
    camera:detach()
    

    rs.push()
        -- Draw camera's canvas.
        love.graphics.draw(camera_canvas)
    rs.pop()

    -- Draw rectangle to see game zone.
    love.graphics.rectangle("line", rs.get_game_zone())
end

return state_gameplay