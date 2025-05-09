local replicatedStorage = game:GetService("ReplicatedStorage")
local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local PPS = game:GetService("ProximityPromptService")
local ContextActionService = game:GetService("ContextActionService")
local runService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local notificationModule = require(replicatedStorage.Modules.Notification)
local getFarmModule = require(replicatedStorage.Modules.GetFarm)

local plantEvent = replicatedStorage:WaitForChild("GameEvents"):WaitForChild("Plant_RE")

local localPlayer = players.LocalPlayer
local farm = getFarmModule(localPlayer)

local destroy = false --destroy button in UI
local pickupTime = 0.022 --to be set by UI
local saveWeight = 20 --to be set by UI

local pi    = math.pi
local abs   = math.abs
local clamp = math.clamp
local exp   = math.exp
local rad   = math.rad
local sign  = math.sign
local sqrt  = math.sqrt
local tan   = math.tan

local plantList = { --will be set in UI once made
	Carrot = true,
	Strawberry = false,
	Blueberry = false,
	Orange = false,
	Tomato = false,
	Corn = false,
	Daffodil = false,
	Watermelon = true,
	Pumpkin = true,
	Apple = false,
	Bamboo = true,
	Coconut = false,
	Cactus = false,
	["Dragon Fruit"] = false,
	Mango = false,
	Grap = false,
	["Chocolate Carrot"] = false,
	["Red Lollipop"] = false,
	["Candy Sunflower"] = false,
	["Easter Egg"] = false,
	["Candy Blossom"] = false
}

local buyList = { --will be set in UI once made
	Carrot = true,
	Strawberry = false,
	Blueberry = false,
	Orange = false,
	Tomato = false,
	Corn = false,
	Daffodil = false,
	Watermelon = true,
	Pumpkin = true,
	Apple = true,
	Bamboo = true,
	Coconut = true,
	Cactus = true,
	["Dragon Fruit"] = true,
	Mango = true,
	Grape = true
}

local gearBuyList = { --will be set in UI once made
	WateringCan = true,
	BasicSprinkler = true,
	AdvancedSprinkler = true,
	GodlySprinkler = true,
	MasterSprinkler = true
}

local easterBuyList = { --will be set in UI once made
	["Chocolate Carrot"] = true,
	["Red Lollipop"] = true,
	["Candy Sunflower"] = true,
	["Easter Egg"] = true,
	["Chocolate Sprinkler"] = false,
	["Candy Blossom"] = true
}

local gameActions = { --will be set in UI once made
	["AutoSell"] = true,
	["AutoBuy"] = true,
	["Autoharvest"] = true,
	["AutoPlant"] = true,
	["AutoBuyGear"] = true,
	["CollectNear"] = true,
	["FruitNoClip"] = true,
	["SaveItemsAboveWeight"] = true,
	["FreeCamOnCollection"] = true
}

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

		local shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)

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

		mouseBehavior = UserInputService.MouseBehavior
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
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

		UserInputService.MouseBehavior = mouseBehavior
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
			if not UserInputService:IsKeyDown(macro[i]) then
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

--saving items above a weight
local function checkForSave()
	if gameActions["SaveItemsAboveWeight"] then
		for _, item in localPlayer.Backpack:GetDescendants() do
			if item.Name == "Weight" and item.Value >= saveWeight and not item.Parent:GetAttribute("Favorite") then
				replicatedStorage:WaitForChild("GameEvents"):WaitForChild("Favorite_Item"):FireServer(item.Parent)
			end
		end
	end
end

--sell fruit
local function sellFruits()
	checkForSave()
	localPlayer.Character:PivotTo(CFrame.new(62,3,-1))
	wait(0.3)
	replicatedStorage:WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
end

--disable collisions
local function disableFruitsCollisions()
	for _,fruit in farm.Important.Plants_Physical:GetChildren() do
		for _,p in fruit:GetDescendants() do
			if p:IsA("BasePart") then
				p.CanCollide = false
			end
		end
	end
end

--collect on show
PPS.PromptShown:Connect(function(prompt)
	if gameActions["CollectNear"] and prompt:IsDescendantOf(farm.Important.Plants_Physical) then
		runService.RenderStepped:Wait()
		fireproximityprompt(prompt)
	end
end)

--easter stuff
local function easterCheckStock(item)
	for _,des in game.Players.LocalPlayer.PlayerGui.Easter_Shop.Frame.ScrollingFrame:GetDescendants() do
		if des.Name == "Stock_Text" and des.Parent.Parent.Name == item then
			return string.match(des.Text, "%d+")
		end
	end
end

local function easterBuyItem(item)
	local stock = tonumber(easterCheckStock(item))
	if stock > 0 then
		for i = 1, stock do
			if not gameActions["AutoBuy"] then
				return
			end
			replicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyEasterStock"):FireServer(item)
		end
	end
end

--buy gears
local function gearCheckStock(gear)
	for _,des in game.Players.LocalPlayer.PlayerGui.Gear_Shop.Frame.ScrollingFrame:GetDescendants() do
		if des.Name == "Stock_Text" and des.Parent.Parent.Name == gear then
			return string.match(des.Text, "%d+")
		end
	end
end

