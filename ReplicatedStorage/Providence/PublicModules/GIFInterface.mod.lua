--[[

File:           GIFInterface.lua (Localscript)
Description:    API To render GIF animations in ROBLOX

Pre-requisites: FE Compatability, Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120; WUNDER_WULFE.
Privilege:      Y

]]

-- DOCUMENTATION
--"SPRITESHEETS?"--
--[[
	Spritesheets are images that contain multiple different images.
	In order to use this API, you must use spritesheets from this
	url here:

		https://www.piskelapp.com/

	Instructions:

		1) Click the "Create Sprite" button

		2) Click on the 📁 icon (Import button)

		3) Look at "IMPORT FROM PICTURE" and click on
			"Browse images"

		4) Select the GIF of your choice

		5) Check the radio button that says "Import as
			spritesheet"

		6) It might ask you to replace the current
			animation, if so, press yes

		7) Click on the mountain icon (Export button)

		8) Select the first download option (in PNG), you may
			need to split it up if it's too large in
			order to keep good quality

		9) Upload the spritesheet(s) as a decal and
			make a spritesheet for each one in the
			data table (see DATA TABLE), making sure all values
			match correctly

		10) It might not play correctly so play it slowly
			at first and try to get the dimensions right!
--]]

--USAGE--
--[[
	To load this API into a script:

	local makeGIF = require(ModuleScript module)
--]]

--DOCUMENTATION--
--[[
	GIF makeGIF(table data)
		Creates a new GIF table
--]]

--DATA TABLE--
--[[
	The data table used when creating gifs should follow this format:

	{
		Screen = instance screen, --The screen/gui to display in
		Frames = { --An array of spritesheets
			{ --A single spritesheet
				Asset = string content, --Content url
				Cols = int cols, --Column count
				Count = int count, --The total number of frames
				Resolution = vector2 res, --The dimension of each frame
				FPS = double fps --The frames per second
			}
		},
		Loops = int times --Amount of times to loop (CAN BE INFINITY)
	}
--]]

--QUICK EXAMPLE--
--[[
	Example code:

	local makeGIF = require(script:WaitForChild("GIF Player"))
	local GIF = makeGIF({
		Screen = script.Parent:WaitForChild("MyGui"),
		Frames = {
			{
				Asset = 'rbxassetid://1137423765',
				Cols = 3,
				Count = 11,
				Resolution = Vector2.new(112,112),
				FPS = 11
			}
		},
		Loops = 1/0
	})
	GIF:Play(1)
--]]

--METHODS--
--[[
	These all return the GIF after called

	GIF:SetParent(instance parent)
		Changes the parent of the GIF

	GIF:Play(double speed)
		Plays the GIF with a multipler of speed

	GIF:Pause()
		Pauses the GIF

	GIF:Stop()
		Stops the GIF (reset)

	GIF:Goto(double time)
		Changes the TimePosition of the GIF

	GIF:Jump(int frame)
		Changes the frame to show

	GIF:Destroy()
		Removes most of the GIF
--]]

--EVENTS--
--[[
	RBXScriptSignal GIF.Played(double speed)
		Fires when Play is used

	RBXScriptSignal GIF.Stopped()
		Fires when Stop is used

	RBXScriptSignal GIF.Paused()
		Fires when Stop or Pause is used

	RBXScriptSignal GIF.Loop(int amount)
		Fires when the GIF loops with how many times

	RBXScriptSignal GIF.FrameReached(int frame)
		Fires when a new frame is reached

	RBXScriptSignal GIF.SheetReached(int sheet)
		Fires when a new spritesheet is reached

	RBXScriptSignal GIF.Destroyed()
		Fires when Destroy is used
--]]

