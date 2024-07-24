-- Wrapper for lib.loveconsole with our user commands
local console = require "lib.loveconsole"

console.addCommand("hello", function(args)
    if args then
        console.print(string.format("Greetings %s!", args[1]))	
    else
        console.print("Hey there!")
    end
end, "Greets you in a non rude way - Arguments: [person to say hello to]")

return console