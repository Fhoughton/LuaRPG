local console = require "console"

local scaling = {}

rs = require "lib.resolution_solution"
rs.conf({game_width = 640, game_height = 360, scale_mode = rs.ASPECT_MODE})
rs.setMode(rs.game_width, rs.game_height, {resizable = true})

camera_canvas = love.graphics.newCanvas(rs.game_width, rs.game_height)

rs.resize_callback = function()
    if rs.scale_mode == rs.NO_SCALING_MODE then
      camera_canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
    else
      camera_canvas = love.graphics.newCanvas(rs.game_width, rs.game_height)
    end
end

function scaling:resize(w, h)
    rs.resize(w, h)
    console.resize(w, h)
end

love.resize = function(w, h)
    scaling.resize(w, h)
end

function scaling:drawScreenSpace()
    love.graphics.setCanvas()    
  
    rs.push()
        -- Draw camera's canvas.
        love.graphics.draw(camera_canvas)
    rs.pop()
end

return scaling