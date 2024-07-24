-- Wrapper for lib.loveconsole with our user commands
local console = require "lib.loveconsole"

console.addCommand("drawCollisions", function(args)
    if args then
        if args[1] == "true" then
            debug.shouldDrawCollisions = true
        elseif args[1] == "false" then
            debug.shouldDrawCollisions = false
        else
            console.error("Invalid argument to drawCollisions")
        end
    else
        debug.shouldDrawCollisions = not debug.shouldDrawCollisions
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