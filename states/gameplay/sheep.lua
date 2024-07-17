local GameObject = require "states.gameplay.game_object"

local Sheep = GameObject:extend()

function Sheep:new(x, y)
    self.image = love.graphics.newImage("/resources/sheep.png")
    self.x = x
    self.y = y
    self.speed = 100
end

function Sheep:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("down") then
        self.y = self.y + self.speed * dt
    end
end

function Sheep:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1)
end

return Sheep