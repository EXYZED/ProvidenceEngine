--[[

File:           CreateEvents.lua (ModuleScript)
Description:    Creates events.

Pre-requisites: FE Compatability, Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y

]]

--  Global Variables --
local HttpService = game.GetService'HttpService'
local EventDirectory = game:GetService'ReplicatedStorage':WaitForChild'Providence':WaitForChild'EventFolder';
local ModuleDirectory = game:GetService'ReplicatedStorage':WaitForChild'Providence':WaitForChild'PublicModules';
  local Async = require(ModuleDirectory:WaitForChild'Async');
local UniverseSettings = HttpService:JSONDecode(Async.Get("https://raw.githubusercontent.com/EXYZED/ProvidenceEngine/master/UniverseSettings.json"))

local sprintSpeed    = UniverseSettings.Interactivity.PlayerSprintSpeed;
-----------
local Module = {}

function Module:CreateEvents()
  -- Event to deal with sprint
  local SprintRemote = Instance.new("RemoteEvent");
  SprintRemote.Name = "SprinterRemote"
  SprintRemote.Parent = EventDirectory;
  SprintRemote.OnServerEvent:Connect(function(player,info)
      if tostring(info) == "EndSprint" then
          player.Character.Humanoid.WalkSpeed = 16
      end
      if tostring(info) == "StartSprint" then
          player.Character.Humanoid.WalkSpeed = sprintSpeed
      end
  end)
  --
  local GenericEvent = Instance.new("RemoteEvent")
  GenericEvent.Name = "GenericExampleEvent"
  GenericEvent.Parent = EventDirectory;
  GenericEvent.OnServerEvent:Connect(function()
    print'Hello World!'
  end)
  --


end -- end createfunction.

return Module
