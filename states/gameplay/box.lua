local GameObject = require "states.gameplay.game_object"

local Box = GameObject:extend()

function Box:new(x, y)
    self.x = x
    self.y = y
end

function Box:draw()
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle("fill", self.x, self.y, 32, 32)
    love.graphics.setColor(255, 255, 255, 255)
end

return Box