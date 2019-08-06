
--- Global Variables ---
local EventsModule = require(game:GetService('ReplicatedStorage'):WaitForChild('CreateEvents'))
EventsModule.CreateEvents()
local Players = game:GetService("Players")
local System = script.Parent
  local Client = System:WaitForChild("Client")
  local Server = System:WaitForChild("Server")

--- Code ---

--[[
F:	Client Manager Block
D:	Create a folder to store all client scripts and parent to individiual PlayerGui.
	PlayerGui Must NOT reset for this to work.
]]
Players.PlayerAdded:Connect(function(Player)
  local ScriptFolder = Instance.new('Folder')
  ScriptFolder.Name = 'ClientScripts'

  for i, child in ipairs(Client:GetChildren()) do
  	local Script = child:Clone()
    Script.Parent = ScriptFolder
  end

  ScriptFolder.Parent = Player.PlayerGui
end)

--[[
F:	RemoveHandler
D:	Placeholder.
]]
Players.PlayerRemoving:Connect(function(player)
--	print(player.Name .. " left the game!")
end)
