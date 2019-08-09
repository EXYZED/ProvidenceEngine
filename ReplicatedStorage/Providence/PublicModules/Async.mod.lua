--[[

File:           Async.lua (ModuleScript)
Description:    Handling HTTP requests/etc.

Pre-requisites: N/A?

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      N

]]
local HttpService 			= game:GetService('HttpService');
local ContentProvider 		= game:GetService('ContentProvider');


local function GetAsync(...)
	local OpenGetRequests = 0
	repeat until OpenGetRequests == 0 or not wait()
	local Success, Data = pcall(HttpService.GetAsync, HttpService, ...)
	if Success then
		return Data
	elseif Data:find("HTTP 429") or Data:find("Number of requests exceeded limit") then
		wait(math.random(5))
		warn("Too many requests")
		return (...);
	elseif Data:find("HTTP Requests are not enabled") then
		OpenGetRequests = OpenGetRequests + 1
		require(script.Parent.UI):CreateSnackbar(Data)
		repeat
			local Success, Data = pcall(HttpService.GetAsync, HttpService, ...)
		until Success and not Data:find("HTTP Requests are not enabled") or require(script.Parent.UI):CreateSnackbar(Data) or not wait(1)
		OpenGetRequests = 0
		return (...);
	else
		error(Data .. (...), 0)
	end
end

local function PreloadAsync(...)
	ContentProvider:PreloadAsync(...)
end

local Module = {
	Get = GetAsync,
	Preload = PreloadAsync
	}
return Module
