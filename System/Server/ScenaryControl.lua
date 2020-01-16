--[[

File:           ScenaryControl.lua (ServerScript)
Description:    Deals with minor effects such as road lamps, rain etc.

Pre-requisites: FE Compatability, Greatest Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y

]]--

local UniverseSettings 		= game:GetService('ReplicatedStorage').Providence:WaitForChild('UniverseSettings')
local Rain                = require(game:GetService('ReplicatedStorage').Providence.PublicModules.Rain)
local SceneryDirectory		= UniverseSettings:WaitForChild('Scenery')
local EventsDirectory		  = UniverseSettings:WaitForChild('Events')
local RainChance 					= EventsDirectory.ProbabilityRain.Value

---

local StreetLights        = {}
local DecimalAccuracy     = (1e9)
local Counter01           = 0

---

local function RandomNumeric(Low,High)
  return math.floor(math.random()*(High-Low)*(DecimalAccuracy))/(DecimalAccuracy) + Low
end
--

local function GetStreetLights()
  for Index, Object in ipairs (game.Workspace:WaitForChild('Streetlights'):GetDescendents()) do
  if (Object.Name == 'Light') and (Object.Parent == "Streetlight") then
    table.Insert(StreetLights,Object.Light)
  end
end

local function CheckGameTime()

    if (game.Lighting.ClockTime >= 0 and game.Lighting.ClockTime <= 6) or (game.Lighting.ClockTime >= 21 and game.Lighting.ClockTime <= 24)  then
      return 'Night'
    else
      return 'Day'
    end

  return nil
end

local function RunLights(Mode)
  if Mode == true then
    for Index, LightInstance in ipairs (StreetLights) do
      LightInstance.Enabled = true
    end
  else
    for Index, LightInstance in ipairs (StreetLights) do
      LightInstance.Enabled = false
    end
  end
end

----------
local function Runtime()
  while true do local StartT = tick() ; wait((tick() - StartT)*1.5e6); -- Variable timing, lag reduction

    Counter01 = (Counter01 + 1)
    if Counter01 == 10 then  -- Reduce the number of operations, Check time for every 10 generic ticks - lag reduction
      if CheckGameTime() == 'Night' then
        RunLights(true)
      elseif CheckGameTime() == 'Day' then
        RunLights(false)
      end
    end

    if RandomNumeric(0,0.09) < RainChance then
      Rain:Enable()
    end
  end
end

function RainEvent()

end
