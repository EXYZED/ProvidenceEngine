--[[


File          : SprintHandler.lua (Responder)
Responder     : /Static/SprintHandler.local.lua
Description   : Enables serverside interaction to change parameters such as Walkspeed.

Pre-requisites: FE-Compatability, Efficient.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      HIGH Y

]]

local UniverseSettings 		= game:GetService('ReplicatedStorage').Providence:WaitForChild('UniverseSettings');
local EventDirectory      = game:GetService('ReplicatedStorage').Providence:WaitForChild('EventFolder');
local InteractivityDir		= UniverseSettings:WaitForChild('Interactivity');
local StdWalkspeed 				= InteractivityDir.PlayerWalkSpeed.Value;
local SprWalkspeed 				= InteractivityDir.PlayerSprintSpeed.Value;

local SprintRemote        = Instance.new("RemoteEvent");
      SprintRemote.Name   = "SprinterRemote";
      SprintRemote.Parent = EventDirectory;
      SprintRemote.OnServerEvent:Connect(function(player,info)
        repeat wait() until player.Character:FindFirstChild('Humanoid')
        if tostring(info) == "EndSprint" then
            player.Character.Humanoid.WalkSpeed = StdWalkspeed
        end
        if tostring(info) == "StartSprint" then
            player.Character.Humanoid.WalkSpeed = SprWalkspeed
        end
      end)
