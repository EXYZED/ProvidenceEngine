--[[

File:           CelestialControl.lua (ServerScript)
Description:    Should handle TimeOfDay scrolling between day and night, requests to change time through
                a connected remote event.

Pre-requisites: FE Compatability, Greatest Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y

]]

local TweenService 				= game:GetService("TweenService")

local UniverseSettings 		= game:GetService('ReplicatedStorage').Providence:WaitForChild('UniverseSettings')
local SceneryDirectory		= UniverseSettings:WaitForChild('Scenery')
local CycleTime 					= SceneryDirectory.CycleTime.Value
local RandomStartTime 		= math.random(7, 16)

--
game.Lighting.ClockTime 	= RandomStartTime

local LightGoal = {}
LightGoal.ClockTime = 24
local LightStyle = TweenInfo.new(CycleTime*(RandomStartTime/24), Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
TweenService:Create(game.Lighting, LightStyle, LightGoal):Play()
delay(0.000001, function()
	game.Lighting.ClockTime = 0
	local LightGoal = {}
	LightGoal.ClockTime = 24
	local LightStyle = TweenInfo.new(CycleTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1)
	TweenService:Create(game.Lighting, LightStyle, LightGoal):Play()
end)

local CurrentDayCycle = ""

while script do
	if game.Lighting.ClockTime >= 0 and game.Lighting.ClockTime < 6 then
		if CurrentDayCycle ~= "NightTime" then
			local AmbientGoal = {}
			AmbientGoal.FogColor = Color3.fromRGB(24, 42, 63)
			AmbientGoal.FogEnd = 7000
			AmbientGoal.FogStart = 50
			AmbientGoal.OutdoorAmbient = Color3.fromRGB(107, 107, 107)
			local AmbientStyle = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
			TweenService:Create(game.Lighting, AmbientStyle, AmbientGoal):Play()
		end
		CurrentDayCycle = "NightTime"
	elseif game.Lighting.ClockTime >= 6 and game.Lighting.ClockTime < 6.25 then
		if CurrentDayCycle ~= "SunRise" then
			local AmbientGoal = {}
			AmbientGoal.FogColor = Color3.fromRGB(146, 163, 114)
			AmbientGoal.FogEnd = 7000
			AmbientGoal.FogStart = 600
			AmbientGoal.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
			local AmbientStyle = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
			TweenService:Create(game.Lighting, AmbientStyle, AmbientGoal):Play()
		end
		CurrentDayCycle = "SunRise"
	elseif game.Lighting.ClockTime >= 6.25 and game.Lighting.ClockTime < 17.75 then
		if CurrentDayCycle ~= "DayTime" then
			local AmbientGoal = {}
			AmbientGoal.FogColor = Color3.fromRGB(75, 129, 191)
			AmbientGoal.FogEnd = 10000
			AmbientGoal.FogStart = 1750
			AmbientGoal.OutdoorAmbient = Color3.fromRGB(136, 136, 136)
			local AmbientStyle = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
			TweenService:Create(game.Lighting, AmbientStyle, AmbientGoal):Play()
		end
		CurrentDayCycle = "DayTime"
	elseif game.Lighting.ClockTime >= 17.75 and game.Lighting.ClockTime < 18 then
		if CurrentDayCycle ~= "SunSetting" then
			local AmbientGoal = {}
			AmbientGoal.FogColor = Color3.fromRGB(146, 163, 114)
			AmbientGoal.FogEnd = 7000
			AmbientGoal.FogStart = 600
			AmbientGoal.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
			local AmbientStyle = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
			TweenService:Create(game.Lighting, AmbientStyle, AmbientGoal):Play()
		end
		CurrentDayCycle = "SunSetting"
	elseif game.Lighting.ClockTime >= 18 and game.Lighting.ClockTime <= 24 then
		if CurrentDayCycle ~= "NightTime" then
			local AmbientGoal = {}
			AmbientGoal.FogColor = Color3.fromRGB(24, 42, 63)
			AmbientGoal.FogEnd = 7000
			AmbientGoal.FogStart = 50
			AmbientGoal.OutdoorAmbient = Color3.fromRGB(107, 107, 107)
			local AmbientStyle = TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
			TweenService:Create(game.Lighting, AmbientStyle, AmbientGoal):Play()
		end
		CurrentDayCycle = "NightTime"
	end
	wait(2.25)
end
