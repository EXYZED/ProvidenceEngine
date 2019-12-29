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

Sentry.captureMessage("Message from Byron Bay", Sentry.Level.Info)
