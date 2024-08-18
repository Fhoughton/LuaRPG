local GameObject = require "objects.game_object"

local ParticleEmitter = GameObject:extend()

local allParticleData = require("resources.particles.colorful")

function ParticleEmitter:new(x, y, xscale, yscale, rotation)
    ParticleEmitter.super.new(self, x, y)
    self.xscale = xscale
    self.yscale = yscale
    self.rotation = rotation

    -- Deep copy particle systems for this instance
    self.particleData = {}
    for _, particleData in ipairs(allParticleData) do
        local copy = {
            system = particleData.system:clone(),
            blendMode = particleData.blendMode,
            shader = particleData.shader,
            x = particleData.x,
            y = particleData.y,
            kickStartSteps = particleData.kickStartSteps,
            kickStartDt = particleData.kickStartDt,
            emitAtStart = particleData.emitAtStart
        }
        table.insert(self.particleData, copy)
    end

    self:reset()
end

function ParticleEmitter:reset()
    for _, particleData in ipairs(self.particleData) do
        local particleSystem = particleData.system
        particleSystem:reset()
        particleSystem:setPosition(particleData.x, particleData.y)
        for step = 1, particleData.kickStartSteps do
            particleSystem:update(particleData.kickStartDt)
        end
        particleSystem:emit(particleData.emitAtStart)
    end
end

function ParticleEmitter:update(dt)
    for _, particleData in ipairs(self.particleData) do
        particleData.system:update(dt)
    end
end

function ParticleEmitter:draw()
    local w, h = love.graphics.getDimensions()
    local oldBlendMode = love.graphics.getBlendMode()

    for _, particleData in ipairs(self.particleData) do
        love.graphics.setBlendMode(particleData.blendMode)
        love.graphics.setShader(particleData.shader)
        love.graphics.draw(particleData.system, self.x, self.y, self.rotation, self.xscale, self.yscale)
    end

    love.graphics.setBlendMode(oldBlendMode)
end


return ParticleEmitter