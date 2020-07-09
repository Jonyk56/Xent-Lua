------------------------------------
-- XenText Interpreter
-- Written in Lua by eitan3085/Snorp
------------------------------------
local config = require("conf")
local function run()
  local success, error = pcall(function()
    local instructions = {}
    for line in io.lines(".temp.xt") do
      instructions[#instructions + 1] = line
    end
    assert(loadfile("xent.lua"))(instructions)
    os.remove(".temp.xt") -- no forcerun needed b.c. cache
  end)
  if error then
    print("Error occured while evaluating the code:")
    print(error)
  end
end

local function exit()
  print("Exiting the interpreter...")
  pcall(function() os.remove(".temp.xt") end)
  os.exit()
end

local function prompt()
  io.write(">>> ")
  local input = io.read()

  if input == "run()" then
    run()
    return
  elseif input == "exit()" then
    exit()
    return
  end
  
  local file = io.open(".temp.xt", "a")
  file:write(input)
	file:write("\n")
	file:close()

  return
end

local function main()
  print("XenText Interpreter ( Xent version " .. config.runtime_opt.version)
  print("Type XenText Code here, then type run() to execute it")
  print("or type exit() to exit the interpreter")

  while true do prompt() end
end

main()