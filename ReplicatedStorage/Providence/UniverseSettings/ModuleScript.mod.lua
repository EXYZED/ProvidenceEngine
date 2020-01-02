local HTTPService = game:GetService("HttpService")

local Initalize = {}

function Initalize.Start()

	local JSONString;
	local data;
	local Version				= 0

	------- PCall block
	local function GetRawData()
		local success, request = pcall(function()
		    return HTTPService:GetAsync('https://raw.githubusercontent.com/EXYZED/ProvidenceEngine/master/UniverseSettings.json')
		end)
		if success then
		    --print("[ProvidenceEngine] : UniverseSettings Synced")
		    JSONString = request
		else
		    --error("[ProvidenceEngine] : Issue with UniverseSettings, check HTTPService?")
		end
	end

	GetRawData()
	-------

	local function InstanceHandler(name,object,parent)
		if tostring(type(object)) == 'table' then
			local Replicant = Instance.new('Folder')
			Replicant.Name = name
			Replicant.Parent = parent
		end

		if tostring(type(object)) == 'boolean' then
			local Replicant = Instance.new('BoolValue')
			Replicant.Name = name
			Replicant.Value = object
			Replicant.Parent = parent
		end

		if tostring(type(object)) == 'string' then
			local Replicant = Instance.new('StringValue')
			Replicant.Name = name
			Replicant.Value = object
			Replicant.Parent = parent
		end

		if tostring(type(object)) == 'number' then
			local Replicant = Instance.new('StringValue')
			Replicant.Name = name
			Replicant.Value = object
			Replicant.Parent = parent
		end
	end
	---



	local function CheckVersion()
		if data.ServerSettings.ServerVersion ~= Version then
			Version = data.ServerSettings.ServerVersion
			print("[ProvidenceEngine] : UniverseSettings Updated / Initalized Version: "..Version)
			return true
		else
			return false
		end
	end

	local function UpdateValues()

		for index, object in ipairs (script.Parent:GetChildren()) do -- Clear old values
			if not(object:IsA('BaseScript') or object:IsA('ModuleScript')) then
				object:Destroy();
			end
		end

		for k,v in pairs(data) do
			InstanceHandler(k,v,script.Parent)

			for e,c in pairs(v) do
			InstanceHandler(e,c,script.Parent[k])

			end
		end
	end

	if JSONString then
		data = HTTPService:JSONDecode(JSONString)
		if CheckVersion() then UpdateValues() end
	end

	while script do wait(30)
		GetRawData()
		if CheckVersion() then UpdateValues() end
	end

end -- end func
return Initalize
