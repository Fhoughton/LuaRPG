local state_shapes = {}

local Rectangle = require "shapes.rectangle"
local Circle = require "shapes.circle"

local state_title = require "title.state_title"

local myImage = love.graphics.newImage("/resources/sheep.png")

local listOfRectangles = {}

function state_shapes:enter()

end

function state_shapes:keypressed(key)
    if key == "space" then
        table.insert(listOfRectangles, Rectangle(math.random(100), math.random(100), math.random(200), math.random(50)))
    end

    if key == "lshift" then
        table.insert(listOfRectangles, Circle(math.random(100), math.random(200), math.random(50)))
    end

    if key == "rshift" then
        Gamestate.switch(state_title)
    end
end

function state_shapes:update(dt)
    if love.keyboard.isDown("right") then
        for i,v in ipairs(listOfRectangles) do
            v:update(dt)
        end
    end
end

function state_shapes:draw()
    for i,v in ipairs(listOfRectangles) do
        v:draw()
    end

    love.graphics.draw(myImage, 100, 100, 0, 1, 1)
end

return state_shapes