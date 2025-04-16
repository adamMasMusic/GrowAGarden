local localFarm
local enabled = false

local plantList = {
	Bamboo = false,
	Coconut = false,
	Tomato = false,
	Pumpkin = false,
	Apple = false,
	Corn = false,
	["Dragon Fruit"] = false,
	Blueberry = false,
	Carrot = false,
	Mango = false,
	Cactus = false,
	Strawberry = false,
	Watermelon = false
}

local fruitList = {
	Bamboo = false,
	Coconut = false,
	Tomato = false,
	Pumpkin = false,
	Apple = false,
	Corn = false,
	["Dragon Fruit"] = false,
	Blueberry = false,
	Carrot = false,
	Mango = false,
	Cactus = false,
	Strawberry = false,
	Watermelon = false
}

local plantEvent = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Plant_RE")
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Pages = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")
local AutoPlant = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local OpenAutoPlantButton = Instance.new("TextButton")
local UIPadding = Instance.new("UIPadding")
local UIPadding_2 = Instance.new("UIPadding")
local AutoHarvest = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local OpenAutoHarvestButton = Instance.new("TextButton")
local UIPadding_3 = Instance.new("UIPadding")
local AutoSell = Instance.new("Frame")
local UICorner_5 = Instance.new("UICorner")
local OpenAutoSellButton = Instance.new("TextButton")
local UIPadding_4 = Instance.new("UIPadding")
local AutoBuy = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local OpenAutoBuyButton = Instance.new("TextButton")
local UIPadding_5 = Instance.new("UIPadding")
local AutoSell_2 = Instance.new("Frame")
local UICorner_7 = Instance.new("UICorner")
local UIListLayout_2 = Instance.new("UIListLayout")
local Enable = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local AutoSellEnableButton = Instance.new("ImageButton")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local AutoBuy_2 = Instance.new("Frame")
local UICorner_8 = Instance.new("UICorner")
local UIListLayout_3 = Instance.new("UIListLayout")
local Enable_2 = Instance.new("Frame")
local TextLabel_2 = Instance.new("TextLabel")
local AutoBuyEnableButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout_4 = Instance.new("UIListLayout")
local Bamboo = Instance.new("Frame")
local TextLabel_3 = Instance.new("TextLabel")
local BuyBambooButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
local TextLabel_4 = Instance.new("TextLabel")
local Coconut = Instance.new("Frame")
local TextLabel_5 = Instance.new("TextLabel")
local BuyCoconutButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint")
local Tomato = Instance.new("Frame")
local TextLabel_6 = Instance.new("TextLabel")
local BuyTomatoButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint")
local Pumpkin = Instance.new("Frame")
local TextLabel_7 = Instance.new("TextLabel")
local BuyPumpkinButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_6 = Instance.new("UIAspectRatioConstraint")
local Apple = Instance.new("Frame")
local TextLabel_8 = Instance.new("TextLabel")
local BuyAppleButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_7 = Instance.new("UIAspectRatioConstraint")
local Corn = Instance.new("Frame")
local TextLabel_9 = Instance.new("TextLabel")
local BuyCornButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_8 = Instance.new("UIAspectRatioConstraint")
local DragonFruit = Instance.new("Frame")
local TextLabel_10 = Instance.new("TextLabel")
local BuyDragonFruitButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_9 = Instance.new("UIAspectRatioConstraint")
local Blueberry = Instance.new("Frame")
local TextLabel_11 = Instance.new("TextLabel")
local BuyBlueberryButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_10 = Instance.new("UIAspectRatioConstraint")
local Carrot = Instance.new("Frame")
local TextLabel_12 = Instance.new("TextLabel")
local BuyCarrotButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_11 = Instance.new("UIAspectRatioConstraint")
local Mango = Instance.new("Frame")
local TextLabel_13 = Instance.new("TextLabel")
local BuyMangoButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_12 = Instance.new("UIAspectRatioConstraint")
local Cactus = Instance.new("Frame")
local TextLabel_14 = Instance.new("TextLabel")
local BuyCactusButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_13 = Instance.new("UIAspectRatioConstraint")
local Strawberry = Instance.new("Frame")
local TextLabel_15 = Instance.new("TextLabel")
local BuyStrawberryButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_14 = Instance.new("UIAspectRatioConstraint")
local Watermelon = Instance.new("Frame")
local TextLabel_16 = Instance.new("TextLabel")
local BuyWatermelonButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_15 = Instance.new("UIAspectRatioConstraint")
local AutoHarvest_2 = Instance.new("Frame")
local UICorner_9 = Instance.new("UICorner")
local UIListLayout_5 = Instance.new("UIListLayout")
local Enable_3 = Instance.new("Frame")
local TextLabel_17 = Instance.new("TextLabel")
local AutoHarvestEnableButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_16 = Instance.new("UIAspectRatioConstraint")
local NoClipFruit = Instance.new("Frame")
local TextLabel_18 = Instance.new("TextLabel")
local FruitNoclipEnableButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_17 = Instance.new("UIAspectRatioConstraint")
local AutoPlant_2 = Instance.new("Frame")
local UICorner_10 = Instance.new("UICorner")
local UIListLayout_6 = Instance.new("UIListLayout")
local Enable_4 = Instance.new("Frame")
local TextLabel_19 = Instance.new("TextLabel")
local AutoPlantEnableButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_18 = Instance.new("UIAspectRatioConstraint")
local ScrollingFrame_2 = Instance.new("ScrollingFrame")
local UIListLayout_7 = Instance.new("UIListLayout")
local Bamboo_2 = Instance.new("Frame")
local TextLabel_20 = Instance.new("TextLabel")
local PlantBambooButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_19 = Instance.new("UIAspectRatioConstraint")
local TextLabel_21 = Instance.new("TextLabel")
local Coconut_2 = Instance.new("Frame")
local TextLabel_22 = Instance.new("TextLabel")
local PlantCoconutButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_20 = Instance.new("UIAspectRatioConstraint")
local Tomato_2 = Instance.new("Frame")
local TextLabel_23 = Instance.new("TextLabel")
local PlantTomatoButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_21 = Instance.new("UIAspectRatioConstraint")
local Pumpkin_2 = Instance.new("Frame")
local TextLabel_24 = Instance.new("TextLabel")
local PlantPumpkinButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_22 = Instance.new("UIAspectRatioConstraint")
local Apple_2 = Instance.new("Frame")
local TextLabel_25 = Instance.new("TextLabel")
local PlantAppleButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_23 = Instance.new("UIAspectRatioConstraint")
local Corn_2 = Instance.new("Frame")
local TextLabel_26 = Instance.new("TextLabel")
local PlantCornButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_24 = Instance.new("UIAspectRatioConstraint")
local DragonFruit_2 = Instance.new("Frame")
local TextLabel_27 = Instance.new("TextLabel")
local PlantDragonFruitButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_25 = Instance.new("UIAspectRatioConstraint")
local Blueberry_2 = Instance.new("Frame")
local TextLabel_28 = Instance.new("TextLabel")
local PlantBlueberryButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_26 = Instance.new("UIAspectRatioConstraint")
local Carrot_2 = Instance.new("Frame")
local TextLabel_29 = Instance.new("TextLabel")
local PlantCarrotButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_27 = Instance.new("UIAspectRatioConstraint")
local Mango_2 = Instance.new("Frame")
local TextLabel_30 = Instance.new("TextLabel")
local PlantMangoButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_28 = Instance.new("UIAspectRatioConstraint")
local Cactus_2 = Instance.new("Frame")
local TextLabel_31 = Instance.new("TextLabel")
local PlantCactusButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_29 = Instance.new("UIAspectRatioConstraint")
local Strawberry_2 = Instance.new("Frame")
local TextLabel_32 = Instance.new("TextLabel")
local PlantStrawberryButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_30 = Instance.new("UIAspectRatioConstraint")
local Watermelon_2 = Instance.new("Frame")
local TextLabel_33 = Instance.new("TextLabel")
local PlantWatermelonButton = Instance.new("ImageButton")
local UIAspectRatioConstraint_31 = Instance.new("UIAspectRatioConstraint")

