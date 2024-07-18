local GameObject = require "states.gameplay.game_object"

local Sheep = GameObject:extend()

function Sheep:new(x, y)
    self.image = love.graphics.newImage("/resources/sheep.png")
    self.x = x
    self.y = y
    self.speed = 100
end

function Sheep:update(dt)

end

function Sheep:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1)
end

return Sheep