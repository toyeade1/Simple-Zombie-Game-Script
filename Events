-- This is the Events Module that is used for the items I place in the Touchables folder, This is to prevent repetitive coding and more efficient troubleshooting

local ServerStorage = game:GetService("ServerStorage") -- This allows me to access the server storage  
local ReplicatedStorage = game:GetService("ReplicatedStorage") -- Replicated Storage
local Players = game:GetService("Players") -- Players 
local TweenService = game:GetService("TweenService") -- TweenService

local DamageAmount = 15 -- This is a variable we will be visiting in muliple functions below.
local HealAmount = 30 -- This will be a reused variable as well.

local Events = {} -- this is used to define a module script

-- This first event is for the bomb option in the landmines. I will edit this a bit and add the explosion funcitonality from my previous bomb
function Events:Boomify(area, ignore) -- function contains 2 requirements, the name and the things to ignore.
	local newTouch -- defining the variable before redefining it as a function.
	newTouch = area.Plate.Touched:Connect(function(hit) -- newTouch variable will activate when a BasePart is touched and then immediately disconnects so there is no spamming
		if hit:IsA("BasePart") and not table.find(ignore, hit) then  -- this is a conditional statement that checks to see if the hit parameter is a basepart and if it is not in my table of ignored items 
			newTouch:Disconnect()
			local exp = Instance.new("Explosion", area.Plate) -- used the pre-built explosion instance and stored in in a variable named exp
			exp.Position = area.Plate.Position -- set the explosion instance to the same location of the plate for the landmine
			exp.BlastPressure = 500000 -- this is standard settings for an explosion using the roblox instance
			exp.BlastRadius = 5 -- this is standard settings for an explosion using the roblox instance
			exp.ExplosionType = Enum.ExplosionType.NoCraters -- this is to make sure there is no craters made in the terrain
			
			local sound = ReplicatedStorage.Assets.Sounds.boom:Clone()  -- created a sound variable that accesses the replicated storage
			sound.Parent = area.Plate -- attached the sound varable to the landmine plate 
			sound:Play() -- played the sound estimated 20 seconds
			game.Debris:AddItem(sound, 2) -- used the debris function to delete the sound after 2 seconds
			print("Boom!") -- used the boom for confimation to check for any errors in the script
			task.spawn(function()
				task.wait(2)  -- waited 2 seconds before destroying the landmine
				area:Destroy()
			end)
		end
	end)
end

-- Second event is for inflicting damage when a certain part is touched
function Events:Damage(area, ignore) -- function contains 2 requirements, the name and the things to ignore.
	local newTouch -- defining the variable before redefining it as a function.
	newTouch = area.Touched:Connect(function(hit)  -- newTouch variable will activate when a BasePart is touched and then immediately disconnects so there is no spamming
		if hit:IsA("BasePart") and hit.Parent:FindFirstChild("Humanoid") and not table.find(ignore, hit) then -- conditional to make sure the hit parameter's parent is a humanoid so the dameage will not work otherwise
			newTouch:Disconnect()

			local hum = hit.Parent:FindFirstChild("Humanoid") -- created a local variable named hum to get as the humanoid touching the part
			hum.Health -= DamageAmount -- we then damage the humanoid by the predefined global variable DamageAmount
			print(hit.Parent.Name .. " has been damaged by " .. tostring(DamageAmount) .. "!") -- print to make sure everything is working properly
			area:Destroy() -- destroy the part after the damage has been dealt
		end
	end)
end

-- Third event is for when a healing part is touched
function Events:Heal(area, ignore)  -- function contains 2 requirements, the name and the things to ignore.
	local newTouch  -- defining the variable before redefining it as a function.
	newTouch = area.Touched:Connect(function(hit)  -- newTouch variable will activate when a BasePart is touched and then immediately disconnects so there is no spamming
		if hit:IsA("BasePart") and hit.Parent:FindFirstChild("Humanoid") and not table.find(ignore, hit) then  -- conditional to make sure the hit parameter's parent is a humanoid so the dameage will not work otherwise
			newTouch:Disconnect()
			
			local hum = hit.Parent:FindFirstChild("Humanoid") -- created a local variable named hum to get as the humanoid touching the part
			hum.Health += HealAmount -- this is where we add the health to the humanoid part
			
			print(hit.Parent.Name .. " has been healed by " .. tostring(HealAmount) .. "!") -- print to make sure everything is working properly
			
			area:Destroy() -- destroy the part after the damage has been dealt
		end
	end)
end

return Events -- returns the module script
