GameObject = require "states.gameplay.game_object"
Sheep = require "states.gameplay.sheep"
Player = require "states.gameplay.player"
Box = require "states.gameplay.box"
Camera = require "lib.hump.camera"

local sti = require "lib.sti"
local bump = require "lib.bump"
local console = require "states.gameplay.console"

debug = require "states.gameplay.gameplay_debug"

local game_canvas = love.graphics.newCanvas(rs.get_game_size())

local state_gameplay = {}

local objects = {}

collision_world = bump.newWorld()
event_world = bump.newWorld()

player = {}

function state_gameplay:enter()
    love.graphics.setBackgroundColor(0, 1, 0)
    camera = Camera(0, 0)
    camera:zoom(2)

    loadMap("map_object_test")
end

function loadMap(mapPath)
    mapPath = "maps/" .. mapPath .. ".lua"
    objects = {}
    collision_world = bump.newWorld()
    event_world = bump.newWorld()

    player = Player(0, 0, camera)
    table.insert(objects,player)

    map = sti(mapPath)

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
end

function state_gameplay:update(dt)
    map:update(dt)
    for i, obj in ipairs(objects) do
        obj:update(dt)
    end
end

function state_gameplay:draw()
    if rs.scale_mode == rs.NO_SCALING_MODE then
        camera:attach(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
      else
        camera:attach(0, 0, rs.game_width, rs.game_height)
    end

    love.graphics.setCanvas(camera_canvas)
    love.graphics.clear(1, 1, 1, 0)

    for layerName, layerObject in pairs(map.layers) do
        map:drawLayer(layerObject)
    end
    
    for i, obj in ipairs(objects) do
        obj:draw()
    end

    debug.draw()
    love.graphics.setColor(1,1,1,1)

    camera:detach()

    -- Draw GUI Here
    state_gameplay:drawGUI()

    -- Draw Screen Space After Here
    love.graphics.setCanvas()    

    rs.push()
        -- Draw camera's canvas.
        love.graphics.draw(camera_canvas)
    rs.pop()

    -- Draw rectangle to see game zone.
    love.graphics.rectangle("line", rs.get_game_zone())
end

function state_gameplay:drawGUI()
    console.draw()
    debug.drawGUI()
end

function state_gameplay:keypressed(key)
    console.keypressed(key)
end

function state_gameplay:textinput(t)
    if t ~= "`" then
        console.textinput(t)
    end
end

function state_gameplay:resize(w, h)
    console.resize(w, h)
end

return state_gameplay