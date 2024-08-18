local GameObject = require "objects.game_object"

local Bullet = GameObject:extend()

function Bullet:new(x, y)
    Bullet.super.new(self,x,y)
    
    self.speed = 100
    collision_world:add(self, self.x, self.y, 12, 4)
end

function Bullet:draw()
    love.graphics.setColor(1,1,0)
    love.graphics.rectangle("fill",self.x,self.y,12,4)
    love.graphics.setColor(1,1,1)
end

function Bullet:update(dt)
    self.x = self.x + 1
    collision_world:update(self, self.x, self.y)
end

return Bullet