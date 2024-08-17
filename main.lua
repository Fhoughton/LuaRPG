require "debug"

GameObject = require "objects.game_object"
Player = require "objects.player"
Camera = require "lib.hump.camera"

local sti = require "lib.sti"
local bump = require "lib.bump"
local console = require "console"

local debug = require "gameplay_debug"

rs = require "lib.resolution_solution"
rs.conf({game_width = 640, game_height = 360, scale_mode = rs.ASPECT_MODE})
rs.setMode(rs.game_width, rs.game_height, {resizable = true})

local game_canvas = love.graphics.newCanvas(rs.get_game_size())

local state_gameplay = {}

local objects = {}

collision_world = bump.newWorld()
event_world = bump.newWorld()

player = {}


rs.resize_callback = function()
  if rs.scale_mode == rs.NO_SCALING_MODE then
    camera_canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
  else
    camera_canvas = love.graphics.newCanvas(rs.game_width, rs.game_height)
  end
end

camera_canvas = love.graphics.newCanvas(rs.game_width, rs.game_height)

love.resize = function(w, h)
    rs.resize(w, h)
    console.resize(w, h)
end

function love.keypressed(key, scancode, isrepeat)
	if key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "exclusive")
	end

  console.keypressed(key)
end

function love.textinput(t)
  if t ~= "`" then
    console.textinput(t)
  end
end

function loadMap(mapPath)
  mapPath = "maps/" .. mapPath .. ".lua"
  objects = {}
  collision_world = bump.newWorld()
  event_world = bump.newWorld()

  player = Player(0, 0, camera)
  table.insert(objects,player)

  map = sti(mapPath, {"bump"})

  -- Load Map Objects
  if map.layers["Objects"] ~= nil then
      for i,v in ipairs(map.layers.Objects.objects) do
          if v.name == "Box" then
              local newBox = Box(v.x, v.y)
              table.insert(objects,newBox) -- TODO: Tiled assumes it's at 0,0 but it's not so idk what to do zzz
              collision_world:add(newBox, v.x, v.y, 32, 32)
              print(v.x, v.y)
              -- table.insert(objects,Box(0, 0))
          end
      end
      map:removeLayer("Objects")
  else
      console.warning(("Map %s has no 'Objects' layer! Perhaps it's misnamed?"):format(mapPath))
  end

  map:bump_init(collision_world)
end

function love.load()
  love.graphics.setDefaultFilter( "nearest", "nearest")

  -- Enter
  love.graphics.setBackgroundColor(0, 0, 0)
  camera = Camera(0, 0)
  camera:zoom(2)

  loadMap("map_collision_test")
end

function love.update(dt)
  map:update(dt)
  for i, obj in ipairs(objects) do
      obj:update(dt)
  end
end

function love.draw()
  if rs.scale_mode == rs.NO_SCALING_MODE then
      camera:attach(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    else
      camera:attach(0, 0, rs.game_width, rs.game_height)
  end

  love.graphics.setCanvas(camera_canvas)
  love.graphics.clear(0, 0, 1, 1) -- Game background colour

  for layerName, layerObject in pairs(map.layers) do
      map:drawLayer(layerObject)
  end

  for i, obj in ipairs(objects) do
      obj:draw()
  end

  debug.draw()

  camera:detach()

  -- Draw GUI Here
  console.draw()
  debug.drawGUI()

  -- Draw Screen Space After Here
  love.graphics.setCanvas()    

  rs.push()
      -- Draw camera's canvas.
      love.graphics.draw(camera_canvas)
  rs.pop()

  -- Draw rectangle to see game zone.
  --love.graphics.rectangle("line", rs.get_game_zone())
end