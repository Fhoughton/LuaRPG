local GameObject = require "objects.game_object"

local ParticleEmitter = GameObject:extend()

local allParticleData = require("resources.particles.colorful")

function ParticleEmitter:new(x, y, xscale, yscale, rotation)
    ParticleEmitter.super.new(self,x,y)
	self.xscale = xscale
	self.yscale = yscale
	self.rotation = rotation
    self:reset()
end

function ParticleEmitter:reset()
	for _, particleData in ipairs(allParticleData) do
		-- Note that particle systems are already started when created, so we
		-- don't need to call particleSystem:start() at any point.
		local particleSystem = particleData.system

		particleSystem:reset()
		particleSystem:setPosition(allParticleData.x+particleData.x, allParticleData.y+particleData.y)

		for step = 1, particleData.kickStartSteps do -- kickStartSteps may be 0.
			particleSystem:update(particleData.kickStartDt)
		end

		particleSystem:emit(particleData.emitAtStart) -- emitAtStart may be 0.
	end
end

function ParticleEmitter:update(dt)
	for _, particleData in ipairs(allParticleData) do
		particleData.system:update(dt)
	end
end

function ParticleEmitter:draw()
    local w, h = love.graphics.getDimensions()
	local oldBlendMode = love.graphics.getBlendMode()

	-- Draw all particle systems in the middle of the screen.
	for _, particleData in ipairs(allParticleData) do
		love.graphics.setBlendMode(particleData.blendMode)
		love.graphics.setShader(particleData.shader) -- The .shader field is always nil in this example, so this line actually does nothing.
		love.graphics.draw(particleData.system, self.x, self.y, self.rotation, self.xscale, self.yscale)
	end

	love.graphics.setBlendMode(oldBlendMode)
end

return ParticleEmitter