local function setUI()
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = ScreenGui
	Main.BackgroundColor3 = Color3.fromRGB(72, 77, 85)
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.0472279266, 0, 0.401486933, 0)
	Main.Size = UDim2.new(0.300000012, 0, 0.400000006, 0)

	UICorner.CornerRadius = UDim.new(0.0399999991, 0)
	UICorner.Parent = Main

	Pages.Name = "Pages"
	Pages.Parent = Main
	Pages.AnchorPoint = Vector2.new(0, 0.5)
	Pages.BackgroundColor3 = Color3.fromRGB(53, 57, 63)
	Pages.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Pages.BorderSizePixel = 0
	Pages.Position = UDim2.new(0.0342231318, 0, 0.5, 0)
	Pages.Size = UDim2.new(0.249828875, 0, 0.906133831, 0)

	UICorner_2.CornerRadius = UDim.new(0.0547945201, 0)
	UICorner_2.Parent = Pages

	UIListLayout.Parent = Pages
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0.00999999978, 0)

	AutoPlant.Name = "AutoPlant"
	AutoPlant.Parent = Pages
	AutoPlant.AnchorPoint = Vector2.new(0.5, 0)
	AutoPlant.BackgroundColor3 = Color3.fromRGB(72, 77, 85)
	AutoPlant.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoPlant.BorderSizePixel = 0
	AutoPlant.Size = UDim2.new(0.899999976, 0, 0.100000001, 0)

	UICorner_3.CornerRadius = UDim.new(0.205128208, 0)
	UICorner_3.Parent = AutoPlant

	OpenAutoPlantButton.Name = "OpenAutoPlantButton"
	OpenAutoPlantButton.Parent = AutoPlant
	OpenAutoPlantButton.AnchorPoint = Vector2.new(0.5, 0.5)
	OpenAutoPlantButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	OpenAutoPlantButton.BackgroundTransparency = 1.000
	OpenAutoPlantButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	OpenAutoPlantButton.BorderSizePixel = 0
	OpenAutoPlantButton.Position = UDim2.new(0.5, 0, 0.5, 0)
	OpenAutoPlantButton.Size = UDim2.new(1, 0, 1, 0)
	OpenAutoPlantButton.Font = Enum.Font.FredokaOne
	OpenAutoPlantButton.Text = "Auto plant"
	OpenAutoPlantButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	OpenAutoPlantButton.TextScaled = true
	OpenAutoPlantButton.TextSize = 14.000
	OpenAutoPlantButton.TextWrapped = true

	UIPadding.Parent = AutoPlant
	UIPadding.PaddingLeft = UDim.new(0.0500000007, 0)
	UIPadding.PaddingRight = UDim.new(0.0500000007, 0)

	UIPadding_2.Parent = Pages
	UIPadding_2.PaddingTop = UDim.new(0.0199999996, 0)

	AutoHarvest.Name = "AutoHarvest"
	AutoHarvest.Parent = Pages
	AutoHarvest.AnchorPoint = Vector2.new(0.5, 0)
	AutoHarvest.BackgroundColor3 = Color3.fromRGB(72, 77, 85)
	AutoHarvest.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoHarvest.BorderSizePixel = 0
	AutoHarvest.Size = UDim2.new(0.899999976, 0, 0.100000001, 0)

	UICorner_4.CornerRadius = UDim.new(0.205128208, 0)
	UICorner_4.Parent = AutoHarvest

	OpenAutoHarvestButton.Name = "OpenAutoHarvestButton"
	OpenAutoHarvestButton.Parent = AutoHarvest
	OpenAutoHarvestButton.AnchorPoint = Vector2.new(0.5, 0.5)
	OpenAutoHarvestButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	OpenAutoHarvestButton.BackgroundTransparency = 1.000
	OpenAutoHarvestButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	OpenAutoHarvestButton.BorderSizePixel = 0
	OpenAutoHarvestButton.Position = UDim2.new(0.5, 0, 0.5, 0)
	OpenAutoHarvestButton.Size = UDim2.new(1, 0, 1, 0)
	OpenAutoHarvestButton.Font = Enum.Font.FredokaOne
	OpenAutoHarvestButton.Text = "Auto harvest"
	OpenAutoHarvestButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	OpenAutoHarvestButton.TextScaled = true
	OpenAutoHarvestButton.TextSize = 14.000
	OpenAutoHarvestButton.TextWrapped = true

	UIPadding_3.Parent = AutoHarvest
	UIPadding_3.PaddingLeft = UDim.new(0.0500000007, 0)
	UIPadding_3.PaddingRight = UDim.new(0.0500000007, 0)

	AutoSell.Name = "AutoSell"
	AutoSell.Parent = Pages
	AutoSell.AnchorPoint = Vector2.new(0.5, 0)
	AutoSell.BackgroundColor3 = Color3.fromRGB(72, 77, 85)
	AutoSell.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoSell.BorderSizePixel = 0
	AutoSell.Size = UDim2.new(0.899999976, 0, 0.100000001, 0)

	UICorner_5.CornerRadius = UDim.new(0.205128208, 0)
	UICorner_5.Parent = AutoSell

	OpenAutoSellButton.Name = "OpenAutoSellButton"
	OpenAutoSellButton.Parent = AutoSell
	OpenAutoSellButton.AnchorPoint = Vector2.new(0.5, 0.5)
	OpenAutoSellButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	OpenAutoSellButton.BackgroundTransparency = 1.000
	OpenAutoSellButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	OpenAutoSellButton.BorderSizePixel = 0
	OpenAutoSellButton.Position = UDim2.new(0.5, 0, 0.5, 0)
	OpenAutoSellButton.Size = UDim2.new(1, 0, 1, 0)
	OpenAutoSellButton.Font = Enum.Font.FredokaOne
	OpenAutoSellButton.Text = "Auto sell"
	OpenAutoSellButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	OpenAutoSellButton.TextScaled = true
	OpenAutoSellButton.TextSize = 14.000
	OpenAutoSellButton.TextWrapped = true

	UIPadding_4.Parent = AutoSell
	UIPadding_4.PaddingLeft = UDim.new(0.0500000007, 0)
	UIPadding_4.PaddingRight = UDim.new(0.0500000007, 0)

	AutoBuy.Name = "AutoBuy"
	AutoBuy.Parent = Pages
	AutoBuy.AnchorPoint = Vector2.new(0.5, 0)
	AutoBuy.BackgroundColor3 = Color3.fromRGB(72, 77, 85)
	AutoBuy.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoBuy.BorderSizePixel = 0
	AutoBuy.Size = UDim2.new(0.899999976, 0, 0.100000001, 0)

	UICorner_6.CornerRadius = UDim.new(0.205128208, 0)
	UICorner_6.Parent = AutoBuy

	OpenAutoBuyButton.Name = "OpenAutoBuyButton"
	OpenAutoBuyButton.Parent = AutoBuy
	OpenAutoBuyButton.AnchorPoint = Vector2.new(0.5, 0.5)
	OpenAutoBuyButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	OpenAutoBuyButton.BackgroundTransparency = 1.000
	OpenAutoBuyButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	OpenAutoBuyButton.BorderSizePixel = 0
	OpenAutoBuyButton.Position = UDim2.new(0.5, 0, 0.5, 0)
	OpenAutoBuyButton.Size = UDim2.new(1, 0, 1, 0)
	OpenAutoBuyButton.Font = Enum.Font.FredokaOne
	OpenAutoBuyButton.Text = "Auto buy"
	OpenAutoBuyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	OpenAutoBuyButton.TextScaled = true
	OpenAutoBuyButton.TextSize = 14.000
	OpenAutoBuyButton.TextWrapped = true

	UIPadding_5.Parent = AutoBuy
	UIPadding_5.PaddingLeft = UDim.new(0.0500000007, 0)
	UIPadding_5.PaddingRight = UDim.new(0.0500000007, 0)

	AutoSell_2.Name = "AutoSell"
	AutoSell_2.Parent = Main
	AutoSell_2.BackgroundColor3 = Color3.fromRGB(53, 57, 63)
	AutoSell_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoSell_2.BorderSizePixel = 0
	AutoSell_2.Position = UDim2.new(0.328542084, 0, 0.046468474, 0)
	AutoSell_2.Size = UDim2.new(0.626283348, 0, 0.906598568, 0)
	AutoSell_2.Visible = false

	UICorner_7.CornerRadius = UDim.new(0.0218579229, 0)
	UICorner_7.Parent = AutoSell_2

	UIListLayout_2.Parent = AutoSell_2
	UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

	Enable.Name = "Enable"
	Enable.Parent = AutoSell_2
	Enable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Enable.BackgroundTransparency = 1.000
	Enable.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Enable.BorderSizePixel = 0
	Enable.Size = UDim2.new(0.949999988, 0, 0.150000006, 0)

	TextLabel.Parent = Enable
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel.Font = Enum.Font.FredokaOne
	TextLabel.Text = "Enable auto sell"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextWrapped = true

	AutoSellEnableButton.Name = "AutoSellEnableButton"
	AutoSellEnableButton.Parent = Enable
	AutoSellEnableButton.AnchorPoint = Vector2.new(1, 0)
	AutoSellEnableButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AutoSellEnableButton.BackgroundTransparency = 1.000
	AutoSellEnableButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoSellEnableButton.BorderSizePixel = 0
	AutoSellEnableButton.Position = UDim2.new(1, 0, 0, 0)
	AutoSellEnableButton.Size = UDim2.new(0, 100, 1, 0)
	AutoSellEnableButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint.Parent = AutoSellEnableButton

	AutoBuy_2.Name = "AutoBuy"
	AutoBuy_2.Parent = Main
	AutoBuy_2.BackgroundColor3 = Color3.fromRGB(53, 57, 63)
	AutoBuy_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoBuy_2.BorderSizePixel = 0
	AutoBuy_2.Position = UDim2.new(0.328542084, 0, 0.046468474, 0)
	AutoBuy_2.Size = UDim2.new(0.626283348, 0, 0.906598568, 0)
	AutoBuy_2.Visible = false

	UICorner_8.CornerRadius = UDim.new(0.0218579229, 0)
	UICorner_8.Parent = AutoBuy_2

	UIListLayout_3.Parent = AutoBuy_2
	UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

	Enable_2.Name = "Enable"
	Enable_2.Parent = AutoBuy_2
	Enable_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Enable_2.BackgroundTransparency = 1.000
	Enable_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Enable_2.BorderSizePixel = 0
	Enable_2.Size = UDim2.new(0.949999988, 0, 0.150000006, 0)

	TextLabel_2.Parent = Enable_2
	TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.BackgroundTransparency = 1.000
	TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_2.BorderSizePixel = 0
	TextLabel_2.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_2.Font = Enum.Font.FredokaOne
	TextLabel_2.Text = "Enable auto buy"
	TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_2.TextScaled = true
	TextLabel_2.TextSize = 14.000
	TextLabel_2.TextWrapped = true

	AutoBuyEnableButton.Name = "AutoBuyEnableButton"
	AutoBuyEnableButton.Parent = Enable_2
	AutoBuyEnableButton.AnchorPoint = Vector2.new(1, 0)
	AutoBuyEnableButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AutoBuyEnableButton.BackgroundTransparency = 1.000
	AutoBuyEnableButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoBuyEnableButton.BorderSizePixel = 0
	AutoBuyEnableButton.Position = UDim2.new(1, 0, 0, 0)
	AutoBuyEnableButton.Size = UDim2.new(0, 100, 1, 0)
	AutoBuyEnableButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_2.Parent = AutoBuyEnableButton

	ScrollingFrame.Parent = AutoBuy_2
	ScrollingFrame.Active = true
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.BackgroundTransparency = 1.000
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Size = UDim2.new(0.949999988, 0, 0.699999988, 0)
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)

	UIListLayout_4.Parent = ScrollingFrame
	UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_4.Padding = UDim.new(0.00999999978, 0)

	Bamboo.Name = "Bamboo"
	Bamboo.Parent = ScrollingFrame
	Bamboo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Bamboo.BackgroundTransparency = 1.000
	Bamboo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Bamboo.BorderSizePixel = 0
	Bamboo.LayoutOrder = 1
	Bamboo.Position = UDim2.new(0, 0, 0.150000021, 0)
	Bamboo.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_3.Parent = Bamboo
	TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_3.BackgroundTransparency = 1.000
	TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_3.BorderSizePixel = 0
	TextLabel_3.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_3.Font = Enum.Font.FredokaOne
	TextLabel_3.Text = "Bamboo"
	TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_3.TextScaled = true
	TextLabel_3.TextSize = 14.000
	TextLabel_3.TextWrapped = true
	TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

	BuyBambooButton.Name = "BuyBambooButton"
	BuyBambooButton.Parent = Bamboo
	BuyBambooButton.AnchorPoint = Vector2.new(1, 0)
	BuyBambooButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyBambooButton.BackgroundTransparency = 1.000
	BuyBambooButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyBambooButton.BorderSizePixel = 0
	BuyBambooButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyBambooButton.Size = UDim2.new(0, 100, 1, 0)
	BuyBambooButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_3.Parent = BuyBambooButton

	TextLabel_4.Parent = ScrollingFrame
	TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_4.BackgroundTransparency = 1.000
	TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_4.BorderSizePixel = 0
	TextLabel_4.Size = UDim2.new(0.75, 0, 0.0599999987, 0)
	TextLabel_4.Font = Enum.Font.FredokaOne
	TextLabel_4.Text = "Fruits to buy:"
	TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_4.TextScaled = true
	TextLabel_4.TextSize = 14.000
	TextLabel_4.TextWrapped = true
	TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left

	Coconut.Name = "Coconut"
	Coconut.Parent = ScrollingFrame
	Coconut.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Coconut.BackgroundTransparency = 1.000
	Coconut.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Coconut.BorderSizePixel = 0
	Coconut.LayoutOrder = 2
	Coconut.Position = UDim2.new(0, 0, 0.150000021, 0)
	Coconut.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_5.Parent = Coconut
	TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_5.BackgroundTransparency = 1.000
	TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_5.BorderSizePixel = 0
	TextLabel_5.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_5.Font = Enum.Font.FredokaOne
	TextLabel_5.Text = "Coconut"
	TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_5.TextScaled = true
	TextLabel_5.TextSize = 14.000
	TextLabel_5.TextWrapped = true
	TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left

	BuyCoconutButton.Name = "BuyCoconutButton"
	BuyCoconutButton.Parent = Coconut
	BuyCoconutButton.AnchorPoint = Vector2.new(1, 0)
	BuyCoconutButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyCoconutButton.BackgroundTransparency = 1.000
	BuyCoconutButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyCoconutButton.BorderSizePixel = 0
	BuyCoconutButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyCoconutButton.Size = UDim2.new(0, 100, 1, 0)
	BuyCoconutButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_4.Parent = BuyCoconutButton

	Tomato.Name = "Tomato"
	Tomato.Parent = ScrollingFrame
	Tomato.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tomato.BackgroundTransparency = 1.000
	Tomato.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tomato.BorderSizePixel = 0
	Tomato.LayoutOrder = 3
	Tomato.Position = UDim2.new(0, 0, 0.150000021, 0)
	Tomato.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_6.Parent = Tomato
	TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_6.BackgroundTransparency = 1.000
	TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_6.BorderSizePixel = 0
	TextLabel_6.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_6.Font = Enum.Font.FredokaOne
	TextLabel_6.Text = "Tomato"
	TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_6.TextScaled = true
	TextLabel_6.TextSize = 14.000
	TextLabel_6.TextWrapped = true
	TextLabel_6.TextXAlignment = Enum.TextXAlignment.Left

	BuyTomatoButton.Name = "BuyTomatoButton"
	BuyTomatoButton.Parent = Tomato
	BuyTomatoButton.AnchorPoint = Vector2.new(1, 0)
	BuyTomatoButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyTomatoButton.BackgroundTransparency = 1.000
	BuyTomatoButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyTomatoButton.BorderSizePixel = 0
	BuyTomatoButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyTomatoButton.Size = UDim2.new(0, 100, 1, 0)
	BuyTomatoButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_5.Parent = BuyTomatoButton

	Pumpkin.Name = "Pumpkin"
	Pumpkin.Parent = ScrollingFrame
	Pumpkin.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Pumpkin.BackgroundTransparency = 1.000
	Pumpkin.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Pumpkin.BorderSizePixel = 0
	Pumpkin.LayoutOrder = 4
	Pumpkin.Position = UDim2.new(0, 0, 0.150000021, 0)
	Pumpkin.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_7.Parent = Pumpkin
	TextLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_7.BackgroundTransparency = 1.000
	TextLabel_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_7.BorderSizePixel = 0
	TextLabel_7.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_7.Font = Enum.Font.FredokaOne
	TextLabel_7.Text = "Pumpkin"
	TextLabel_7.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_7.TextScaled = true
	TextLabel_7.TextSize = 14.000
	TextLabel_7.TextWrapped = true
	TextLabel_7.TextXAlignment = Enum.TextXAlignment.Left

	BuyPumpkinButton.Name = "BuyPumpkinButton"
	BuyPumpkinButton.Parent = Pumpkin
	BuyPumpkinButton.AnchorPoint = Vector2.new(1, 0)
	BuyPumpkinButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyPumpkinButton.BackgroundTransparency = 1.000
	BuyPumpkinButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyPumpkinButton.BorderSizePixel = 0
	BuyPumpkinButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyPumpkinButton.Size = UDim2.new(0, 100, 1, 0)
	BuyPumpkinButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_6.Parent = BuyPumpkinButton

	Apple.Name = "Apple"
	Apple.Parent = ScrollingFrame
	Apple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Apple.BackgroundTransparency = 1.000
	Apple.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Apple.BorderSizePixel = 0
	Apple.LayoutOrder = 5
	Apple.Position = UDim2.new(0, 0, 0.150000021, 0)
	Apple.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_8.Parent = Apple
	TextLabel_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_8.BackgroundTransparency = 1.000
	TextLabel_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_8.BorderSizePixel = 0
	TextLabel_8.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_8.Font = Enum.Font.FredokaOne
	TextLabel_8.Text = "Apple"
	TextLabel_8.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_8.TextScaled = true
	TextLabel_8.TextSize = 14.000
	TextLabel_8.TextWrapped = true
	TextLabel_8.TextXAlignment = Enum.TextXAlignment.Left

	BuyAppleButton.Name = "BuyAppleButton"
	BuyAppleButton.Parent = Apple
	BuyAppleButton.AnchorPoint = Vector2.new(1, 0)
	BuyAppleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyAppleButton.BackgroundTransparency = 1.000
	BuyAppleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyAppleButton.BorderSizePixel = 0
	BuyAppleButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyAppleButton.Size = UDim2.new(0, 100, 1, 0)
	BuyAppleButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_7.Parent = BuyAppleButton

	Corn.Name = "Corn"
	Corn.Parent = ScrollingFrame
	Corn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Corn.BackgroundTransparency = 1.000
	Corn.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Corn.BorderSizePixel = 0
	Corn.LayoutOrder = 6
	Corn.Position = UDim2.new(0, 0, 0.150000021, 0)
	Corn.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_9.Parent = Corn
	TextLabel_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_9.BackgroundTransparency = 1.000
	TextLabel_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_9.BorderSizePixel = 0
	TextLabel_9.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_9.Font = Enum.Font.FredokaOne
	TextLabel_9.Text = "Corn"
	TextLabel_9.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_9.TextScaled = true
	TextLabel_9.TextSize = 14.000
	TextLabel_9.TextWrapped = true
	TextLabel_9.TextXAlignment = Enum.TextXAlignment.Left

	BuyCornButton.Name = "BuyCornButton"
	BuyCornButton.Parent = Corn
	BuyCornButton.AnchorPoint = Vector2.new(1, 0)
	BuyCornButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyCornButton.BackgroundTransparency = 1.000
	BuyCornButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyCornButton.BorderSizePixel = 0
	BuyCornButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyCornButton.Size = UDim2.new(0, 100, 1, 0)
	BuyCornButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_8.Parent = BuyCornButton

	DragonFruit.Name = "DragonFruit"
	DragonFruit.Parent = ScrollingFrame
	DragonFruit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DragonFruit.BackgroundTransparency = 1.000
	DragonFruit.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DragonFruit.BorderSizePixel = 0
	DragonFruit.LayoutOrder = 7
	DragonFruit.Position = UDim2.new(0, 0, 0.150000021, 0)
	DragonFruit.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_10.Parent = DragonFruit
	TextLabel_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_10.BackgroundTransparency = 1.000
	TextLabel_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_10.BorderSizePixel = 0
	TextLabel_10.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_10.Font = Enum.Font.FredokaOne
	TextLabel_10.Text = "DragonFruit"
	TextLabel_10.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_10.TextScaled = true
	TextLabel_10.TextSize = 14.000
	TextLabel_10.TextWrapped = true
	TextLabel_10.TextXAlignment = Enum.TextXAlignment.Left

	BuyDragonFruitButton.Name = "BuyDragonFruitButton"
	BuyDragonFruitButton.Parent = DragonFruit
	BuyDragonFruitButton.AnchorPoint = Vector2.new(1, 0)
	BuyDragonFruitButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyDragonFruitButton.BackgroundTransparency = 1.000
	BuyDragonFruitButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyDragonFruitButton.BorderSizePixel = 0
	BuyDragonFruitButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyDragonFruitButton.Size = UDim2.new(0, 100, 1, 0)
	BuyDragonFruitButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_9.Parent = BuyDragonFruitButton

	Blueberry.Name = "Blueberry"
	Blueberry.Parent = ScrollingFrame
	Blueberry.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Blueberry.BackgroundTransparency = 1.000
	Blueberry.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Blueberry.BorderSizePixel = 0
	Blueberry.LayoutOrder = 8
	Blueberry.Position = UDim2.new(0, 0, 0.150000021, 0)
	Blueberry.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_11.Parent = Blueberry
	TextLabel_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_11.BackgroundTransparency = 1.000
	TextLabel_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_11.BorderSizePixel = 0
	TextLabel_11.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_11.Font = Enum.Font.FredokaOne
	TextLabel_11.Text = "Blueberry"
	TextLabel_11.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_11.TextScaled = true
	TextLabel_11.TextSize = 14.000
	TextLabel_11.TextWrapped = true
	TextLabel_11.TextXAlignment = Enum.TextXAlignment.Left

	BuyBlueberryButton.Name = "BuyBlueberryButton"
	BuyBlueberryButton.Parent = Blueberry
	BuyBlueberryButton.AnchorPoint = Vector2.new(1, 0)
	BuyBlueberryButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyBlueberryButton.BackgroundTransparency = 1.000
	BuyBlueberryButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyBlueberryButton.BorderSizePixel = 0
	BuyBlueberryButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyBlueberryButton.Size = UDim2.new(0, 100, 1, 0)
	BuyBlueberryButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_10.Parent = BuyBlueberryButton

	Carrot.Name = "Carrot"
	Carrot.Parent = ScrollingFrame
	Carrot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Carrot.BackgroundTransparency = 1.000
	Carrot.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Carrot.BorderSizePixel = 0
	Carrot.LayoutOrder = 9
	Carrot.Position = UDim2.new(0, 0, 0.150000021, 0)
	Carrot.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_12.Parent = Carrot
	TextLabel_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_12.BackgroundTransparency = 1.000
	TextLabel_12.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_12.BorderSizePixel = 0
	TextLabel_12.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_12.Font = Enum.Font.FredokaOne
	TextLabel_12.Text = "Carrot"
	TextLabel_12.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_12.TextScaled = true
	TextLabel_12.TextSize = 14.000
	TextLabel_12.TextWrapped = true
	TextLabel_12.TextXAlignment = Enum.TextXAlignment.Left

	BuyCarrotButton.Name = "BuyCarrotButton"
	BuyCarrotButton.Parent = Carrot
	BuyCarrotButton.AnchorPoint = Vector2.new(1, 0)
	BuyCarrotButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyCarrotButton.BackgroundTransparency = 1.000
	BuyCarrotButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyCarrotButton.BorderSizePixel = 0
	BuyCarrotButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyCarrotButton.Size = UDim2.new(0, 100, 1, 0)
	BuyCarrotButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_11.Parent = BuyCarrotButton

	Mango.Name = "Mango"
	Mango.Parent = ScrollingFrame
	Mango.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Mango.BackgroundTransparency = 1.000
	Mango.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Mango.BorderSizePixel = 0
	Mango.LayoutOrder = 10
	Mango.Position = UDim2.new(0, 0, 0.150000021, 0)
	Mango.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_13.Parent = Mango
	TextLabel_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_13.BackgroundTransparency = 1.000
	TextLabel_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_13.BorderSizePixel = 0
	TextLabel_13.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_13.Font = Enum.Font.FredokaOne
	TextLabel_13.Text = "Mango"
	TextLabel_13.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_13.TextScaled = true
	TextLabel_13.TextSize = 14.000
	TextLabel_13.TextWrapped = true
	TextLabel_13.TextXAlignment = Enum.TextXAlignment.Left

	BuyMangoButton.Name = "BuyMangoButton"
	BuyMangoButton.Parent = Mango
	BuyMangoButton.AnchorPoint = Vector2.new(1, 0)
	BuyMangoButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyMangoButton.BackgroundTransparency = 1.000
	BuyMangoButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyMangoButton.BorderSizePixel = 0
	BuyMangoButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyMangoButton.Size = UDim2.new(0, 100, 1, 0)
	BuyMangoButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_12.Parent = BuyMangoButton

	Cactus.Name = "Cactus"
	Cactus.Parent = ScrollingFrame
	Cactus.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Cactus.BackgroundTransparency = 1.000
	Cactus.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Cactus.BorderSizePixel = 0
	Cactus.LayoutOrder = 11
	Cactus.Position = UDim2.new(0, 0, 0.150000021, 0)
	Cactus.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_14.Parent = Cactus
	TextLabel_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_14.BackgroundTransparency = 1.000
	TextLabel_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_14.BorderSizePixel = 0
	TextLabel_14.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_14.Font = Enum.Font.FredokaOne
	TextLabel_14.Text = "Cactus"
	TextLabel_14.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_14.TextScaled = true
	TextLabel_14.TextSize = 14.000
	TextLabel_14.TextWrapped = true
	TextLabel_14.TextXAlignment = Enum.TextXAlignment.Left

	BuyCactusButton.Name = "BuyCactusButton"
	BuyCactusButton.Parent = Cactus
	BuyCactusButton.AnchorPoint = Vector2.new(1, 0)
	BuyCactusButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyCactusButton.BackgroundTransparency = 1.000
	BuyCactusButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyCactusButton.BorderSizePixel = 0
	BuyCactusButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyCactusButton.Size = UDim2.new(0, 100, 1, 0)
	BuyCactusButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_13.Parent = BuyCactusButton

	Strawberry.Name = "Strawberry"
	Strawberry.Parent = ScrollingFrame
	Strawberry.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Strawberry.BackgroundTransparency = 1.000
	Strawberry.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Strawberry.BorderSizePixel = 0
	Strawberry.LayoutOrder = 12
	Strawberry.Position = UDim2.new(0, 0, 0.150000021, 0)
	Strawberry.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_15.Parent = Strawberry
	TextLabel_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_15.BackgroundTransparency = 1.000
	TextLabel_15.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_15.BorderSizePixel = 0
	TextLabel_15.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_15.Font = Enum.Font.FredokaOne
	TextLabel_15.Text = "Strawberry"
	TextLabel_15.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_15.TextScaled = true
	TextLabel_15.TextSize = 14.000
	TextLabel_15.TextWrapped = true
	TextLabel_15.TextXAlignment = Enum.TextXAlignment.Left

	BuyStrawberryButton.Name = "BuyStrawberryButton"
	BuyStrawberryButton.Parent = Strawberry
	BuyStrawberryButton.AnchorPoint = Vector2.new(1, 0)
	BuyStrawberryButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyStrawberryButton.BackgroundTransparency = 1.000
	BuyStrawberryButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyStrawberryButton.BorderSizePixel = 0
	BuyStrawberryButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyStrawberryButton.Size = UDim2.new(0, 100, 1, 0)
	BuyStrawberryButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_14.Parent = BuyStrawberryButton

	Watermelon.Name = "Watermelon"
	Watermelon.Parent = ScrollingFrame
	Watermelon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Watermelon.BackgroundTransparency = 1.000
	Watermelon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Watermelon.BorderSizePixel = 0
	Watermelon.LayoutOrder = 13
	Watermelon.Position = UDim2.new(0, 0, 0.150000021, 0)
	Watermelon.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_16.Parent = Watermelon
	TextLabel_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_16.BackgroundTransparency = 1.000
	TextLabel_16.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_16.BorderSizePixel = 0
	TextLabel_16.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_16.Font = Enum.Font.FredokaOne
	TextLabel_16.Text = "Watermelon"
	TextLabel_16.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_16.TextScaled = true
	TextLabel_16.TextSize = 14.000
	TextLabel_16.TextWrapped = true
	TextLabel_16.TextXAlignment = Enum.TextXAlignment.Left

	BuyWatermelonButton.Name = "BuyWatermelonButton"
	BuyWatermelonButton.Parent = Watermelon
	BuyWatermelonButton.AnchorPoint = Vector2.new(1, 0)
	BuyWatermelonButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BuyWatermelonButton.BackgroundTransparency = 1.000
	BuyWatermelonButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BuyWatermelonButton.BorderSizePixel = 0
	BuyWatermelonButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	BuyWatermelonButton.Size = UDim2.new(0, 100, 1, 0)
	BuyWatermelonButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_15.Parent = BuyWatermelonButton

	AutoHarvest_2.Name = "AutoHarvest"
	AutoHarvest_2.Parent = Main
	AutoHarvest_2.BackgroundColor3 = Color3.fromRGB(53, 57, 63)
	AutoHarvest_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoHarvest_2.BorderSizePixel = 0
	AutoHarvest_2.Position = UDim2.new(0.328542084, 0, 0.046468474, 0)
	AutoHarvest_2.Size = UDim2.new(0.626283348, 0, 0.906598568, 0)
	AutoHarvest_2.Visible = false

	UICorner_9.CornerRadius = UDim.new(0.0218579229, 0)
	UICorner_9.Parent = AutoHarvest_2

	UIListLayout_5.Parent = AutoHarvest_2
	UIListLayout_5.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder

	Enable_3.Name = "Enable"
	Enable_3.Parent = AutoHarvest_2
	Enable_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Enable_3.BackgroundTransparency = 1.000
	Enable_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Enable_3.BorderSizePixel = 0
	Enable_3.Size = UDim2.new(0.949999988, 0, 0.150000006, 0)

	TextLabel_17.Parent = Enable_3
	TextLabel_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_17.BackgroundTransparency = 1.000
	TextLabel_17.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_17.BorderSizePixel = 0
	TextLabel_17.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_17.Font = Enum.Font.FredokaOne
	TextLabel_17.Text = "Enable auto harvest"
	TextLabel_17.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_17.TextScaled = true
	TextLabel_17.TextSize = 14.000
	TextLabel_17.TextWrapped = true

	AutoHarvestEnableButton.Name = "AutoHarvestEnableButton"
	AutoHarvestEnableButton.Parent = Enable_3
	AutoHarvestEnableButton.AnchorPoint = Vector2.new(1, 0)
	AutoHarvestEnableButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AutoHarvestEnableButton.BackgroundTransparency = 1.000
	AutoHarvestEnableButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoHarvestEnableButton.BorderSizePixel = 0
	AutoHarvestEnableButton.Position = UDim2.new(1, 0, 0, 0)
	AutoHarvestEnableButton.Size = UDim2.new(0, 100, 1, 0)
	AutoHarvestEnableButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_16.Parent = AutoHarvestEnableButton

	NoClipFruit.Name = "NoClipFruit"
	NoClipFruit.Parent = AutoHarvest_2
	NoClipFruit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NoClipFruit.BackgroundTransparency = 1.000
	NoClipFruit.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NoClipFruit.BorderSizePixel = 0
	NoClipFruit.Size = UDim2.new(0.949999988, 0, 0.150000006, 0)

	TextLabel_18.Parent = NoClipFruit
	TextLabel_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_18.BackgroundTransparency = 1.000
	TextLabel_18.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_18.BorderSizePixel = 0
	TextLabel_18.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_18.Font = Enum.Font.FredokaOne
	TextLabel_18.Text = "Enable fruit noclip"
	TextLabel_18.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_18.TextScaled = true
	TextLabel_18.TextSize = 14.000
	TextLabel_18.TextWrapped = true

	FruitNoclipEnableButton.Name = "FruitNoclipEnableButton"
	FruitNoclipEnableButton.Parent = NoClipFruit
	FruitNoclipEnableButton.AnchorPoint = Vector2.new(1, 0)
	FruitNoclipEnableButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	FruitNoclipEnableButton.BackgroundTransparency = 1.000
	FruitNoclipEnableButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	FruitNoclipEnableButton.BorderSizePixel = 0
	FruitNoclipEnableButton.Position = UDim2.new(1, 0, 0, 0)
	FruitNoclipEnableButton.Size = UDim2.new(0, 100, 1, 0)
	FruitNoclipEnableButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_17.Parent = FruitNoclipEnableButton

	AutoPlant_2.Name = "AutoPlant"
	AutoPlant_2.Parent = Main
	AutoPlant_2.BackgroundColor3 = Color3.fromRGB(53, 57, 63)
	AutoPlant_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoPlant_2.BorderSizePixel = 0
	AutoPlant_2.Position = UDim2.new(0.328542084, 0, 0.046468474, 0)
	AutoPlant_2.Size = UDim2.new(0.626283348, 0, 0.906598568, 0)

	UICorner_10.CornerRadius = UDim.new(0.0218579229, 0)
	UICorner_10.Parent = AutoPlant_2

	UIListLayout_6.Parent = AutoPlant_2
	UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder

	Enable_4.Name = "Enable"
	Enable_4.Parent = AutoPlant_2
	Enable_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Enable_4.BackgroundTransparency = 1.000
	Enable_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Enable_4.BorderSizePixel = 0
	Enable_4.Size = UDim2.new(0.949999988, 0, 0.150000006, 0)

	TextLabel_19.Parent = Enable_4
	TextLabel_19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_19.BackgroundTransparency = 1.000
	TextLabel_19.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_19.BorderSizePixel = 0
	TextLabel_19.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_19.Font = Enum.Font.FredokaOne
	TextLabel_19.Text = "Enable auto plant"
	TextLabel_19.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_19.TextScaled = true
	TextLabel_19.TextSize = 14.000
	TextLabel_19.TextWrapped = true

	AutoPlantEnableButton.Name = "AutoPlantEnableButton"
	AutoPlantEnableButton.Parent = Enable_4
	AutoPlantEnableButton.AnchorPoint = Vector2.new(1, 0)
	AutoPlantEnableButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AutoPlantEnableButton.BackgroundTransparency = 1.000
	AutoPlantEnableButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AutoPlantEnableButton.BorderSizePixel = 0
	AutoPlantEnableButton.Position = UDim2.new(1, 0, 0, 0)
	AutoPlantEnableButton.Size = UDim2.new(0, 100, 1, 0)
	AutoPlantEnableButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_18.Parent = AutoPlantEnableButton

	ScrollingFrame_2.Parent = AutoPlant_2
	ScrollingFrame_2.Active = true
	ScrollingFrame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame_2.BackgroundTransparency = 1.000
	ScrollingFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame_2.BorderSizePixel = 0
	ScrollingFrame_2.Size = UDim2.new(0.949999988, 0, 0.699999988, 0)
	ScrollingFrame_2.CanvasSize = UDim2.new(0, 0, 1.5, 0)

	UIListLayout_7.Parent = ScrollingFrame_2
	UIListLayout_7.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_7.Padding = UDim.new(0.00999999978, 0)

	Bamboo_2.Name = "Bamboo"
	Bamboo_2.Parent = ScrollingFrame_2
	Bamboo_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Bamboo_2.BackgroundTransparency = 1.000
	Bamboo_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Bamboo_2.BorderSizePixel = 0
	Bamboo_2.LayoutOrder = 1
	Bamboo_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Bamboo_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_20.Parent = Bamboo_2
	TextLabel_20.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_20.BackgroundTransparency = 1.000
	TextLabel_20.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_20.BorderSizePixel = 0
	TextLabel_20.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_20.Font = Enum.Font.FredokaOne
	TextLabel_20.Text = "Bamboo"
	TextLabel_20.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_20.TextScaled = true
	TextLabel_20.TextSize = 14.000
	TextLabel_20.TextWrapped = true
	TextLabel_20.TextXAlignment = Enum.TextXAlignment.Left

	PlantBambooButton.Name = "PlantBambooButton"
	PlantBambooButton.Parent = Bamboo_2
	PlantBambooButton.AnchorPoint = Vector2.new(1, 0)
	PlantBambooButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantBambooButton.BackgroundTransparency = 1.000
	PlantBambooButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantBambooButton.BorderSizePixel = 0
	PlantBambooButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantBambooButton.Size = UDim2.new(0, 100, 1, 0)
	PlantBambooButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_19.Parent = PlantBambooButton

	TextLabel_21.Parent = ScrollingFrame_2
	TextLabel_21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_21.BackgroundTransparency = 1.000
	TextLabel_21.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_21.BorderSizePixel = 0
	TextLabel_21.Size = UDim2.new(0.75, 0, 0.0599999987, 0)
	TextLabel_21.Font = Enum.Font.FredokaOne
	TextLabel_21.Text = "Fruits to plant:"
	TextLabel_21.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_21.TextScaled = true
	TextLabel_21.TextSize = 14.000
	TextLabel_21.TextWrapped = true
	TextLabel_21.TextXAlignment = Enum.TextXAlignment.Left

	Coconut_2.Name = "Coconut"
	Coconut_2.Parent = ScrollingFrame_2
	Coconut_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Coconut_2.BackgroundTransparency = 1.000
	Coconut_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Coconut_2.BorderSizePixel = 0
	Coconut_2.LayoutOrder = 2
	Coconut_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Coconut_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_22.Parent = Coconut_2
	TextLabel_22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_22.BackgroundTransparency = 1.000
	TextLabel_22.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_22.BorderSizePixel = 0
	TextLabel_22.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_22.Font = Enum.Font.FredokaOne
	TextLabel_22.Text = "Coconut"
	TextLabel_22.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_22.TextScaled = true
	TextLabel_22.TextSize = 14.000
	TextLabel_22.TextWrapped = true
	TextLabel_22.TextXAlignment = Enum.TextXAlignment.Left

	PlantCoconutButton.Name = "PlantCoconutButton"
	PlantCoconutButton.Parent = Coconut_2
	PlantCoconutButton.AnchorPoint = Vector2.new(1, 0)
	PlantCoconutButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantCoconutButton.BackgroundTransparency = 1.000
	PlantCoconutButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantCoconutButton.BorderSizePixel = 0
	PlantCoconutButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantCoconutButton.Size = UDim2.new(0, 100, 1, 0)
	PlantCoconutButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_20.Parent = PlantCoconutButton

	Tomato_2.Name = "Tomato"
	Tomato_2.Parent = ScrollingFrame_2
	Tomato_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Tomato_2.BackgroundTransparency = 1.000
	Tomato_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tomato_2.BorderSizePixel = 0
	Tomato_2.LayoutOrder = 3
	Tomato_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Tomato_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_23.Parent = Tomato_2
	TextLabel_23.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_23.BackgroundTransparency = 1.000
	TextLabel_23.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_23.BorderSizePixel = 0
	TextLabel_23.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_23.Font = Enum.Font.FredokaOne
	TextLabel_23.Text = "Tomato"
	TextLabel_23.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_23.TextScaled = true
	TextLabel_23.TextSize = 14.000
	TextLabel_23.TextWrapped = true
	TextLabel_23.TextXAlignment = Enum.TextXAlignment.Left

	PlantTomatoButton.Name = "PlantTomatoButton"
	PlantTomatoButton.Parent = Tomato_2
	PlantTomatoButton.AnchorPoint = Vector2.new(1, 0)
	PlantTomatoButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantTomatoButton.BackgroundTransparency = 1.000
	PlantTomatoButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantTomatoButton.BorderSizePixel = 0
	PlantTomatoButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantTomatoButton.Size = UDim2.new(0, 100, 1, 0)
	PlantTomatoButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_21.Parent = PlantTomatoButton

	Pumpkin_2.Name = "Pumpkin"
	Pumpkin_2.Parent = ScrollingFrame_2
	Pumpkin_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Pumpkin_2.BackgroundTransparency = 1.000
	Pumpkin_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Pumpkin_2.BorderSizePixel = 0
	Pumpkin_2.LayoutOrder = 4
	Pumpkin_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Pumpkin_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_24.Parent = Pumpkin_2
	TextLabel_24.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_24.BackgroundTransparency = 1.000
	TextLabel_24.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_24.BorderSizePixel = 0
	TextLabel_24.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_24.Font = Enum.Font.FredokaOne
	TextLabel_24.Text = "Pumpkin"
	TextLabel_24.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_24.TextScaled = true
	TextLabel_24.TextSize = 14.000
	TextLabel_24.TextWrapped = true
	TextLabel_24.TextXAlignment = Enum.TextXAlignment.Left

	PlantPumpkinButton.Name = "PlantPumpkinButton"
	PlantPumpkinButton.Parent = Pumpkin_2
	PlantPumpkinButton.AnchorPoint = Vector2.new(1, 0)
	PlantPumpkinButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantPumpkinButton.BackgroundTransparency = 1.000
	PlantPumpkinButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantPumpkinButton.BorderSizePixel = 0
	PlantPumpkinButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantPumpkinButton.Size = UDim2.new(0, 100, 1, 0)
	PlantPumpkinButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_22.Parent = PlantPumpkinButton

	Apple_2.Name = "Apple"
	Apple_2.Parent = ScrollingFrame_2
	Apple_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Apple_2.BackgroundTransparency = 1.000
	Apple_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Apple_2.BorderSizePixel = 0
	Apple_2.LayoutOrder = 5
	Apple_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Apple_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_25.Parent = Apple_2
	TextLabel_25.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_25.BackgroundTransparency = 1.000
	TextLabel_25.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_25.BorderSizePixel = 0
	TextLabel_25.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_25.Font = Enum.Font.FredokaOne
	TextLabel_25.Text = "Apple"
	TextLabel_25.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_25.TextScaled = true
	TextLabel_25.TextSize = 14.000
	TextLabel_25.TextWrapped = true
	TextLabel_25.TextXAlignment = Enum.TextXAlignment.Left

	PlantAppleButton.Name = "PlantAppleButton"
	PlantAppleButton.Parent = Apple_2
	PlantAppleButton.AnchorPoint = Vector2.new(1, 0)
	PlantAppleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantAppleButton.BackgroundTransparency = 1.000
	PlantAppleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantAppleButton.BorderSizePixel = 0
	PlantAppleButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantAppleButton.Size = UDim2.new(0, 100, 1, 0)
	PlantAppleButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_23.Parent = PlantAppleButton

	Corn_2.Name = "Corn"
	Corn_2.Parent = ScrollingFrame_2
	Corn_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Corn_2.BackgroundTransparency = 1.000
	Corn_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Corn_2.BorderSizePixel = 0
	Corn_2.LayoutOrder = 6
	Corn_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Corn_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_26.Parent = Corn_2
	TextLabel_26.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_26.BackgroundTransparency = 1.000
	TextLabel_26.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_26.BorderSizePixel = 0
	TextLabel_26.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_26.Font = Enum.Font.FredokaOne
	TextLabel_26.Text = "Corn"
	TextLabel_26.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_26.TextScaled = true
	TextLabel_26.TextSize = 14.000
	TextLabel_26.TextWrapped = true
	TextLabel_26.TextXAlignment = Enum.TextXAlignment.Left

	PlantCornButton.Name = "PlantCornButton"
	PlantCornButton.Parent = Corn_2
	PlantCornButton.AnchorPoint = Vector2.new(1, 0)
	PlantCornButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantCornButton.BackgroundTransparency = 1.000
	PlantCornButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantCornButton.BorderSizePixel = 0
	PlantCornButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantCornButton.Size = UDim2.new(0, 100, 1, 0)
	PlantCornButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_24.Parent = PlantCornButton

	DragonFruit_2.Name = "DragonFruit"
	DragonFruit_2.Parent = ScrollingFrame_2
	DragonFruit_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DragonFruit_2.BackgroundTransparency = 1.000
	DragonFruit_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DragonFruit_2.BorderSizePixel = 0
	DragonFruit_2.LayoutOrder = 7
	DragonFruit_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	DragonFruit_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_27.Parent = DragonFruit_2
	TextLabel_27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_27.BackgroundTransparency = 1.000
	TextLabel_27.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_27.BorderSizePixel = 0
	TextLabel_27.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_27.Font = Enum.Font.FredokaOne
	TextLabel_27.Text = "DragonFruit"
	TextLabel_27.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_27.TextScaled = true
	TextLabel_27.TextSize = 14.000
	TextLabel_27.TextWrapped = true
	TextLabel_27.TextXAlignment = Enum.TextXAlignment.Left

	PlantDragonFruitButton.Name = "PlantDragonFruitButton"
	PlantDragonFruitButton.Parent = DragonFruit_2
	PlantDragonFruitButton.AnchorPoint = Vector2.new(1, 0)
	PlantDragonFruitButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantDragonFruitButton.BackgroundTransparency = 1.000
	PlantDragonFruitButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantDragonFruitButton.BorderSizePixel = 0
	PlantDragonFruitButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantDragonFruitButton.Size = UDim2.new(0, 100, 1, 0)
	PlantDragonFruitButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_25.Parent = PlantDragonFruitButton

	Blueberry_2.Name = "Blueberry"
	Blueberry_2.Parent = ScrollingFrame_2
	Blueberry_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Blueberry_2.BackgroundTransparency = 1.000
	Blueberry_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Blueberry_2.BorderSizePixel = 0
	Blueberry_2.LayoutOrder = 8
	Blueberry_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Blueberry_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_28.Parent = Blueberry_2
	TextLabel_28.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_28.BackgroundTransparency = 1.000
	TextLabel_28.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_28.BorderSizePixel = 0
	TextLabel_28.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_28.Font = Enum.Font.FredokaOne
	TextLabel_28.Text = "Blueberry"
	TextLabel_28.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_28.TextScaled = true
	TextLabel_28.TextSize = 14.000
	TextLabel_28.TextWrapped = true
	TextLabel_28.TextXAlignment = Enum.TextXAlignment.Left

	PlantBlueberryButton.Name = "PlantBlueberryButton"
	PlantBlueberryButton.Parent = Blueberry_2
	PlantBlueberryButton.AnchorPoint = Vector2.new(1, 0)
	PlantBlueberryButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantBlueberryButton.BackgroundTransparency = 1.000
	PlantBlueberryButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantBlueberryButton.BorderSizePixel = 0
	PlantBlueberryButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantBlueberryButton.Size = UDim2.new(0, 100, 1, 0)
	PlantBlueberryButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_26.Parent = PlantBlueberryButton

	Carrot_2.Name = "Carrot"
	Carrot_2.Parent = ScrollingFrame_2
	Carrot_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Carrot_2.BackgroundTransparency = 1.000
	Carrot_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Carrot_2.BorderSizePixel = 0
	Carrot_2.LayoutOrder = 9
	Carrot_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Carrot_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_29.Parent = Carrot_2
	TextLabel_29.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_29.BackgroundTransparency = 1.000
	TextLabel_29.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_29.BorderSizePixel = 0
	TextLabel_29.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_29.Font = Enum.Font.FredokaOne
	TextLabel_29.Text = "Carrot"
	TextLabel_29.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_29.TextScaled = true
	TextLabel_29.TextSize = 14.000
	TextLabel_29.TextWrapped = true
	TextLabel_29.TextXAlignment = Enum.TextXAlignment.Left

	PlantCarrotButton.Name = "PlantCarrotButton"
	PlantCarrotButton.Parent = Carrot_2
	PlantCarrotButton.AnchorPoint = Vector2.new(1, 0)
	PlantCarrotButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantCarrotButton.BackgroundTransparency = 1.000
	PlantCarrotButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantCarrotButton.BorderSizePixel = 0
	PlantCarrotButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantCarrotButton.Size = UDim2.new(0, 100, 1, 0)
	PlantCarrotButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_27.Parent = PlantCarrotButton

	Mango_2.Name = "Mango"
	Mango_2.Parent = ScrollingFrame_2
	Mango_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Mango_2.BackgroundTransparency = 1.000
	Mango_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Mango_2.BorderSizePixel = 0
	Mango_2.LayoutOrder = 10
	Mango_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Mango_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_30.Parent = Mango_2
	TextLabel_30.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_30.BackgroundTransparency = 1.000
	TextLabel_30.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_30.BorderSizePixel = 0
	TextLabel_30.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_30.Font = Enum.Font.FredokaOne
	TextLabel_30.Text = "Mango"
	TextLabel_30.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_30.TextScaled = true
	TextLabel_30.TextSize = 14.000
	TextLabel_30.TextWrapped = true
	TextLabel_30.TextXAlignment = Enum.TextXAlignment.Left

	PlantMangoButton.Name = "PlantMangoButton"
	PlantMangoButton.Parent = Mango_2
	PlantMangoButton.AnchorPoint = Vector2.new(1, 0)
	PlantMangoButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantMangoButton.BackgroundTransparency = 1.000
	PlantMangoButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantMangoButton.BorderSizePixel = 0
	PlantMangoButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantMangoButton.Size = UDim2.new(0, 100, 1, 0)
	PlantMangoButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_28.Parent = PlantMangoButton

	Cactus_2.Name = "Cactus"
	Cactus_2.Parent = ScrollingFrame_2
	Cactus_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Cactus_2.BackgroundTransparency = 1.000
	Cactus_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Cactus_2.BorderSizePixel = 0
	Cactus_2.LayoutOrder = 11
	Cactus_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Cactus_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_31.Parent = Cactus_2
	TextLabel_31.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_31.BackgroundTransparency = 1.000
	TextLabel_31.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_31.BorderSizePixel = 0
	TextLabel_31.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_31.Font = Enum.Font.FredokaOne
	TextLabel_31.Text = "Cactus"
	TextLabel_31.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_31.TextScaled = true
	TextLabel_31.TextSize = 14.000
	TextLabel_31.TextWrapped = true
	TextLabel_31.TextXAlignment = Enum.TextXAlignment.Left

	PlantCactusButton.Name = "PlantCactusButton"
	PlantCactusButton.Parent = Cactus_2
	PlantCactusButton.AnchorPoint = Vector2.new(1, 0)
	PlantCactusButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantCactusButton.BackgroundTransparency = 1.000
	PlantCactusButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantCactusButton.BorderSizePixel = 0
	PlantCactusButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantCactusButton.Size = UDim2.new(0, 100, 1, 0)
	PlantCactusButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_29.Parent = PlantCactusButton

	Strawberry_2.Name = "Strawberry"
	Strawberry_2.Parent = ScrollingFrame_2
	Strawberry_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Strawberry_2.BackgroundTransparency = 1.000
	Strawberry_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Strawberry_2.BorderSizePixel = 0
	Strawberry_2.LayoutOrder = 12
	Strawberry_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Strawberry_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_32.Parent = Strawberry_2
	TextLabel_32.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_32.BackgroundTransparency = 1.000
	TextLabel_32.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_32.BorderSizePixel = 0
	TextLabel_32.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_32.Font = Enum.Font.FredokaOne
	TextLabel_32.Text = "Strawberry"
	TextLabel_32.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_32.TextScaled = true
	TextLabel_32.TextSize = 14.000
	TextLabel_32.TextWrapped = true
	TextLabel_32.TextXAlignment = Enum.TextXAlignment.Left

	PlantStrawberryButton.Name = "PlantStrawberryButton"
	PlantStrawberryButton.Parent = Strawberry_2
	PlantStrawberryButton.AnchorPoint = Vector2.new(1, 0)
	PlantStrawberryButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantStrawberryButton.BackgroundTransparency = 1.000
	PlantStrawberryButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantStrawberryButton.BorderSizePixel = 0
	PlantStrawberryButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantStrawberryButton.Size = UDim2.new(0, 100, 1, 0)
	PlantStrawberryButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_30.Parent = PlantStrawberryButton

	Watermelon_2.Name = "Watermelon"
	Watermelon_2.Parent = ScrollingFrame_2
	Watermelon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Watermelon_2.BackgroundTransparency = 1.000
	Watermelon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Watermelon_2.BorderSizePixel = 0
	Watermelon_2.LayoutOrder = 13
	Watermelon_2.Position = UDim2.new(0, 0, 0.150000021, 0)
	Watermelon_2.Size = UDim2.new(1, 0, 0.0599999987, 0)

	TextLabel_33.Parent = Watermelon_2
	TextLabel_33.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_33.BackgroundTransparency = 1.000
	TextLabel_33.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_33.BorderSizePixel = 0
	TextLabel_33.Size = UDim2.new(0.75, 0, 1, 0)
	TextLabel_33.Font = Enum.Font.FredokaOne
	TextLabel_33.Text = "Watermelon"
	TextLabel_33.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_33.TextScaled = true
	TextLabel_33.TextSize = 14.000
	TextLabel_33.TextWrapped = true
	TextLabel_33.TextXAlignment = Enum.TextXAlignment.Left

	PlantWatermelonButton.Name = "PlantWatermelonButton"
	PlantWatermelonButton.Parent = Watermelon_2
	PlantWatermelonButton.AnchorPoint = Vector2.new(1, 0)
	PlantWatermelonButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PlantWatermelonButton.BackgroundTransparency = 1.000
	PlantWatermelonButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PlantWatermelonButton.BorderSizePixel = 0
	PlantWatermelonButton.Position = UDim2.new(0.899999976, 0, 0, 0)
	PlantWatermelonButton.Size = UDim2.new(0, 100, 1, 0)
	PlantWatermelonButton.Image = "rbxassetid://14914770151"

	UIAspectRatioConstraint_31.Parent = PlantWatermelonButton

	ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
