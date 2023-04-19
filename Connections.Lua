-- This is a connection module made for the zombie spawner

-- The first step is getting the game services that will be used
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local szs = ServerStorage:WaitForChild("SimpleZSpawner") -- We then access a local script stored in server storage called SimpleZSpawner, which essentially clones a model of drooling zombiies I had prteviously made
local gameSettings = ReplicatedStorage.Settings -- stored the variables for the spawner in replicated storage in a folder called settings, this will allow me to add variables without having to define them as varables
local part = workspace.Touchables.Interactables.Barrel.LidTop -- this will be the part that is being interacted with
local prompt = part.ActionPrompt -- this is the toggle that the user will access to spawn the zombies
local alarm = part.alarm -- this is a sound ran on a loop that will notify the user that zombies are being spawned
local zombieModel = szs:WaitForChild("Zombies") -- this is the zombie model that the simplezspawner is hosting



local Connections = {} -- the name of the modulescript is connections

function Connections:SetZombiePrompt(prompt) -- in this function we are passing the prompt 
	local newTrigger -- defining a varable to be later used to connect the triggered instance
	newTrigger = prompt.Triggered:Connect(function(hit)
		 -- newTrigger:Disconnect() 
		if gameSettings:GetAttribute("Activation") == true then -- checking to see if the activated attribute is true, then will toggle it
			gameSettings:SetAttribute("Activation", false)
			alarm:Stop()
		else
			gameSettings:SetAttribute("Activation", true)
			alarm:Play()
		end
	end)
end


function Connections:ZombieSpawner() -- in this function the zombies are cloned after a certain amount of time defined in the game settings variable 
	while true do
		task.wait(gameSettings:GetAttribute('Intermission')) -- waiting for the intermission attribute which is numerical
		if gameSettings:GetAttribute("Activation") then -- then checking to see if the activation attribute is true and if it is then the zombie model is cloned to the spawn point
			local zombies = zombieModel:Clone()
			zombies.Parent = workspace -- setting the parent of the zombies to the workspace otherwise they do not appear in game
			task.wait(gameSettings:SetAttribute("Round")) -- waits till the end of the round
			game.Debris:AddItem(zombies, gameSettings:GetAttribute("TimeToLive")) -- then uses the debris function to remove the existing zombies after the time to live period has passed
		end
	end

end


return Connections
