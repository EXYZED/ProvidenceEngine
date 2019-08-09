--[[


File:           SprintHandler.lua (LocalScript)
Description:    Added running functionality, Double tap W and Shift Run.

Pre-requisites: FE-Compatability, Efficient.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      HIGH Y

]]

--Variables--
local Debounce = false
local timeUntilReset = 0.4 -- Duration of subsequent W presses to trigger sprinting.
local MainRemote = game:GetService('ReplicatedStorage'):WaitForChild'Providence':WaitForChild('EventFolder'):WaitForChild('SprinterRemote')
--------------

game:GetService('UserInputService').InputBegan:Connect(function(input, processed)
   if input.KeyCode == Enum.KeyCode.LeftShift then
        MainRemote:FireServer('StartSprint')
    end

    if input.KeyCode == Enum.KeyCode.W then
        if Debounce == false then
            Debounce = true
            spawn(function()
                wait(timeUntilReset)
                Debounce = false
            end)
        else
            Debounce = false
            MainRemote:FireServer('StartSprint')
        end
    end
end)

game:GetService('UserInputService').InputEnded:Connect(function(input, gameProcessed)
    if (input.KeyCode == Enum.KeyCode.W) or (input.KeyCode == Enum.KeyCode.LeftShift) then
        MainRemote:FireServer('EndSprint')
    end
end)
