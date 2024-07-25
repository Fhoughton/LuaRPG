local debug = {}

debug.shouldDrawCollisions = false
debug.shouldDrawEvents = false
debug.showFPS = false

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

function debug.drawEvents()
    -- Debug draw evnts
    if not debug.shouldDrawEvents then
        local items, len = event_world:getItems()

        for _, item in pairs(items) do
            local rect_x, rect_y, rect_w, rect_h = event_world:getRect(item)
            love.graphics.setColor(0, 1.0, 0, 1.0)
            love.graphics.print(("Pos: %d %d"):format(rect_x, rect_y), rect_x, rect_y - 16)
            love.graphics.print(("Size: %d %d"):format(rect_w, rect_h), rect_x, rect_y - 32)
            love.graphics.rectangle("line", rect_x, rect_y, rect_w, rect_h)
        end
    end
end

function debug.draw()
    debug.drawCollisions()
    debug.drawEvents()
end

function debug.drawGUI()
    if debug.showFPS then
        love.graphics.print(("FPS: %d"):format(love.timer.getFPS()), 0, 0)
    end
end

return debug