end

local mouse = game.Players.LocalPlayer:GetMouse()
local hovered = false
local holding = false
local moveCon = nil
local initialX, initialY, UIInitialPos

local function Drag()
	if holding == false then moveCon:Disconnect(); return end
	local distanceMovedX = initialX - mouse.X
	local distanceMovedY = initialY - mouse.Y

	Main.Position = UIInitialPos - UDim2.new(0, distanceMovedX, 0, distanceMovedY)
end

Main.MouseEnter:Connect(function()
	hovered = true
end)

Main.MouseLeave:Connect(function()
	hovered = false
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		holding = hovered
		if holding then
			initialX, initialY = mouse.X, mouse.Y
			UIInitialPos = Main.Position

			moveCon = mouse.Move:Connect(Drag)
		end
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		holding = false
	end
end)

local function changeButton(button, state)
	if state then
		button.Image = "rbxassetid://14914767493"
	else
		button.Image = "rbxassetid://14914770151"
	end
end

local plantButtons = {
	["Bamboo"] = PlantBambooButton,
	["Coconut"] = PlantCoconutButton,
	["Tomato"] = PlantTomatoButton,
	["Pumpkin"] = PlantPumpkinButton,
	["Apple"] = PlantAppleButton,
	["Corn"] = PlantCornButton,
	["DragonFruit"] = PlantDragonFruitButton,
	["Blueberry"] = PlantBlueberryButton,
	["Carrot"] = PlantCarrotButton,
	["Mango"] = PlantMangoButton,
	["Cactus"] = PlantCactusButton,
	["Strawberry"] = PlantStrawberryButton,
	["Watermelon"] = PlantWatermelonButton
}

