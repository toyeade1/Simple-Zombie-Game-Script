-- This will be the main script where I will be adding the functionaity from the scripts i create in the scripts folder

-- The first step will to to get the services we will be accessing 
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Accessing the folder stored in the Replicated Storage, which is where majority of the folders we will be intereacting with in the game will be stored.
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Classes = ReplicatedStorage:WaitForChild("Classes")
local Remote = ReplicatedStorage:WaitForChild("RemoteObjects") -- This might not be used at all but we added it to the replicated storage so i wanted to access it as well.

-- These are the modulescripts we will be accessing for the loop
local Connections = require(Modules:WaitForChild("Connections"))
local Events = require(Modules:WaitForChild("Events"))
local DataService = require(ServerStorage.Classes:WaitForChild('DataService'))
DataService:Inject()

local Ign = workspace.Ignore:GetChildren() -- This is the ignore folder/table. I created this to avoid certain things happening unintentionally in the script

local GetDataRemoteFunction = ReplicatedStorage:WaitForChild('RemoteObjects'):WaitForChild('GetData') -- Accessing remote objects to be passed between the client and the server
GetDataRemoteFunction.OnServerInvoke = function(Player, value)
	local profile = DataService:GetPlayerProfile(Player, false) -- checks to see if the player has any data saved 
	if profile then
		return profile.Data -- if they do then the data is returned
	end
	return nil -- if not, then nothing is returned
end

Players.PlayerAdded:Connect(function(player)

end)

for i, v in pairs (workspace.Touchables:GetDescendants()) do -- key value pair loop for all of the children in the touchables folder
	if v.Parent.Name =="Boomable" then
		Events:Boomify(v, Ign)
	elseif v.Parent.Name == "Healing" then
		Events:Heal(v, Ign)
	elseif v.Parent.Name == "Damage" then
		Events:Damage(v, Ign)
	elseif v.Parent.Name == "Interactables" then
		Connections:SetZombiePrompt(v.LidTop.ActionPrompt)
		Connections:ZombieSpawner()
	end
end
