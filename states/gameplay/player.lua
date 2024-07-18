local peachy = require("lib.peachy")

local GameObject = require "states.gameplay.game_object"

local Player = GameObject:extend()

function Player:new(x, y, camera)
    self.image = peachy.new("resources/man.json", love.graphics.newImage("resources/man.png"), "WalkDown")
    self.x = x
    self.y = y
    self.speed = 100
    self.camera = camera
end

function Player:draw()
    self.image:draw(self.x, self.y)
end


function Player:update(dt)
  self.image:update(dt)
  self.image:play()

  if love.keyboard.isDown("left") then
    self.x = self.x - (self.speed * dt)
    self.image:setTag("WalkLeft")
  elseif love.keyboard.isDown("right") then
    self.x = self.x + (self.speed * dt)
    self.image:setTag("WalkRight")
  elseif love.keyboard.isDown("up") then
    self.y = self.y - (self.speed * dt)
    self.image:setTag("WalkUp")
  elseif love.keyboard.isDown("down") then
    self.y = self.y + (self.speed * dt)
    self.image:setTag("WalkDown")
  else
    self.image:pause()
  end

  local middle = self:getMiddle()
  camera:lookAt(middle.x, middle.y)
end

return Player