for key, button in plantButtons do
	button.MouseButton1Click:Connect(function()
		plantList[key] = not plantList[key]
		changeButton(button, plantList[key])
	end)
end

local buyButtons = {
	["Bamboo"] = BuyBambooButton,
	["Coconut"] = BuyCoconutButton,
	["Tomato"] = BuyTomatoButton,
	["Pumpkin"] = BuyPumpkinButton,
	["Apple"] = BuyAppleButton,
	["Corn"] = BuyCornButton,
	["Dragon Fruit"] = BuyDragonFruitButton,
	["Blueberry"] = BuyBlueberryButton,
	["Carrot"] = BuyCarrotButton,
	["Mango"] = BuyMangoButton,
	["Cactus"] = BuyCactusButton,
	["Strawberry"] = BuyStrawberryButton,
	["Watermelon"] = BuyWatermelonButton
}

for key, button in buyButtons do
	button.MouseButton1Click:Connect(function()
		fruitList[key] = not fruitList[key]
		changeButton(button, fruitList[key])
	end)
end

local functions = {
	["AutoSell"] = false,
	["AutoBuy"] = false,
	["Autoharvest"] = false,
	["AutoPlant"] = false,
	["FruitNoClip"] = false
}

AutoSellEnableButton.MouseButton1Click:Connect(function()
	functions["AutoSell"] = not functions["AutoSell"]
	changeButton(AutoSellEnableButton, functions["AutoSell"])
end)

