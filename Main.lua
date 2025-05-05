local replicatedStorage = game:GetService("ReplicatedStorage")
local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local PPS = game:GetService("ProximityPromptService")
local ContextActionService = game:GetService("ContextActionService")
local runService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local userInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local notificationModule = require(replicatedStorage.Modules.Notification)
local getFarmModule = require(replicatedStorage.Modules.GetFarm)

local plantEvent = replicatedStorage:WaitForChild("GameEvents"):WaitForChild("Plant_RE")

local localPlayer = players.LocalPlayer
local farm = getFarmModule(localPlayer)
local playerMouse = localPlayer:GetMouse()
local previous
local fruit

-- Initialize global variables if they don't exist
if not _G.destroy then
	_G.destroy = false -- destroy button in UI
end

if not _G.pickupTime then
	_G.pickupTime = 0.022 -- to be set by UI
end

if not _G.saveWeight then
	_G.saveWeight = 20 -- to be set by UI
end

if not _G.plantList then
	_G.plantList = {
		Carrot = false,
		Strawberry = false,
		Blueberry = false,
		Orange = false,
		Tomato = false,
		Corn = false,
		Daffodil = false,
		Watermelon = false,
		Pumpkin = false,
		Apple = false,
		Bamboo = false,
		Coconut = false,
		Cactus = false,
		["Dragon Fruit"] = false,
		Mango = false,
		Grape = false,
		["Chocolate Carrot"] = false,
		["Red Lollipop"] = false,
		["Candy Sunflower"] = false,
		["Easter Egg"] = false,
		["Candy Blossom"] = false,
		["Orange Tulip"] = false,
		Mushroom = false,
		Pepper = false
	}
end

if not _G.buyList then
	_G.buyList = {
		Carrot = false,
		Strawberry = false,
		Blueberry = false,
		["Orange Tulip"] = false,
		Orange = false,
		Tomato = false,
		Corn = false,
		Daffodil = false,
		Watermelon = false,
		Pumpkin = false,
		Apple = false,
		Bamboo = false,
		Coconut = false,
		Cactus = false,
		["Dragon Fruit"] = false,
		Mango = false,
		Grape = false,
		Mushroom = false,
		Pepper = false
	}
end

if not _G.gearBuyList then
	_G.gearBuyList = {
		["Watering Can"] = false,
		["Trowel"] = false,
		["Basic Sprinkler"] = false,
		["Advanced Sprinkler"] = false,
		["Godly Sprinkler"] = false,
		["Lightning Rod"] = false,
		["Master Sprinkler"] = false
	}
end

--if not _G.easterBuyList then
--	_G.easterBuyList = {
--		["Chocolate Carrot"] = false,
--		["Red Lollipop"] = false,
--		["Candy Sunflower"] = false,
--		["Easter Egg"] = false,
--		["Chocolate Sprinkler"] = false,
--		["Candy Blossom"] = false
--	}
--end

if not _G.eggBuyList then
	_G.eggBuyList = {
		["Common"] = false,
		["Uncommon"] = false,
		["Rare"] = false,
		["Legendary"] = false,
		["Bug"] = false,
	}
end

if not _G.gameActions then
	_G.gameActions = {
		["AutoSell"] = false,
		["AutoBuy"] = false,
		["Autoharvest"] = false,
		["AutoPlant"] = false,
		["CollectNear"] = false,
		["FruitNoClip"] = false,
		["SaveItemsAboveWeight"] = false,
		["FreeCamOnCollection"] = true
	}
end

local pi    = math.pi
local abs   = math.abs
local clamp = math.clamp
local exp   = math.exp
local rad   = math.rad
local sign  = math.sign
local sqrt  = math.sqrt
local tan   = math.tan

if not localPlayer then
	players:GetPropertyChangedSignal("LocalPlayer"):Wait()
	localPlayer = players.LocalPlayer
end

local Camera = Workspace.CurrentCamera
Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	local newCamera = Workspace.CurrentCamera
	if newCamera then
		Camera = newCamera
	end
end)

-- ================ FREECAM SETUP ================
local TOGGLE_INPUT_PRIORITY = Enum.ContextActionPriority.Low.Value
local INPUT_PRIORITY = Enum.ContextActionPriority.High.Value
local FREECAM_MACRO_KB = {Enum.KeyCode.LeftShift, Enum.KeyCode.P}

local NAV_GAIN = Vector3.new(1, 1, 1)*64
local PAN_GAIN = Vector2.new(0.75, 1)*8
local FOV_GAIN = 300

local PITCH_LIMIT = rad(90)

local VEL_STIFFNESS = 1.5
local PAN_STIFFNESS = 1.0
local FOV_STIFFNESS = 4.0

local Spring = {} do
	Spring.__index = Spring

	function Spring.new(freq, pos)
		local self = setmetatable({}, Spring)
		self.f = freq
		self.p = pos
		self.v = pos*0
		return self
	end

	function Spring:Update(dt, goal)
		local f = self.f*2*pi
		local p0 = self.p
		local v0 = self.v

		local offset = goal - p0
		local decay = exp(-f*dt)

		local p1 = goal + (v0*dt - offset*(f*dt + 1))*decay
		local v1 = (f*dt*(offset*f - v0) + v0)*decay

		self.p = p1
		self.v = v1

		return p1
	end

	function Spring:Reset(pos)
		self.p = pos
		self.v = pos*0
	end
end

local cameraPos = Vector3.new()
local cameraRot = Vector2.new()
local cameraFov = 0

local velSpring = Spring.new(VEL_STIFFNESS, Vector3.new())
local panSpring = Spring.new(PAN_STIFFNESS, Vector2.new())
local fovSpring = Spring.new(FOV_STIFFNESS, 0)

