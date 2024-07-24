-- Wrapper for lib.loveconsole with our user commands
local console = require "lib.loveconsole"

console.addCommand("drawCollisions", function(args)
    debug.shouldDrawCollisions = not debug.shouldDrawCollisions
end, "Should collisions be drawn? - Arguments: [true/false]")

console.addCommand("drawFPS", function(args)
    debug.showFPS = not debug.showFPS
end, "Should collisions be drawn? - Arguments: [true/false]")


console.addCommand("hello", function(args)
    if args then
        console.print(string.format("Greetings %s!", args[1]))	
    else
        console.print("Hey there!")
    end
end, "Greets you in a non rude way - Arguments: [person to say hello to]")

return console