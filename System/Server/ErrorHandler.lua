--[[

File:           ErrorHandler.lua (ServerScript)
Description:    Forwards errors to another server for analysis.


Pre-requisites: FE Compatability, Greatest Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y

]]--

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Sentry = require(ReplicatedStorage.Providence.PublicModules.Sentry)

Sentry.init({
	dsn = "https://d243e16260d1406f96f88a8b133a9857@sentry.io/1868233"
})

game:GetService("LogService").MessageOut:Connect(function(Message, Type)
	if Type == Enum.MessageType.MessageError then
		Sentry.captureMessage(Message, Sentry.Level.Error)
	end
	if Type == Enum.MessageType.MessageWarning then
		Sentry.captureMessage(Message, Sentry.Level.Warning)
	end
end)
