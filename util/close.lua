local function run(dhx)
    if(dhx.stri == "@xutil.close") then
        dhx.state = -math.mininteger
        os.exit()
    end
    dhx.state = 1
    print(dhx)
    return dhx
end

local config = {
    name="xutil.close"
}


return { run=run, config=config }