local Input = {} do
	local thumbstickCurve do
		local K_CURVATURE = 2.0
		local K_DEADZONE = 0.15

		local function fCurve(x)
			return (exp(K_CURVATURE*x) - 1)/(exp(K_CURVATURE) - 1)
		end

		local function fDeadzone(x)
			return fCurve((x - K_DEADZONE)/(1 - K_DEADZONE))
		end

		function thumbstickCurve(x)
			return sign(x)*clamp(fDeadzone(abs(x)), 0, 1)
		end
	end

	local gamepad = {
		ButtonX = 0,
		ButtonY = 0,
		DPadDown = 0,
		DPadUp = 0,
		ButtonL2 = 0,
		ButtonR2 = 0,
		Thumbstick1 = Vector2.new(),
		Thumbstick2 = Vector2.new(),
	}

	local keyboard = {
		W = 0,
		A = 0,
		S = 0,
		D = 0,
		E = 0,
		Q = 0,
		U = 0,
		H = 0,
		J = 0,
		K = 0,
		I = 0,
		Y = 0,
		Up = 0,
		Down = 0,
		LeftShift = 0,
		RightShift = 0,
	}

	local mouse = {
		Delta = Vector2.new(),
		MouseWheel = 0,
	}

	local NAV_GAMEPAD_SPEED  = Vector3.new(1, 1, 1)
	local NAV_KEYBOARD_SPEED = Vector3.new(1, 1, 1)
	local PAN_MOUSE_SPEED    = Vector2.new(1, 1)*(pi/64)
	local PAN_GAMEPAD_SPEED  = Vector2.new(1, 1)*(pi/8)
	local FOV_WHEEL_SPEED    = 1.0
	local FOV_GAMEPAD_SPEED  = 0.25
	local NAV_ADJ_SPEED      = 0.75
	local NAV_SHIFT_MUL      = 0.25

	local navSpeed = 1

	function Input.Vel(dt)
		navSpeed = clamp(navSpeed + dt*(keyboard.Up - keyboard.Down)*NAV_ADJ_SPEED, 0.01, 4)

		local kGamepad = Vector3.new(
			thumbstickCurve(gamepad.Thumbstick1.x),
			thumbstickCurve(gamepad.ButtonR2) - thumbstickCurve(gamepad.ButtonL2),
			thumbstickCurve(-gamepad.Thumbstick1.y)
		)*NAV_GAMEPAD_SPEED

		local kKeyboard = Vector3.new(
			keyboard.D - keyboard.A + keyboard.K - keyboard.H,
			keyboard.E - keyboard.Q + keyboard.I - keyboard.Y,
			keyboard.S - keyboard.W + keyboard.J - keyboard.U
		)*NAV_KEYBOARD_SPEED

		local shift = userInputService:IsKeyDown(Enum.KeyCode.LeftShift) or userInputService:IsKeyDown(Enum.KeyCode.RightShift)

		return (kGamepad + kKeyboard)*(navSpeed*(shift and NAV_SHIFT_MUL or 1))
	end

	function Input.Pan(dt)
		local kGamepad = Vector2.new(
			thumbstickCurve(gamepad.Thumbstick2.y),
			thumbstickCurve(-gamepad.Thumbstick2.x)
		)*PAN_GAMEPAD_SPEED
		local kMouse = mouse.Delta*PAN_MOUSE_SPEED
		mouse.Delta = Vector2.new()
		return kGamepad + kMouse
	end

	function Input.Fov(dt)
		local kGamepad = (gamepad.ButtonX - gamepad.ButtonY)*FOV_GAMEPAD_SPEED
		local kMouse = mouse.MouseWheel*FOV_WHEEL_SPEED
		mouse.MouseWheel = 0
		return kGamepad + kMouse
	end

	do
		local function Keypress(action, state, input)
			keyboard[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
			return Enum.ContextActionResult.Sink
		end

		local function GpButton(action, state, input)
			gamepad[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
			return Enum.ContextActionResult.Sink
		end

		local function MousePan(action, state, input)
			local delta = input.Delta
			mouse.Delta = Vector2.new(-delta.y, -delta.x)
			return Enum.ContextActionResult.Sink
		end

		local function Thumb(action, state, input)
			gamepad[input.KeyCode.Name] = input.Position
			return Enum.ContextActionResult.Sink
		end

		local function Trigger(action, state, input)
			gamepad[input.KeyCode.Name] = input.Position.z
			return Enum.ContextActionResult.Sink
		end

		local function MouseWheel(action, state, input)
			mouse[input.UserInputType.Name] = -input.Position.z
			return Enum.ContextActionResult.Sink
		end

		local function Zero(t)
			for k, v in pairs(t) do
				t[k] = v*0
			end
		end

		function Input.StartCapture()
			ContextActionService:BindActionAtPriority("FreecamKeyboard", Keypress, false, INPUT_PRIORITY,
				Enum.KeyCode.W, Enum.KeyCode.U,
				Enum.KeyCode.A, Enum.KeyCode.H,
				Enum.KeyCode.S, Enum.KeyCode.J,
				Enum.KeyCode.D, Enum.KeyCode.K,
				Enum.KeyCode.E, Enum.KeyCode.I,
				Enum.KeyCode.Q, Enum.KeyCode.Y,
				Enum.KeyCode.Up, Enum.KeyCode.Down
			)
			ContextActionService:BindActionAtPriority("FreecamMousePan",          MousePan,   false, INPUT_PRIORITY, Enum.UserInputType.MouseMovement)
			ContextActionService:BindActionAtPriority("FreecamMouseWheel",        MouseWheel, false, INPUT_PRIORITY, Enum.UserInputType.MouseWheel)
			ContextActionService:BindActionAtPriority("FreecamGamepadButton",     GpButton,   false, INPUT_PRIORITY, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY)
			ContextActionService:BindActionAtPriority("FreecamGamepadTrigger",    Trigger,    false, INPUT_PRIORITY, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2)
			ContextActionService:BindActionAtPriority("FreecamGamepadThumbstick", Thumb,      false, INPUT_PRIORITY, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2)
		end

		function Input.StopCapture()
			navSpeed = 1
			Zero(gamepad)
			Zero(keyboard)
			Zero(mouse)
			ContextActionService:UnbindAction("FreecamKeyboard")
			ContextActionService:UnbindAction("FreecamMousePan")
			ContextActionService:UnbindAction("FreecamMouseWheel")
			ContextActionService:UnbindAction("FreecamGamepadButton")
			ContextActionService:UnbindAction("FreecamGamepadTrigger")
			ContextActionService:UnbindAction("FreecamGamepadThumbstick")
		end
	end
end

local function GetFocusDistance(cameraFrame)
	local znear = 0.1
	local viewport = Camera.ViewportSize
	local projy = 2*tan(cameraFov/2)
	local projx = viewport.x/viewport.y*projy
	local fx = cameraFrame.rightVector
	local fy = cameraFrame.upVector
	local fz = cameraFrame.lookVector

	local minVect = Vector3.new()
	local minDist = 512

	for x = 0, 1, 0.5 do
		for y = 0, 1, 0.5 do
			local cx = (x - 0.5)*projx
			local cy = (y - 0.5)*projy
			local offset = fx*cx - fy*cy + fz
			local origin = cameraFrame.p + offset*znear
			local _, hit = Workspace:FindPartOnRay(Ray.new(origin, offset.unit*minDist))
			local dist = (hit - origin).magnitude
			if minDist > dist then
				minDist = dist
				minVect = offset.unit
			end
		end
	end

	return fz:Dot(minVect)*minDist
end

local function StepFreecam(dt)
	local vel = velSpring:Update(dt, Input.Vel(dt))
	local pan = panSpring:Update(dt, Input.Pan(dt))
	local fov = fovSpring:Update(dt, Input.Fov(dt))

	local zoomFactor = sqrt(tan(rad(70/2))/tan(rad(cameraFov/2)))

	cameraFov = clamp(cameraFov + fov*FOV_GAIN*(dt/zoomFactor), 1, 120)
	cameraRot = cameraRot + pan*PAN_GAIN*(dt/zoomFactor)
	cameraRot = Vector2.new(clamp(cameraRot.x, -PITCH_LIMIT, PITCH_LIMIT), cameraRot.y%(2*pi))

	local cameraCFrame = CFrame.new(cameraPos)*CFrame.fromOrientation(cameraRot.x, cameraRot.y, 0)*CFrame.new(vel*NAV_GAIN*dt)
	cameraPos = cameraCFrame.p

	Camera.CFrame = cameraCFrame
	Camera.Focus = cameraCFrame*CFrame.new(0, 0, -GetFocusDistance(cameraCFrame))
	Camera.FieldOfView = cameraFov
end

local PlayerState = {} do
	local mouseBehavior
	local mouseIconEnabled
	local cameraType
	local cameraFocus
	local cameraCFrame
	local cameraFieldOfView

	function PlayerState.Push()
		cameraFieldOfView = Camera.FieldOfView
		Camera.FieldOfView = 70

		cameraType = Camera.CameraType
		Camera.CameraType = Enum.CameraType.Custom

		cameraCFrame = Camera.CFrame
		cameraFocus = Camera.Focus

		mouseBehavior = userInputService.MouseBehavior
		userInputService.MouseBehavior = Enum.MouseBehavior.Default
	end

	-- Restore state
	function PlayerState.Pop()
		Camera.FieldOfView = cameraFieldOfView
		cameraFieldOfView = nil

		Camera.CameraType = cameraType
		cameraType = nil

		Camera.CFrame = cameraCFrame
		cameraCFrame = nil

		Camera.Focus = cameraFocus
		cameraFocus = nil

		userInputService.MouseBehavior = mouseBehavior
		mouseBehavior = nil
	end
end

local function StartFreecam()
	local cameraCFrame = Camera.CFrame
	cameraRot = Vector2.new(cameraCFrame:toEulerAnglesYXZ())
	cameraPos = cameraCFrame.p
	cameraFov = Camera.FieldOfView

	velSpring:Reset(Vector3.new())
	panSpring:Reset(Vector2.new())
	fovSpring:Reset(0)

	PlayerState.Push()
	runService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam)
	Input.StartCapture()
end

local function StopFreecam()
	Input.StopCapture()
	runService:UnbindFromRenderStep("Freecam")
	PlayerState.Pop()
end

do
	local enabled = false

	local function ToggleFreecam()
		if enabled then
			StopFreecam()
		else
			StartFreecam()
		end
		enabled = not enabled
	end

	local function CheckMacro(macro)
		for i = 1, #macro - 1 do
			if not userInputService:IsKeyDown(macro[i]) then
				return
			end
		end
		ToggleFreecam()
	end

	local function HandleActivationInput(action, state, input)
		if state == Enum.UserInputState.Begin then
			if input.KeyCode == FREECAM_MACRO_KB[#FREECAM_MACRO_KB] then
				CheckMacro(FREECAM_MACRO_KB)
			end
		end
		return Enum.ContextActionResult.Pass
	end

	ContextActionService:BindActionAtPriority("FreecamToggle", HandleActivationInput, false, TOGGLE_INPUT_PRIORITY, FREECAM_MACRO_KB[#FREECAM_MACRO_KB])
end

-- ================ FARMING FUNCTIONS ================

-- Saving items above a weight
local function checkForSave()
	if _G.gameActions["SaveItemsAboveWeight"] then
		for _, item in localPlayer.Backpack:GetDescendants() do
			if item.Name == "Weight" and item.Value >= _G.saveWeight and not item.Parent:GetAttribute("Favorite") then
				replicatedStorage:WaitForChild("GameEvents"):WaitForChild("Favorite_Item"):FireServer(item.Parent)
			end
		end
	end
end

-- Sell fruit
local function sellFruits()
	checkForSave()
	localPlayer.Character:PivotTo(CFrame.new(62,3,-1))
	wait(0.3)
	replicatedStorage:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
end

-- Disable collisions
local function disableFruitsCollisions()
	for _,fruit in farm.Important.Plants_Physical:GetChildren() do
		for _,p in fruit:GetDescendants() do
			if p:IsA("BasePart") then
				p.CanCollide = false
			end
		end
	end
end

-- Collect on show
PPS.PromptShown:Connect(function(prompt)
	if _G.gameActions["CollectNear"] and prompt:IsDescendantOf(farm.Important.Plants_Physical) then
		runService.RenderStepped:Wait()
		fireproximityprompt(prompt)
	end
end)

-- Easter stuff
local function easterCheckStock(item)
	for _,des in game.Players.LocalPlayer.PlayerGui.Easter_Shop.Frame.ScrollingFrame:GetDescendants() do
		if des.Name == "Stock_Text" and des.Parent.Parent.Name == item then
			return string.match(des.Text, "%d+")
		end
	end
end

local function easterBuyItem(item)
	local stock = tonumber(easterCheckStock(item))
	if stock and stock > 0 then
		for i = 1, stock do
			if not _G.gameActions["AutoBuy"] then
				return
			end
			replicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyEasterStock"):FireServer(item)
		end
	end
end

-- Buy gears
local function gearCheckStock(gear)
	for _,des in game.Players.LocalPlayer.PlayerGui.Gear_Shop.Frame.ScrollingFrame:GetDescendants() do
		if des.Name == "Stock_Text" and des.Parent.Parent.Name == gear then
			return string.match(des.Text, "%d+")
		end
	end
end

local function buyGear(gear)
	local stock = tonumber(gearCheckStock(gear))
	if stock and stock > 0 then
		for i = 1, stock do
			if not _G.gameActions["AutoBuy"] then
				return
			end
			replicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer(gear)
		end
	end
end

local function checkGearBuy()
	for gear, a in pairs(_G.gearBuyList) do
		if not _G.gameActions["AutoBuy"] then
			return
		end
		if a then
			buyGear(gear)
		end
	end
end

--Buy eggs
local function checkEggBuyable(egg)
	for _, item in game.Workspace.NPCS["Pet Stand"].EggLocations:GetChildren() do
		if not _G.gameActions["AutoBuy"] then
			return
		end

		if item:IsA("Model") and item.WorldPivot == egg.CFrame and not item:GetAttribute("RobuxEggOnly") then
			print("buyable")
			return true
		end
	end
end

local function buyEgg(egg)
	if checkEggBuyable(egg) then
		print("buying egg")
		if not _G.gameActions["AutoBuy"] then
				return
			end
		if egg.Position.Z > 1 then
			replicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(2)
		elseif egg.Position.Z < -1 then
			replicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(1)
		else
			replicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(3)
		end
	end
end

local function checkBuyEggs()
	for _, item in game.Workspace.NPCS["Pet Stand"].EggLocations:GetChildren() do
		if item.Name == "Location" then
			for key, need in _G.eggBuyList do
				if not _G.gameActions["AutoBuy"] then
					return
				end
				if need and key == item.PetInfo.SurfaceGui.RarityTextLabel.Text then
					print(key)
					buyEgg(item)
				end
			end
		end
	end
end

-- Buy fruit
local function checkStock(fruit)
	for _,des in game.Players.LocalPlayer.PlayerGui.Seed_Shop.Frame.ScrollingFrame:GetDescendants() do
		if des.Name == "Stock_Text" and des.Parent.Parent.Name == fruit then
			return string.match(des.Text, "%d+")
		end
	end
end

local function buyFruit(fruit)
	local stock = tonumber(checkStock(fruit))
	if stock and stock > 0 then
		for i = 1, stock do
			if not _G.gameActions["AutoBuy"] then
				return
			end
			replicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(fruit)
		end
	end
end

local function checkFruitBuy()
	for fruit, a in pairs(_G.buyList) do
		if not _G.gameActions["AutoBuy"] then
			return
		end
		if a then
			buyFruit(fruit)
		end
	end
	--for item, a in pairs(_G.easterBuyList) do
	--	if not _G.gameActions["AutoBuy"] then
	--		return
	--	end
	--	if a then
	--		easterBuyItem(item)
	--	end
	--end
end

-- Planting
local function selectFruit(fruit)
	for _,item in game.Players.LocalPlayer.Backpack:GetChildren() do
		local hasPlantName = pcall(function()
			local name = item.Plant_Name
		end)
		if hasPlantName and item.Plant_Name.Value == fruit then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(item)
		end
	end
end

local function plantAtFeet(fruit)
	plantEvent:FireServer(Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X, 1, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z), fruit)
end

local function gotoPlant()
	local items = farm.Important.Plant_Locations:GetChildren()
	local field = items[math.random(1,#items)]
	local halfSize = field.Size / 2 - Vector3.new(4,0,4)
	local pos = field.Position + Vector3.new(math.random(-halfSize.X, halfSize.X), 5, math.random(-halfSize.Z, halfSize.Z))
	game.Players.LocalPlayer.Character:PivotTo(CFrame.new(pos))
end

local function plantSeeds()
	for _, des in game.Players.LocalPlayer.Backpack:GetDescendants() do
		if not _G.gameActions["AutoPlant"] then
			return
		end
		if des:IsA("StringValue") and des.Name == "Plant_Name" and _G.plantList[des.Value] then
			selectFruit(des.Value)
			wait(1)
			for i = 1, des.Parent.Numbers.Value do
				if not _G.gameActions["AutoPlant"] then
					return
				end
				gotoPlant()
				wait(0.3)
				plantAtFeet(des.Parent.Plant_Name.Value)
				wait(0.2)
			end
		end
	end
end

-- Harvest
local freecam = false
local function fruitCollect()
	if _G.gameActions["FreeCamOnCollection"] and not freecam then
		freecam = true
		StartFreecam()
	end
	for _, fruit in collectionService:GetTagged("CollectPrompt") do
		fruit.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow
	end
	for _, fruit in collectionService:GetTagged("Harvestable") do
		if not _G.gameActions["Autoharvest"] then
			return
		end
		if #localPlayer.Backpack:GetChildren() >= 200 then
			sellFruits()
		end
		local item = fruit:FindFirstChild("ProximityPrompt", true)
		if fruit and fruit.PrimaryPart and item and fruit:IsDescendantOf(farm.Important.Plants_Physical) then
			localPlayer.Character:PivotTo(CFrame.new(fruit.PrimaryPart.Position))
			task.wait(_G.pickupTime)
			fireproximityprompt(item)
			task.wait(_G.pickupTime)
		end
	end
end

-- Anti afk
game.Players.LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):CaptureController()
	game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

-- ================ GUI SECTION ================
local player = game.Players.LocalPlayer

-- Utility functions
local function createInstance(className, properties)
	local instance = Instance.new(className)
	for property, value in pairs(properties) do
		instance[property] = value
	end
	return instance
end

-- Create ScreenGui
local gui = createInstance("ScreenGui", {
	Name = "FarmGUI",
	Parent = player.PlayerGui,
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

-- Create main frame
local mainFrame = createInstance("Frame", {
    Name = "MainFrame",
    Parent = gui,
    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, -250, 0.5, -150),
    Size = UDim2.new(0, 500, 0, 300),
    Active = true,
    Draggable = true,
    Selectable = true,
    ClipsDescendants = true  -- Add this to prevent content overflow
})

-- Add resize button
local resizeButton = createInstance("TextButton", {
	Name = "ResizeButton",
	Parent = mainFrame,
	BackgroundColor3 = Color3.fromRGB(60, 60, 60),
	BorderSizePixel = 0,
	Position = UDim2.new(1, -15, 1, -15),
	Size = UDim2.new(0, 15, 0, 15),
	Text = "↘",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 12,
	Font = Enum.Font.SourceSans
})

-- Add resize functionality
local resizing = false
local minSize = Vector2.new(400, 250)
local startSize, startPos, startMouse

resizeButton.MouseButton1Down:Connect(function()
	startSize = mainFrame.AbsoluteSize
	startPos = mainFrame.AbsolutePosition
	startMouse = userInputService:GetMouseLocation()
	resizing = true
end)

userInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		resizing = false
	end
end)

userInputService.InputChanged:Connect(function(input)
	if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
		local mouseDelta = userInputService:GetMouseLocation() - startMouse
		local newSize = Vector2.new(
			math.max(minSize.X, startSize.X + mouseDelta.X),
			math.max(minSize.Y, startSize.Y + mouseDelta.Y)
		)

		mainFrame.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
	end
end)

-- Create header
local header = createInstance("Frame", {
	Name = "Header",
	Parent = mainFrame,
	BackgroundColor3 = Color3.fromRGB(45, 45, 45),
	BorderSizePixel = 0,
	Size = UDim2.new(1, 0, 0, 30)
})

local title = createInstance("TextLabel", {
	Name = "Title",
	Parent = header,
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 10, 0, 0),
	Size = UDim2.new(1, -20, 1, 0),
	Font = Enum.Font.SourceSansBold,
	Text = "Farm GUI by _blahaj",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 16,
	TextXAlignment = Enum.TextXAlignment.Left
})

local closeButton = createInstance("TextButton", {
	Name = "CloseButton",
	Parent = header,
	BackgroundColor3 = Color3.fromRGB(200, 50, 50),
	BorderSizePixel = 0,
	Position = UDim2.new(1, -25, 0.5, -10),
	Size = UDim2.new(0, 20, 0, 20),
	Font = Enum.Font.SourceSansBold,
	Text = "X",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 14
})

closeButton.MouseButton1Click:Connect(function()
	gui.Enabled = false
end)

-- Create tabs sidebar
local tabsSidebar = createInstance("Frame", {
	Name = "TabsSidebar",
	Parent = mainFrame,
	BackgroundColor3 = Color3.fromRGB(45, 45, 45),
	BorderSizePixel = 0,
	Position = UDim2.new(0, 0, 0, 30),
	Size = UDim2.new(0, 100, 1, -30)
})

-- Create content frame
local contentFrame = createInstance("Frame", {
    Name = "ContentFrame",
    Parent = mainFrame,
    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 100, 0, 30),
    Size = UDim2.new(1, -100, 1, -30),
    ClipsDescendants = true  -- Add this to prevent content overflow
})

-- Function to create a tab
local function createTab(name, index)
    local tab = createInstance("TextButton", {
        Name = name .. "Tab",
        Parent = tabsSidebar,
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 40 * (index - 1)),
        Size = UDim2.new(1, 0, 0, 40),
        Font = Enum.Font.SourceSansBold,
        Text = name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14
    })

    local contentPage = createInstance("ScrollingFrame", {
        Name = name .. "Page",
        Parent = contentFrame,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 2, 0),  -- Increase canvas size for scrolling
        ScrollBarThickness = 6,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Visible = false,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png",
        MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
        TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
    })

    return tab, contentPage
