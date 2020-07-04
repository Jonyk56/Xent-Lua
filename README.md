# Xent-cli

The official CLI and interpreter for the Xentext langauge.

------------------------------

# to download:

Download as a ZIP or clone this repository to use, you must have lua 5.1/5.2
this comes with the Lua edition of XenText

------------------------------

# command line flags

Xent ( Lua Edition ) does not have any command line powers, so, yea, this is worthless, just run the main.lua file


-------------------------------

# interpreter commands

Type any Xent code into the interpreter and it will save to a file, this file is deleted later on.

1. `run()` - run any code you typed in earlier
2. `exit()` - exit the interpreter/unlink all session files
3. `moomoo()` - :D we brought a cow!

---------------------------------

# configuration file

Xent reads CLI configuration from **config.lua**, which must exist for the CLI to run. You can use the 
following sample to save hassle:

```lua
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

```

---------------------------------

# quite obvious small print

> &copy; 2020 17lwinn/XentDevs

> &copy; 2020 Jonyk56 ( Creator )

> &copy; 2020 eitan3085 ( Lua Edition dev )