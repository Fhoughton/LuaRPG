local peachy = require("lib.peachy")

local GameObject = require "states.gameplay.game_object"

local Player = GameObject:extend()

function Player:new(x, y, camera)
    self.image = peachy.new("resources/man.json", love.graphics.newImage("resources/man.png"), "WalkDown")
    self.x = x
    self.y = y
    self.speed = 100
    self.camera = camera

    collision_world:add(self, self.x, self.y, 16, 24)
end

function Player:draw()
    self.image:draw(self.x, self.y)
end

function Player:update(dt)
  self.image:update(dt)
  self.image:play()

  local deltaX, deltaY = 0, 0

  if love.keyboard.isDown("left") then
    deltaX = -self.speed * dt
    self.image:setTag("WalkLeft")
  elseif love.keyboard.isDown("right") then
    deltaX = self.speed * dt
    self.image:setTag("WalkRight")
  elseif love.keyboard.isDown("up") then
    deltaY = -self.speed * dt
    self.image:setTag("WalkUp")
  elseif love.keyboard.isDown("down") then
    deltaY = self.speed * dt
    self.image:setTag("WalkDown")
  else
    self.image:pause()
  end

  -- Calculate new position based on input
  local newX = self.x + deltaX
  local newY = self.y + deltaY

  -- Resolve collision
  local actualX, actualY, cols, len = collision_world:move(self, newX, newY)

  self.x = actualX
  self.y = actualY

  -- Camera follows the player's new position
  local middle = self:getMiddle()
  camera:lookAt(middle.x, middle.y)

  -- if len > 0 then
  --   print(("Attempted to move to %d,%d, but ended up in %d,%d due to %d collisions"):format(newX, newY, actualX, actualY, len))
  -- else
  --   print("Moved to new position without collisions")
  -- end
end

return Player
