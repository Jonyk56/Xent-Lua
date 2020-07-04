-- Parser Speed
-- ~1,000,000 whitespaces / s
-- ~1,000 whitespaces / ms

local instructions = ...
local config = require("conf")

local modules_ = {}

-- TO DO
-- Put functions in a table
--[[
  {
    {
      name = "hi",
      run = function(args)

      end
    }
  }
]]--

local function input(prompt)
  io.write(prompt)
  return io.read()
end

local function lex(instruction)
  local stri = "" -- string of data

  local state = 0 -- state of data
  -- state 0: default state
  -- state 1: string printing
  -- state 2: comment
  -- state 3: command runner
  -- if in a string

  local in_str = 0 -- am i in a string?
  
  local no_brk = 0 -- breakpoints
  local cmd_run = "" --macros

  local pl_run = {}

  local prev_char = ""

  for i=1, #instruction do -- actual parser
    local char = instruction:sub(i, i)

    stri = stri .. char

    if
      (char == " " and (state == 0 or state == -1) and in_str == 0)
      or (char == "!" and state == 0 and in_str == 0)
      or (char == "\n" and state == 0 and in_str == 0)
    then
      stri = ""
    
    elseif (stri == "PRINT" or stri == "print") and state == 0 then
      state = 1
      stri = ""

    elseif (char == "\"" or char == "\'") and state == 1 and in_str == 0 then
      in_str = 1
      stri = ""
    
    elseif state == 1 and in_str == 1 and (char == "\"" or char == "\'") then
      in_str = 0
      print(string.sub(stri, 1, #stri - 1))
      stri = ""
      state = 0
    
    -- Comments
    elseif state == 0 and stri == "~" then
      state = 2
      stri = ""

    elseif state == 2 and stri == "~" then
      state = 0
      stri = ""

    -- Macros
    elseif state == 0 and char == "%" then
      -- Macro Instator
      state = 3
      stri = ""
    
    elseif state == 3 and char == "%" then
      state = 0
      stri = ""

      --os.popen stuff
			os.execute(cmd_run)
    elseif state == 3 then
      cmd_run = cmd_run .. char
      stri = ""

    -- Breakpoint @brk
    elseif state == 0 and no_brk == 0 and stri == "@brk" then
      input("===") -- implemented custom function
      stri = ""

    elseif state == 0 and no_brk == 0 and stri == "@nbrk" then
      no_brk = 1
      stri = ""

    elseif state == 0 and no_brk == 1 and stri == "@ybrk" then
      no_brk = 0
      stri = ""
      
    --[[elseif state == 0 and string.sub(stri, 1, 5) == "@hold" then
      local duration = os.time() + tonumber(string.sub(stri, 5, #stri))
      -- whiny linux >:C
      repeat until os.time() >= duration
      -- let us destroy @hold
    end]] --lua is weird
    


		--plugin hell
		elseif state == 0 and stri == "@import" then
      state = 5
      stri = ""
    
    elseif (char == "\"" or char == "\'") and state == 5 and in_str == 0 then
      in_str = 1
      stri = ""

    elseif state == 5 and in_str == 1 and  (char == "\"" or char == "\'") then
      in_str = 0
      pl_run[#pl_run + 1] = string.sub(stri, 1, #stri - 1)
      state = 0
		end
		for _,plugin in ipairs(pl_run) do
			if not modules_[plugin] then break end
			local dhx = {
				LIN = "",
				state = 0,
				stri = "",
				prev_char = "",
				in_str = 0
			}
			dhx["LIN"] = instruction
			dhx["state"] = state
			dhx["stri"] = stri
			dhx["prev_char"] = prev_char
			dhx["in_str"] = in_str

			local abx = modules_[plugin].run(dhx)

			stri = abx["stri"]
			state = abx["state"]
			in_str = abx["in_str"]
		end

		prev_char = char
	
  end
end

local function main()
  for _,module in ipairs(config.INSTALLED_PACKAGES) do
    modules_[module] = require(module)
    print("Loaded " .. module)
  end

  for _,instruction in ipairs(instructions) do lex(instruction) end
end

main()