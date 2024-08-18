-- Wrapper for lib.loveconsole with our user commands
local debug = require "gameplay_debug"
local console = require "lib.loveconsole"
local maps = require "maps"

console.addCommand("drawCollisions", function(args)
    debug.shouldDrawCollisions = not debug.shouldDrawCollisions
end, "Should collision hitboxes be drawn?]")

console.addCommand("drawEvents", function(args)
    debug.shouldDrawEvents = not debug.shouldDrawEvents
end, "Should event debug info be drawn?")

console.addCommand("drawGameZone", function(args)
    debug.shouldDrawGameZone = not debug.shouldDrawGameZone -- Broken rn, likely because it's in GUI and not after where it used to be
end, "Should game zone (screen boundaries for scaling) drawn?")

console.addCommand("drawFPS", function(args)
    debug.showFPS = not debug.showFPS
end, "Should collisions be drawn? - Arguments: [true/false]")

console.addCommand("tp", function(args)
    if args then
        if #args == 2 then
            player.x = args[1]
            player.y = args[2]
        end
    end
end, "Teleport the player to an x/y position - Arguments: [x, y]")

console.addCommand("exec", function(args)
    if args then
        assert(loadstring(args[1]))()
    end
end, "Runs some lua code after the point - Arguments: [code]")

function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end 

console.addCommand("map", function(args)
    if args then
        maps:loadMap(args[1])
    else
        console.print("MAP NAME AT SOME POINT")
    end
end, "Should collisions be drawn? - Arguments: [true/false]")


console.addCommand("hello", function(args)
    if args then
        console.print(string.format("Greetings %s!", args[1]))	
    else
        console.print("Hey there!")
    end
end, "Greets you in a non rude way - Arguments: [person to say hello to]")

return console