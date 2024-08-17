require "debug"

GameObject = require "objects.game_object"
Player = require "objects.player"
Camera = require "lib.hump.camera"

local bump = require "lib.bump"
local console = require "console"
local debug = require "gameplay_debug"
local maps = require "maps"
local scaling = require "scaling"

--local game_canvas = love.graphics.newCanvas(rs.get_game_size())

objects = {}

collision_world = bump.newWorld()
event_world = bump.newWorld()

player = {}

function love.keypressed(key, scancode, isrepeat)
	if key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "exclusive")
	end

  for i, obj in ipairs(objects) do
    obj:keypressed(key, scancode, isrepeat)
  end

  console.keypressed(key)
end

function love.textinput(t)
  if t ~= "`" then
    console.textinput(t)
  end
end

function love.load()
  love.graphics.setDefaultFilter( "nearest", "nearest")

  -- Enter
  love.graphics.setBackgroundColor(0, 0, 0)
  camera = Camera(0, 0)
  camera:zoom(2)

  maps:load("map_collision_test")
end

function love.update(dt)
  maps:update(dt)
  for i, obj in ipairs(objects) do
      obj:update(dt)
  end
end

local function drawObjects()
  for i, obj in ipairs(objects) do
    obj:draw()
  end
end

function love.draw()
  -- Handle scaling --
  if rs.scale_mode == rs.NO_SCALING_MODE then
      camera:attach(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    else
      camera:attach(0, 0, rs.game_width, rs.game_height)
  end
  love.graphics.setCanvas(camera_canvas)

  love.graphics.clear(0, 0, 1, 1) -- Game background colour

  -- Draw Game --
  maps:draw()
  drawObjects()
  debug.draw()

  -- Draw GUI --
  camera:detach()
  console.draw()
  debug.drawGUI()
  
  -- Draw Screen (scaled) --
  scaling:drawScreenSpace()
end