require "debug"

Object = require "classic"
tick = require "tick"

require "shape"
require "rectangle"
require "circle"

function love.load()
    listOfRectangles = {}

    --tick.delay(function () drawRectangle = true end ,   2)
end

function love.keypressed(key)
    if key == "space" then
        table.insert(listOfRectangles, Rectangle(math.random(100), math.random(100), math.random(200), math.random(50)))
    end

    if key == "lshift" then
        table.insert(listOfRectangles, Circle(math.random(100), math.random(200), math.random(50)))
    end
end

function love.update(dt)
    tick.update(dt)

    if love.keyboard.isDown("right") then
        for i,v in ipairs(listOfRectangles) do
            v:update(dt)
        end
    end
end

function love.draw()
    for i,v in ipairs(listOfRectangles) do
        v:draw()
    end
end