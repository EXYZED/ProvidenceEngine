--[[

DEPRECATED!DEPRECATED!DEPRECATED!DEPRECATED!DEPRECATED!DEPRECATED!DEPRECATED!DEPRECATED!
File:           CreateEvents.lua (ModuleScript)
Description:    Creates events.

Pre-requisites: FE Compatability, Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y

]]

--  Global Variables --
local HttpService       = game:GetService'HttpService'
local EventDirectory    = game:GetService'ReplicatedStorage':WaitForChild'Providence':WaitForChild'EventFolder';
local ModuleDirectory   = game:GetService'ReplicatedStorage':WaitForChild'Providence':WaitForChild'PublicModules';
local Async             = require(ModuleDirectory:WaitForChild'Async');
local UniverseSettings  = HttpService:JSONDecode(Async.Get("https://raw.githubusercontent.com/EXYZED/ProvidenceEngine/master/UniverseSettings.json"))
-----------
local Module = {}

function Module:CreateEvents()
  --
  local GenericEvent = Instance.new("RemoteEvent")
  GenericEvent.Name = "GenericExampleEvent"
  GenericEvent.Parent = EventDirectory;
  GenericEvent.OnServerEvent:Connect(function()
  end)
  --


end -- end createfunction.

return Module
