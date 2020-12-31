local shortname = "evorts"

local mapWhitelist       = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/mapWhitelist.lua")
local aiBlacklist        = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/aiBlacklist.lua")
local singleplayerConfig = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/singleplayerMenu.lua")
local helpSubmenuConfig  = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/helpSubmenuConfig.lua")
local skirmishDefault    = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/skirmishDefault.lua")
local defaultModoptions  = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/ModOptions.lua")
local rankFunction       = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/zk/rankFunction.lua")
local backgroundConfig   = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/skinning/skinConfig.lua")

local link_homePage, link_maps = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/linkFunctions.lua")

local settingsConfig, settingsNames, settingsDefault = VFS.Include(LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/settingsMenu.lua")

local headingLarge    = LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/skinning/headingLarge.png"
local headingSmall    = LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/skinning/headingSmall.png"
local backgroundImage = LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/skinning/background.jpg"
local taskbarIcon     = LUA_DIRNAME .. "configs/gameConfig/" .. shortname .. "/taskbarLogo.png"

local background = {
	image           = backgroundImage,
	backgroundFocus = backgroundConfig.backgroundFocus,
}

local minimapOverridePath  = LUA_DIRNAME .. "configs/gameConfig/evorts/minimapOverride/"
local minimapThumbnailPath = LUA_DIRNAME .. "configs/gameConfig/evorts/minimapThumbnail/"

---------------------------------------------------------------------------------
-- Getters
---------------------------------------------------------------------------------

local externalFuncAndData = {
	dirName                = "evorts",
	name                   = "Evolution RTS",
	--_defaultGameArchiveName = "??", fill this in.
	_defaultGameRapidTag   = "evo:stable", -- Do not read directly
	editor                 = "rapid://sb-evo:test",
	--editor                 = "SpringBoard EVO $VERSION",
	mapWhitelist           = mapWhitelist,
	aiBlacklist            = aiBlacklist,
	settingsConfig         = settingsConfig,
	settingsNames          = settingsNames,
	settingsDefault        = settingsDefault,
	singleplayerConfig     = singleplayerConfig,
	helpSubmenuConfig      = helpSubmenuConfig,
	skirmishDefault        = skirmishDefault,
	defaultModoptions      = defaultModoptions,
	rankFunction           = rankFunction,
	headingLarge           = headingLarge,
	headingSmall           = headingSmall,
	taskbarTitle           = "Evolution RTS",
	taskbarTitleShort      = "EvoRTS",
	taskbarIcon            = taskbarIcon,
	background             = background,
	minimapOverridePath    = minimapOverridePath,
	minimapThumbnailPath   = minimapThumbnailPath,
	ignoreServerVersion    = true,
	battleListOnlyShow     = "Evolution RTS -",
	disableBattleListHostButton = true, -- Hides "Host" button as this function is not working as one might imagine
	disableSteam 				= true, -- removes settings related to steam
	disablePlanetwars 			= true, -- removes settings related to planetwars
	disableMatchMaking 			= true, -- removes match making
	disableCommunityWindow 		= true, -- removes Community Window
	disableZKMapFiltering       = true, -- removes ZK "featured" map filter
	link_homePage,
	link_maps,
	randomTrackList = {
		"LuaMenu/configs/gameConfig/evorts/lobbyMusic/Ad Infinitum.ogg",
		"LuaMenu/configs/gameConfig/evorts/lobbyMusic/Code Of Existence.ogg",
		"LuaMenu/configs/gameConfig/evorts/lobbyMusic/Coherence.ogg",
		"LuaMenu/configs/gameConfig/evorts/lobbyMusic/Emergence.ogg",
	},
}

function externalFuncAndData.CheckAvailability()
	return true
end

return externalFuncAndData
