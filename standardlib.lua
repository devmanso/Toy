-- Author: Mansour Quddus
-- Date: 1.03.2023

functions = {}

function functions.garbageCollectorOptions(param)
	if param == "s" then
		collectgarbage("stop")
	elseif param == "r" then
		collectgarbage("restart")
	else collectgarbage("collect") end
end	

function functions.footprint(param)
	GC_count = collectgarbage("count")
	print("kBytes", GC_count)
end

function functions.quit(param)
	print("PROGRAM TERMINATED")
	os.exit()
end

function functions.winClearScreen(param) 
	os.execute("cls")
end

function functions.clearScreen(param)
	os.execute("clear")
end

function functions.wait(seconds)
	local start = os.time() 
	repeat until os.time() > start + seconds
end

function functions.printWorkingDirectory(param)
	os.execute("pwd")
end

return functions
