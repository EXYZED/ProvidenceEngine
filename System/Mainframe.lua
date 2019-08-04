

local EventsModule = require(game:GetService('ReplicatedStorage'):WaitForChild('CreateEvents'))
EventsModule.CreateEvents()
local Players = game:GetService("Players")
local System = game:GetService("ServerScriptService"):WaitForChild("System")
  local Client = System:WaitForChild("Client")
  local Server = System:WaitForChild("Server")

---

Players.PlayerAdded:Connect(function(Player)
	local PlayerScripts = Client:GetChildren():Clone()
  PlayerScript.Parent = Player.PlayerScripts
end)

Players.PlayerRemoving:Connect(function(player)
	print(player.Name .. " left the game!")
end)