AutoBuyEnableButton.MouseButton1Click:Connect(function()
	functions["AutoBuy"] = not functions["AutoBuy"]
	changeButton(AutoBuyEnableButton, functions["AutoBuy"])
end)

AutoHarvestEnableButton.MouseButton1Click:Connect(function()
	functions["AutoHarvest"] = not functions["AutoHarvest"]
	changeButton(AutoHarvestEnableButton, functions["AutoHarvest"])
end)

AutoPlantEnableButton.MouseButton1Click:Connect(function()
	functions["AutoPlant"] = not functions["AutoPlant"]
	changeButton(AutoPlantEnableButton, functions["AutoPlant"])
end)

FruitNoclipEnableButton.MouseButton1Click:Connect(function()
	functions["FruitNoClip"] = not functions["FruitNoClip"]
	changeButton(FruitNoclipEnableButton, functions["FruitNoClip"])
end)

local pageButtons = {
	OpenAutoSellButton,
	OpenAutoBuyButton,
	OpenAutoPlantButton,
	OpenAutoHarvestButton
}

local pages = {
	AutoSell_2,
	AutoBuy_2,
	AutoPlant_2,
	AutoHarvest_2
}

for i,page in pageButtons do
	page.MouseButton1Click:Connect(function()
		for k,p in pages do
			p.Visible = false
		end
		pages[i].Visible = true
	end)
