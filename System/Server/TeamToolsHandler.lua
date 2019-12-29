--[[

File:           TeamHandler.lua (ServerScript)
Description:    Should dynamically handle Tools and UIs for all teams automatically given in the TeamService.
				Team pre-requisities i.e Rank and GroupID Are ignored in this script and should be handled through Client.

Pre-requisites: FE Compatability, Greatest Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y


-- Instance Heirarchy

	┌ Team
	├── Team Specific Tools
	├── Team Specific UI
	├── *IntValue of GroupID (Named GroupID)
	└── *IntValue of Minimum Rank Required Inclusive (Named Rank)

	[*] Optional Instances
]]

local function ToolProvision(Player)
	--[[
	for BackpackI , Tool in pairs(Player.Backpack:GetChildren())do
		Tool:Destroy();
	end
	--]]
	--
	if Player.Team == nil then return end

	for Index, TeamInstance in pairs(Player.Team:GetChildren()) do
			local Replicant = TeamInstance:Clone()
			if TeamInstance:isA('Tool') then
				Replicant.Parent = Player.Backpack
			elseif TeamInstance:isA('ScreenGui') then
				Replicant.Parent = Player.PlayerGui
			else
				Replicant.Parent = nil
			end

		end
	end

for Index, Player in ipairs(game:GetService("Players"):GetChildren()) do
	Player.CharacterAdded:Connect(function(character)
		ToolProvision(Player)
	end)
end

game.Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(character)
		ToolProvision(Player)
	end)
end)
