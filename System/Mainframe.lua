--[[

File:           Mainframe.lua (ServerScript)
Description:    System.

Pre-requisites: FE Compatability, Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y*

]]


local Version = 'e.10.01'

---  Game Services  	---
local HttpService 		= game:GetService('HttpService')
local Players 			= game:GetService("Players")

--- Global Variables 	---
local ModuleDirectory 	= game:GetService'ReplicatedStorage':WaitForChild'Providence':WaitForChild'PublicModules';
local EventsModule 		= require(ModuleDirectory:WaitForChild'CreateEvents');
local Async 			= require(ModuleDirectory:WaitForChild'Async');

local UniverseSettings = HttpService:JSONDecode(Async.Get("https://raw.githubusercontent.com/EXYZED/ProvidenceEngine/master/UniverseSettings.json"))

--- Local Variables		---
local System 			= script.Parent
  local Client 			= System:WaitForChild("Client")
  local Server 			= System:WaitForChild("Server")

local Blacklist			= UniverseSettings.Blacklist
---       Code      	---

print('Providence Engine Version: '..Version..', Running on '.. _VERSION)

--[[
F:	Client Manager Block
D:	Create a folder to store all client scripts and parent to individiual PlayerGui.
	PlayerGui Must NOT reset for this to work.
]]
Players.PlayerAdded:Connect(function(Player)
	print(Player.Name..' joined the game')
	for index, child in ipairs(Blacklist) do
  		if Player.Name == tostring(child) then
		Players.Player:Kick("You have been blacklisted.")
		end
  	end

  	local ScriptFolder = Instance.new('Folder')
  	ScriptFolder.Name = 'ClientScripts'

  	for i, child in ipairs(Client:GetChildren()) do
  		local Script = child:Clone()
   		Script.Parent = ScriptFolder
  	end

  	ScriptFolder.Parent = Player.PlayerGui
end)

EventsModule.CreateEvents()
--[[
F:	RemoveHandler
D:	Placeholder.
]]
Players.PlayerRemoving:Connect(function(player)
--	print(player.Name .. " left the game!")
end)