end

local function getFarm()
	for _,F in game.Workspace.Farm:GetChildren() do
		if F.Important.Data.Owner.Value == game.Players.LocalPlayer.Name then
			localFarm = F
		end
	end
end

local function disableFruitsCollisions()
	for _,fruit in localFarm.Important.Plants_Physical:GetChildren() do
		for _,p in fruit:GetDescendants() do
			if p:IsA("BasePart") then
				p.CanCollide = false
			end
		end
	end
end

local function getFruit(fruit)
	fruit.ProximityPrompt.MaxActivationDistance = 5
	game.Players.LocalPlayer.Character:PivotTo(CFrame.new(fruit.CFrame.X, math.max(4, fruit.CFrame.Y), fruit.CFrame.Z))
	if fruit and fruit.ProximityPrompt then
		wait(0.25)
		fireproximityprompt(fruit.ProximityPrompt)
	end
end

local function sellFruits()
	game.Players.LocalPlayer.Character:PivotTo(CFrame.new(62,3,-1))
	wait(0.3)
	game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
end

local function fruitLoop()
	for _,des in localFarm.Important.Plants_Physical:GetDescendants() do
		if not functions["AutoHarvest"] then
			return
		end
		if #game.Players.LocalPlayer.Backpack:GetChildren() >= 200 then
			sellFruits()
		end
		if des:IsA("ProximityPrompt") then
			des.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow
			getFruit(des.Parent)
			wait(0.05)
		end
	end
