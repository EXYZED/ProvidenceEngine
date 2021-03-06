--[[

File:           Sentry.lua (ModuleScript)
Description:    Logs any errors and warning through the Sentry system.

Pre-requisites: FE Compatability, Efficiency.

Issuer, A:      XLNS_XYZ Danté#9120
Privilege:      Y

]]

-- https://docs.sentry.io/development/sdk-dev/unified-api/#static-api
local SentryF = script.Parent:WaitForChild("SentryF")
local Hub = require(SentryF.Hub)
local Client = require(SentryF.Client)
local DefaultIntegrations = require(SentryF.DefaultIntegrations)
local Log = require(SentryF.Log)
local Breadcrumb = require(SentryF.Breadcrumb)

local globalOptions
local disabled = true

local function getDefaultOptions()
	return {
		sampleRate = 1,
		maxBreadcrumbs = 100,
		attachStacktrace = false,
		defaultIntegrations = true,
		shutdownTimeout = 2,
		debug = false
	}
end

local Sentry = {}

Sentry.Level = {
	Fatal = "fatal",
	Error = "error",
	Warning = "warning",
	Info = "info",
	Debug = "debug"
}

function Sentry.init(options)
	local default = getDefaultOptions()
	for i, v in pairs(options) do
		default[i] = v
	end
	globalOptions = default
	Log.setEnabled(globalOptions.debug)
	Hub.setCurrent(Hub.new(Client.new(globalOptions)))
	disabled = globalOptions.dsn == nil or globalOptions.dsn == ""
	if not disabled then
		for name, integration in pairs(DefaultIntegrations) do
			integration(Sentry)
			Log.info("Integration installed: " .. name)
		end
	end
end

function Sentry.captureEvent(event)
	if not disabled then
		local hint = {
			sourceTrace = debug.traceback("Sentry syntheticException", 2)
		}
		return Hub.getCurrent():captureEvent(event, hint)
	end
end

function Sentry.captureException(exception)
	if not disabled then
		local hint = {
			sourceTrace = debug.traceback("Sentry syntheticException", 2)
		}
		return Hub.getCurrent():captureException(exception, hint)
	end
end

function Sentry.captureMessage(message, level)
	if not disabled then
		local hint = {
			sourceTrace = debug.traceback("Sentry syntheticException", 2)
		}
		return Hub.getCurrent():captureMessage(message, level, hint)
	end
end

function Sentry.addBreadcrumb(crumb)
	if not disabled then
		return Hub.getCurrent():addBreadcrumb(Breadcrumb.new(crumb))
	end
end

function Sentry.configureScope(callback)
	if not disabled then
		return Hub.getCurrent():configureScope(callback)
	end
end

function Sentry.withScope(callback)
	if not disabled then
		return Hub.getCurrent():withScope(callback)
	end
end

function Sentry.getLastEventId()
	if not disabled then
		return Hub.getCurrent():getLastEventId()
	end
end

return Sentry
