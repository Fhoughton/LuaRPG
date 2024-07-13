require "debug"

local state_gameplay = require "states.gameplay.state_gameplay"

Gamestate = require "lib.hump.gamestate"

function love.load()
    love.graphics.setBackgroundColor(0, 0.4, 1)
    love.graphics.setDefaultFilter( "nearest", "nearest")

    Gamestate.registerEvents()
    Gamestate.switch(state_gameplay)
end