end


-- Function to create a toggle
local function createToggle(parent, name, description, startingValue, callback, yPos)
	local toggle = createInstance("Frame", {
		Name = name .. "Toggle",
		Parent = parent,
		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 10, 0, yPos),
		Size = UDim2.new(1, -20, 0, 40)
	})

	local title = createInstance("TextLabel", {
		Name = "Title",
		Parent = toggle,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 0),
		Size = UDim2.new(1, -60, 0, 20),
		Font = Enum.Font.SourceSansBold,
		Text = name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	local desc = createInstance("TextLabel", {
		Name = "Description",
		Parent = toggle,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 20),
		Size = UDim2.new(1, -60, 0, 20),
		Font = Enum.Font.SourceSans,
		Text = description,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	local button = createInstance("Frame", {
		Name = "Button",
		Parent = toggle,
		BackgroundColor3 = startingValue and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(1, -40, 0.5, -10),
		Size = UDim2.new(0, 30, 0, 20),
		ZIndex = 2
	})

	local buttonCorner = createInstance("UICorner", {
		Name = "ButtonCorner",
		CornerRadius = UDim.new(0, 10),
		Parent = button
	})

	local knob = createInstance("Frame", {
		Name = "Knob",
		Parent = button,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Position = startingValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
		Size = UDim2.new(0, 16, 0, 16),
		ZIndex = 3
	})

	local knobCorner = createInstance("UICorner", {
		Name = "KnobCorner",
		CornerRadius = UDim.new(1, 0),
		Parent = knob
	})

	local clickArea = createInstance("TextButton", {
		Name = "ClickArea",
		Parent = toggle,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = "",
		ZIndex = 10
	})

	local value = startingValue

	clickArea.MouseButton1Click:Connect(function()
		value = not value
		button.BackgroundColor3 = value and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
		knob:TweenPosition(
			value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
			Enum.EasingDirection.InOut,
			Enum.EasingStyle.Quad,
			0.2,
			true
		)
		callback(value)
	end)

	return toggle, function() return value end, function(v) 
		value = v
		button.BackgroundColor3 = value and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
		knob.Position = value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
		callback(value)
	end
end

-- Function to create input field
local function createInputField(parent, name, description, defaultValue, callback, yPos)
	local inputField = createInstance("Frame", {
		Name = name .. "Field",
		Parent = parent,
		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 10, 0, yPos),
		Size = UDim2.new(1, -20, 0, 40)
	})

	local title = createInstance("TextLabel", {
		Name = "Title",
		Parent = inputField,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 0),
		Size = UDim2.new(1, -110, 0, 20),
		Font = Enum.Font.SourceSansBold,
		Text = name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	local desc = createInstance("TextLabel", {
		Name = "Description",
		Parent = inputField,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 20),
		Size = UDim2.new(1, -110, 0, 20),
		Font = Enum.Font.SourceSans,
		Text = description,
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	local input = createInstance("TextBox", {
		Name = "Input",
		Parent = inputField,
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderColor3 = Color3.fromRGB(100, 100, 100),
		BorderSizePixel = 1,
		Position = UDim2.new(1, -100, 0.5, -10),
		Size = UDim2.new(0, 90, 0, 20),
		Font = Enum.Font.SourceSans,
		Text = tostring(defaultValue),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14
	})

	input.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local success, value = pcall(function()
				return tonumber(input.Text) or input.Text
			end)

			if success then
				callback(value)
			end
		end
	end)

	return inputField, function() return input.Text end, function(value) input.Text = tostring(value) end
end

-- Function to create a small toggle without description
local function createSmallToggle(parent, name, startingValue, callback, x, y)
	local toggle = createInstance("Frame", {
		Name = name .. "Toggle",
		Parent = parent,
		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
		BorderSizePixel = 0,
		Position = UDim2.new(x, 0, 0, y),
		Size = UDim2.new(0.45, -10, 0, 30),
		ClipsDescendants = true
	})

	local title = createInstance("TextLabel", {
		Name = "Title",
		Parent = toggle,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 0),
		Size = UDim2.new(1, -50, 1, 0),
		Font = Enum.Font.SourceSansBold,
		Text = name,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	local button = createInstance("Frame", {
		Name = "Button",
		Parent = toggle,
		BackgroundColor3 = startingValue and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0),
		BorderSizePixel = 0,
		Position = UDim2.new(1, -40, 0.5, -8),
		Size = UDim2.new(0, 30, 0, 16),
		ZIndex = 2
	})

	local buttonCorner = createInstance("UICorner", {
		Name = "ButtonCorner",
		CornerRadius = UDim.new(0, 10),
		Parent = button
	})

	local knob = createInstance("Frame", {
		Name = "Knob",
		Parent = button,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Position = startingValue and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 2, 0.5, -6),
		Size = UDim2.new(0, 12, 0, 12),
		ZIndex = 3
	})

	local knobCorner = createInstance("UICorner", {
		Name = "KnobCorner",
		CornerRadius = UDim.new(1, 0),
		Parent = knob
	})

	local clickArea = createInstance("TextButton", {
		Name = "ClickArea",
		Parent = toggle,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = "",
		ZIndex = 10
	})

	local value = startingValue

	clickArea.MouseButton1Click:Connect(function()
		value = not value
		button.BackgroundColor3 = value and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
		knob:TweenPosition(
			value and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 2, 0.5, -6),
			Enum.EasingDirection.InOut,
			Enum.EasingStyle.Quad,
			0.2,
			true
		)
		callback(value)
	end)

	return toggle, function() return value end, function(v) 
		value = v
		button.BackgroundColor3 = value and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
		knob.Position = value and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
		callback(value)
	end
