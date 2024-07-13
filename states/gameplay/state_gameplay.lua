GameObject = require "states.gameplay.game_object"

local state_gameplay = {}

local objects = {}

function state_gameplay:enter()
    love.graphics.setBackgroundColor(0, 1, 0)
    table.insert(objects,GameObject(100, 100))
end

function state_gameplay:update(dt)
    for i, obj in ipairs(objects) do
        obj:update(dt)
    end
end

function state_gameplay:draw()
    for i, obj in ipairs(objects) do
        obj:draw()
    end
end

return state_gameplay