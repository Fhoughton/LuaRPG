-- This file contains the code to make debug handling better in Love2D
-- Written by me, comes from the sheepolution tutorial code
if arg[2] == "debug" then
    require("lldebugger").start()
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end

local debug = {}

debug.shouldDrawCollisions = false
debug.showFPS = false
debug.shouldDrawGameZone = false

function debug.drawCollisions()
    -- Debug draw collisions
    if debug.shouldDrawCollisions then
        local items, len = collision_world:getItems()

        for _, item in pairs(items) do
            local rect_x, rect_y, rect_w, rect_h = collision_world:getRect(item)
            love.graphics.setColor(1.0, 0, 0, 1.0)
            love.graphics.print(("Pos: %d %d"):format(rect_x, rect_y), rect_x, rect_y - 16)
            love.graphics.print(("Size: %d %d"):format(rect_w, rect_h), rect_x, rect_y - 32)
            love.graphics.rectangle("line", rect_x, rect_y, rect_w, rect_h)
        end
    end
end

function debug.draw()
    debug.drawCollisions()
    love.graphics.setColor(1,1,1,1) -- Reset draw colour to white
end

function debug.drawGUI()
    if debug.showFPS then
        love.graphics.print(("FPS: %d"):format(love.timer.getFPS()), 0, 0)
    end

    if debug.shouldDrawGameZone then
        love.graphics.rectangle("line", rs.get_game_zone())
    end
end

return debug