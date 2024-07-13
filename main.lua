require "debug"

rs = require "lib.resolution_solution"
rs.conf({game_width = 640, game_height = 360, scale_mode = rs.ASPECT_MODE})
rs.setMode(rs.game_width, rs.game_height, {resizable = true})

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
  end

local state_gameplay = require "states.gameplay.state_gameplay"

Gamestate = require "lib.hump.gamestate"

function love.keypressed(key, scancode, isrepeat)
	if key == "f11" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "exclusive")
	end
end

function love.load()
    love.graphics.setBackgroundColor(0, 0.4, 1)
    love.graphics.setDefaultFilter( "nearest", "nearest")

    Gamestate.registerEvents()
    Gamestate.switch(state_gameplay)
end