--[[

File:           CelestialControl.lua (ServerScript)
Description:    Should handle TimeOfDay scrolling between day and night, requests to change time through
                a connected remote event.

Pre-requisites: FE Compatability, Greatest Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y

]]

Lighting = game:GetService("Lighting")
--[[ Broken Script
while true do
	wait(1)
	T = Lighting:GetMinutesAfterMidnight(T + 1)
	Lighting:SetMinutesAfterMidnight(T + 1)
end

]]
