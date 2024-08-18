--[[
module = {
	x=emitterPositionX, y=emitterPositionY,
	[1] = {
		system=particleSystem1,
		kickStartSteps=steps1, kickStartDt=dt1, emitAtStart=count1,
		blendMode=blendMode1, shader=shader1,
		texturePreset=preset1, texturePath=path1,
		shaderPath=path1, shaderFilename=filename1,
		x=emitterOffsetX, y=emitterOffsetY
	},
	[2] = {
		system=particleSystem2,
		...
	},
	...
}
]]
local LG        = love.graphics
local particles = {x=0, y=0}

local image1 = LG.newImage("resources/particles/light.png")
image1:setFilter("linear", "linear")

local ps = LG.newParticleSystem(image1, 47)
ps:setColors(1, 0.98785400390625, 0.22265625, 0, 1, 0.4791259765625, 0.01953125, 1, 0.91796875, 0.064544677734375, 0, 0.92578125, 0.6326904296875, 0.6015625, 1, 0)
ps:setDirection(-1.3597029447556)
ps:setEmissionArea("none", 0, 0, 0, false)
ps:setEmissionRate(20)
ps:setEmitterLifetime(-1)
ps:setInsertMode("top")
ps:setLinearAcceleration(0, 0, 55.578804016113, 0)
ps:setLinearDamping(0, 0)
ps:setOffset(75, 75)
ps:setParticleLifetime(1.7999999523163, 2.2000000476837)
ps:setRadialAcceleration(0, 0)
ps:setRelativeRotation(false)
ps:setRotation(0, 0)
ps:setSizes(0.40000000596046)
ps:setSizeVariation(0)
ps:setSpeed(90, 100)
ps:setSpin(0, 0)
ps:setSpinVariation(0)
ps:setSpread(0.32911923527718)
ps:setTangentialAcceleration(0, 0)
table.insert(particles, {system=ps, kickStartSteps=0, kickStartDt=0, emitAtStart=0, blendMode="add", shader=nil, texturePath="light.png", texturePreset="light", shaderPath="", shaderFilename="", x=0, y=0})

return particles
