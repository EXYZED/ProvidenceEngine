--[[

File:           ScenaryControl.lua (ServerScript)
Description:    Deals with minor effects such as road lamps, rain etc.

Pre-requisites: FE Compatability, Greatest Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y

]]--

local UniverseSettings 		= game:GetService("ReplicatedStorage").Providence:WaitForChild("UniverseSettings")
local Rain                = require(game:GetService("ReplicatedStorage").Providence.PublicModules.Rain)
local SceneryDirectory		= UniverseSettings:WaitForChild("Scenery")
local EventsDirectory		  = UniverseSettings:WaitForChild("Events")
local RainChance 					= EventsDirectory.ProbabilityRain.Value

---

local LightElement		  = {}
local DecimalAccuracy     = (1e9)
local Counter01           = 0

---

local function RandomNumeric(Low,High)
  return (math.floor(math.random()*(High-Low)*(DecimalAccuracy))/(DecimalAccuracy) + Low)
end
--

local function GetLIghtElements()
  for Index, Object in ipairs (game.Workspace:WaitForChild("DynamicLightElements"):GetDescendants()) do
	  if (Object.Name == "Light") and (Object:IsA("Light")) and Object then
		print(Object.Name)
		LightElement[#LightElement+1] = Object
	  end
  end
end


local function CheckGameTime()
    if (game.Lighting.ClockTime >= 0 and game.Lighting.ClockTime <= 6) or (game.Lighting.ClockTime >= 21 and game.Lighting.ClockTime <= 24)  then
        return "Night"
      elseif not (game.Lighting.ClockTime >= 0 and game.Lighting.ClockTime <= 6) or (game.Lighting.ClockTime >= 21 and game.Lighting.ClockTime <= 24) then
        return "Day"
      else
        return false
    end
end

local function RunLights(Mode)
  if (Mode == true) then
    for Index, LightInstance in ipairs (LightElement) do
      LightInstance.Enabled = true
	  if LightInstance.Parent:IsA"BasePart" or LightInstance.Parent:IsA"UnionOperation" then
		LightInstance.Parent.Material = "Neon"
	  end
    end
  else
    for Index, LightInstance in ipairs (LightElement) do
      LightInstance.Enabled = false
		if LightInstance.Parent:IsA"BasePart" or LightInstance.Parent:IsA"UnionOperation" then
			LightInstance.Parent.Material = "SmoothPlastic"
	  	end
    end
  end
end

function RainEvent()
  print("AHHH")
end

----------
local function RuntimeA()
  while true do local StartT = tick() ; wait((tick() - StartT)*1.5e6); -- Variable timing, lag reduction
      Counter01 = (Counter01 + 1)
      if Counter01 == 10 then  -- Reduce the number of operations, Check time for every 10 generic ticks - lag reduction
        if CheckGameTime() == "Night" then
					print("IteratedN")
          RunLights(true)
        elseif CheckGameTime() == "Day" then
					print("IteratedD")
          RunLights(false)
        end
		Counter01 = 0
      end
      print(RandomNumeric())
      if RandomNumeric(0,0.09) < RainChance then
        RainEvent();
        --Rain:Enable()
      end
    end
  end


GetLIghtElements()
RuntimeA()