end

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
			if not functions["AutoBuy"] then
				return
			end
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(fruit)
		end
	end
end

local function checkFruitBuy()
	for fruit, a in fruitList do
		if not functions["AutoBuy"] then
			return
		end
		if a then
			buyFruit(fruit)
		end
	end
end

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
	local items = localFarm.Important.Plant_Locations:GetChildren()
	local field = items[math.random(1,#items)]
	local halfSize = field.Size / 2 - Vector3.new(4,0,4)
	local pos = field.Position + Vector3.new(math.random(-halfSize.X, halfSize.X), 5, math.random(-halfSize.Z, halfSize.Z))
	game.Players.LocalPlayer.Character:PivotTo(CFrame.new(pos))
end

local function plantSeeds()
	for _, des in game.Players.LocalPlayer.Backpack:GetDescendants() do
		if not functions["AutoPlant"] then
			return
		end
		if des:IsA("StringValue") and plantList[des.Value] then
			selectFruit(des.Value)
			wait(1)
			for i = 1, des.Parent.Numbers.Value do
				if not functions["AutoPlant"] then
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

game.Players.LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):CaptureController()
	game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

getFarm()
setUI()

game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
	if gameProcessedEvent then
		return
	end	
	if input.KeyCode == Enum.KeyCode.C then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end
end)

while true do
	if functions["FruitNoClip"] then
		disableFruitsCollisions()
	end
	if functions["AutoHarvest"] then
		fruitLoop()
	end
	if functions["AutoSell"] then
		sellFruits()
	end
	if functions["AutoBuy"] then
		checkFruitBuy()
	end
	wait(0.2)
	if functions["AutoPlant"] then
		plantSeeds()
	end
	wait()
end