local Object = require "lib.classic"

local GameObject = Object:extend()

function GameObject:new(x, y)
    self.image = love.graphics.newImage("/resources/sheep.png")
    self.x = x
    self.y = y
end

function GameObject:update()
end

function GameObject:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 1, 1)
end

function GameObject:keypressed(key, scancode, isrepeat)
end

-- Returns the x and y offset to find the middle of the object from the sprite
function GameObject:getMiddle()
    return { ["x"] = self.x + (self.image:getWidth() / 2), ["y"] = self.y + (self.image:getHeight() / 2)}
end

return GameObject