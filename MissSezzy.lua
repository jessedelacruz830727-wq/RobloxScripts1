-- Miss Sezzy | NON-VISUAL
-- No GUI | No Visual Effects

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- SETTINGS
local TARGET_PLAYER_NAME = "PlayerNameHere" -- change this

-- FLY
local flying = false
local bv, bg
local flySpeed = 50

local function startFly()
	if flying then return end
	flying = true

	bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(9e9,9e9,9e9)
	bv.Velocity = Vector3.zero
	bv.Parent = hrp

	bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
	bg.CFrame = hrp.CFrame
	bg.Parent = hrp

	RunService.RenderStepped:Connect(function()
		if flying then
			local cam = workspace.CurrentCamera
			bv.Velocity = cam.CFrame.LookVector * flySpeed
			bg.CFrame = cam.CFrame
		end
	end)
end

local function stopFly()
	flying = false
	if bv then bv:Destroy() end
	if bg then bg:Destroy() end
end

-- KILL PLAYER (silent)
local function killPlayer()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr.Name:lower():find(TARGET_PLAYER_NAME:lower()) then
			if plr.Character and plr.Character:FindFirstChild("Humanoid") then
				plr.Character.Humanoid.Health = 0
			end
		end
	end
end

-- KEYBINDS
UIS.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == Enum.KeyCode.F then
		startFly()
	elseif input.KeyCode == Enum.KeyCode.L then
		stopFly()
	elseif input.KeyCode == Enum.KeyCode.K then
		killPlayer()
	end
end)

-- Silent message (console only)
print("Miss Sezzy Loaded | Follow @GERIMIAH Group")
