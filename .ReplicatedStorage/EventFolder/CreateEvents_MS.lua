--[[

File:           CreateEvents.lua (ModuleScript)
Description:    Creates events.

Pre-requisites: FE Compatability, Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y

]]

local EventDirectory = game:GetService'ReplicatedStorage':WaitForChild'EventFolder';
---
local Module = {}

function CreateEvents()
  -- Event to deal with sprint
  local SprintRemote = Instance.new("RemoteEvent");
  SprintRemote.Parent = EventDirectory;
  SprintRemote.OnServerEvent:Connect(function(player,info))
      if tostring(info) == "EndSprint" then
          player.Character.Humanoid.WalkSpeed = 16
      end
      if tostring(info) == "StartSprint" then
          player.Character.Humanoid.WalkSpeed = sprintSpeed
      end
  end)
  --
  local GenericEvent = Instance.new("RemoteEvent")
  GenericEvent.Parent = EventDirectory;
  SprintRemote.OnServerEvent:Connect(function()
    print'Hello World!'
  end)
  --


end -- end createfunction.

return Module
