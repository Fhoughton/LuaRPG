local peachy = require("lib.peachy")
local GameObject = require "objects.game_object"
local Bullet = require "objects.bullet"
local Player = GameObject:extend()
local ParticleEmitter = require "objects.particle_emitter"

function Player:new(x, y, camera)
    Player.super.new(self, x, y)
    self.image = peachy.new("resources/man.json", love.graphics.newImage("resources/man.png"), "WalkDown")
    self.speed = 100
    self.camera = camera

    collision_world:add(self, self.x, self.y, 16, 24)

    self.collision_filter = function(item, other)
      if other.is ~= nil then
        if other:is(Bullet) then
          -- Can do updates here e.g. hp damage
          return 'cross'
        end
      end

      return 'slide'
    end
end

function Player:draw()
    self.image:draw(self.x, self.y)
end

function Player:handle_movement(dt)
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

  return deltaX, deltaY
end

function Player:update(dt)
  self.image:update(dt)
  self.image:play()

  local deltaX, deltaY = self:handle_movement(dt)

  -- Calculate new position based on input
  local newX = self.x + deltaX
  local newY = self.y + deltaY

  -- Resolve collision
  local actualX, actualY, cols, len = collision_world:move(self, newX, newY, self.collision_filter)

  self.x = actualX
  self.y = actualY

  -- Camera follows the player's new position
  local middle = self:getMiddle()
  camera:lookAt(middle.x, middle.y)
end

function Player:keypressed(key, scancode, isrepeat)
  if isrepeat == false then
    if key == "space" then
      table.insert(objects,Bullet(self.x, self.y))
    elseif key == "lshift" then
      table.insert(objects,ParticleEmitter(self.x, self.y, 0.25, 0.25, 0))
    end
  end
end

return Player