end

-- Function to create section title
local function createSectionTitle(parent, title, yPos)
	local sectionTitle = createInstance("TextLabel", {
		Name = title .. "Section",
		Parent = parent,
		BackgroundColor3 = Color3.fromRGB(50, 50, 50),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 10, 0, yPos),
		Size = UDim2.new(1, -20, 0, 30),
		Font = Enum.Font.SourceSansBold,
		Text = "  " .. title,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	})

	return sectionTitle
end

-- Create tabs
local autoBuyTab, autoBuyPage = createTab("Auto Buy", 1)
local autoSellTab, autoSellPage = createTab("Auto Sell", 2)
local autoPlantTab, autoPlantPage = createTab("Auto Plant", 3)
local autoHarvestTab, autoHarvestPage = createTab("Harvest", 4)
local miscTab, miscPage = createTab("Misc", 5)

-- Show the first page by default
autoBuyPage.Visible = true

-- Tab switching logic
local tabs = {autoBuyTab, autoSellTab, autoPlantTab, autoHarvestTab, miscTab}
local pages = {autoBuyPage, autoSellPage, autoPlantPage, autoHarvestPage, miscPage}

local function switchTab(index)
	for i, tab in ipairs(tabs) do
		tab.BackgroundColor3 = i == index and Color3.fromRGB(55, 55, 55) or Color3.fromRGB(35, 35, 35)
	end

	for i, page in ipairs(pages) do
		page.Visible = i == index
	end
