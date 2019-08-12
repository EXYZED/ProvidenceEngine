--[[


File:           LocalisedGui.lua (LocalScript)
Description:    Place in GUI, edit corresponding to team.

Pre-requisites: FE-Compatability, NOT-Efficient.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      N

]]

local GUI 		= 	script.Parent;
local Teams		= 	game:GetService('Teams');
local Player	=	game:GetService('Players').LocalPlayer;

--

local TeamName 	=	"Teamj"

--

for index,	Team in pairs(Teams:GetTeams())do
	if Team.Name ~= TeamName then
		for index, descendant in pairs(GUI:GetDescendants()) do
			if descendant:IsA('BaseScript') then
				descendant:Destroy();
			end
		end
		GUI.Enabled = false	--Destroy();
	end
end
