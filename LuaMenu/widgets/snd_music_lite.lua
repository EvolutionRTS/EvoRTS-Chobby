--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
	return {
		name	= "Music Player Lite",
		desc	= "Plays music for ingame lobby client",
		author	= "GoogleFrog and KingRaptor",
		date	= "25 September 2016",
		license	= "GNU GPL, v2 or later",
		layer	= 2000,
		enabled	= true	--	loaded by default?
	}
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local playingTrack	-- boolean
local previousTrack
local loopTrack	-- string trackPath
local randomTrackList
local openTrack

local function GetRandomTrack(previousTrack)
	local trackCount = #randomTrackList
	local previousTrackIndex
	if previousTrack then
		for i = 1, #randomTrackList do
			if randomTrackList[i] == previousTrack then
				trackCount = trackCount - 1
				previousTrackIndex = i
				break
			end
		end
	end

	local randomTrack = math.ceil(math.random()*trackCount)
	if randomTrack == previousTrackIndex then
		randomTrack = trackCount + 1
	end
	return randomTrackList[randomTrack]
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function StartTrack(trackName, snd_volmusic)
	snd_volmusic = Spring.GetConfigInt("snd_volmusic")
	trackName = trackName or GetRandomTrack(previousTrack)
	Spring.Echo("[Lobby Music Player] Starting Track", trackName, snd_volmusic)
	if snd_volmusic == 0 then
		return
	end
	Spring.StopSoundStream()
	Spring.PlaySoundStream(trackName, snd_volmusic)
	Spring.SetSoundStreamVolume(snd_volmusic)
	playingTrack = true
end

local function LoopTrack(trackName, trackNameIntro, snd_volmusic)
	trackNameIntro = trackNameIntro or trackName
	loopTrack = trackName
	StartTrack(trackNameIntro, snd_volmusic)
	Spring.SetSoundStreamVolume(snd_volmusic)
end

local function StopTrack()
	Spring.StopSoundStream()
	playingTrack = false
	loopTrack = nil
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function SetTrackVolume(snd_volmusic)
	if snd_volmusic == 0 then
		StopTrack()
		return
	end
	if playingTrack then
		Spring.SetSoundStreamVolume(snd_volmusic)
		return
	end
	StartTrack(GetRandomTrack(), snd_volmusic)
	Spring.SetSoundStreamVolume(snd_volmusic)
	previousTrack = nil
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local firstActivation = true
local ingame = false

function widget:Update()
	snd_volmusic = Spring.GetConfigInt("snd_volmusic")

	if ingame or (snd_volmusic == 0 )then
		return
	end

	if not playingTrack then
		return
	end

	local playedTime, totalTime = Spring.GetSoundStreamTime()
	playedTime = math.floor(playedTime)
	totalTime = math.floor(totalTime)

	if (playedTime >= totalTime) then
		local newTrack = loopTrack or GetRandomTrack(previousTrack)
		StartTrack(newTrack)
		Spring.SetSoundStreamVolume(snd_volmusic)
		previousTrack = newTrack
	end
end

local MusicHandler = {
	StartTrack = StartTrack,
	StopTrack = StopTrack,
	LoopTrack = LoopTrack
}

-- Called just before the game loads
-- This could be used to implement music in the loadscreen
--function widget:GamePreload()
--	-- Ingame, no longer any of our business
--	if Spring.GetGameName() ~= "" then
--		ingame = true
--		StopTrack()
--	end
--end

-- called when returning to menu from a game
function widget:ActivateMenu()
	ingame = false
	if firstActivation then
		StartTrack(openTrack)
		Spring.SetSoundStreamVolume(snd_volmusic)
		previousTrack = openTrack
		firstActivation = false
		return
	end
	-- start playing music again
	local newTrack = GetRandomTrack(previousTrack)
	StartTrack(newTrack)
	Spring.SetSoundStreamVolume(snd_volmusic)
	previousTrack = newTrack
end

function widget:Initialize()
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------
	--Lets unfuck these volumes.

	musicInitialValue = Spring.GetConfigInt("evo_musicInitialValue", 0)
	if musicInitialValue ~= 1 then
		Spring.SetConfigInt("snd_volmusic", 10)
		Spring.SetConfigInt("evo_musicInitialValue", 1)
		Spring.Echo("[Lobby Music Player] Setting initial music volume")
	end

	snd_volmusic = Spring.GetConfigInt("snd_volmusic")
	--------------------------------------------------------------------------------
	--------------------------------------------------------------------------------

	-- load custom game dependent music
	randomTrackList = WG.Chobby.Configuration.gameConfig.randomTrackList

	if randomTrackList == nil or #randomTrackList == 0 then
		Spring.Log("snd_music.lite.lua", LOG.NOTICE, "No random track list found, disabling lobby music")
		widgetHandler:RemoveWidget()
		return
	end

	openTrack = WG.Chobby.Configuration.gameConfig.openTrack
	if openTrack == nil then
		openTrack = randomTrackList[math.random(#randomTrackList)]
	end

	math.randomseed(os.clock() * 100)

	local Configuration = WG.Chobby.Configuration

	local function onConfigurationChange(listener, key, value)
		if key == "menuMusicVolume" then
			snd_volmusic = Spring.GetConfigInt("snd_volmusic")
			SetTrackVolume(snd_volmusic)
		end
	end
	Configuration:AddListener("OnConfigurationChange", onConfigurationChange)

	local function OnBattleAboutToStart()
		ingame = true
		StopTrack()
	end
	WG.LibLobby.localLobby:AddListener("OnBattleAboutToStart", OnBattleAboutToStart)
	WG.LibLobby.lobby:AddListener("OnBattleAboutToStart", OnBattleAboutToStart)

	WG.MusicHandler = MusicHandler
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
