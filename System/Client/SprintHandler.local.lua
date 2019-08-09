--Variables--
text = ""
timeUntilReset = 0.3
MainRemote = game:GetService("ReplicatedStorage"):WaitForChild'Providence':WaitForChild("EventFolder"):WaitForChild("SprinterRemote")
--------------

game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
   if input.KeyCode == Enum.KeyCode.LeftShift then
        MainRemote:FireServer("StartSprint")
    end

    if input.KeyCode == Enum.KeyCode.W then
        if text == "" then
            text = "w"
            spawn(function()
                wait(timeUntilReset)
                text = ""
            end)
        else
            text = ""
            MainRemote:FireServer("StartSprint")
        end
    end
end)

game:GetService('UserInputService').InputEnded:Connect(function(input, gameProcessed)
     if input.KeyCode == Enum.KeyCode.W then
        MainRemote:FireServer("EndSprint")
    end
    if input.KeyCode == Enum.KeyCode.LeftShift then
        MainRemote:FireServer("EndSprint")
    end
end)