--PROPERTIES--
--[[
	!REQUIRES PLAY TO BE CALLED AGAIN!

	int GIF.Loops
		The amount of times the GIF can loop for

	!DO NOT ASSIGN TO THESE PROPERTIES!

	Let the API assign values to them, however
	it is ok to read their values.

	bool GIF.Playing
		Whether or not the GIF is currently playing

	double GIF.TimePosition
		Position of the GIF in seconds

	double GIF.Duration
		Duration of the GIF in seconds

	int GIF.Current
		Current spritesheet

	int GIF.FrameCount
		Count of frames from all spritesheets

	int GIF.Position
		Frame of current spritesheet

	table GIF.Frames
		A table containing all the image objects

	table GIF.FrameData
		A table containing all the spritesheets
		(These are cloned)
--]]

--DO NOT USE--
--[[
	Useless properties only available so the API can use them.

	table GIF._d
		A duration table used for frame picking

	BindableEvent GIF._s
		Stopped event

	BindableEvent GIF._p
		API Played event

	BindableEvent GIF._pp
		Paused event

	BindableEvent GIF._ap
		Played event

	BindableEvent GIF._fr
		FrameReached event

	BindableEvent GIF._l
		Loop event

	BindableEvent GIF._ns
		SheetReached event

	BindableEvent GIF._ds
		Destroyed event
--]]

-- END DOCUMENTATION

--CODE--
local this = script.Parent.Parent
local push,pop,join = table.insert,table.remove,table.concat
local runservice = game:GetService("RunService")
local heartbeat,stepped,renderstepped = runservice.Heartbeat,runservice.Stepped,runservice.RenderStepped
local sleep = runservice:IsServer() and heartbeat or renderstepped
local new,next = Instance.new,next
local set = function(inst,objs)
	for k,v in next,objs do
		inst[k] = v
	end
	return inst
end
local udim2 = UDim2.new
local rect = Rect.new
local vec = Vector2.new
local lastlowest = function(value,tbl)
	local f,ind = 0,0
	for i=1,#tbl do
		if tbl[i]>value then break end
		f = tbl[i]
		ind = i
	end
	return ind,f
end
local floor = math.floor
local loadframe = function(gif)
	if gif.Previous then
		gif.Frames[gif.Previous].Visible = false
	end
	local cf = gif.Frames[gif.Current]
	local data = gif.FrameData[gif.Current]
	local res = data.Resolution
	cf.ImageRectSize = res
	cf.ImageRectOffset = res*vec((gif.Position-1)%data.Cols,floor((gif.Position-1)/data.Cols))
	cf.Visible = true
	gif.Previous = gif.Current
	return gif
end
local wrap = coroutine.wrap
local tick = tick
local playfunc = function(gif,speed)
	local stopped = false
	spawn(function()
		gif._pp.Event:Wait()
		stopped = true
	end)
	local t
	local frameno = 0
	local np
	local tw
	local loops = 0
	local saidnew = false
	if gif.Loops>0 then
		while not stopped do
			t = gif.TimePosition
			local c,v = lastlowest(t,gif._d)
			gif.Current = c+1
			np = 1+floor(gif.FrameData[c+1].Count*(t-v)/(gif._d[c+1]-v))
			if gif.Position~=np then
				frameno = 0
				for i=1,c do
					frameno = frameno + gif.FrameData[i].Count
				end
				gif._fr:Fire(frameno + np)
			end
			if np==1 and saidnew then
				gif._ns:Fire(c+1)
			end
			saidnew = np~=1
			gif.Position = np
			loadframe(gif)
			local ft = tick()
			sleep:Wait()
			tw = (gif.TimePosition + (tick()-ft)*speed)
			if tw<0 or tw>gif.Duration then
				loops = loops + 1
				gif._l:Fire(loops)
			end
			gif.TimePosition = tw%gif.Duration
			if loops>=gif.Loops then
				gif:Pause()
			end
		end
	end
end
local playself = function(self,speed)
	if self.Loops>0 then
		self:Pause()
		if speed~=0 then
			self.Playing = true
			wrap(playfunc)(self,speed)
			self._ap:Fire(speed)
		end
	end
	return self
