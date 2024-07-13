GameObject = require "states.gameplay.game_object"
Player = require "states.gameplay.player"
Camera = require "lib.hump.camera"

local game_canvas = love.graphics.newCanvas(rs.get_game_size())

local state_gameplay = {}

local objects = {}

function state_gameplay:enter()
    love.graphics.setBackgroundColor(0, 1, 0)
    table.insert(objects,Player(100, 100))
    camera = Camera(0, 0)
end

function state_gameplay:update(dt)
    for i, obj in ipairs(objects) do
        obj:update(dt)

        local middle = obj:getMiddle()
        camera:lookAt(middle.x, middle.y)
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

    love.graphics.rectangle("fill", 100, 100, 300, 300)

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