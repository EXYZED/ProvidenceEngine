

local EventsModule = require(game:GetService('ReplicatedStorage'):WaitForChild('CreateEvents'))
EventsModule.CreateEvents()
local Players = game:GetService("Players")
local System = script.Parent
  local Client = System:WaitForChild("Client")
  local Server = System:WaitForChild("Server")

---

Players.PlayerAdded:Connect(function(Player)
  for i, child in ipairs(Client:GetChildren()) do
  	local Script = child:Clone()
    Script.Parent = Player.PlayerScripts
  end
end)

Players.PlayerRemoving:Connect(function(player)
	print(player.Name .. " left the game!")
end)
