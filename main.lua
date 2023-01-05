-- Author: Mansour Quddus
-- Date: 1.3.2023
-- interpreter for toy, 
-- a tiny "programming language" made just for fun

-- libs
standard_functions = require 'standardlib'

-- open script
local script = assert(io.open("script.toy", "r"))

local line_count = 0

local variables = {}

for line in io.lines("script.toy") do
  collectgarbage("stop")
  line_count = line_count + 1

  -- printing text
  for word in line:gmatch("'(.-)'") do
  	local is_pointer = false

  	-- check if string inside text is a variable
  	if variables[word] then
  		is_pointer = true
  		print(variables[word]) 
  	elseif is_pointer == false then
  		print(word)
  	end

  end

  -- variables
  for key, value in line:gmatch("<(.-)>%[([^%]]+)%]") do
  	-- modify line:gmatch so that it works like this instead:
  	-- <my_var>["some value"]
  	variables[key] = value

  end

  -- pointers
  for output in line:gmatch("&(.-)&") do
  	local var_found = false
  	
  	if variables[output] then
  		--print(variables[output])
  		var_found = true
  	elseif var_found == false then
  		print("VARIABLE ACCESS ERROR ".. output .." DOES NOT EXIST")
  		print("DECLARE VARIABLES LIKE THIS")
  		print("<".. output .. ">" ..'["some value"]')
  	end

  end

  -- standard functions 
  for func, param in line:gmatch("!(.-)!([%d%a]+)") do
  	-- modify line:gmatch so that it accepts strings and numbers after the second exclamation mark
  	if func == "footprint" then 
  		standard_functions.footprint(tonumber(param))
  	elseif func == "quit" then
  		standard_functions.quit(tonumber(param))
  	elseif func == "win_cls" then
  		standard_functions.winClearScreen(tonumber(param))
  	elseif func == "cls" then
  		standard_functions.clearScreen(tonumber(param))
  	elseif func == "sleep" then
  		standard_functions.wait(tonumber(param))
  	elseif func == "workdir" then
  		standard_functions.printWorkingDirectory(tonumber(param))
  	end 

  end

end

-- close script and release any resources using it
script:close()

