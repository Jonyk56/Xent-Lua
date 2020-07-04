local conf = {
	--[[ 
		example:
		INSTALLED_PACKAGES={ "pkg.1"}
	]]--
	INSTALLED_PACKAGES={}, --xent packages installed
	EXPERIMENTAL_MODE=false, --enable experimental features
	Block_Run_From_console=false, --block running xent files from console
	runtime_opt={
		compiler="xent.lua ", --space must be at end of string or error
		version="0.2 LUA"
	}
}


local function GetPackages(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
end



local package = {
	conf = conf,
	gpack= GetPackages
}

return conf