end

for i, tab in ipairs(tabs) do
	tab.MouseButton1Click:Connect(function()
		switchTab(i)
	end)
end

-- Initialize with the first tab selected
switchTab(1)

-- Create content for Auto Buy page
local autoBuyMainToggle, getAutoBuyMain, setAutoBuyMain = createToggle(
	autoBuyPage, 
	"Auto Buy", 
	"Auto buy seeds from the shop", 
	_G.gameActions and _G.gameActions["AutoBuy"] or false, 
	function(value)
		if not _G.gameActions then _G.gameActions = {} end
		_G.gameActions["AutoBuy"] = value
	end, 
	10
)

-- Normal Seeds Section
-- Create section title for Normal Seeds
local normalSeedsSection = createSectionTitle(autoBuyPage, "Normal Seeds", 60)

local normalSeedToggles = {}
local buyListItems = {
	"Carrot", "Strawberry", "Blueberry", "Orange", "Tomato", "Corn", "Daffodil",
	"Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus",
	"Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper"
}

for i, item in ipairs(buyListItems) do
	local row = math.floor((i-1) / 2)
	local col = (i-1) % 2
	local xPos = col * 0.5
	local yPos = 100 + row * 40

	local toggle, getToggle, setToggle = createSmallToggle(
		autoBuyPage, 
		item, 
		_G.buyList and _G.buyList[item] or false, 
		function(value)
			if not _G.buyList then _G.buyList = {} end
			_G.buyList[item] = value
		end, 
		xPos,
		yPos
	)
	normalSeedToggles[item] = {toggle = toggle, get = getToggle, set = setToggle}
