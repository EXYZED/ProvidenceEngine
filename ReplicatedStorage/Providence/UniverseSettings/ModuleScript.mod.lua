local HTTPService = game:GetService("HttpService")

local Initalize = {}

function Initalize.Start()

	local JSONString;
	------- PCall block

	local success, request = pcall(function ()
	    return HTTPService:GetAsync('https://raw.githubusercontent.com/EXYZED/ProvidenceEngine/master/UniverseSettings.json')
	end)
	if success then
	    print("[ProvidenceEngine] : UniverseSettings Synced")
	    JSONString = request
	else
	    error("[ProvidenceEngine] : Issue with UniverseSettings, check HTTPService?")
	end

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

	if JSONString then
		local data = HTTPService:JSONDecode(JSONString)
		for k,v in pairs(data) do
			InstanceHandler(k,v,script.Parent)

			for e,c in pairs(v) do
			InstanceHandler(e,c,script.Parent[k])

			end
		end
	end

end -- end func
return Initalize
