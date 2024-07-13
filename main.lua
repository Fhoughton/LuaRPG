require "debug"

local state_shapes = require "states.shapes.state_shapes"

Gamestate = require "lib.hump.gamestate"

function love.load()
    love.graphics.setBackgroundColor(0, 0.4, 1)
    love.graphics.setDefaultFilter( "nearest", "nearest")

    Gamestate.registerEvents()
    Gamestate.switch(state_shapes)
end