end
local pauseself = function(self)
	if self.Loops>0 then
		self.Playing = false
		self._pp:Fire()
	end
	return self
end
local gotoself = function(self,t)
	if self.Loops>0 then
		t = t%self.Duration
		local c,v = lastlowest(t,self._d)
		self.Current = c+1
		self.Position = 1+floor(self.FrameData[c+1].Count*(t-v)/(self._d[c+1]-v))
		self.TimePosition = t
		loadframe(self)
	end
	return self
end
local jumpself = function(self,pos)
	if self.Loops>0 then
		pos = (pos-1)%self.FrameCount+1
		local t = 0
		local f
		for i=1,#self.FrameData do
			f = self.FrameData[i]
			if pos<=f.Count then
				t = t + pos*(1/f.FPS)-.000001
				break
			else
				t = t + f.Count*(1/f.FPS)
				pos = pos - f.Count
			end
		end
		local c,v = lastlowest(t,self._d)
		self.Current = c+1
		self.Position = 1+floor(self.FrameData[c+1].Count*(t-v)/(self._d[c+1]-v))
		self.TimePosition = t
		loadframe(self)
	end
	return self
end
local stopself = function(self)
	self.Playing = false
	self._pp:Fire()
	self._s:Fire()
	self.Current = 1
	self.Position = 1
	self.TimePosition = 0
	loadframe(self)
	return self
end
local clearself = function(self)
	if self.Playing then self:Stop() end
	for i=#self.Frames,1,-1 do
		pop(self.Frames,i):Destroy()
		pop(self.FrameData,i)
	end
	self.Loops = 0
	self._ds:Fire()
	return self
end
local parentself = function(self,wanted)
	if self.Loops>0 then
		for i=1,#self.Frames do
			self.Frames[i].Parent = wanted
		end
	end
end
local mainmeta = {
	__index = {
		Play = playself,
		Pause = pauseself,
		Goto = gotoself,
		Jump = jumpself,
		Stop = stopself,
		Destroy = clearself,
		SetParent = parentself
	},
	__tostring = function()
		return 'GIF'
	end
}
local function makeGIF(data)
	local basedata = {
		Parent = data.Screen,
		Size = udim2(1,0,1,0),
		Position = udim2(.5,0,.5,0),
		AnchorPoint = vec(.5,.5),
		BackgroundTransparency = 1,
		Visible = false
	}
	local sframes = {unpack(data.Frames)}
	local frames = {}
	local count,countT = 0,0
	local tcounts = {}
	local _
	for i=1,#sframes do
		_ = sframes[i]
		basedata.Image = _.Asset
		count = count + _.Count
		countT = countT + _.Count*1/_.FPS
		push(tcounts,(tcounts[i-1] or 0) + _.Count*1/_.FPS)
		push(frames,set(new "ImageLabel",basedata))
	end
	local played = new "BindableEvent"
	local acplayed = new "BindableEvent"
	local newsheet = new "BindableEvent"
	local stoppedn = new "BindableEvent"
	local framereach = new "BindableEvent"
	local loopn = new "BindableEvent"
	local paused = new "BindableEvent"
	local destroyed = new "BindableEvent"
	return loadframe(setmetatable({
		FrameData = sframes,
		Frames = frames,
		Loops = data.Loops,
		_d = tcounts,
		Current = 1,
		Position = 1,
		FrameCount = count,
		Duration = countT,
		TimePosition = 0,
		Playing = false,
		Stopped = stoppedn.Event,
		_s = stoppedn,
		Paused = paused.Event,
		_pp = paused,
		Played = acplayed.Event,
		_ap = acplayed,
		FrameReached = framereach.Event,
		_fr = framereach,
		Loop = loopn.Event,
		_l = loopn,
		SheetReached = newsheet.Event,
		_ns = newsheet,
		Destroyed = destroyed.Event,
		_ds = destroyed,
	},mainmeta))
end

return makeGIF