local function buyGear(gear)
	local stock = tonumber(gearCheckStock(gear))
	if stock > 0 then
		for i = 1, stock do
			if not gameActions["AutoBuyGear"] then
				return
			end
			replicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer(gear)
		end
	end
end

local function checkGearBuy()
	for gear, a in gearBuyList do
		if not gameActions["AutoBuyGear"] then
			return
		end
		if a then
			buyGear(gear)
		end
	end
end

--buy fruit
local function checkStock(fruit)
	for _,des in game.Players.LocalPlayer.PlayerGui.Seed_Shop.Frame.ScrollingFrame:GetDescendants() do
		if des.Name == "Stock_Text" and des.Parent.Parent.Name == fruit then
			return string.match(des.Text, "%d+")
		end
	end
end

local function buyFruit(fruit)
	local stock = tonumber(checkStock(fruit))
	if stock > 0 then
		for i = 1, stock do
			if not gameActions["AutoBuy"] then
				return
			end
			replicatedStorage:WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(fruit)
		end
	end
end

local function checkFruitBuy()
	for fruit, a in buyList do
		if not gameActions["AutoBuy"] then
			return
		end
		if a then
			buyFruit(fruit)
		end
	end
	for item, a in easterBuyList do
		if not gameActions["AutoBuy"] then
			return
		end
		if a then
			easterBuyItem(item)
		end
	end
end

--planting
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
		if not gameActions["AutoPlant"] then
			return
		end
		if des:IsA("StringValue") and des.Name == "Plant_Name" and plantList[des.Value] then
			selectFruit(des.Value)
			wait(1)
			for i = 1, des.Parent.Numbers.Value do
				if not gameActions["AutoPlant"] then
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

--harvest
local freecam = false
local function fruitCollect()
	if gameActions["FreeCamOnCollection"] and not freecam then
		freecam = true
		StartFreecam()
	end
	for _, fruit in collectionService:GetTagged("CollectPrompt") do
		fruit.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow
	end
	for _, fruit in collectionService:GetTagged("Harvestable") do
		for a,b in gameActions do if a == "AutoHarvest" then return end end
		if #localPlayer.Backpack:GetChildren() >= 200 then
			sellFruits()
		end
		local item = fruit:FindFirstChild("ProximityPrompt", true)
		if fruit and fruit.PrimaryPart and item and fruit:IsDescendantOf(farm.Important.Plants_Physical) then
			localPlayer.Character:PivotTo(CFrame.new(fruit.PrimaryPart.Position))
			task.wait(pickupTime)
			fireproximityprompt(item)
			task.wait(pickupTime)
		end
	end
end

--anti afk
game.Players.LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):CaptureController()
	game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

--script notification
notificationModule:CreateNotification([[<font face="Roboto"><font color="#ff0000">T</font><font color="#ff1f00">h</font><font color="#ff3e00">i</font><font color="#ff5d00">s</font> <font color="#ff7c00">s</font><font color="#ff9b00">c</font><font color="#ffba00">r</font><font color="#ffd900">i</font><font color="#fff800">p</font><font color="#e7ff00">t</font> <font color="#c8ff00">w</font><font color="#a9ff00">a</font><font color="#8aff00">s</font> <font color="#6bff00">m</font><font color="#4cff00">a</font><font color="#2dff00">d</font><font color="#0eff00">e</font> <font color="#00ff11">b</font><font color="#00ff30">y</font> <font color="#00ff4f">_</font><font color="#00ff6e">b</font><font color="#00ff8d">l</font><font color="#00ffac">a</font><font color="#00ffcb">h</font><font color="#00ffea">a</font><font color="#00f5ff">j</font> <font color="#00d6ff">o</font><font color="#00b7ff">n</font> <font color="#0098ff">D</font><font color="#0079ff">C</font><font color="#005aff">,</font> <font color="#003bff">e</font><font color="#001cff">n</font><font color="#0300ff">j</font><font color="#2200ff">o</font><font color="#4100ff">y</font> <font color="#6000ff">;</font><font color="#8000ff">3</font></font>]])

--main loop
while true do
	if not destroy then
		if gameActions["FruitNoClip"] then
			local s,r = pcall(function()
				disableFruitsCollisions()
			end)
			if not s then print(r) end
		end
		if gameActions["Autoharvest"] then
			local s,r = pcall(function()
				fruitCollect()
			end)
			if not s then print(r) end
		end
		if gameActions["AutoSell"] then
			local s,r = pcall(function()
				sellFruits()
			end)
			if not s then print(r) end
		end
		if gameActions["AutoBuy"] then
			local s,r = pcall(function()
				checkFruitBuy()
			end)
			if not s then print(r) end
		end
		if gameActions["AutoBuyGear"] then
			local s,r = pcall(function()
				checkGearBuy()
			end)
			if not s then print(r) end
		end
		if gameActions["AutoPlant"] then
			local s,r = pcall(function()
				plantSeeds()
			end)
			if not s then print(r) end
		end
		if not gameActions["Autoharvest"] and not gameActions["AutoBuy"] and not gameActions["AutoSell"] and not gameActions["AutoPlant"] then
			StopFreecam()
			freecam = false
			task.wait(1)
		end
	else
		--destroy UI once implemented
		break
	end
end