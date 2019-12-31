--[[


File:           LoadingSequence.lua (LocalScript)
Description:    Your GUI.

Pre-requisites: FE-Compatability, Efficient.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      HIGH Y

]]


-- ClientLoadingUI
-- Instances:
local Player = game:GetService'Players'.LocalPlayer
local LoadingUI = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local LoadingCircle = Instance.new("Frame")
--Properties:
LoadingUI.Enabled = false
LoadingUI.Name = "LoadingUI"
LoadingUI.Parent = Player.PlayerGui
LoadingUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoadingUI.ResetOnSpawn = false

Frame.Parent = LoadingUI
Frame.BackgroundColor3 = Color3.new(0.164706, 0.152941, 0.145098)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(1, 0, 1, 0)

LoadingCircle.Name = "LoadingCircle"
LoadingCircle.Parent = Frame
LoadingCircle.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingCircle.BackgroundColor3 = Color3.new(0.164706, 0.152941, 0.145098)
LoadingCircle.BorderSizePixel = 0
LoadingCircle.Position = UDim2.new(0.100000001, 0, 0.5, 0)
LoadingCircle.Size = UDim2.new(0.100000001, 0, 0.100000001, 0)
LoadingCircle.SizeConstraint = Enum.SizeConstraint.RelativeYY
LoadingCircle.Visible = false
LoadingCircle.ZIndex = 2
-- Scripts:
function SCRIPT_GEZU75_FAKESCRIPT() -- LoadingCircle.CircleAnimator
	local script = Instance.new('LocalScript')
	script.Parent = LoadingCircle
	local makeGIF = require(game:GetService'ReplicatedStorage':WaitForChild'Providence':WaitForChild'PublicModules':WaitForChild('GIFInterface'))

	local GIF = makeGIF({
		Screen = script.Parent,
		Frames = {
			{
				Asset = 'rbxassetid://3606528997',
				Cols = 7,
				Count = 54,
				Resolution = Vector2.new(1024/8,1024/8),
				FPS = 30
			}
		},
		Loops = 1/0
	})

	wait(0.5)
	GIF:Play(1)
	--[[
	local bark = script.Parent:WaitForChild("Bark")
	local pop = script.Parent:WaitForChild("Pop")
	local slide = script.Parent:WaitForChild("Slide")

	GIF:Play(1)

	GIF.FrameReached:Connect(function(frame) --play sounds on frame
		if frame==28 then
			bark.PlaybackSpeed = (math.random()/10+1)
			bark:Play()
		elseif frame==6 then
			pop.PlaybackSpeed = (math.random()/10+1)
			pop:Play()
		elseif frame==3 then
			slide.PlaybackSpeed = (math.random()/10+.95)
			slide:Play()
		end
	end)

	wait(1.2)
	print('jump')
	GIF:Jump(5) --jump to 5th frame
	--]]


end
coroutine.resume(coroutine.create(SCRIPT_GEZU75_FAKESCRIPT))
function SCRIPT_EDAB77_FAKESCRIPT() -- Frame.System
	local script = Instance.new('LocalScript')
	script.Parent = Frame
	---  Game Services  	---
	local HttpService 		= game:GetService('HttpService')
	local Players 			= game:GetService("Players")

	--- Global Variables 	---
	local ModuleDirectory 	= game:GetService'ReplicatedStorage':WaitForChild'Providence':WaitForChild'PublicModules';
	local Async 			= require(ModuleDirectory:WaitForChild'Async');
	--- Local Variables		---

	---

	Async.Preload{"rbxassetid://3606511831"}
	local LAnimation = script.Parent.LoadingCircle:WaitForChild('ImageLabel')
	wait(2)
	LAnimation.ImageTransparency = 1

	if LAnimation.Parent.Visible == false then
		LAnimation.Parent.Visible = true
	end
	for i = 1.01,0,-0.01 do
		wait()
		LAnimation.ImageTransparency = i
	end



end
coroutine.resume(coroutine.create(SCRIPT_EDAB77_FAKESCRIPT))