end

---- Easter Section
---- Create section title for Easter Items
--local easterSection = createSectionTitle(autoBuyPage, "Easter Items", 100 + math.ceil(#buyListItems/2) * 40)
--
--local easterToggles = {}
--local easterItems = {
--	"Chocolate Carrot", "Red Lollipop", "Candy Sunflower", "Easter Egg", 
--	"Chocolate Sprinkler", "Candy Blossom"
--}
--
--for i, item in ipairs(easterItems) do
--	local row = math.floor((i-1) / 2)
--	local col = (i-1) % 2
--	local xPos = col * 0.5
--	local yPos = 140 + math.ceil(#buyListItems/2) * 40 + row * 40
--
--	local toggle, getToggle, setToggle = createSmallToggle(
--		autoBuyPage, 
--		item, 
--		_G.easterBuyList and _G.easterBuyList[item] or false, 
--		function(value)
--			if not _G.easterBuyList then _G.easterBuyList = {} end
--			_G.easterBuyList[item] = value
--		end, 
--		xPos,
--		yPos
--	)
--	easterToggles[item] = {toggle = toggle, get = getToggle, set = setToggle}
--end

-- Gear Section
-- Create section title for Gear Items
local gearSection = createSectionTitle(autoBuyPage, "Gear Items", 100 + math.ceil(#buyListItems/2) * 40)

local gearToggles = {}
local gearItems = {
	"Watering Can", "Trowel", "Basic Sprinkler", "Advanced Sprinkler", "Godly Sprinkler", "Lightning Rod", "Master Sprinkler"
}

for i, item in ipairs(gearItems) do
	local row = math.floor((i-1) / 2)
	local col = (i-1) % 2
	local xPos = col * 0.5
	local yPos = 140 + math.ceil(#buyListItems/2) * 40 + row * 40

	local toggle, getToggle, setToggle = createSmallToggle(
		autoBuyPage, 
		item, 
		_G.gearBuyList and _G.gearBuyList[item] or false, 
		function(value)
			if not _G.gearBuyList then _G.gearBuyList = {} end
			_G.gearBuyList[item] = value
		end, 
		xPos,
		yPos
	)
	gearToggles[item] = {toggle = toggle, get = getToggle, set = setToggle}
end

local eggSection = createSectionTitle(autoBuyPage, "Eggs", 140 + (math.ceil(#buyListItems/2) + math.ceil(#gearItems/2)) * 40)

local eggToggles = {}
local eggItems = {
    "Common", "Uncommon", "Rare", "Legendary", "Bug"
}

for i, item in ipairs(eggItems) do
	local row = math.floor((i-1) / 2)
	local col = (i-1) % 2
	local xPos = col * 0.5
	local yPos = 180 + (math.ceil(#buyListItems/2) + math.ceil(#gearItems/2)) * 40 + row * 40

	local toggle, getToggle, setToggle = createSmallToggle(
		autoBuyPage, 
		item, 
		_G.eggBuyList and _G.eggBuyList[item] or false, 
		function(value)
			if not _G.eggBuyList then _G.eggBuyList = {} end
			_G.eggBuyList[item] = value
		end, 
		xPos,
		yPos
	)
	eggToggles[item] = {toggle = toggle, get = getToggle, set = setToggle}
end

-- Create content for Auto Sell page
local autoSellToggle, getAutoSell, setAutoSell = createToggle(
	autoSellPage, 
	"Auto Sell", 
	"Auto sell your inventory", 
	_G.gameActions and _G.gameActions["AutoSell"] or false, 
	function(value)
		if not _G.gameActions then _G.gameActions = {} end
		_G.gameActions["AutoSell"] = value
	end, 
	10
)

local saveItemsToggle, getSaveItems, setSaveItems = createToggle(
	autoSellPage, 
	"Save Items Above Weight", 
	"Automatically favorite items above a certain weight", 
	_G.gameActions and _G.gameActions["SaveItemsAboveWeight"] or false, 
	function(value)
		if not _G.gameActions then _G.gameActions = {} end
		_G.gameActions["SaveItemsAboveWeight"] = value
	end, 
	60
)

local saveWeightInput, getSaveWeight, setSaveWeight = createInputField(
	autoSellPage,
	"Save Weight",
	"Save items above this weight",
	_G.saveWeight or 20,
	function(value)
		_G.saveWeight = tonumber(value)
	end,
	110
)

-- Create content for Auto Plant page
local autoPlantToggle, getAutoPlant, setAutoPlant = createToggle(
	autoPlantPage, 
	"Auto Plant", 
	"Auto plant seeds in your inventory", 
	_G.gameActions and _G.gameActions["AutoPlant"] or false, 
	function(value)
		if not _G.gameActions then _G.gameActions = {} end
		_G.gameActions["AutoPlant"] = value
	end, 
	10
)

-- Create section title for Plant Toggles
local plantToggleSection = createSectionTitle(autoPlantPage, "Plant Seeds", 60)

local plantToggles = {}
local plantItems = {
	"Carrot", "Strawberry", "Blueberry", "Orange", "Tomato", "Corn", "Daffodil",
	"Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus",
	"Dragon Fruit", "Mango", "Grape", "Chocolate Carrot", "Red Lollipop", 
	"Candy Sunflower", "Easter Egg", "Candy Blossom"
}

for i, item in ipairs(plantItems) do
	local row = math.floor((i-1) / 2)
	local col = (i-1) % 2
	local xPos = col * 0.5
	local yPos = 100 + row * 40

	local toggle, getToggle, setToggle = createSmallToggle(
		autoPlantPage, 
		item, 
		_G.plantList and _G.plantList[item] or false, 
		function(value)
			if not _G.plantList then _G.plantList = {} end
			_G.plantList[item] = value
		end, 
		xPos,
		yPos
	)
	plantToggles[item] = {toggle = toggle, get = getToggle, set = setToggle}
end

-- Create content for Auto Harvest page
local autoHarvestToggle, getAutoHarvest, setAutoHarvest = createToggle(
	autoHarvestPage, 
	"Auto Harvest", 
	"Auto harvest plants", 
	_G.gameActions and _G.gameActions["Autoharvest"] or false, 
	function(value)
		if not _G.gameActions then _G.gameActions = {} end
		_G.gameActions["Autoharvest"] = value
	end, 
	10
)

local collectNearToggle, getCollectNear, setCollectNear = createToggle(
	autoHarvestPage, 
	"Collect Near", 
	"Auto collect plants near you", 
	_G.gameActions and _G.gameActions["CollectNear"] or false, 
	function(value)
		if not _G.gameActions then _G.gameActions = {} end
		_G.gameActions["CollectNear"] = value
	end, 
	60
)

local fruitNoClipToggle, getFruitNoClip, setFruitNoClip = createToggle(
	autoHarvestPage, 
	"Fruit No Clip", 
	"Make fruits not collide with you", 
	_G.gameActions and _G.gameActions["FruitNoClip"] or false, 
	function(value)
		if not _G.gameActions then _G.gameActions = {} end
		_G.gameActions["FruitNoClip"] = value
	end, 
	110
)

local pickupTimeInput, getPickupTime, setPickupTime = createInputField(
	autoHarvestPage,
	"Pickup Time",
	"Time between pickups (seconds)",
	_G.pickupTime or 0.022,
	function(value)
		_G.pickupTime = tonumber(value)
	end,
	160
)

-- Create content for Misc page
local freeCamToggle, getFreeCam, setFreeCam = createToggle(
	miscPage, 
	"FreeCam On Collection", 
	"Enable freecam during collection", 
	_G.gameActions and _G.gameActions["FreeCamOnCollection"] or false, 
	function(value)
		if not _G.gameActions then _G.gameActions = {} end
		_G.gameActions["FreeCamOnCollection"] = value
	end, 
	10
)

local walkSpeedInput, getWalkSpeed, setWalkSpeed = createInputField(
	miscPage,
	"Walk Speed",
	"Your character's walk speed",
	game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed or 16,
	function(value)
		if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(value)
		end
	end,
	60
)

local jumpPowerInput, getJumpPower, setJumpPower = createInputField(
	miscPage,
	"Jump Power",
	"Your character's jump power",
	game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.JumpPower or 50,
	function(value)
		if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(value)
		end
	end,
	110
)

-- Create toggle for GUI visibility
local toggleButton = createInstance("TextButton", {
	Name = "ToggleButton",
	Parent = player.PlayerGui,
	BackgroundColor3 = Color3.fromRGB(45, 45, 45),
	BorderColor3 = Color3.fromRGB(255, 255, 255),
	BorderSizePixel = 2,
	Position = UDim2.new(0, 10, 0.5, -15),
	Size = UDim2.new(0, 30, 0, 30),
	Text = "FG",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 14,
	Font = Enum.Font.SourceSansBold
})

toggleButton.MouseButton1Click:Connect(function()
	gui.Enabled = not gui.Enabled
end)

-- Create corners for UI elements
local mainCorner = createInstance("UICorner", {
	CornerRadius = UDim.new(0, 6),
	Parent = mainFrame
})

local toggleCorner = createInstance("UICorner", {
	CornerRadius = UDim.new(0, 6),
	Parent = toggleButton
})

-- Update character speed and jump power when the character respawns
player.CharacterAdded:Connect(function(character)
	local humanoid = character:WaitForChild("Humanoid")
	if getWalkSpeed then
		humanoid.WalkSpeed = tonumber(getWalkSpeed())
	end
	if getJumpPower then
		humanoid.JumpPower = tonumber(getJumpPower())
	end
end)

-- Create key shortcut to toggle GUI (Right Control)
userInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.RightControl then
		gui.Enabled = not gui.Enabled
	end
end)

-- Expose the GUI visibility toggle function
_G.toggleFarmGUI = function()
	gui.Enabled = not gui.Enabled
end

-- Expose the destroy function
_G.destroyFarmGUI = function()
	gui:Destroy()
	toggleButton:Destroy()
	_G.destroy = true
end

-- Connect to the destroy variable
spawn(function()
	while wait(1) do
		if _G.destroy then
			gui:Destroy()
			toggleButton:Destroy()
			break
		end
	end
end)

--plant mover
local function selectTrowel()
	for _,item in game.Players.LocalPlayer.Backpack:GetChildren() do
		if string.find(item.Name, "Trowel") then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(item)
		end
	end
end

local function getCoreFruit(item)
    if item.Parent == farm.Important.Plants_Physical then
        fruit = item
    elseif item.Parent == game.Workspace then
        error("Item is not a fruit on your farm")
    else
        getCoreFruit(item.Parent)
    end
end

local function pickup(item)
    selectTrowel()
    local trowel
    for _, item in game.Players.LocalPlayer.Backpack:GetChildren() do
        if string.find(item.Name, "Trowel") then
            trowel = item
        end
    end
    if string.find(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name, "Trowel") then
        trowel = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    end
    if not trowel then error("No trowel found") end

    local args = {
	    "Pickup",
	    trowel,
	    item
    }
    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("TrowelRemote"):InvokeServer(unpack(args))
end

local function place(item, overwrite)
    local trowel
    for _, item in game.Players.LocalPlayer.Backpack:GetChildren() do
        if string.find(item.Name, "Trowel") then
            trowel = item
        end
    end
    if string.find(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name, "Trowel") then
        trowel = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    end
    if not trowel then error("No trowel found") end

    local position
    if overwrite then
        position = previous
    else
        position = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
        previous = position
    end
    local args = {
    	"Place",
    	trowel,
    	item,
    	position
    }
    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("TrowelRemote"):InvokeServer(unpack(args))
end

userInputService.InputBegan:connect(function(input)
    if input.KeyCode == Enum.KeyCode.X then
        getCoreFruit(playerMouse.Target)
        print(fruit)
        pickup(fruit)
    end
    if input.KeyCode == Enum.KeyCode.V and fruit then
        place(fruit, false)
    end
    if input.KeyCode == Enum.KeyCode.C and fruit then
        place(fruit, true)
    end
end)

--script notification
notificationModule:CreateNotification([[<font face="Roboto"><font color="#ff0000">T</font><font color="#ff1f00">h</font><font color="#ff3e00">i</font><font color="#ff5d00">s</font> <font color="#ff7c00">s</font><font color="#ff9b00">c</font><font color="#ffba00">r</font><font color="#ffd900">i</font><font color="#fff800">p</font><font color="#e7ff00">t</font> <font color="#c8ff00">w</font><font color="#a9ff00">a</font><font color="#8aff00">s</font> <font color="#6bff00">m</font><font color="#4cff00">a</font><font color="#2dff00">d</font><font color="#0eff00">e</font> <font color="#00ff11">b</font><font color="#00ff30">y</font> <font color="#00ff4f">_</font><font color="#00ff6e">b</font><font color="#00ff8d">l</font><font color="#00ffac">a</font><font color="#00ffcb">h</font><font color="#00ffea">a</font><font color="#00f5ff">j</font> <font color="#00d6ff">o</font><font color="#00b7ff">n</font> <font color="#0098ff">D</font><font color="#0079ff">C</font><font color="#005aff">,</font> <font color="#003bff">e</font><font color="#001cff">n</font><font color="#0300ff">j</font><font color="#2200ff">o</font><font color="#4100ff">y</font> <font color="#6000ff">;</font><font color="#8000ff">3</font></font>]])

-- ================ MAIN LOOP ================
-- Main running loop
while true do
	if _G.destroy then
		if freecam then
			StopFreecam()
		end
		break
	end

	local success, errorMsg

	if _G.gameActions["FruitNoClip"] then
		success, errorMsg = pcall(disableFruitsCollisions)
		if not success then
			warn("Error in FruitNoClip: " .. tostring(errorMsg))
		end
	end

	if _G.gameActions["Autoharvest"] then
		success, errorMsg = pcall(fruitCollect)
		if not success then
			warn("Error in Autoharvest: " .. tostring(errorMsg))
		end
	end

	if _G.gameActions["AutoSell"] then
		success, errorMsg = pcall(sellFruits)
		if not success then
			warn("Error in AutoSell: " .. tostring(errorMsg))
		end
	end

	if _G.gameActions["AutoBuy"] then
		success, errorMsg = pcall(checkFruitBuy)
		if not success then
			warn("Error in AutoBuy: " .. tostring(errorMsg))
		end
		success, errorMsg = pcall(checkGearBuy)
		if not success then
			warn("Error in AutoBuy: " .. tostring(errorMsg))
		end
		success, errorMsg = pcall(checkBuyEggs)
		if not success then
			warn("Error in AutoBuy: " .. tostring(errorMsg))
		end
	end

	if _G.gameActions["AutoPlant"] then
		success, errorMsg = pcall(plantSeeds)
		if not success then
			warn("Error in AutoPlant: " .. tostring(errorMsg))
		end
	end

	-- If no automation features are active, disable freecam and wait longer
	if not (_G.gameActions["Autoharvest"] or _G.gameActions["AutoBuy"] or 
		_G.gameActions["AutoSell"] or _G.gameActions["AutoPlant"]) then
		if freecam then
			StopFreecam()
			freecam = false
		end
		task.wait(1)
	else
		task.wait(0.1) -- More responsive wait time when features are active
	end
end