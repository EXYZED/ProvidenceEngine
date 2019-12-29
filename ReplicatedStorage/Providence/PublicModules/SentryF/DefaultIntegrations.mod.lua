local integrations = {}

for _, v in pairs(script.Parent:WaitForChild("DefaultIntegrations"):GetChildren()) do
	integrations[v.Name] = require(v)
end

return integrations
