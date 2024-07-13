GameObject = require "states.gameplay.game_object"
Player = require "states.gameplay.player"
Camera = require "lib.hump.camera"

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
    camera:attach()
    love.graphics.rectangle("fill", 100, 100, 300, 300)

    for i, obj in ipairs(objects) do
        obj:draw()
    end
    camera:detach()
end

return state_gameplay