print("A7medHub STARTED")

print("STEP 1")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("STEP 2")

local gui = Instance.new("ScreenGui")
gui.Name = "A7medHub"
gui.Parent = player:WaitForChild("PlayerGui")

print("STEP 3")

local punishgoatby97mzu = {
	Instances = {},
	ThemeChangedHooks = {},
	CurrentTheme = "punishgoat",
	Themes = {
		punishgoat = {
    MainBg = Color3.fromRGB(15, 15, 15),
    Stroke = Color3.fromRGB(70, 70, 70),
    Accent = Color3.fromRGB(40, 40, 40),
    Accentpunish = Color3.fromRGB(230, 230, 230),
    Text = Color3.fromRGB(220, 220, 220),
    TextInactive = Color3.fromRGB(255, 255, 255),
    ToggleBgOff = Color3.fromRGB(50, 50, 50),
    ToggleBtnBg = Color3.fromRGB(35, 35, 35), 
    ToggleDot = Color3.fromRGB(200, 200, 200),
    SectionTitle = Color3.fromRGB(160, 160, 160),
},
	},
}
 
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
 
function punishgoatby97mzu:ApplyThemeObj(Inst, Prop, ThemeType)
	table.insert(self.Instances, { Inst = Inst, Prop = Prop, Type = ThemeType })
	local palette = self.Themes[self.CurrentTheme]
	Inst[Prop] = palette[ThemeType]
	return Inst
end
 
function punishgoatby97mzu:ChangeTheme(ThemeName)
	self.CurrentTheme = ThemeName
	local palette = self.Themes[ThemeName]
	for _, obj in pairs(self.Instances) do
		if obj.Inst and obj.Inst.Parent then
			TweenService:Create(obj.Inst, TweenInfo.new(0.3), { [obj.Prop] = palette[obj.Type] }):Play()
		end
	end
 
	for _, hook in pairs(self.ThemeChangedHooks) do
		if hook.Inst and hook.Inst.Parent then
			hook.Func(ThemeName)
		end
	end
end
 
local NotifUI = Instance.new("ScreenGui")
NotifUI.Name = "punishgoatNotifUI"
NotifUI.ResetOnSpawn = false
NotifUI.IgnoreGuiInset = true
-- Set the highest DisplayOrder so notification cards never get covered by the game's HUD
NotifUI.DisplayOrder = 99999
NotifUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
 
local NotifContainer = Instance.new("Frame", NotifUI)
NotifContainer.Name = "NotifContainer"
NotifContainer.Size = UDim2.new(0, 260, 1, -20)
NotifContainer.Position = UDim2.new(1, -20, 0, 10)
NotifContainer.AnchorPoint = Vector2.new(1, 0)
NotifContainer.BackgroundTransparency = 1
NotifContainer.ZIndex = 1000
 
local NotifLayout = Instance.new("UIListLayout", NotifContainer)
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding = UDim.new(0, 10)
 
function punishgoatby97mzu:Notify(Data)
	local TitleStr = Data.Title or "Notification"
	local ContentStr = Data.Content or "Description here"
	local Duration = Data.Duration or 3
 
	local NCard = Instance.new("Frame", NotifContainer)
	NCard.Size = UDim2.new(1, 0, 0, 60)
	NCard.Position = UDim2.new(1, 300, 0, 0)
	NCard.BackgroundTransparency = 0.15
	NCard.ClipsDescendants = true
	NCard.ZIndex = 1001
	Instance.new("UICorner", NCard).CornerRadius = UDim.new(0, 8)
	punishgoatby97mzu:ApplyThemeObj(NCard, "BackgroundColor3", "ToggleBtnBg")
 
	local NStroke = Instance.new("UIStroke", NCard)
	NStroke.Thickness = 1
	NStroke.Transparency = 0.5
	punishgoatby97mzu:ApplyThemeObj(NStroke, "Color", "Stroke")
 
	local NIcon = Instance.new("ImageLabel", NCard)
	NIcon.Size = UDim2.new(0, 24, 0, 24)
	NIcon.Position = UDim2.new(0, 15, 0.5, -12)
	NIcon.BackgroundTransparency = 1
	NIcon.Image = "rbxassetid://10709771426"
	NIcon.ZIndex = 1002
	punishgoatby97mzu:ApplyThemeObj(NIcon, "ImageColor3", "Accent")
 
	local NTitle = Instance.new("TextLabel", NCard)
	NTitle.Size = UDim2.new(1, -55, 0, 18)
	NTitle.Position = UDim2.new(0, 50, 0, 10)
	NTitle.BackgroundTransparency = 1
	NTitle.Text = TitleStr
	NTitle.Font = Enum.Font.GothamBold
	NTitle.TextSize = 13
	NTitle.TextXAlignment = Enum.TextXAlignment.Left
	NTitle.ZIndex = 1002
	punishgoatby97mzu:ApplyThemeObj(NTitle, "TextColor3", "Text")
 
	local NDesc = Instance.new("TextLabel", NCard)
	NDesc.Size = UDim2.new(1, -55, 1, -30)
	NDesc.Position = UDim2.new(0, 50, 0, 28)
	NDesc.BackgroundTransparency = 1
	NDesc.Text = ContentStr
	NDesc.Font = Enum.Font.Gotham
	NDesc.TextSize = 11
	NDesc.TextWrapped = true
	NDesc.TextYAlignment = Enum.TextYAlignment.Top
	NDesc.TextXAlignment = Enum.TextXAlignment.Left
	NDesc.ZIndex = 1002
	punishgoatby97mzu:ApplyThemeObj(NDesc, "TextColor3", "TextInactive")
 
	local NBarBg = Instance.new("Frame", NCard)
	NBarBg.Size = UDim2.new(1, 0, 0, 3)
	NBarBg.Position = UDim2.new(0, 0, 1, -3)
	NBarBg.BorderSizePixel = 0
	NBarBg.ZIndex = 1002
	punishgoatby97mzu:ApplyThemeObj(NBarBg, "BackgroundColor3", "MainBg")
 
	local NBarFill = Instance.new("Frame", NBarBg)
	NBarFill.Size = UDim2.new(1, 0, 1, 0)
	NBarFill.BorderSizePixel = 0
	NBarFill.ZIndex = 1002
	punishgoatby97mzu:ApplyThemeObj(NBarFill, "BackgroundColor3", "Accent")
 
	TweenService:Create(
		NCard,
		TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{ Position = UDim2.new(0, 0, 0, 0) }
	):Play()
	TweenService:Create(NBarFill, TweenInfo.new(Duration, Enum.EasingStyle.Linear), { Size = UDim2.new(0, 0, 1, 0) })
		:Play()
 
	task.delay(Duration, function()
		local OutAnim = TweenService:Create(
			NCard,
			TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
			{ Position = UDim2.new(1, 300, 0, 0) }
		)
		OutAnim:Play()
		OutAnim.Completed:Wait()
		NCard:Destroy()
	end)
end
 
-- This is the "brain" that stores UI state for as long as the script is running
local UI_Session = {
    Pos = UDim2.new(0.5, 0, 0.5, 0), -- Default ke tengah
    Size = UDim2.new(0, 600, 0, 400), -- Default ukuran
}
 function punishgoatby97mzu:CreateWindow(TitleText)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    -- Se já existir uma instância antiga, destrói
    local oldUI = PlayerGui:FindFirstChild("punishgoatUI")
    if oldUI then
        oldUI:Destroy()
    end

    local Window = { Tabs = {}, SelectCloseFuncs = {}, DropdownCloseFuncs = {}, CurrentTab = nil }
 
    local punishgoatUI = Instance.new("ScreenGui")
    punishgoatUI.Name = "punishgoatUI"
    punishgoatUI.ResetOnSpawn = false
    punishgoatUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    punishgoatUI.IgnoreGuiInset = true
    punishgoatUI.DisplayOrder = 99999 
    punishgoatUI.Parent = PlayerGui
 
    local Main = Instance.new("Frame")
    local currentSize = UDim2.new(0, 600, 0, 400)
 
    local Camera = workspace.CurrentCamera
    local Viewport = Camera and Camera.ViewportSize or Vector2.new(1000, 1000)
    local scaleX = Viewport.X / 640
    local scaleY = Viewport.Y / 440
    local initialScale = math.clamp(math.min(scaleX, scaleY, 1), 0.38, 1)
    local initialYOffset = (Viewport.Y / 2) - (400 * initialScale / 2)
    local currentPos = UDim2.new(0.5, 0, 0, initialYOffset)
 
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.AnchorPoint = Vector2.new(0.5, 0) 
    Main.Position = currentPos
    Main.BackgroundTransparency = 0.02
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.ZIndex = 10
    Main.Parent = punishgoatUI
    punishgoatby97mzu:ApplyThemeObj(Main, "BackgroundColor3", "MainBg")
 
	local MainScale = Instance.new("UIScale")
	MainScale.Name = "punishgoatAutoScaler"
	MainScale.Parent = Main
 
	local function ScaleUI()
            local Camera = workspace.CurrentCamera
            if not Camera then
                return
            end
            local Viewport = Camera.ViewportSize
 
local maxWidth = 600 + 40
local maxHeight = 400 + 40
 
            local scaleX = Viewport.X / maxWidth
            local scaleY = Viewport.Y / maxHeight
 
            local finalScale = math.min(scaleX, scaleY, 1)
 
            -- Clamp the minimum scale to 0.38 so it still fits on short phone screens
            MainScale.Scale = math.clamp(finalScale, 0.38, 1)
        end
 
	ScaleUI()
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(ScaleUI)
 
 
	local MainCorner = Instance.new("UICorner", Main)
	MainCorner.CornerRadius = UDim.new(0, 8)
 
	local MainStroke = Instance.new("UIStroke", Main)
	MainStroke.Thickness = 1
	MainStroke.Transparency = 0.5
	MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	punishgoatby97mzu:ApplyThemeObj(MainStroke, "Color", "Stroke")
 
	local TopBar = Instance.new("Frame", Main)
	TopBar.Name = "TopBar"
	TopBar.Size = UDim2.new(1, 0, 0, 30)
	TopBar.BackgroundTransparency = 1
	TopBar.ZIndex = 50
 
	local TopBarPadding = Instance.new("UIPadding", TopBar)
	TopBarPadding.PaddingLeft = UDim.new(0, 15)
	TopBarPadding.PaddingRight = UDim.new(0, 15)
 
	local Title = Instance.new("TextLabel", TopBar)
	Title.Name = "Title"
	Title.Size = UDim2.new(0.5, 0, 1, 0)
	Title.BackgroundTransparency = 1
	Title.Text = TitleText or "punishgoat Hub | V6 God Tier"
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 15
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 51
	punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
	local dragging, dragInput, dragStart, startPos
	TopBar.InputBegan:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			dragging = true
			dragStart = input.Position
			startPos = Main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	TopBar.InputChanged:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			Main.Position =
				UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			currentPos = Main.Position -- 🔥 TIMPA: Simpan posisi terbaru setiap kali UI digeser
		end
	end)
 
	local ControlContainer = Instance.new("Frame", TopBar)
	ControlContainer.Name = "ControlContainer"
	ControlContainer.Size = UDim2.new(0.5, 0, 1, 0)
	ControlContainer.AnchorPoint = Vector2.new(1, 0)
	ControlContainer.Position = UDim2.new(1, 0, 0, 0)
	ControlContainer.BackgroundTransparency = 1
	ControlContainer.ZIndex = 51
 
	local ControlLayout = Instance.new("UIListLayout", ControlContainer)
	ControlLayout.FillDirection = Enum.FillDirection.Horizontal
	ControlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	ControlLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	ControlLayout.Padding = UDim.new(0, 10)
	ControlLayout.SortOrder = Enum.SortOrder.LayoutOrder
 
	local MinimizeBtn = Instance.new("ImageButton", ControlContainer)
	MinimizeBtn.Size = UDim2.new(0, 18, 0, 18)
	MinimizeBtn.BackgroundTransparency = 1
	MinimizeBtn.LayoutOrder = 2
	MinimizeBtn.Image = "rbxassetid://10734896206"
	MinimizeBtn.ZIndex = 51
	punishgoatby97mzu:ApplyThemeObj(MinimizeBtn, "ImageColor3", "Text")

 
	local CloseBtn = Instance.new("ImageButton", ControlContainer)
	CloseBtn.Size = UDim2.new(0, 18, 0, 18)
	CloseBtn.BackgroundTransparency = 1
	CloseBtn.LayoutOrder = 4
	CloseBtn.Image = "rbxassetid://10747384394"
	CloseBtn.ZIndex = 51
	punishgoatby97mzu:ApplyThemeObj(CloseBtn, "ImageColor3", "Text")
 
	local function ApplyHover(btn, hoverColor)
		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.2), { ImageColor3 = hoverColor }):Play()
		end)
		btn.MouseLeave:Connect(function()
			local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
			TweenService:Create(btn, TweenInfo.new(0.2), { ImageColor3 = palette.Text }):Play()
		end)
	end
	ApplyHover(MinimizeBtn, Color3.fromRGB(250, 154, 50))
	ApplyHover(CloseBtn, Color3.fromRGB(255, 54, 54))
 
	local ProfileCard
 
	local isMinimized = false
	local preMinSize = Main.Size
	local preMinPos = Main.Position
	local isMinTweening = false
 
MinimizeBtn.MouseButton1Click:Connect(function()
    if isMinTweening then return end
    isMinTweening = true
    isMinimized = not isMinimized
 
    -- Toggle ProfileCard visibility (assumes the variable is named ProfileCard)
    if ProfileCard then
        ProfileCard.Visible = not isMinimized 
    end
 
    -- Use currentSize as the target height when un-minimizing
    local targetHeight = isMinimized and 30 or currentSize.Y.Offset
    
    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(currentSize.X.Scale, currentSize.X.Offset, 0, targetHeight)
    }):Play()
 
    task.delay(0.4, function() isMinTweening = false end)
end)

 
	local ModalOverlay = Instance.new("Frame", Main)
	ModalOverlay.Size = UDim2.new(1, 0, 1, 0)
	ModalOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	ModalOverlay.BackgroundTransparency = 1
	ModalOverlay.Visible = false
	ModalOverlay.ZIndex = 998
 
	local ModalBox = Instance.new("Frame", ModalOverlay)
	ModalBox.Size = UDim2.new(0, 300, 0, 150)
	ModalBox.AnchorPoint = Vector2.new(0.5, 0.5)
	ModalBox.Position = UDim2.new(0.5, 0, 0.5, 20)
	ModalBox.BackgroundTransparency = 1
	ModalBox.ZIndex = 999
	Instance.new("UICorner", ModalBox).CornerRadius = UDim.new(0, 10)
	punishgoatby97mzu:ApplyThemeObj(ModalBox, "BackgroundColor3", "MainBg")
 
	local ModalStroke = Instance.new("UIStroke", ModalBox)
	ModalStroke.Thickness = 1
	ModalStroke.Transparency = 1
	punishgoatby97mzu:ApplyThemeObj(ModalStroke, "Color", "Stroke")
 
	local ModalTitle = Instance.new("TextLabel", ModalBox)
	ModalTitle.Size = UDim2.new(1, 0, 0, 40)
	ModalTitle.BackgroundTransparency = 1
	ModalTitle.Text = "Exit punishgoat Hub?"
	ModalTitle.Font = Enum.Font.GothamBold
	ModalTitle.TextSize = 16
	ModalTitle.TextTransparency = 1
	ModalTitle.ZIndex = 999
	punishgoatby97mzu:ApplyThemeObj(ModalTitle, "TextColor3", "Text")
 
	local ModalDesc = Instance.new("TextLabel", ModalBox)
	ModalDesc.Size = UDim2.new(1, -40, 0, 40)
	ModalDesc.Position = UDim2.new(0, 20, 0, 40)
	ModalDesc.BackgroundTransparency = 1
	ModalDesc.Text = "Are you sure you want to exit? You will need to re-execute the script."
	ModalDesc.TextWrapped = true
	ModalDesc.Font = Enum.Font.Gotham
	ModalDesc.TextSize = 12
	ModalDesc.TextTransparency = 1
	ModalDesc.ZIndex = 999
	punishgoatby97mzu:ApplyThemeObj(ModalDesc, "TextColor3", "TextInactive")
 
	local CancelBtn = Instance.new("TextButton", ModalBox)
	CancelBtn.Size = UDim2.new(0, 110, 0, 36)
	CancelBtn.Position = UDim2.new(0, 30, 1, -50)
	CancelBtn.Text = "Cancel"
	CancelBtn.Font = Enum.Font.GothamMedium
	CancelBtn.TextSize = 13
	CancelBtn.AutoButtonColor = false
	CancelBtn.BackgroundTransparency = 1
	CancelBtn.TextTransparency = 1
	CancelBtn.ZIndex = 999
	Instance.new("UICorner", CancelBtn).CornerRadius = UDim.new(0, 6)
	punishgoatby97mzu:ApplyThemeObj(CancelBtn, "BackgroundColor3", "ToggleBgOff")
	punishgoatby97mzu:ApplyThemeObj(CancelBtn, "TextColor3", "Text")
 
	local ConfirmBtn = Instance.new("TextButton", ModalBox)
	ConfirmBtn.Size = UDim2.new(0, 110, 0, 36)
	ConfirmBtn.Position = UDim2.new(1, -140, 1, -50)
	ConfirmBtn.Text = "Yes, Exit"
	ConfirmBtn.Font = Enum.Font.GothamMedium
	ConfirmBtn.TextSize = 13
	ConfirmBtn.AutoButtonColor = false
	ConfirmBtn.BackgroundTransparency = 1
	ConfirmBtn.TextTransparency = 1
	ConfirmBtn.ZIndex = 999
	Instance.new("UICorner", ConfirmBtn).CornerRadius = UDim.new(0, 6)
	punishgoatby97mzu:ApplyThemeObj(ConfirmBtn, "BackgroundColor3", "Accent")
	ConfirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
 
	CloseBtn.MouseButton1Click:Connect(function()
		ModalOverlay.Visible = true
		TweenService:Create(ModalOverlay, TweenInfo.new(0.3), { BackgroundTransparency = 0.5 }):Play()
		TweenService:Create(
			ModalBox,
			TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{ Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 0 }
		):Play()
		TweenService:Create(ModalStroke, TweenInfo.new(0.3), { Transparency = 0.5 }):Play()
		TweenService:Create(ModalTitle, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
		TweenService:Create(ModalDesc, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
		TweenService:Create(CancelBtn, TweenInfo.new(0.3), { BackgroundTransparency = 0, TextTransparency = 0 }):Play()
		TweenService:Create(ConfirmBtn, TweenInfo.new(0.3), { BackgroundTransparency = 0.2, TextTransparency = 0 })
			:Play()
	end)
 
	CancelBtn.MouseButton1Click:Connect(function()
		TweenService:Create(ModalOverlay, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
		TweenService:Create(
			ModalBox,
			TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
			{ Position = UDim2.new(0.5, 0, 0.5, 20), BackgroundTransparency = 1 }
		):Play()
		TweenService:Create(ModalStroke, TweenInfo.new(0.3), { Transparency = 1 }):Play()
		TweenService:Create(ModalTitle, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
		TweenService:Create(ModalDesc, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
		TweenService:Create(CancelBtn, TweenInfo.new(0.3), { BackgroundTransparency = 1, TextTransparency = 1 }):Play()
		TweenService:Create(ConfirmBtn, TweenInfo.new(0.3), { BackgroundTransparency = 1, TextTransparency = 1 }):Play()
		task.wait(0.3)
		ModalOverlay.Visible = false
	end)
 
	ConfirmBtn.MouseButton1Click:Connect(function()
		TweenService:Create(
			Main,
			TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
			{ Size = UDim2.new(0, 0, 0, 0) }
		):Play()
		TweenService:Create(FloatingBtn, TweenInfo.new(0.3), { Size = UDim2.new(0, 0, 0, 0) }):Play()
		task.wait(0.3)
		punishgoatUI:Destroy()
	end)
 
local ResizeGrip = Instance.new("ImageButton", Main)
ResizeGrip.Size = UDim2.new(0, 20, 0, 20)
ResizeGrip.Position = UDim2.new(1, 0, 1, 0)
ResizeGrip.AnchorPoint = Vector2.new(1, 1)
ResizeGrip.BackgroundTransparency = 1
ResizeGrip.Image = "rbxassetid://83865456239149"
ResizeGrip.ZIndex = 100
	local resizing, rDragStart, startSize
	ResizeGrip.InputBegan:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			if isMinimized or isMaximized then
				return
			end
			resizing = true
			rDragStart = input.Position
			startSize = Main.Size
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					resizing = false
				end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if
			resizing
			and (
				input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch
			)
		then
			local delta = input.Position - rDragStart
local newX = math.clamp(startSize.X.Offset + delta.X, 400, 1000)
local newY = math.clamp(startSize.Y.Offset + delta.Y, 300, 800)
			Main.Size = UDim2.new(0, newX, 0, newY)
			currentSize = Main.Size
		end
	end)
 
	local Sidebar = Instance.new("ScrollingFrame", Main)
	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.new(0, 180, 1, -95)
	Sidebar.Position = UDim2.new(0, 0, 0, 30)
	Sidebar.BackgroundTransparency = 1
	Sidebar.BorderSizePixel = 0
	Sidebar.ScrollBarThickness = 0
	Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
	Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
 
	local SidebarPadding = Instance.new("UIPadding", Sidebar)
	SidebarPadding.PaddingTop = UDim.new(0, 10)
	SidebarPadding.PaddingBottom = UDim.new(0, 10)
	SidebarPadding.PaddingLeft = UDim.new(0, 10)
	SidebarPadding.PaddingRight = UDim.new(0, 10)
 
	local SidebarLayout = Instance.new("UIListLayout", Sidebar)
	SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SidebarLayout.Padding = UDim.new(0, 5)
 
	local SidebarDivider = Instance.new("Frame", Main)
	SidebarDivider.Name = "SidebarDivider"
	SidebarDivider.Size = UDim2.new(0, 1, 1, -80)
	SidebarDivider.AnchorPoint = Vector2.new(0, 0.5)
	SidebarDivider.Position = UDim2.new(0, 180, 0.5, 15)
	SidebarDivider.BackgroundTransparency = 0.7
	SidebarDivider.BorderSizePixel = 0
	punishgoatby97mzu:ApplyThemeObj(SidebarDivider, "BackgroundColor3", "Stroke")
 
	ProfileCard = Instance.new("Frame", Main)
	ProfileCard.Size = UDim2.new(0, 160, 0, 50)
	ProfileCard.Position = UDim2.new(0, 10, 1, -60)
	ProfileCard.BackgroundTransparency = 0.55
	Instance.new("UICorner", ProfileCard).CornerRadius = UDim.new(0, 8)
	punishgoatby97mzu:ApplyThemeObj(ProfileCard, "BackgroundColor3", "ToggleBtnBg")
 
	local ProfStroke = Instance.new("UIStroke", ProfileCard)
	ProfStroke.Transparency = 0.85
	punishgoatby97mzu:ApplyThemeObj(ProfStroke, "Color", "Stroke")
 
	local AvatarImg = Instance.new("ImageLabel", ProfileCard)
	AvatarImg.Size = UDim2.new(0, 36, 0, 36)
	AvatarImg.Position = UDim2.new(0, 7, 0.5, -18)
	AvatarImg.BackgroundTransparency = 1
	AvatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
	Instance.new("UICorner", AvatarImg).CornerRadius = UDim.new(1, 0)
 
	local PlayerName = Instance.new("TextLabel", ProfileCard)
	PlayerName.Size = UDim2.new(1, -105, 0, 16)
	PlayerName.Position = UDim2.new(0, 50, 0, 8)
	PlayerName.BackgroundTransparency = 1
	PlayerName.Text = LocalPlayer.Name
	PlayerName.Font = Enum.Font.GothamBold
	PlayerName.TextSize = 12
	PlayerName.TextXAlignment = Enum.TextXAlignment.Left
	PlayerName.TextTruncate = Enum.TextTruncate.AtEnd
	punishgoatby97mzu:ApplyThemeObj(PlayerName, "TextColor3", "Text")
 
	local f = Instance.new("TextLabel", ProfileCard)
	f.Size = UDim2.new(1, -105, 0, 14)
	f.Position = UDim2.new(0, 45, 0, 26)
	f.BackgroundTransparency = 1
	f.Text = "Punishment User"
	f.Font = Enum.Font.GothamMedium
	f.TextSize = 10
	f.TextXAlignment = Enum.TextXAlignment.Left
	punishgoatby97mzu:ApplyThemeObj(f, "TextColor3", "Accentpunish")
 
	local ThemePanel = Instance.new("Frame", Main)
	ThemePanel.Name = "ThemePanel"
	ThemePanel.AnchorPoint = Vector2.new(0, 1)
	ThemePanel.Position = UDim2.new(0, 10, 1, -65)
	ThemePanel.Size = UDim2.new(0, 160, 0, 0)
	ThemePanel.BackgroundTransparency = 0.55
	ThemePanel.ClipsDescendants = true
	ThemePanel.ZIndex = 50
	Instance.new("UICorner", ThemePanel).CornerRadius = UDim.new(0, 8)
	punishgoatby97mzu:ApplyThemeObj(ThemePanel, "BackgroundColor3", "ToggleBtnBg")
 
	local TPStroke = Instance.new("UIStroke", ThemePanel)
	TPStroke.Transparency = 0.85
	punishgoatby97mzu:ApplyThemeObj(TPStroke, "Color", "Stroke")
 
	local TPPadding = Instance.new("UIPadding", ThemePanel)
	TPPadding.PaddingTop = UDim.new(0, 8)
	TPPadding.PaddingBottom = UDim.new(0, 8)
	TPPadding.PaddingLeft = UDim.new(0, 8)
	TPPadding.PaddingRight = UDim.new(0, 8)
 
	local TPLayout = Instance.new("UIListLayout", ThemePanel)
	TPLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TPLayout.Padding = UDim.new(0, 4)
 
	local ThemeOrder =
		{ "Dark", "Light", "Ocean", "Cyberpunk", "Matcha", "Silver", "White", "Platinum", "Crimson", "Gold" }
	for i, tName in ipairs(ThemeOrder) do
		local tBtn = Instance.new("TextButton", ThemePanel)
		tBtn.Size = UDim2.new(1, 0, 0, 26)
		tBtn.BackgroundTransparency = 1
		tBtn.Text = tName
		tBtn.Font = Enum.Font.GothamMedium
		tBtn.TextSize = 11
		tBtn.AutoButtonColor = false
		tBtn.LayoutOrder = i
		Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 4)
		punishgoatby97mzu:ApplyThemeObj(tBtn, "BackgroundColor3", "ToggleBgOff")
		punishgoatby97mzu:ApplyThemeObj(tBtn, "TextColor3", "TextInactive")
 
		tBtn.MouseEnter:Connect(function()
			TweenService:Create(tBtn, TweenInfo.new(0.2), { BackgroundTransparency = 0.8 }):Play()
		end)
		tBtn.MouseLeave:Connect(function()
			TweenService:Create(tBtn, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
		end)
 
		tBtn.MouseButton1Click:Connect(function()
			punishgoatby97mzu:ChangeTheme(tName)
			for _, tabData in pairs(Window.Tabs) do
				if tabData.Page.Visible then
					local palette = punishgoatby97mzu.Themes[tName]
					TweenService:Create(tabData.Icon, TweenInfo.new(0.3), { ImageColor3 = palette.Accent }):Play()
					TweenService:Create(tabData.TitleLabel, TweenInfo.new(0.3), { TextColor3 = palette.Text }):Play()
				end
			end
		end)
	end
 
	local t = Instance.new("ImageLabel", ProfileCard)
	t.Size = UDim2.new(0, 20, 0, 20)
	t.AnchorPoint = Vector2.new(1, 0.5)
	t.Position = UDim2.new(1, -10, 0.6, 0)
	t.BackgroundTransparency = 1
	t.Image = "rbxassetid://81899856845503"
	punishgoatby97mzu:ApplyThemeObj(t, "ImageColor3", "TextInactive")
 
	local ContentContainer = Instance.new("Frame", Main)
	ContentContainer.Name = "ContentContainer"
	ContentContainer.Size = UDim2.new(1, -181, 1, -30)
	ContentContainer.Position = UDim2.new(0, 181, 0, 30)
	ContentContainer.BackgroundTransparency = 1
	ContentContainer.BorderSizePixel = 0
	ContentContainer.ClipsDescendants = true
 
	function Window:CreateTab(TabName, IconID)
		local TabBtn = Instance.new("TextButton", Sidebar)
		TabBtn.Name = "TabBtn_" .. TabName
		TabBtn.Size = UDim2.new(1, 0, 0, 32)
		TabBtn.BackgroundTransparency = 0.98
		TabBtn.Text = ""
		TabBtn.AutoButtonColor = false
		Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
		punishgoatby97mzu:ApplyThemeObj(TabBtn, "BackgroundColor3", "Text")
 
		local Indicator = Instance.new("Frame", TabBtn)
		Indicator.Name = "Indicator"
		Indicator.Size = UDim2.new(0, 3, 0, 16)
		Indicator.AnchorPoint = Vector2.new(0, 0.5)
		Indicator.Position = UDim2.new(0, 4, 0.5, 0)
		Indicator.BackgroundTransparency = 1
		Indicator.BorderSizePixel = 0
		Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)
		punishgoatby97mzu:ApplyThemeObj(Indicator, "BackgroundColor3", "Accent")
 
		local Icon = Instance.new("ImageLabel", TabBtn)
		Icon.Name = "Icon"
		Icon.Size = UDim2.new(0, 16, 0, 16)
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.Position = UDim2.new(0, 14, 0.5, 0)
		Icon.BackgroundTransparency = 1
		Icon.Image = IconID or ""
		punishgoatby97mzu:ApplyThemeObj(Icon, "ImageColor3", "TextInactive")
 
		local TitleLabel = Instance.new("TextLabel", TabBtn)
		TitleLabel.Name = "TitleLabel"
		TitleLabel.Size = UDim2.new(1, -40, 1, 0)
		TitleLabel.Position = UDim2.new(0, 40, 0, 0)
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Text = TabName
		TitleLabel.Font = Enum.Font.GothamMedium
		TitleLabel.TextSize = 13
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		TitleLabel.TextTruncate = Enum.TextTruncate.AtEnd
		punishgoatby97mzu:ApplyThemeObj(TitleLabel, "TextColor3", "TextInactive")
 
		local Page = Instance.new("ScrollingFrame", ContentContainer)
		Page.Name = "Page_" .. TabName
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.Position = UDim2.new(0, 0, 1, 0)
		Page.BackgroundTransparency = 1
		Page.BorderSizePixel = 0
		Page.ScrollBarThickness = 2
		Page.CanvasSize = UDim2.new(0, 0, 0, 0)
		-- Use Roblox's built-in AutomaticCanvasSize so scroll height adapts to dropdown content automatically
		Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		punishgoatby97mzu:ApplyThemeObj(Page, "ScrollBarImageColor3", "Stroke")
 
		local PagePadding = Instance.new("UIPadding", Page)
		PagePadding.PaddingTop = UDim.new(0, 15)
		PagePadding.PaddingBottom = UDim.new(0, 15)
		PagePadding.PaddingLeft = UDim.new(0, 15)
		PagePadding.PaddingRight = UDim.new(0, 15)
 
		local PageLayout = Instance.new("UIListLayout", Page)
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Padding = UDim.new(0, 8)
 
		local TabData = {
			Button = TabBtn,
			Indicator = Indicator,
			Icon = Icon,
			TitleLabel = TitleLabel,
			Page = Page,
		}
		table.insert(Window.Tabs, TabData)
 
		TabBtn.MouseButton1Click:Connect(function()
			if Window.CurrentTab == TabData then
				return
			end
			local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
 
			for _, v in pairs(Window.Tabs) do
				TweenService:Create(v.Button, TweenInfo.new(0.2), { BackgroundTransparency = 0.98 }):Play()
				TweenService:Create(v.Indicator, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
				TweenService:Create(v.Icon, TweenInfo.new(0.2), { ImageColor3 = palette.TextInactive }):Play()
				TweenService:Create(v.TitleLabel, TweenInfo.new(0.2), { TextColor3 = palette.TextInactive }):Play()
 
				if v.Page.Visible then
					v.Page.Visible = false
				end
			end
 
			Window.CurrentTab = TabData
			Page.Visible = true
			Page.Position = UDim2.new(0, 0, 0, 0)
			Page.CanvasPosition = Vector2.new(0, 0)
 
			TweenService:Create(TabBtn, TweenInfo.new(0.2), { BackgroundTransparency = 0.9 }):Play()
			TweenService:Create(Indicator, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
			TweenService:Create(Icon, TweenInfo.new(0.2), { ImageColor3 = palette.Accent }):Play()
			TweenService:Create(TitleLabel, TweenInfo.new(0.2), { TextColor3 = palette.Text }):Play()
 
			for _, closeFunc in pairs(Window.SelectCloseFuncs) do
				closeFunc()
			end
		end)
 
		if #Window.Tabs == 1 then
			Window.CurrentTab = TabData
			Page.Visible = true
			Page.Position = UDim2.new(0, 0, 0, 0)
			TabBtn.BackgroundTransparency = 0.9
			Indicator.BackgroundTransparency = 0
			local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
			Icon.ImageColor3 = palette.Accent
			TitleLabel.TextColor3 = palette.Text
		end
 
		local Tab = {}
		function Tab:CreateSection(SectionName)
			local SectionLabel = Instance.new("Frame", Page)
			SectionLabel.Size = UDim2.new(1, 0, 0, 30)
			SectionLabel.BackgroundTransparency = 1
 
			local Title = Instance.new("TextLabel", SectionLabel)
			Title.Size = UDim2.new(1, -10, 1, 0)
			Title.Position = UDim2.new(0, 5, 0, 0)
			Title.BackgroundTransparency = 1
			Title.Text = SectionName
			Title.Font = Enum.Font.GothamBold
			Title.TextSize = 14
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "SectionTitle")
 
			Instance.new("UIPadding", SectionLabel).PaddingTop = UDim.new(0, 15)
		end
 
		-- Thin horizontal separator to break up long lists of components.
		function Tab:CreateDivider()
			local DividerHolder = Instance.new("Frame", Page)
			DividerHolder.Size = UDim2.new(1, 0, 0, 9)
			DividerHolder.BackgroundTransparency = 1
 
			local Line = Instance.new("Frame", DividerHolder)
			Line.Size = UDim2.new(1, 0, 0, 1)
			Line.Position = UDim2.new(0, 0, 0.5, 0)
			Line.AnchorPoint = Vector2.new(0, 0.5)
			Line.BorderSizePixel = 0
			Line.BackgroundTransparency = 0.7
			punishgoatby97mzu:ApplyThemeObj(Line, "BackgroundColor3", "Stroke")
		end
 
		-- Same idea as CreateDivider, but accepts an optional centered label
		-- (e.g. AddLine("Advanced"), or just AddLine() for a plain line).
		function Tab:AddLine(Text)
			local LineHolder = Instance.new("Frame", Page)
			LineHolder.Size = UDim2.new(1, 0, 0, 9)
			LineHolder.BackgroundTransparency = 1
 
			if Text and Text ~= "" then
				local LeftLine = Instance.new("Frame", LineHolder)
				LeftLine.AnchorPoint = Vector2.new(0, 0.5)
				LeftLine.Position = UDim2.new(0, 0, 0.5, 0)
				LeftLine.Size = UDim2.new(0.4, 0, 0, 1)
				LeftLine.BorderSizePixel = 0
				LeftLine.BackgroundTransparency = 0.7
				punishgoatby97mzu:ApplyThemeObj(LeftLine, "BackgroundColor3", "Stroke")
 
				local Label = Instance.new("TextLabel", LineHolder)
				Label.AnchorPoint = Vector2.new(0.5, 0.5)
				Label.Position = UDim2.new(0.5, 0, 0.5, 0)
				Label.Size = UDim2.new(0, 0, 0, 14)
				Label.AutomaticSize = Enum.AutomaticSize.X
				Label.BackgroundTransparency = 1
				Label.Text = Text
				Label.Font = Enum.Font.GothamMedium
				Label.TextSize = 11
				punishgoatby97mzu:ApplyThemeObj(Label, "TextColor3", "TextInactive")
 
				local RightLine = Instance.new("Frame", LineHolder)
				RightLine.AnchorPoint = Vector2.new(1, 0.5)
				RightLine.Position = UDim2.new(1, 0, 0.5, 0)
				RightLine.Size = UDim2.new(0.4, 0, 0, 1)
				RightLine.BorderSizePixel = 0
				RightLine.BackgroundTransparency = 0.7
				punishgoatby97mzu:ApplyThemeObj(RightLine, "BackgroundColor3", "Stroke")
			else
				local Line = Instance.new("Frame", LineHolder)
				Line.Size = UDim2.new(1, 0, 0, 1)
				Line.Position = UDim2.new(0, 0, 0.5, 0)
				Line.AnchorPoint = Vector2.new(0, 0.5)
				Line.BorderSizePixel = 0
				Line.BackgroundTransparency = 0.7
				punishgoatby97mzu:ApplyThemeObj(Line, "BackgroundColor3", "Stroke")
			end
		end
 
		-- Live search box. Calls Callback(query) on every keystroke; the caller decides
		-- what to filter (component list, dropdown options, etc). Returns a handle with
		-- :Set(text) so the search text can be cleared/updated from outside too.
		function Tab:CreateSearchBar(Placeholder, Callback)
			local CallbackFunc = Callback or function() end
 
			local SearchContainer = Instance.new("Frame", Page)
			SearchContainer.Size = UDim2.new(1, 0, 0, 36)
			SearchContainer.BackgroundTransparency = 0.55
			Instance.new("UICorner", SearchContainer).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(SearchContainer, "BackgroundColor3", "ToggleBtnBg")
 
			local SearchStroke = Instance.new("UIStroke", SearchContainer)
			SearchStroke.Thickness = 1
			SearchStroke.Transparency = 0.85
			SearchStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			punishgoatby97mzu:ApplyThemeObj(SearchStroke, "Color", "Stroke")
 
			local Icon = Instance.new("ImageLabel", SearchContainer)
			Icon.Size = UDim2.new(0, 16, 0, 16)
			Icon.AnchorPoint = Vector2.new(0, 0.5)
			Icon.Position = UDim2.new(0, 12, 0.5, 0)
			Icon.BackgroundTransparency = 1
			Icon.Image = "rbxassetid://10709791245" -- magnifying glass icon
			punishgoatby97mzu:ApplyThemeObj(Icon, "ImageColor3", "TextInactive")
 
			local Input = Instance.new("TextBox", SearchContainer)
			Input.Size = UDim2.new(1, -70, 1, 0)
			Input.Position = UDim2.new(0, 36, 0, 0)
			Input.BackgroundTransparency = 1
			Input.PlaceholderText = Placeholder or "Search..."
			Input.Text = ""
			Input.ClearTextOnFocus = false
			Input.Font = Enum.Font.Gotham
			Input.TextSize = 13
			Input.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Input, "TextColor3", "Text")
			punishgoatby97mzu:ApplyThemeObj(Input, "PlaceholderColor3", "TextInactive")
 
			local ClearBtn = Instance.new("TextButton", SearchContainer)
			ClearBtn.Size = UDim2.new(0, 24, 0, 24)
			ClearBtn.AnchorPoint = Vector2.new(1, 0.5)
			ClearBtn.Position = UDim2.new(1, -8, 0.5, 0)
			ClearBtn.BackgroundTransparency = 1
			ClearBtn.Text = "X"
			ClearBtn.Font = Enum.Font.GothamBold
			ClearBtn.TextSize = 12
			ClearBtn.AutoButtonColor = false
			ClearBtn.Visible = false
			punishgoatby97mzu:ApplyThemeObj(ClearBtn, "TextColor3", "TextInactive")
 
			Input.Focused:Connect(function()
				TweenService:Create(SearchStroke, TweenInfo.new(0.2), {
					Color = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme].Accent,
					Transparency = 0.5,
				}):Play()
			end)
			Input.FocusLost:Connect(function()
				TweenService:Create(SearchStroke, TweenInfo.new(0.2), {
					Color = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme].Stroke,
					Transparency = 0.85,
				}):Play()
			end)
 
			-- [FIX] React on every keystroke (GetPropertyChangedSignal), not just FocusLost,
			-- so filtering feels instant instead of only firing once the box loses focus.
			Input:GetPropertyChangedSignal("Text"):Connect(function()
				ClearBtn.Visible = Input.Text ~= ""
				CallbackFunc(Input.Text)
			end)
 
			ClearBtn.MouseButton1Click:Connect(function()
				Input.Text = ""
				Input:CaptureFocus()
			end)
 
			local SearchBar = {}
			function SearchBar:Set(text)
				Input.Text = text or ""
			end
			function SearchBar:Get()
				return Input.Text
			end
			return SearchBar
		end
 
		function Tab:CreateThemeDropdown(DropdownName)
			local Expanded = false
 
			local DropdownContainer = Instance.new("Frame", Page)
			DropdownContainer.Size = UDim2.new(1, 0, 0, 36)
			DropdownContainer.BackgroundTransparency = 0.55
			DropdownContainer.ClipsDescendants = true
			Instance.new("UICorner", DropdownContainer).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(DropdownContainer, "BackgroundColor3", "ToggleBtnBg")
 
			local ContainerStroke = Instance.new("UIStroke", DropdownContainer)
			ContainerStroke.Thickness = 1
			ContainerStroke.Transparency = 0.85
			ContainerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			punishgoatby97mzu:ApplyThemeObj(ContainerStroke, "Color", "Stroke")
 
			local Header = Instance.new("TextButton", DropdownContainer)
			Header.Size = UDim2.new(1, 0, 0, 36)
			Header.BackgroundTransparency = 1
			Header.AutoButtonColor = false
			Header.Text = ""
 
			local Title = Instance.new("TextLabel", Header)
			Title.Size = UDim2.new(1, -60, 1, 0)
			Title.Position = UDim2.new(0, 15, 0, 0)
			Title.BackgroundTransparency = 1
			Title.Text = DropdownName or "Select Theme"
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			local Arrow = Instance.new("ImageLabel", Header)
			Arrow.Size = UDim2.new(0, 16, 0, 16)
			Arrow.AnchorPoint = Vector2.new(1, 0.5)
			Arrow.Position = UDim2.new(1, -15, 0.5, 0)
			Arrow.BackgroundTransparency = 1
			Arrow.Image = "rbxassetid://10709790948"
			punishgoatby97mzu:ApplyThemeObj(Arrow, "ImageColor3", "TextInactive")
 
			local ContentArea = Instance.new("Frame", DropdownContainer)
			ContentArea.Size = UDim2.new(1, 0, 0, 0)
			ContentArea.Position = UDim2.new(0, 0, 0, 36)
			ContentArea.BackgroundTransparency = 1
 
			local ContentPadding = Instance.new("UIPadding", ContentArea)
			ContentPadding.PaddingTop = UDim.new(0, 8)
			ContentPadding.PaddingBottom = UDim.new(0, 12)
			ContentPadding.PaddingLeft = UDim.new(0, 12)
			ContentPadding.PaddingRight = UDim.new(0, 12)
 
			local ContentLayout = Instance.new("UIListLayout", ContentArea)
			ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ContentLayout.Padding = UDim.new(0, 4)
 
			local function ToggleDropdown()
				Expanded = not Expanded
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
 
				if Expanded then
					local TargetHeight = 36 + 20 + ContentLayout.AbsoluteContentSize.Y
					TweenService:Create(
						DropdownContainer,
						TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
						{ Size = UDim2.new(1, 0, 0, TargetHeight) }
					):Play()
					TweenService
						:Create(ContainerStroke, TweenInfo.new(0.3), { Color = palette.Accent, Transparency = 0.5 })
						:Play()
					TweenService:Create(Arrow, TweenInfo.new(0.3), { ImageColor3 = palette.Accent, Rotation = 180 })
						:Play()
					TweenService:Create(Title, TweenInfo.new(0.3), { TextColor3 = palette.Accent }):Play()
				else
					TweenService:Create(
						DropdownContainer,
						TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
						{ Size = UDim2.new(1, 0, 0, 36) }
					):Play()
					TweenService
						:Create(ContainerStroke, TweenInfo.new(0.3), { Color = palette.Stroke, Transparency = 0.85 })
						:Play()
					TweenService:Create(Arrow, TweenInfo.new(0.3), { ImageColor3 = palette.TextInactive, Rotation = 0 })
						:Play()
					TweenService:Create(Title, TweenInfo.new(0.3), { TextColor3 = palette.Text }):Play()
				end
			end
 
			Header.MouseButton1Click:Connect(ToggleDropdown)
 
			local ThemeOrder =
				{ "Dark", "Light", "Ocean", "Cyberpunk", "Matcha", "Silver", "White", "Platinum", "Crimson", "Gold" }
			for _, tName in ipairs(ThemeOrder) do
				local tBtn = Instance.new("TextButton", ContentArea)
				tBtn.Size = UDim2.new(1, 0, 0, 30)
				tBtn.BackgroundTransparency = 1
				tBtn.Text = tName
				tBtn.Font = Enum.Font.GothamMedium
				tBtn.TextSize = 12
				tBtn.AutoButtonColor = false
				Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 4)
				punishgoatby97mzu:ApplyThemeObj(tBtn, "BackgroundColor3", "ToggleBgOff")
				punishgoatby97mzu:ApplyThemeObj(tBtn, "TextColor3", "TextInactive")
 
				tBtn.MouseEnter:Connect(function()
					TweenService:Create(tBtn, TweenInfo.new(0.2), { BackgroundTransparency = 0 }):Play()
				end)
				tBtn.MouseLeave:Connect(function()
					TweenService:Create(tBtn, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
				end)
 
				tBtn.MouseButton1Click:Connect(function()
					punishgoatby97mzu:ChangeTheme(tName)
 
					for _, tabData in pairs(Window.Tabs) do
						if tabData.Page.Visible then
							local palette = punishgoatby97mzu.Themes[tName]
							TweenService:Create(tabData.Icon, TweenInfo.new(0.3), { ImageColor3 = palette.Accent })
								:Play()
							TweenService:Create(tabData.TitleLabel, TweenInfo.new(0.3), { TextColor3 = palette.Text })
								:Play()
						end
					end
 
					ToggleDropdown()
				end)
			end
		end
 
		function Tab:CreateChangelog(TitleText, ContentText)
			local Expanded = false
 
			local LogContainer = Instance.new("TextButton", Page)
			LogContainer.Size = UDim2.new(1, 0, 0, 36)
			LogContainer.BackgroundTransparency = 0.55
			LogContainer.AutoButtonColor = false
			LogContainer.Text = ""
			LogContainer.ClipsDescendants = true
			Instance.new("UICorner", LogContainer).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(LogContainer, "BackgroundColor3", "ToggleBtnBg")
 
			local LogStroke = Instance.new("UIStroke", LogContainer)
			LogStroke.Thickness = 1
			LogStroke.Transparency = 0.85
			LogStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			punishgoatby97mzu:ApplyThemeObj(LogStroke, "Color", "Stroke")
 
			local Header = Instance.new("Frame", LogContainer)
			Header.Size = UDim2.new(1, 0, 0, 36)
			Header.BackgroundTransparency = 1
 
			local Title = Instance.new("TextLabel", Header)
			Title.Size = UDim2.new(1, -40, 1, 0)
			Title.Position = UDim2.new(0, 15, 0, 0)
			Title.BackgroundTransparency = 1
			Title.Text = TitleText
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			local Arrow = Instance.new("ImageLabel", Header)
			Arrow.Size = UDim2.new(0, 16, 0, 16)
			Arrow.AnchorPoint = Vector2.new(1, 0.5)
			Arrow.Position = UDim2.new(1, -15, 0.5, 0)
			Arrow.BackgroundTransparency = 1
			Arrow.Image = "rbxassetid://10709790948"
			punishgoatby97mzu:ApplyThemeObj(Arrow, "ImageColor3", "TextInactive")
 
			local ContentArea = Instance.new("Frame", LogContainer)
			ContentArea.Size = UDim2.new(1, 0, 0, 0)
			ContentArea.Position = UDim2.new(0, 0, 0, 36)
			ContentArea.BackgroundTransparency = 1
 
			local ContentPadding = Instance.new("UIPadding", ContentArea)
			ContentPadding.PaddingTop = UDim.new(0, 5)
			ContentPadding.PaddingBottom = UDim.new(0, 10)
			ContentPadding.PaddingLeft = UDim.new(0, 15)
			ContentPadding.PaddingRight = UDim.new(0, 15)
 
			local ContentLayout = Instance.new("UIListLayout", ContentArea)
			ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ContentLayout.Padding = UDim.new(0, 6)
 
			local lines = {}
			for s in string.gmatch(ContentText, "[^\r\n]+") do
				table.insert(lines, s)
			end
 
			for _, lineText in ipairs(lines) do
				local LogCard = Instance.new("Frame", ContentArea)
				LogCard.Size = UDim2.new(1, 0, 0, 26)
				LogCard.BackgroundTransparency = 0.5
				Instance.new("UICorner", LogCard).CornerRadius = UDim.new(0, 4)
				punishgoatby97mzu:ApplyThemeObj(LogCard, "BackgroundColor3", "ToggleBgOff")
 
				local CardStroke = Instance.new("UIStroke", LogCard)
				CardStroke.Thickness = 1
				CardStroke.Transparency = 0.8
				punishgoatby97mzu:ApplyThemeObj(CardStroke, "Color", "Stroke")
 
				local LogLineText = Instance.new("TextLabel", LogCard)
				LogLineText.Size = UDim2.new(1, -20, 1, 0)
				LogLineText.Position = UDim2.new(0, 10, 0, 0)
				LogLineText.BackgroundTransparency = 1
				LogLineText.Text = lineText
				LogLineText.Font = Enum.Font.GothamMedium
				LogLineText.TextSize = 11
				LogLineText.TextXAlignment = Enum.TextXAlignment.Left
				punishgoatby97mzu:ApplyThemeObj(LogLineText, "TextColor3", "TextInactive")
			end
 
			local function ToggleLog()
				Expanded = not Expanded
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
 
				if Expanded then
					local TargetHeight = 36 + 15 + ContentLayout.AbsoluteContentSize.Y
					TweenService:Create(
						LogContainer,
						TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
						{ Size = UDim2.new(1, 0, 0, TargetHeight) }
					):Play()
					TweenService:Create(Arrow, TweenInfo.new(0.3), { Rotation = 180, ImageColor3 = palette.Accent })
						:Play()
					TweenService:Create(LogStroke, TweenInfo.new(0.3), { Color = palette.Accent, Transparency = 0.5 })
						:Play()
				else
					TweenService:Create(
						LogContainer,
						TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
						{ Size = UDim2.new(1, 0, 0, 36) }
					):Play()
					TweenService:Create(Arrow, TweenInfo.new(0.3), { Rotation = 0, ImageColor3 = palette.TextInactive })
						:Play()
					TweenService:Create(LogStroke, TweenInfo.new(0.3), { Color = palette.Stroke, Transparency = 0.85 })
						:Play()
				end
			end
 
			LogContainer.MouseButton1Click:Connect(ToggleLog)
			ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if Expanded then
					local TargetHeight = 36 + 15 + ContentLayout.AbsoluteContentSize.Y
					TweenService:Create(
						LogContainer,
						TweenInfo.new(0.2, Enum.EasingStyle.Sine),
						{ Size = UDim2.new(1, 0, 0, TargetHeight) }
					):Play()
				end
			end)
		end
 
		function Tab:CreateToggle(ToggleName, Description, Default, Callback)
			local State = Default or false
			local CallbackFunc = Callback or function() end
			local HasDesc = type(Description) == "string" and Description ~= ""
 
			local ToggleBtn = Instance.new("TextButton", Page)
			ToggleBtn.Active = false
			ToggleBtn.Size = UDim2.new(1, 0, 0, HasDesc and 52 or 36)
			ToggleBtn.AutoButtonColor = false
			ToggleBtn.Text = ""
			ToggleBtn.BackgroundTransparency = 0.2
			Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(ToggleBtn, "BackgroundColor3", "ToggleBtnBg")
 
			local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
			ToggleStroke.Thickness = 1
			ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
 
			ToggleStroke.Color = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme].Stroke
			ToggleStroke.Transparency = 0.85
 
			local function UpdateStrokeVisual(isActive, themeName)
				local palette = punishgoatby97mzu.Themes[themeName or punishgoatby97mzu.CurrentTheme]
				if isActive then
					TweenService:Create(
						ToggleStroke,
						TweenInfo.new(0.3, Enum.EasingStyle.Quint),
						{ Color = palette.Accent, Transparency = 0.85 }
					):Play()
				else
					TweenService:Create(
						ToggleStroke,
						TweenInfo.new(0.3, Enum.EasingStyle.Quint),
						{ Color = palette.Stroke, Transparency = 0.88 }
					):Play()
				end
			end
 
			UpdateStrokeVisual(State, punishgoatby97mzu.CurrentTheme)
			table.insert(punishgoatby97mzu.ThemeChangedHooks, {
				Inst = ToggleBtn,
				Func = function(tName)
					UpdateStrokeVisual(State, tName)
				end,
			})
 
			local Title = Instance.new("TextLabel", ToggleBtn)
			Title.Size = UDim2.new(1, -60, 0, 16)
			Title.Position = UDim2.new(0, 15, 0, HasDesc and 10 or 10)
			if not HasDesc then
				Title.Size = UDim2.new(1, -60, 1, 0)
				Title.Position = UDim2.new(0, 15, 0, 0)
			end
			Title.BackgroundTransparency = 1
			Title.Text = ToggleName
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			if HasDesc then
				local DescLabel = Instance.new("TextLabel", ToggleBtn)
				DescLabel.Size = UDim2.new(1, -60, 0, 14)
				DescLabel.Position = UDim2.new(0, 15, 0, 26)
				DescLabel.BackgroundTransparency = 1
				DescLabel.Text = Description
				DescLabel.Font = Enum.Font.Gotham
				DescLabel.TextSize = 11
				DescLabel.TextXAlignment = Enum.TextXAlignment.Left
				punishgoatby97mzu:ApplyThemeObj(DescLabel, "TextColor3", "TextInactive")
			end
 
			local SwitchBg = Instance.new("Frame", ToggleBtn)
			SwitchBg.Size = UDim2.new(0, 36, 0, 18)
			SwitchBg.AnchorPoint = Vector2.new(1, 0.5)
			SwitchBg.Position = UDim2.new(1, -15, 0.5, 0)
			Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)
			punishgoatby97mzu:ApplyThemeObj(SwitchBg, "BackgroundColor3", State and "Accent" or "ToggleBgOff")
 
			local Dot = Instance.new("Frame", SwitchBg)
			Dot.Size = UDim2.new(0, 14, 0, 14)
			Dot.AnchorPoint = Vector2.new(0, 0.5)
			Dot.Position = UDim2.new(0, State and 20 or 2, 0.5, 0)
			Dot.ZIndex = 2
			Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)
			punishgoatby97mzu:ApplyThemeObj(Dot, "BackgroundColor3", "ToggleDot")
 
			ToggleBtn.MouseButton1Click:Connect(function()
				State = not State
				CallbackFunc(State)
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
 
				UpdateStrokeVisual(State)
 
				if State then
					TweenService
						:Create(
							Dot,
							TweenInfo.new(0.3, Enum.EasingStyle.Quint),
							{ Position = UDim2.new(0, 20, 0.5, 0) }
						)
						:Play()
					TweenService
						:Create(
							SwitchBg,
							TweenInfo.new(0.3, Enum.EasingStyle.Quint),
							{ BackgroundColor3 = palette.Accent }
						)
						:Play()
				else
					TweenService
						:Create(Dot, TweenInfo.new(0.3, Enum.EasingStyle.Quint), { Position = UDim2.new(0, 2, 0.5, 0) })
						:Play()
					TweenService:Create(
						SwitchBg,
						TweenInfo.new(0.3, Enum.EasingStyle.Quint),
						{ BackgroundColor3 = palette.ToggleBgOff }
					):Play()
				end
 
				for _, obj in pairs(punishgoatby97mzu.Instances) do
					if obj.Inst == SwitchBg then
						obj.Type = State and "Accent" or "ToggleBgOff"
					end
				end
			end)
		end
 
		function Tab:CreateButton(ButtonName, Description, IconID, Callback)
			local CallbackFunc = Callback or function() end
			local HasDesc = type(Description) == "string" and Description ~= ""
 
			local ButtonContainer = Instance.new("TextButton", Page)
			ButtonContainer.Active = false -- 🔥 TAMBAHKAN BARIS INI
			ButtonContainer.Size = UDim2.new(1, 0, 0, HasDesc and 52 or 36)
			ButtonContainer.BackgroundTransparency = 0.55
			ButtonContainer.AutoButtonColor = false
			ButtonContainer.Text = ""
			Instance.new("UICorner", ButtonContainer).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(ButtonContainer, "BackgroundColor3", "ToggleBtnBg")
 
			local BtnStroke = Instance.new("UIStroke", ButtonContainer)
			BtnStroke.Thickness = 1
			BtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			BtnStroke.Color = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme].Stroke
			BtnStroke.Transparency = 0.85
 
			local function UpdateBtnStrokeVisual(isActive, themeName)
				local palette = punishgoatby97mzu.Themes[themeName or punishgoatby97mzu.CurrentTheme]
				if isActive then
					TweenService:Create(
						BtnStroke,
						TweenInfo.new(0.3, Enum.EasingStyle.Quint),
						{ Color = palette.Accent, Transparency = 0.5 }
					):Play()
				else
					TweenService:Create(
						BtnStroke,
						TweenInfo.new(0.5, Enum.EasingStyle.Sine),
						{ Color = palette.Stroke, Transparency = 0.85 }
					):Play()
				end
			end
 
			UpdateBtnStrokeVisual(false, punishgoatby97mzu.CurrentTheme)
			table.insert(punishgoatby97mzu.ThemeChangedHooks, {
				Inst = ButtonContainer,
				Func = function(tName)
					UpdateBtnStrokeVisual(false, tName)
				end,
			})
 
			local Title = Instance.new("TextLabel", ButtonContainer)
			Title.Size = UDim2.new(1, -60, 0, 16)
			Title.Position = UDim2.new(0, 15, 0, HasDesc and 10 or 10)
			if not HasDesc then
				Title.Size = UDim2.new(1, -60, 1, 0)
				Title.Position = UDim2.new(0, 15, 0, 0)
			end
			Title.BackgroundTransparency = 1
			Title.Text = ButtonName
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			if HasDesc then
				local DescLabel = Instance.new("TextLabel", ButtonContainer)
				DescLabel.Size = UDim2.new(1, -60, 0, 14)
				DescLabel.Position = UDim2.new(0, 15, 0, 26)
				DescLabel.BackgroundTransparency = 1
				DescLabel.Text = Description
				DescLabel.Font = Enum.Font.Gotham
				DescLabel.TextSize = 11
				DescLabel.TextXAlignment = Enum.TextXAlignment.Left
				punishgoatby97mzu:ApplyThemeObj(DescLabel, "TextColor3", "TextInactive")
			end
 
			local ActionKey = Instance.new("Frame", ButtonContainer)
			ActionKey.Size = UDim2.new(0, 30, 0, 30)
			ActionKey.AnchorPoint = Vector2.new(1, 0.5)
			ActionKey.Position = UDim2.new(1, -3, 0.5, 0)
			Instance.new("UICorner", ActionKey).CornerRadius = UDim.new(0, 6)
			punishgoatby97mzu:ApplyThemeObj(ActionKey, "BackgroundColor3", "ToggleBgOff")
 
			local KeyStroke = Instance.new("UIStroke", ActionKey)
			KeyStroke.Thickness = 1
			KeyStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			KeyStroke.Color = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme].Stroke
			KeyStroke.Transparency = 0.7
 
			local Icon = Instance.new("ImageLabel", ActionKey)
			Icon.Size = UDim2.new(0, 18, 0, 18)
			Icon.AnchorPoint = Vector2.new(0.5, 0.5)
			Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
			Icon.BackgroundTransparency = 1
			Icon.Image = IconID or "rbxassetid://10734933056"
			punishgoatby97mzu:ApplyThemeObj(Icon, "ImageColor3", "TextInactive")
 
			ButtonContainer.MouseEnter:Connect(function()
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				TweenService:Create(ActionKey, TweenInfo.new(0.2), {
					BackgroundColor3 = Color3.fromRGB(
						math.clamp(palette.ToggleBgOff.R * 255 + 12, 0, 255),
						math.clamp(palette.ToggleBgOff.G * 255 + 12, 0, 255),
						math.clamp(palette.ToggleBgOff.B * 255 + 12, 0, 255)
					),
				}):Play()
				TweenService:Create(KeyStroke, TweenInfo.new(0.2), { Color = palette.Accent, Transparency = 0.4 })
					:Play()
				TweenService:Create(Icon, TweenInfo.new(0.2), { ImageColor3 = palette.Text }):Play()
			end)
 
			ButtonContainer.MouseLeave:Connect(function()
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				TweenService:Create(ActionKey, TweenInfo.new(0.2), { BackgroundColor3 = palette.ToggleBgOff }):Play()
				TweenService:Create(KeyStroke, TweenInfo.new(0.2), { Color = palette.Stroke, Transparency = 0.7 })
					:Play()
				TweenService:Create(Icon, TweenInfo.new(0.2), { ImageColor3 = palette.TextInactive }):Play()
			end)
 
			ButtonContainer.MouseButton1Click:Connect(function()
				CallbackFunc()
			end)
 
			ButtonContainer.MouseButton1Down:Connect(function()
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				TweenService
					:Create(ActionKey, TweenInfo.new(0.05, Enum.EasingStyle.Sine), { Size = UDim2.new(0, 26, 0, 26) })
					:Play()
				TweenService:Create(
					Icon,
					TweenInfo.new(0.05, Enum.EasingStyle.Sine),
					{ Size = UDim2.new(0, 14, 0, 14), ImageColor3 = palette.Accent }
				):Play()
				TweenService:Create(
					KeyStroke,
					TweenInfo.new(0.05, Enum.EasingStyle.Sine),
					{ Color = palette.Accent, Transparency = 0.2 }
				):Play()
				UpdateBtnStrokeVisual(true)
			end)
 
			local function ResetButtonAnim()
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				TweenService:Create(
					ActionKey,
					TweenInfo.new(0.3, Enum.EasingStyle.Bounce),
					{ Size = UDim2.new(0, 30, 0, 30), BackgroundColor3 = palette.ToggleBgOff }
				):Play()
				TweenService:Create(
					Icon,
					TweenInfo.new(0.3, Enum.EasingStyle.Bounce),
					{ Size = UDim2.new(0, 18, 0, 18), ImageColor3 = palette.TextInactive }
				):Play()
				TweenService:Create(
					KeyStroke,
					TweenInfo.new(0.3, Enum.EasingStyle.Sine),
					{ Color = palette.Stroke, Transparency = 0.7 }
				):Play()
				UpdateBtnStrokeVisual(false)
			end
 
			ButtonContainer.MouseButton1Up:Connect(ResetButtonAnim)
		end
 
		function Tab:CreateSlider(SliderName, Min, Max, Default, Callback)
			local CallbackFunc = Callback or function() end
			local Value = math.clamp(Default or Min, Min, Max)
 
			local SliderContainer = Instance.new("TextButton", Page)
			SliderContainer.Active = false
			SliderContainer.Size = UDim2.new(1, 0, 0, 42)
			SliderContainer.BackgroundTransparency = 0.55
			SliderContainer.AutoButtonColor = false
			SliderContainer.Text = ""
			Instance.new("UICorner", SliderContainer).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(SliderContainer, "BackgroundColor3", "ToggleBtnBg")
 
			local SliderStroke = Instance.new("UIStroke", SliderContainer)
			SliderStroke.Thickness = 1
			SliderStroke.Transparency = 0.85
			SliderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			punishgoatby97mzu:ApplyThemeObj(SliderStroke, "Color", "Stroke")
 
			local Title = Instance.new("TextLabel", SliderContainer)
			Title.Size = UDim2.new(1, -100, 0, 20)
			Title.Position = UDim2.new(0, 15, 0, 5)
			Title.BackgroundTransparency = 1
			Title.Text = SliderName
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			local ValueCard = Instance.new("Frame", SliderContainer)
			ValueCard.Size = UDim2.new(0, 35, 0, 20)
			ValueCard.AnchorPoint = Vector2.new(1, 0)
			ValueCard.Position = UDim2.new(1, -15, 0, 5)
			ValueCard.BackgroundTransparency = 0.5
			ValueCard.BorderSizePixel = 0
			Instance.new("UICorner", ValueCard).CornerRadius = UDim.new(0, 4)
			punishgoatby97mzu:ApplyThemeObj(ValueCard, "BackgroundColor3", "ToggleBgOff")
 
			local CardStroke = Instance.new("UIStroke", ValueCard)
			CardStroke.Thickness = 1
			CardStroke.Transparency = 0.8
			punishgoatby97mzu:ApplyThemeObj(CardStroke, "Color", "Stroke")
 
			local ValueInput = Instance.new("TextBox", ValueCard)
			ValueInput.Size = UDim2.new(1, 0, 1, 0)
			ValueInput.BackgroundTransparency = 1
			ValueInput.Text = tostring(Value)
			ValueInput.Font = Enum.Font.GothamMedium
			ValueInput.TextSize = 12
			ValueInput.ClearTextOnFocus = false
			punishgoatby97mzu:ApplyThemeObj(ValueInput, "TextColor3", "Text")
 
			local SliderBg = Instance.new("Frame", SliderContainer)
			SliderBg.Size = UDim2.new(1, -30, 0, 4)
			SliderBg.AnchorPoint = Vector2.new(0.5, 1)
			SliderBg.Position = UDim2.new(0.5, 0, 1, -8)
			SliderBg.BorderSizePixel = 0
			Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)
			punishgoatby97mzu:ApplyThemeObj(SliderBg, "BackgroundColor3", "ToggleBgOff")
 
			local SliderFill = Instance.new("Frame", SliderBg)
			local SizeScale = (Value - Min) / (Max - Min)
			SliderFill.Size = UDim2.new(SizeScale, 0, 1, 0)
			SliderFill.BorderSizePixel = 0
			Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)
			punishgoatby97mzu:ApplyThemeObj(SliderFill, "BackgroundColor3", "Accent")
 
			local Dot = Instance.new("Frame", SliderFill)
			Dot.Size = UDim2.new(0, 12, 0, 12)
			Dot.AnchorPoint = Vector2.new(1, 0.5)
			Dot.Position = UDim2.new(1, 6, 0.5, 0)
			Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)
			punishgoatby97mzu:ApplyThemeObj(Dot, "BackgroundColor3", "ToggleDot")
 
			local DotStroke = Instance.new("UIStroke", Dot)
			DotStroke.Thickness = 1
			punishgoatby97mzu:ApplyThemeObj(DotStroke, "Color", "Stroke")
 
			local Dragging = false
			local function UpdateSlider(Input)
				local Percent =
					math.clamp((Input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
				Value = math.floor(Min + ((Max - Min) * Percent))
				ValueInput.Text = tostring(Value)
				TweenService
					:Create(
						SliderFill,
						TweenInfo.new(0.05, Enum.EasingStyle.Sine),
						{ Size = UDim2.new(Percent, 0, 1, 0) }
					)
					:Play()
				CallbackFunc(Value)
			end
 
			SliderContainer.InputBegan:Connect(function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					Dragging = true
					UpdateSlider(Input)
					TweenService
						:Create(Dot, TweenInfo.new(0.2, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 16, 0, 16) })
						:Play()
				end
			end)
 
			UserInputService.InputChanged:Connect(function(Input)
				if
					Dragging
					and (
						Input.UserInputType == Enum.UserInputType.MouseMovement
						or Input.UserInputType == Enum.UserInputType.Touch
					)
				then
					UpdateSlider(Input)
				end
			end)
 
			UserInputService.InputEnded:Connect(function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					if Dragging then
						Dragging = false
						TweenService
							:Create(Dot, TweenInfo.new(0.2, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 12, 0, 12) })
							:Play()
					end
				end
			end)
 
			SliderContainer.MouseEnter:Connect(function()
				if not Dragging then
					TweenService
						:Create(Dot, TweenInfo.new(0.2, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 16, 0, 16) })
						:Play()
				end
			end)
			SliderContainer.MouseLeave:Connect(function()
				if not Dragging then
					TweenService
						:Create(Dot, TweenInfo.new(0.2, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 12, 0, 12) })
						:Play()
				end
			end)
 
			ValueInput.FocusLost:Connect(function()
				local Num = tonumber(ValueInput.Text)
				if Num then
					Value = math.clamp(math.floor(Num), Min, Max)
					local NewScale = (Value - Min) / (Max - Min)
					TweenService:Create(
						SliderFill,
						TweenInfo.new(0.3, Enum.EasingStyle.Quint),
						{ Size = UDim2.new(NewScale, 0, 1, 0) }
					):Play()
					CallbackFunc(Value)
				end
				ValueInput.Text = tostring(Value)
			end)
		end
 
function Tab:CreateImageParagraph(Title, Desc, Image)
    local Container = Instance.new("Frame", Page)
    Container.Size = UDim2.new(1, 0, 0, 0)
    Container.AutomaticSize = Enum.AutomaticSize.Y
    Container.BackgroundTransparency = 0.55
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)
    punishgoatby97mzu:ApplyThemeObj(Container, "BackgroundColor3", "ToggleBtnBg")

    local Stroke = Instance.new("UIStroke", Container)
    Stroke.Thickness = 1
    Stroke.Transparency = 0.85
    punishgoatby97mzu:ApplyThemeObj(Stroke, "Color", "Stroke")

    local Padding = Instance.new("UIPadding", Container)
    Padding.PaddingTop = UDim.new(0, 10)
    Padding.PaddingBottom = UDim.new(0, 10)
    Padding.PaddingLeft = UDim.new(0, 12)
    Padding.PaddingRight = UDim.new(0, 12)

    local Top = Instance.new("Frame", Container)
    Top.Size = UDim2.new(1, 0, 0, 40)
    Top.BackgroundTransparency = 1

    local ImageLabel = Instance.new("ImageLabel", Top)
    ImageLabel.Size = UDim2.new(0, 36, 0, 36)
    ImageLabel.Position = UDim2.new(0, 0, 0.5, -16)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = Image or ""

    local Corner = Instance.new("UICorner", ImageLabel)
    Corner.CornerRadius = UDim.new(0, 5)

    local TitleLbl = Instance.new("TextLabel", Top)
    TitleLbl.Position = UDim2.new(0, 42, 0, 5)
    TitleLbl.Size = UDim2.new(1, -42, 0, 16)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text = Title or ""
    TitleLbl.Font = Enum.Font.GothamBold
    TitleLbl.TextSize = 14
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    TitleLbl.RichText = true
    punishgoatby97mzu:ApplyThemeObj(TitleLbl, "TextColor3", "Text")

    local DescLbl = Instance.new("TextLabel", Top)
    DescLbl.Position = UDim2.new(0, 42, 0, 19)
    DescLbl.Size = UDim2.new(1, -42, 0, 14)
    DescLbl.BackgroundTransparency = 1
    DescLbl.Text = Desc or ""
    DescLbl.Font = Enum.Font.Gotham
    DescLbl.TextSize = 13.4
    DescLbl.TextXAlignment = Enum.TextXAlignment.Left
    DescLbl.RichText = true
    punishgoatby97mzu:ApplyThemeObj(DescLbl, "TextColor3", "TextInactive")

    local Obj = {}

    function Obj:SetTitle(NewTitle)
        TitleLbl.Text = NewTitle
    end

    function Obj:SetDescription(NewDesc)
        DescLbl.Text = NewDesc
    end

    function Obj:SetImage(NewImage)
        ImageLabel.Image = NewImage
    end

    return Obj
end

		function Tab:CreateInput(InputName, Description, Placeholder, ExtraIcon, ExtraCallback, TextCallback)
			if type(ExtraIcon) == "function" then
				TextCallback = ExtraIcon
				ExtraIcon = nil
				ExtraCallback = nil
			end
 
			local CallbackFunc = TextCallback or function() end
			local HasDesc = type(Description) == "string" and Description ~= ""
 
			local InputContainer = Instance.new("TextButton", Page)
			InputContainer.Active = false
			InputContainer.Size = UDim2.new(1, 0, 0, HasDesc and 52 or 36)
			InputContainer.BackgroundTransparency = 0.55
			InputContainer.AutoButtonColor = false
			InputContainer.Text = ""
			Instance.new("UICorner", InputContainer).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(InputContainer, "BackgroundColor3", "ToggleBtnBg")
 
			local InputStroke = Instance.new("UIStroke", InputContainer)
			InputStroke.Thickness = 1
			InputStroke.Transparency = 0.85
			InputStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			punishgoatby97mzu:ApplyThemeObj(InputStroke, "Color", "Stroke")
 
			local Title = Instance.new("TextLabel", InputContainer)
			Title.Size = UDim2.new(1, ExtraIcon and -200 or -170, 0, 16)
			Title.Position = UDim2.new(0, 15, 0, HasDesc and 10 or 10)
			if not HasDesc then
				Title.Size = UDim2.new(1, ExtraIcon and -200 or -170, 1, 0)
				Title.Position = UDim2.new(0, 15, 0, 0)
			end
			Title.BackgroundTransparency = 1
			Title.Text = InputName
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			if HasDesc then
				local DescLabel = Instance.new("TextLabel", InputContainer)
				DescLabel.Size = UDim2.new(1, ExtraIcon and -200 or -170, 0, 14)
				DescLabel.Position = UDim2.new(0, 15, 0, 26)
				DescLabel.BackgroundTransparency = 1
				DescLabel.Text = Description
				DescLabel.Font = Enum.Font.Gotham
				DescLabel.TextSize = 11
				DescLabel.TextXAlignment = Enum.TextXAlignment.Left
				punishgoatby97mzu:ApplyThemeObj(DescLabel, "TextColor3", "TextInactive")
			end
 
			local TextBoxCard = Instance.new("Frame", InputContainer)
			TextBoxCard.Size = UDim2.new(0, ExtraIcon and 180 or 150, 0, 26)
			TextBoxCard.AnchorPoint = Vector2.new(1, 0.5)
			TextBoxCard.Position = UDim2.new(1, -10, 0.5, 0)
			TextBoxCard.BackgroundTransparency = 0.5
			Instance.new("UICorner", TextBoxCard).CornerRadius = UDim.new(0, 6)
			punishgoatby97mzu:ApplyThemeObj(TextBoxCard, "BackgroundColor3", "ToggleBgOff")
 
			local CardStroke = Instance.new("UIStroke", TextBoxCard)
			CardStroke.Thickness = 1
			CardStroke.Transparency = 0.7
			punishgoatby97mzu:ApplyThemeObj(CardStroke, "Color", "Stroke")
 
			local TextBox = Instance.new("TextBox", TextBoxCard)
			TextBox.Size = UDim2.new(1, ExtraIcon and -36 or -16, 1, 0)
			TextBox.Position = UDim2.new(0, 8, 0, 0)
			TextBox.BackgroundTransparency = 1
			TextBox.Text = ""
			TextBox.PlaceholderText = Placeholder or "Type here..."
			TextBox.Font = Enum.Font.GothamMedium
			TextBox.TextSize = 11
			TextBox.TextXAlignment = Enum.TextXAlignment.Left
			TextBox.ClearTextOnFocus = false
			TextBox.ClipsDescendants = true
			punishgoatby97mzu:ApplyThemeObj(TextBox, "TextColor3", "Text")
			punishgoatby97mzu:ApplyThemeObj(TextBox, "PlaceholderColor3", "TextInactive")
 
			TextBox.Focused:Connect(function()
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				TweenService:Create(CardStroke, TweenInfo.new(0.3), { Color = palette.Accent, Transparency = 0.3 })
					:Play()
			end)
 
			TextBox.FocusLost:Connect(function()
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				TweenService:Create(CardStroke, TweenInfo.new(0.3), { Color = palette.Stroke, Transparency = 0.7 })
					:Play()
				CallbackFunc(TextBox.Text)
			end)
			-- [FIX FOCUSLOST BUG] Save instantly so the value registers even before pressing Enter!
			TextBox:GetPropertyChangedSignal("Text"):Connect(function()
				CallbackFunc(TextBox.Text)
			end)
			-- Detect text changes instantly (real-time) on paste, without needing to press Enter
			TextBox:GetPropertyChangedSignal("Text"):Connect(function()
				CallbackFunc(TextBox.Text)
			end)
 
			if ExtraIcon then
				local ExtraBtn = Instance.new("ImageButton", TextBoxCard)
				ExtraBtn.Size = UDim2.new(0, 20, 0, 20)
				ExtraBtn.Position = UDim2.new(1, -4, 0.5, 0)
				ExtraBtn.AnchorPoint = Vector2.new(1, 0.5)
				ExtraBtn.BackgroundTransparency = 1
				ExtraBtn.Image = ExtraIcon
				punishgoatby97mzu:ApplyThemeObj(ExtraBtn, "ImageColor3", "Accent")
 
				ExtraBtn.MouseButton1Click:Connect(function()
					TweenService:Create(ExtraBtn, TweenInfo.new(0.1), { Size = UDim2.new(0, 16, 0, 16) }):Play()
					task.wait(0.1)
					TweenService:Create(ExtraBtn, TweenInfo.new(0.1), { Size = UDim2.new(0, 20, 0, 20) }):Play()
					if ExtraCallback then
						ExtraCallback(TextBox.Text)
					end
				end)
			end
		end
 
		function Tab:CreateDropdown(DropdownName)
			local Expanded = false
 
			local DropdownContainer = Instance.new("Frame", Page)
			DropdownContainer.Name = "Dropdown_" .. DropdownName
			DropdownContainer.Size = UDim2.new(1, 0, 0, 36)
			DropdownContainer.BackgroundTransparency = 0.55
			DropdownContainer.ClipsDescendants = true
			Instance.new("UICorner", DropdownContainer).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(DropdownContainer, "BackgroundColor3", "ToggleBtnBg")
 
			local ContainerStroke = Instance.new("UIStroke", DropdownContainer)
			ContainerStroke.Thickness = 1
			ContainerStroke.Transparency = 0.85
			ContainerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			punishgoatby97mzu:ApplyThemeObj(ContainerStroke, "Color", "Stroke")
 
			local Header = Instance.new("TextButton", DropdownContainer)
			Header.Active = false
			Header.Size = UDim2.new(1, 0, 0, 36)
			Header.BackgroundTransparency = 1
			Header.AutoButtonColor = false
			Header.Text = ""
 
			local Title = Instance.new("TextLabel", Header)
			Title.Size = UDim2.new(1, -60, 1, 0)
			Title.Position = UDim2.new(0, 15, 0, 0)
			Title.BackgroundTransparency = 1
			Title.Text = DropdownName
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			local Arrow = Instance.new("ImageLabel", Header)
			Arrow.Size = UDim2.new(0, 16, 0, 16)
			Arrow.AnchorPoint = Vector2.new(1, 0.5)
			Arrow.Position = UDim2.new(1, -15, 0.5, 0)
			Arrow.BackgroundTransparency = 1
			Arrow.Image = "rbxassetid://10709791523"
			punishgoatby97mzu:ApplyThemeObj(Arrow, "ImageColor3", "TextInactive")
 
			local ContentArea = Instance.new("Frame", DropdownContainer)
			ContentArea.Size = UDim2.new(1, 0, 0, 0)
			ContentArea.Position = UDim2.new(0, 0, 0, 36)
			ContentArea.BackgroundTransparency = 1
 
			local ContentPadding = Instance.new("UIPadding", ContentArea)
			ContentPadding.PaddingTop = UDim.new(0, 8)
			ContentPadding.PaddingBottom = UDim.new(0, 2)
			ContentPadding.PaddingLeft = UDim.new(0, 12)
			ContentPadding.PaddingRight = UDim.new(0, 12)
 
			local ContentLayout = Instance.new("UIListLayout", ContentArea)
			ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ContentLayout.Padding = UDim.new(0, 6)
 
			local function ToggleDropdown()
				Expanded = not Expanded
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
 
				if Expanded then
					local TargetHeight = 36 + 16 + ContentLayout.AbsoluteContentSize.Y
					TweenService:Create(
						DropdownContainer,
						TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
						{ Size = UDim2.new(1, 0, 0, TargetHeight) }
					):Play()
					TweenService
						:Create(ContainerStroke, TweenInfo.new(0.3), { Color = palette.Accent, Transparency = 0.5 })
						:Play()
					TweenService:Create(Arrow, TweenInfo.new(0.3), { ImageColor3 = palette.Accent, Rotation = 180 })
						:Play()
					TweenService:Create(Title, TweenInfo.new(0.3), { TextColor3 = palette.Accent }):Play()
				else
					TweenService:Create(
						DropdownContainer,
						TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
						{ Size = UDim2.new(1, 0, 0, 36) }
					):Play()
					TweenService
						:Create(ContainerStroke, TweenInfo.new(0.3), { Color = palette.Stroke, Transparency = 0.85 })
						:Play()
					TweenService:Create(Arrow, TweenInfo.new(0.3), { ImageColor3 = palette.TextInactive, Rotation = 0 })
						:Play()
					TweenService:Create(Title, TweenInfo.new(0.3), { TextColor3 = palette.Text }):Play()
				end
			end
 
			Header.MouseButton1Click:Connect(ToggleDropdown)
 
			local function ForceCloseDropdown()
				if Expanded then
					Expanded = false
					local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
					TweenService:Create(DropdownContainer, TweenInfo.new(0.2), { Size = UDim2.new(1, 0, 0, 36) }):Play()
					TweenService
						:Create(ContainerStroke, TweenInfo.new(0.2), { Color = palette.Stroke, Transparency = 0.85 })
						:Play()
					TweenService:Create(Arrow, TweenInfo.new(0.2), { ImageColor3 = palette.TextInactive, Rotation = 0 })
						:Play()
					TweenService:Create(Title, TweenInfo.new(0.2), { TextColor3 = palette.Text }):Play()
				end
			end
			table.insert(Window.DropdownCloseFuncs, ForceCloseDropdown)
 
			ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if Expanded then
					local TargetHeight = 36 + 16 + ContentLayout.AbsoluteContentSize.Y
					TweenService:Create(
						DropdownContainer,
						TweenInfo.new(0.2, Enum.EasingStyle.Sine),
						{ Size = UDim2.new(1, 0, 0, TargetHeight) }
					):Play()
				end
			end)
 
			local DropdownObj = {}
			function DropdownObj:CreateToggle(...)
				local oldPage = Page
				Page = ContentArea
				Tab.CreateToggle(Tab, ...)
				Page = oldPage
			end
			function DropdownObj:CreateButton(...)
				local oldPage = Page
				Page = ContentArea
				Tab.CreateButton(Tab, ...)
				Page = oldPage
			end
			function DropdownObj:CreateSlider(...)
				local oldPage = Page
				Page = ContentArea
				Tab.CreateSlider(Tab, ...)
				Page = oldPage
			end
			function DropdownObj:CreateInput(...)
				local oldPage = Page
				Page = ContentArea
				Tab.CreateInput(Tab, ...)
				Page = oldPage
			end
			function DropdownObj:CreateSelect(...)
				local oldPage = Page
				Page = ContentArea
				Tab.CreateSelect(Tab, ...)
				Page = oldPage
			end
			return DropdownObj
		end
 
		function Tab:CreateSelect(SelectName, Description, Options, Default, Callback)
			local CallbackFunc = Callback or function() end
			local OptionsList = Options or {}
			local Expanded = false
			local HasDesc = type(Description) == "string" and Description ~= ""
 
			local SelectedItems = {}
			if type(Default) == "table" then
				for _, v in pairs(Default) do
					table.insert(SelectedItems, v)
				end
			elseif type(Default) == "string" and Default ~= "None" and Default ~= "" then
				table.insert(SelectedItems, Default)
			end
 
			local TriggerBtn = Instance.new("TextButton", Page)
			TriggerBtn.Active = false
			TriggerBtn.Size = UDim2.new(1, 0, 0, HasDesc and 52 or 36)
			TriggerBtn.BackgroundTransparency = 0.55
			TriggerBtn.AutoButtonColor = false
			TriggerBtn.Text = ""
			Instance.new("UICorner", TriggerBtn).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(TriggerBtn, "BackgroundColor3", "ToggleBtnBg")
 
			local TriggerStroke = Instance.new("UIStroke", TriggerBtn)
			TriggerStroke.Thickness = 1
			TriggerStroke.Transparency = 0.85
			TriggerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			punishgoatby97mzu:ApplyThemeObj(TriggerStroke, "Color", "Stroke")
 
			local Title = Instance.new("TextLabel", TriggerBtn)
			Title.Size = UDim2.new(0.5, -15, 0, 16)
			Title.Position = UDim2.new(0, 15, 0, HasDesc and 10 or 10)
			if not HasDesc then
				Title.Size = UDim2.new(0.5, -15, 1, 0)
				Title.Position = UDim2.new(0, 15, 0, 0)
			end
			Title.BackgroundTransparency = 1
			Title.Text = SelectName
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			if HasDesc then
				local DescLabel = Instance.new("TextLabel", TriggerBtn)
				DescLabel.Size = UDim2.new(0.5, -15, 0, 14)
				DescLabel.Position = UDim2.new(0, 15, 0, 26)
				DescLabel.BackgroundTransparency = 1
				DescLabel.Text = Description
				DescLabel.Font = Enum.Font.Gotham
				DescLabel.TextSize = 11
				DescLabel.TextXAlignment = Enum.TextXAlignment.Left
				punishgoatby97mzu:ApplyThemeObj(DescLabel, "TextColor3", "TextInactive")
			end
 
			local SelectedText = Instance.new("TextLabel", TriggerBtn)
			SelectedText.Size = UDim2.new(0.5, -35, 1, 0)
			SelectedText.Position = UDim2.new(0.5, 0, 0, 0)
			SelectedText.BackgroundTransparency = 1
			SelectedText.Font = Enum.Font.GothamMedium
			SelectedText.TextSize = 12
			SelectedText.TextXAlignment = Enum.TextXAlignment.Right
			punishgoatby97mzu:ApplyThemeObj(SelectedText, "TextColor3", "TextInactive")
 
			local Arrow = Instance.new("ImageLabel", TriggerBtn)
			Arrow.Size = UDim2.new(0, 16, 0, 16)
			Arrow.AnchorPoint = Vector2.new(1, 0.5)
			Arrow.Position = UDim2.new(1, -15, 0.5, 0)
			Arrow.BackgroundTransparency = 1
			Arrow.Image = "rbxassetid://10709790948"
			punishgoatby97mzu:ApplyThemeObj(Arrow, "ImageColor3", "TextInactive")
 
			local function UpdateTriggerText()
				-- If empty OR only "Any" / "All" is selected, automatically display "--"
				if #SelectedItems == 0 or (#SelectedItems == 1 and (SelectedItems[1] == "Any" or SelectedItems[1] == "All")) then
					SelectedText.Text = "--"
				elseif #SelectedItems == 1 then
					SelectedText.Text = SelectedItems[1]
				else
					SelectedText.Text = tostring(#SelectedItems) .. " Selected"
				end
			end
			UpdateTriggerText()
 
			local ContainerParent = ContentContainer
 
			local CloseArea = Instance.new("TextButton", ContainerParent)
			CloseArea.Size = UDim2.new(1, 0, 1, 0)
			CloseArea.BackgroundTransparency = 1
			CloseArea.Text = ""
			CloseArea.ZIndex = 9
			CloseArea.Visible = false
 
			local SidePanel = Instance.new("Frame", ContainerParent)
			SidePanel.Name = "SidePanel_" .. SelectName
			SidePanel.Size = UDim2.new(0.55, -10, 1, -10)
			SidePanel.Position = UDim2.new(1, 10, 0, 5)
			SidePanel.BackgroundTransparency = 0.05
			SidePanel.ZIndex = 10
			Instance.new("UICorner", SidePanel).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(SidePanel, "BackgroundColor3", "ToggleBgOff")
 
			local PanelStroke = Instance.new("UIStroke", SidePanel)
			PanelStroke.Thickness = 1
			PanelStroke.Transparency = 0.85
			punishgoatby97mzu:ApplyThemeObj(PanelStroke, "Color", "Stroke")
 
			local SearchContainer = Instance.new("Frame", SidePanel)
			SearchContainer.Size = UDim2.new(1, -20, 0, 30)
			SearchContainer.Position = UDim2.new(0, 10, 0, 10)
			SearchContainer.BackgroundTransparency = 0.5
			SearchContainer.ZIndex = 11
			Instance.new("UICorner", SearchContainer).CornerRadius = UDim.new(0, 6)
			punishgoatby97mzu:ApplyThemeObj(SearchContainer, "BackgroundColor3", "ToggleBtnBg")
 
			local SearchStroke = Instance.new("UIStroke", SearchContainer)
			SearchStroke.Thickness = 1
			SearchStroke.Transparency = 0.8
			punishgoatby97mzu:ApplyThemeObj(SearchStroke, "Color", "Stroke")
 
			local SearchIcon = Instance.new("ImageLabel", SearchContainer)
			SearchIcon.Size = UDim2.new(0, 14, 0, 14)
			SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
			SearchIcon.Position = UDim2.new(0, 10, 0.5, 0)
			SearchIcon.BackgroundTransparency = 1
			SearchIcon.Image = "rbxassetid://10709761217"
			SearchIcon.ZIndex = 11
			punishgoatby97mzu:ApplyThemeObj(SearchIcon, "ImageColor3", "TextInactive")
 
			local SearchInput = Instance.new("TextBox", SearchContainer)
			SearchInput.Size = UDim2.new(1, -34, 1, 0)
			SearchInput.Position = UDim2.new(0, 30, 0, 0)
			SearchInput.BackgroundTransparency = 1
			SearchInput.Text = ""
			SearchInput.PlaceholderText = "Search..."
			SearchInput.Font = Enum.Font.GothamMedium
			SearchInput.TextSize = 12
			SearchInput.TextXAlignment = Enum.TextXAlignment.Left
			SearchInput.ZIndex = 11
			SearchInput.ClearTextOnFocus = false
			punishgoatby97mzu:ApplyThemeObj(SearchInput, "TextColor3", "Text")
			punishgoatby97mzu:ApplyThemeObj(SearchInput, "PlaceholderColor3", "TextInactive")
 
			SearchInput.Focused:Connect(function()
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				TweenService:Create(SearchStroke, TweenInfo.new(0.3), { Color = palette.Accent, Transparency = 0.3 })
					:Play()
			end)
 
			SearchInput.FocusLost:Connect(function()
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				TweenService:Create(SearchStroke, TweenInfo.new(0.3), { Color = palette.Stroke, Transparency = 0.8 })
					:Play()
			end)
 
		local ItemList = Instance.new("ScrollingFrame", SidePanel)
		ItemList.Size = UDim2.new(1, 0, 1, -55)
		ItemList.Position = UDim2.new(0, 10, 0, 50)
		ItemList.BackgroundTransparency = 1
		ItemList.BorderSizePixel = 0
		ItemList.ScrollBarThickness = 2
		ItemList.ZIndex = 11
 
		-- Use Roblox's built-in AutomaticCanvasSize so the search list doesn't lag while scrolling
		ItemList.AutomaticCanvasSize = Enum.AutomaticSize.Y
		ItemList.CanvasSize = UDim2.new(0, 0, 0, 0)
		punishgoatby97mzu:ApplyThemeObj(ItemList, "ScrollBarImageColor3", "Stroke")
 
		local ListPadding = Instance.new("UIPadding", ItemList)
		ListPadding.PaddingLeft = UDim.new(0, 1)
		ListPadding.PaddingRight = UDim.new(0, 20)
		ListPadding.PaddingTop = UDim.new(0, 5)
 
		ListPadding.PaddingBottom = UDim.new(0, 5)
 
		local ListLayout = Instance.new("UIListLayout", ItemList)
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Padding = UDim.new(0, 6)
 
			local OptionButtons = {}
 
			local function ClosePanel()
				Expanded = false
				CloseArea.Visible = false
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				TweenService:Create(
					SidePanel,
					TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
					{ Position = UDim2.new(1, 10, 0, 5) }
				):Play()
				TweenService:Create(Arrow, TweenInfo.new(0.3), { Rotation = 0, ImageColor3 = palette.TextInactive })
					:Play()
				TweenService:Create(TriggerStroke, TweenInfo.new(0.3), { Transparency = 0.85, Color = palette.Stroke })
					:Play()
			end
 
			table.insert(Window.SelectCloseFuncs, ClosePanel)
			CloseArea.MouseButton1Click:Connect(ClosePanel)
 
			local function RefreshOptions()
				for _, btn in pairs(OptionButtons) do
					btn:Destroy()
				end
				table.clear(OptionButtons)
 
				local FilterText = string.lower(SearchInput.Text)
 
				for _, opt in ipairs(OptionsList) do
					if FilterText == "" or string.find(string.lower(opt), FilterText) then
						local OptBtn = Instance.new("TextButton", ItemList)
						OptBtn.Active = false
						OptBtn.Size = UDim2.new(1, 0, 0, 32)
						OptBtn.BackgroundTransparency = 0.95
						OptBtn.AutoButtonColor = false
						OptBtn.Text = ""
						OptBtn.ZIndex = 12
						Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 6)
						punishgoatby97mzu:ApplyThemeObj(OptBtn, "BackgroundColor3", "ToggleBtnBg")
 
						local OptStroke = Instance.new("UIStroke", OptBtn)
						OptStroke.Thickness = 1
						OptStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
 
						local Indicator = Instance.new("Frame", OptBtn)
						local isSelected = table.find(SelectedItems, opt) ~= nil
						Indicator.Size = UDim2.new(0, 3, 0, isSelected and 16 or 0)
						Indicator.AnchorPoint = Vector2.new(0, 0.5)
						Indicator.Position = UDim2.new(0, 4, 0.5, 0)
						Indicator.BorderSizePixel = 0
						Indicator.ZIndex = 12
						Indicator.BackgroundTransparency = 0
						Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)
						punishgoatby97mzu:ApplyThemeObj(Indicator, "BackgroundColor3", "Accent")
 
						local ItemTitle = Instance.new("TextLabel", OptBtn)
						ItemTitle.Size = UDim2.new(1, -30, 1, 0)
						ItemTitle.Position = UDim2.new(0, 15, 0, 0)
						ItemTitle.BackgroundTransparency = 1
						ItemTitle.Text = opt
						ItemTitle.Font = Enum.Font.GothamMedium
						ItemTitle.TextSize = 12
						ItemTitle.TextXAlignment = Enum.TextXAlignment.Left
						ItemTitle.ZIndex = 12
 
						if isSelected then
							OptStroke.Transparency = 0.95
							punishgoatby97mzu:ApplyThemeObj(OptStroke, "Color", "Accent")
							punishgoatby97mzu:ApplyThemeObj(ItemTitle, "TextColor3", "Accent")
							OptBtn.BackgroundTransparency = 0.55
						else
							OptStroke.Transparency = 0.85
							punishgoatby97mzu:ApplyThemeObj(OptStroke, "Color", "Stroke")
							punishgoatby97mzu:ApplyThemeObj(ItemTitle, "TextColor3", "Text")
							OptBtn.BackgroundTransparency = 0.95
						end
 
						OptBtn.MouseButton1Click:Connect(function()
							local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
							local idx = table.find(SelectedItems, opt)
 
							if idx then
								table.remove(SelectedItems, idx)
								TweenService:Create(
									Indicator,
									TweenInfo.new(0.3, Enum.EasingStyle.Quint),
									{ Size = UDim2.new(0, 3, 0, 0) }
								):Play()
								TweenService
									:Create(
										OptStroke,
										TweenInfo.new(0.3),
										{ Transparency = 0.85, Color = palette.Stroke }
									)
									:Play()
								TweenService:Create(ItemTitle, TweenInfo.new(0.3), { TextColor3 = palette.Text }):Play()
								TweenService:Create(OptBtn, TweenInfo.new(0.3), { BackgroundTransparency = 0.95 })
									:Play()
							else
								table.insert(SelectedItems, opt)
								TweenService:Create(
									Indicator,
									TweenInfo.new(0.3, Enum.EasingStyle.Quint),
									{ Size = UDim2.new(0, 3, 0, 16) }
								):Play()
								TweenService
									:Create(
										OptStroke,
										TweenInfo.new(0.3),
										{ Transparency = 0.95, Color = palette.Accent }
									)
									:Play()
								TweenService:Create(ItemTitle, TweenInfo.new(0.3), { TextColor3 = palette.Accent })
									:Play()
								TweenService:Create(OptBtn, TweenInfo.new(0.3), { BackgroundTransparency = 0.55 })
									:Play()
							end
 
							UpdateTriggerText()
							CallbackFunc(SelectedItems)
						end)
 
						table.insert(OptionButtons, OptBtn)
					end
				end
			end
 
			RefreshOptions()
 
			SearchInput:GetPropertyChangedSignal("Text"):Connect(RefreshOptions)
 
			TriggerBtn.MouseButton1Click:Connect(function()
				Expanded = not Expanded
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
 
				if Expanded then
					CloseArea.Visible = true
					TweenService:Create(
						SidePanel,
						TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
						{ Position = UDim2.new(0.45, 5, 0, 5) }
					):Play()
					TweenService:Create(Arrow, TweenInfo.new(0.3), { Rotation = 90, ImageColor3 = palette.Accent })
						:Play()
					TweenService
						:Create(TriggerStroke, TweenInfo.new(0.3), { Transparency = 0.5, Color = palette.Accent })
						:Play()
				else
					ClosePanel()
				end
			end)
 
			local SelectObj = {}
			
			-- New internal function to force a selection change from outside the library
			local function SetSelection(newSelection)
				SelectedItems = {}
				if type(newSelection) == "table" then
					for _, v in pairs(newSelection) do
						table.insert(SelectedItems, v)
					end
				elseif type(newSelection) == "string" and newSelection ~= "None" and newSelection ~= "" then
					table.insert(SelectedItems, newSelection)
				end
				UpdateTriggerText()
				RefreshOptions()
				pcall(function() CallbackFunc(SelectedItems) end)
			end
 
			-- Expose the Set function so it can be called from the main script
			function SelectObj:Set(newSelection)
				SetSelection(newSelection)
			end
 
			function SelectObj:SetValue(newSelection)
				SetSelection(newSelection)
			end
 
			-- Update the Refresh function to support auto-cleaning stale data
			function SelectObj:Refresh(NewOptions, KeepSelection)
                OptionsList = NewOptions or {}
                
                if KeepSelection == false then
                    SelectedItems = {}
                else
                    -- [SMART AUTO-CLEAN & UPGRADE SYNC]
                    local validSet = {}
                    for _, opt in ipairs(OptionsList) do
                        validSet[opt] = true
                    end
                    
                    for i = #SelectedItems, 1, -1 do
                        local item = SelectedItems[i]
                        if item ~= "Any" and item ~= "All" and not validSet[item] then
                            -- MAIN FIX: check whether this is just a level-up/mutation change, NOT actually removed
                            local baseItem = item:match("^(.-)%s*%[Lvl") or item:match("^(.-)%s*%[Lv") or item:match("^(.-)%s*%(") or item
                            
                            local foundEvolution = false
                            for _, opt in ipairs(OptionsList) do
                                local baseOpt = opt:match("^(.-)%s*%[Lvl") or opt:match("^(.-)%s*%[Lv") or opt:match("^(.-)%s*%(") or opt
                                
                                -- If the base name matches (e.g. Passionfruit) but the level differs
                                if baseItem:lower() == baseOpt:lower() then
                                    -- Automatically move the selection to the new level name!
                                    SelectedItems[i] = opt
                                    foundEvolution = true
                                    break
                                end
                            end
                            
                            -- Only deselect once the base name is truly gone (actually removed from the field)
                            if not foundEvolution then
                                table.remove(SelectedItems, i)
                            end
                        end
                    end
                end
                
                UpdateTriggerText()
                RefreshOptions()
            end
			
			return SelectObj
		end
 
		function Tab:CreateKeybind(KeybindName, Description, DefaultKey, Callback)
			local CallbackFunc = Callback or function() end
			local CurrentKey = DefaultKey or Enum.KeyCode.Unknown
			local HasDesc = type(Description) == "string" and Description ~= ""
			local Listening = false
 
			local KeybindBtn = Instance.new("Frame", Page)
			KeybindBtn.Size = UDim2.new(1, 0, 0, HasDesc and 52 or 36)
			KeybindBtn.BackgroundTransparency = 0.2
			Instance.new("UICorner", KeybindBtn).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(KeybindBtn, "BackgroundColor3", "ToggleBtnBg")
 
			local KeybindStroke = Instance.new("UIStroke", KeybindBtn)
			KeybindStroke.Thickness = 1
			KeybindStroke.Transparency = 0.85
			punishgoatby97mzu:ApplyThemeObj(KeybindStroke, "Color", "Stroke")
 
			local Title = Instance.new("TextLabel", KeybindBtn)
			Title.Size = UDim2.new(1, -110, 0, 16)
			Title.Position = UDim2.new(0, 15, 0, HasDesc and 10 or 10)
			if not HasDesc then
				Title.Size = UDim2.new(1, -110, 1, 0)
				Title.Position = UDim2.new(0, 15, 0, 0)
			end
			Title.BackgroundTransparency = 1
			Title.Text = KeybindName
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			if HasDesc then
				local DescLabel = Instance.new("TextLabel", KeybindBtn)
				DescLabel.Size = UDim2.new(1, -110, 0, 14)
				DescLabel.Position = UDim2.new(0, 15, 0, 26)
				DescLabel.BackgroundTransparency = 1
				DescLabel.Text = Description
				DescLabel.Font = Enum.Font.Gotham
				DescLabel.TextSize = 11
				DescLabel.TextXAlignment = Enum.TextXAlignment.Left
				punishgoatby97mzu:ApplyThemeObj(DescLabel, "TextColor3", "TextInactive")
			end
 
			local KeyBtn = Instance.new("TextButton", KeybindBtn)
			KeyBtn.Size = UDim2.new(0, 80, 0, 26)
			KeyBtn.AnchorPoint = Vector2.new(1, 0.5)
			KeyBtn.Position = UDim2.new(1, -12, 0.5, 0)
			KeyBtn.AutoButtonColor = false
			KeyBtn.Font = Enum.Font.GothamBold
			KeyBtn.TextSize = 12
			Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0, 6)
			punishgoatby97mzu:ApplyThemeObj(KeyBtn, "BackgroundColor3", "ToggleBgOff")
			punishgoatby97mzu:ApplyThemeObj(KeyBtn, "TextColor3", "Text")
 
			local function KeyName()
				return (CurrentKey and CurrentKey ~= Enum.KeyCode.Unknown) and CurrentKey.Name or "None"
			end
			KeyBtn.Text = KeyName()
 
			local captureConn
			KeyBtn.MouseButton1Click:Connect(function()
				if Listening then
					return
				end
				Listening = true
				KeyBtn.Text = "..."
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				TweenService:Create(KeybindStroke, TweenInfo.new(0.2), { Color = palette.Accent, Transparency = 0.5 })
					:Play()
 
				-- One-shot listener: grabs the very next key press, then disconnects itself.
				captureConn = UserInputService.InputBegan:Connect(function(input, gpe)
					if gpe then
						return
					end
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode ~= Enum.KeyCode.Escape then
							CurrentKey = input.KeyCode
						end
						Listening = false
						KeyBtn.Text = KeyName()
						TweenService:Create(
							KeybindStroke,
							TweenInfo.new(0.2),
							{ Color = palette.Stroke, Transparency = 0.85 }
						):Play()
						if captureConn then
							captureConn:Disconnect()
							captureConn = nil
						end
					end
				end)
			end)
 
			-- Fires the callback whenever the bound key is pressed (ignored while rebinding).
			UserInputService.InputBegan:Connect(function(input, gpe)
				if gpe or Listening then
					return
				end
				if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == CurrentKey then
					CallbackFunc(CurrentKey)
				end
			end)
 
			local KeybindObj = {}
			function KeybindObj:Set(keyCode)
				CurrentKey = keyCode
				KeyBtn.Text = KeyName()
			end
			function KeybindObj:Get()
				return CurrentKey
			end
			return KeybindObj
		end
 
		-- Static one-liner, e.g. hints, warnings, small info text. Returns a handle
		-- with :Set(text) so it can be updated later (e.g. live status text).
		function Tab:CreateLabel(Text)
			local LabelHolder = Instance.new("Frame", Page)
			LabelHolder.Size = UDim2.new(1, 0, 0, 0)
			LabelHolder.AutomaticSize = Enum.AutomaticSize.Y
			LabelHolder.BackgroundTransparency = 1
 
			local TextLbl = Instance.new("TextLabel", LabelHolder)
			TextLbl.Size = UDim2.new(1, 0, 0, 0)
			TextLbl.AutomaticSize = Enum.AutomaticSize.Y
			TextLbl.BackgroundTransparency = 1
			TextLbl.Text = Text or ""
			TextLbl.Font = Enum.Font.Gotham
			TextLbl.TextSize = 12
			TextLbl.TextWrapped = true
			TextLbl.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(TextLbl, "TextColor3", "TextInactive")
 
			local LabelObj = {}
			function LabelObj:Set(newText)
				TextLbl.Text = newText
			end
			return LabelObj
		end
 
		-- Boxed title + body text, for longer explanations/warnings that a one-line
		-- Label wouldn't fit nicely.
		function Tab:CreateParagraph(Title, Content)
			local Container = Instance.new("Frame", Page)
			Container.Size = UDim2.new(1, 0, 0, 0)
			Container.AutomaticSize = Enum.AutomaticSize.Y
			Container.BackgroundTransparency = 0.55
			Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(Container, "BackgroundColor3", "ToggleBtnBg")
 
			local Stroke = Instance.new("UIStroke", Container)
			Stroke.Thickness = 1
			Stroke.Transparency = 0.85
			punishgoatby97mzu:ApplyThemeObj(Stroke, "Color", "Stroke")
 
			local Padding = Instance.new("UIPadding", Container)
			Padding.PaddingTop = UDim.new(0, 10)
			Padding.PaddingBottom = UDim.new(0, 10)
			Padding.PaddingLeft = UDim.new(0, 12)
			Padding.PaddingRight = UDim.new(0, 12)
 
			local Layout = Instance.new("UIListLayout", Container)
			Layout.SortOrder = Enum.SortOrder.LayoutOrder
			Layout.Padding = UDim.new(0, 4)
 
			local TitleLbl = Instance.new("TextLabel", Container)
			TitleLbl.Size = UDim2.new(1, 0, 0, 16)
			TitleLbl.BackgroundTransparency = 1
			TitleLbl.Text = Title or ""
			TitleLbl.Font = Enum.Font.GothamBold
			TitleLbl.TextSize = 13
			TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(TitleLbl, "TextColor3", "Text")
 
			local ContentLbl = Instance.new("TextLabel", Container)
			ContentLbl.Size = UDim2.new(1, 0, 0, 0)
			ContentLbl.AutomaticSize = Enum.AutomaticSize.Y
			ContentLbl.BackgroundTransparency = 1
			ContentLbl.Text = Content or ""
			ContentLbl.Font = Enum.Font.Gotham
			ContentLbl.TextSize = 12
			ContentLbl.TextWrapped = true
			ContentLbl.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(ContentLbl, "TextColor3", "TextInactive")
 
			local ParagraphObj = {}
			function ParagraphObj:Set(newContent)
				ContentLbl.Text = newContent
			end
			return ParagraphObj
		end
 
		-- Progress/stat bar with a :Set(value, max?) handle — good for things like
		-- Cash/Sec, farm progress, or a session counter shown right inside a tab.
		function Tab:CreateProgressBar(BarName, Max, Default)
			local MaxValue = Max or 100
			local Value = math.clamp(Default or 0, 0, MaxValue)
 
			local Container = Instance.new("Frame", Page)
			Container.Size = UDim2.new(1, 0, 0, 46)
			Container.BackgroundTransparency = 0.55
			Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(Container, "BackgroundColor3", "ToggleBtnBg")
 
			local Stroke = Instance.new("UIStroke", Container)
			Stroke.Thickness = 1
			Stroke.Transparency = 0.85
			punishgoatby97mzu:ApplyThemeObj(Stroke, "Color", "Stroke")
 
			local Title = Instance.new("TextLabel", Container)
			Title.Size = UDim2.new(1, -80, 0, 18)
			Title.Position = UDim2.new(0, 15, 0, 6)
			Title.BackgroundTransparency = 1
			Title.Text = BarName
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			local ValueLabel = Instance.new("TextLabel", Container)
			ValueLabel.Size = UDim2.new(0, 65, 0, 18)
			ValueLabel.AnchorPoint = Vector2.new(1, 0)
			ValueLabel.Position = UDim2.new(1, -15, 0, 6)
			ValueLabel.BackgroundTransparency = 1
			ValueLabel.Text = tostring(Value) .. "/" .. tostring(MaxValue)
			ValueLabel.Font = Enum.Font.GothamMedium
			ValueLabel.TextSize = 12
			ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
			punishgoatby97mzu:ApplyThemeObj(ValueLabel, "TextColor3", "TextInactive")
 
			local BarBg = Instance.new("Frame", Container)
			BarBg.Size = UDim2.new(1, -30, 0, 6)
			BarBg.Position = UDim2.new(0, 15, 1, -14)
			BarBg.BorderSizePixel = 0
			Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)
			punishgoatby97mzu:ApplyThemeObj(BarBg, "BackgroundColor3", "ToggleBgOff")
 
			local BarFill = Instance.new("Frame", BarBg)
			BarFill.Size = UDim2.new(MaxValue > 0 and (Value / MaxValue) or 0, 0, 1, 0)
			BarFill.BorderSizePixel = 0
			Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)
			punishgoatby97mzu:ApplyThemeObj(BarFill, "BackgroundColor3", "Accent")
 
			local BarObj = {}
			function BarObj:Set(value, max)
				if max then
					MaxValue = max
				end
				Value = math.clamp(value, 0, MaxValue)
				ValueLabel.Text = tostring(Value) .. "/" .. tostring(MaxValue)
				TweenService:Create(BarFill, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
					Size = UDim2.new(MaxValue > 0 and (Value / MaxValue) or 0, 0, 1, 0),
				}):Play()
			end
			function BarObj:Get()
				return Value, MaxValue
			end
			return BarObj
		end
 
		-- Scrollable-friendly history/list block (e.g. "last brainrots found"). Caps
		-- itself at MaxRows so it can't grow forever like an unbounded log would.
		function Tab:CreateTable(TableName, MaxRows)
			MaxRows = MaxRows or 20
 
			if TableName and TableName ~= "" then
				local TitleLabel = Instance.new("TextLabel", Page)
				TitleLabel.Size = UDim2.new(1, 0, 0, 20)
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Text = TableName
				TitleLabel.Font = Enum.Font.GothamBold
				TitleLabel.TextSize = 13
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
				punishgoatby97mzu:ApplyThemeObj(TitleLabel, "TextColor3", "SectionTitle")
			end
 
			local ListFrame = Instance.new("Frame", Page)
			ListFrame.Size = UDim2.new(1, 0, 0, 0)
			ListFrame.AutomaticSize = Enum.AutomaticSize.Y
			ListFrame.BackgroundTransparency = 1
 
			local ListLayout = Instance.new("UIListLayout", ListFrame)
			ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ListLayout.Padding = UDim.new(0, 4)
 
			local Rows = {}
			local OrderCounter = 0
 
			local TableObj = {}
			function TableObj:AddRow(text)
				local Row = Instance.new("Frame", ListFrame)
				Row.Size = UDim2.new(1, 0, 0, 26)
				Row.BackgroundTransparency = 0.5
				OrderCounter = OrderCounter - 1
				Row.LayoutOrder = OrderCounter -- newest row always sorts first
				Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 4)
				punishgoatby97mzu:ApplyThemeObj(Row, "BackgroundColor3", "ToggleBgOff")
 
				local RowStroke = Instance.new("UIStroke", Row)
				RowStroke.Thickness = 1
				RowStroke.Transparency = 0.8
				punishgoatby97mzu:ApplyThemeObj(RowStroke, "Color", "Stroke")
 
				local RowText = Instance.new("TextLabel", Row)
				RowText.Size = UDim2.new(1, -20, 1, 0)
				RowText.Position = UDim2.new(0, 10, 0, 0)
				RowText.BackgroundTransparency = 1
				RowText.Text = text
				RowText.Font = Enum.Font.GothamMedium
				RowText.TextSize = 11
				RowText.TextXAlignment = Enum.TextXAlignment.Left
				RowText.TextTruncate = Enum.TextTruncate.AtEnd
				punishgoatby97mzu:ApplyThemeObj(RowText, "TextColor3", "TextInactive")
 
				table.insert(Rows, 1, Row)
 
				-- [Cap] never let the history grow forever — trim the oldest row past MaxRows.
				if #Rows > MaxRows then
					local oldest = table.remove(Rows)
					oldest:Destroy()
				end
			end
 
			function TableObj:Clear()
				for _, row in ipairs(Rows) do
					row:Destroy()
				end
				Rows = {}
			end
 
			return TableObj
		end
 
		-- Two-step "arm then confirm" button for dangerous actions (e.g. reset config).
		-- First click arms it (turns red, shows ConfirmText for 3s); a second click
		-- within that window fires the callback. Avoids building a full modal/overlay.
		function Tab:CreateConfirmButton(ButtonName, Description, ConfirmText, Callback)
			local CallbackFunc = Callback or function() end
			local HasDesc = type(Description) == "string" and Description ~= ""
			local Armed = false
			local resetTask
 
			local Btn = Instance.new("TextButton", Page)
			Btn.Size = UDim2.new(1, 0, 0, HasDesc and 52 or 36)
			Btn.AutoButtonColor = false
			Btn.Text = ""
			Btn.BackgroundTransparency = 0.2
			Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
			punishgoatby97mzu:ApplyThemeObj(Btn, "BackgroundColor3", "ToggleBtnBg")
 
			local BtnStroke = Instance.new("UIStroke", Btn)
			BtnStroke.Thickness = 1
			BtnStroke.Transparency = 0.85
			punishgoatby97mzu:ApplyThemeObj(BtnStroke, "Color", "Stroke")
 
			local Title = Instance.new("TextLabel", Btn)
			Title.Size = UDim2.new(1, -20, 0, 16)
			Title.Position = UDim2.new(0, 15, 0, HasDesc and 10 or 10)
			if not HasDesc then
				Title.Size = UDim2.new(1, -20, 1, 0)
				Title.Position = UDim2.new(0, 15, 0, 0)
			end
			Title.BackgroundTransparency = 1
			Title.Text = ButtonName
			Title.Font = Enum.Font.GothamMedium
			Title.TextSize = 13
			Title.TextXAlignment = Enum.TextXAlignment.Left
			punishgoatby97mzu:ApplyThemeObj(Title, "TextColor3", "Text")
 
			if HasDesc then
				local DescLabel = Instance.new("TextLabel", Btn)
				DescLabel.Size = UDim2.new(1, -20, 0, 14)
				DescLabel.Position = UDim2.new(0, 15, 0, 26)
				DescLabel.BackgroundTransparency = 1
				DescLabel.Text = Description
				DescLabel.Font = Enum.Font.Gotham
				DescLabel.TextSize = 11
				DescLabel.TextXAlignment = Enum.TextXAlignment.Left
				punishgoatby97mzu:ApplyThemeObj(DescLabel, "TextColor3", "TextInactive")
			end
 
			Btn.MouseButton1Click:Connect(function()
				local palette = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme]
				if not Armed then
					Armed = true
					Title.Text = ConfirmText or "Click again to confirm"
					TweenService:Create(
						BtnStroke,
						TweenInfo.new(0.2),
						{ Color = Color3.fromRGB(255, 75, 75), Transparency = 0.4 }
					):Play()
 
					if resetTask then
						task.cancel(resetTask)
					end
					resetTask = task.delay(3, function()
						Armed = false
						Title.Text = ButtonName
						TweenService:Create(
							BtnStroke,
							TweenInfo.new(0.2),
							{ Color = punishgoatby97mzu.Themes[punishgoatby97mzu.CurrentTheme].Stroke, Transparency = 0.85 }
						):Play()
					end)
				else
					Armed = false
					if resetTask then
						task.cancel(resetTask)
					end
					Title.Text = ButtonName
					TweenService:Create(BtnStroke, TweenInfo.new(0.2), { Color = palette.Stroke, Transparency = 0.85 })
						:Play()
					CallbackFunc()
				end
			end)
		end
 
		return Tab
	end
 
	return Window
end
 
-- ==========================================
-- [🔮] IN-GAME DYNAMIC PREDICTION HUD (DRAGGABLE, RESIZABLE & AUTO-WRAPPING)
-- ==========================================
 
local PredictHUD_UI = nil
local PredictHUD = nil
 
function punishgoatby97mzu:UpdatePredictHUD(brainrot, rarity, mutation, cps)
	-- If the toggle is off, pass nil/false as the first argument to hide the HUD
	if not brainrot then
		if PredictHUD then
			PredictHUD.Visible = false
		end
		return
	end
	
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	
	-- Create a dedicated ScreenGui with max DisplayOrder (2147483647) so it's always above gamepass/inventory UI
	if not PredictHUD_UI then
		PredictHUD_UI = Instance.new("ScreenGui")
		PredictHUD_UI.Name = "punishgoatPredictHUD_UI"
		PredictHUD_UI.ResetOnSpawn = false
		PredictHUD_UI.IgnoreGuiInset = true
		PredictHUD_UI.DisplayOrder = 2147483647 -- Limit maksimum 32-bit integer Roblox
		PredictHUD_UI.Parent = PlayerGui
	end
	
	-- Create the HUD Frame if it doesn't exist yet
	if not PredictHUD then
		PredictHUD = Instance.new("Frame")
		PredictHUD.Name = "PredictHUD"
		-- Slightly taller (125) to fit the new Cash/Sec row
		PredictHUD.Size = UDim2.new(0, 210, 0, 125) 
		PredictHUD.Position = UDim2.new(0.02, 0, 0.22, 0) -- Pas di bawah floating button kiri
		PredictHUD.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
		PredictHUD.BackgroundTransparency = 0.15
		PredictHUD.BorderSizePixel = 0
		PredictHUD.ZIndex = 400
		PredictHUD.Active = true
		PredictHUD.ClipsDescendants = true -- Agar resize memotong elemen dengan rapi
		PredictHUD.Parent = PredictHUD_UI
		
		local Corner = Instance.new("UICorner", PredictHUD)
		Corner.CornerRadius = UDim.new(0, 8)
		
		local Stroke = Instance.new("UIStroke", PredictHUD)
		Stroke.Thickness = 1
		Stroke.Color = Color3.fromRGB(121, 121, 121)
		Stroke.Transparency = 0.5
		
		local Title = Instance.new("TextLabel", PredictHUD)
		Title.Name = "HUD_Title"
		Title.Size = UDim2.new(1, 0, 0, 20)
		Title.BackgroundTransparency = 1
		Title.Text = "🔮 PREDICTION HUD"
		Title.Font = Enum.Font.GothamBold
		Title.TextSize = 11
		Title.TextColor3 = Color3.fromRGB(172, 0, 0) -- punishgoat Red Accent
		Title.ZIndex = 401
		
		local Layout = Instance.new("UIListLayout", PredictHUD)
		Layout.SortOrder = Enum.SortOrder.LayoutOrder
		Layout.Padding = UDim.new(0, 4)
		
		local Padding = Instance.new("UIPadding", PredictHUD)
		Padding.PaddingLeft = UDim.new(0, 12)
		Padding.PaddingRight = UDim.new(0, 12)
		Padding.PaddingTop = UDim.new(0, 8)
		Padding.PaddingBottom = UDim.new(0, 8)
		
		local L_Brainrot = Instance.new("TextLabel", PredictHUD)
		L_Brainrot.Name = "L_Brainrot"
		L_Brainrot.Size = UDim2.new(1, -12, 0, 18) -- Sisakan sedikit padding kanan agar tidak menabrak grip
		L_Brainrot.BackgroundTransparency = 1
		L_Brainrot.Font = Enum.Font.GothamMedium
		L_Brainrot.TextSize = 11
		L_Brainrot.TextColor3 = Color3.fromRGB(210, 210, 210)
		L_Brainrot.TextXAlignment = Enum.TextXAlignment.Left
		L_Brainrot.RichText = true
		L_Brainrot.TextWrapped = true -- AKTIFKAN TEXT WRAP AGAR TULISAN PANJANG TURUN KE BAWAH
		L_Brainrot.AutomaticSize = Enum.AutomaticSize.Y -- TINGGI OTOMATIS MENYESUAIKAN JIKA WRAP
		L_Brainrot.ZIndex = 401
		
		local L_Rarity = Instance.new("TextLabel", PredictHUD)
		L_Rarity.Name = "L_Rarity"
		L_Rarity.Size = UDim2.new(1, -12, 0, 18)
		L_Rarity.BackgroundTransparency = 1
		L_Rarity.Font = Enum.Font.GothamMedium
		L_Rarity.TextSize = 11
		L_Rarity.TextColor3 = Color3.fromRGB(210, 210, 210)
		L_Rarity.TextXAlignment = Enum.TextXAlignment.Left
		L_Rarity.RichText = true
		L_Rarity.TextWrapped = true
		L_Rarity.AutomaticSize = Enum.AutomaticSize.Y
		L_Rarity.ZIndex = 401
		
		local L_Mutation = Instance.new("TextLabel", PredictHUD)
		L_Mutation.Name = "L_Mutation"
		L_Mutation.Size = UDim2.new(1, -12, 0, 18)
		L_Mutation.BackgroundTransparency = 1
		L_Mutation.Font = Enum.Font.GothamMedium
		L_Mutation.TextSize = 11
		L_Mutation.TextColor3 = Color3.fromRGB(210, 210, 210)
		L_Mutation.TextXAlignment = Enum.TextXAlignment.Left
		L_Mutation.RichText = true
		L_Mutation.TextWrapped = true
		L_Mutation.AutomaticSize = Enum.AutomaticSize.Y
		L_Mutation.ZIndex = 401
 
		-- Add a new Label for Cash Per Second (CPS)
		local L_CPS = Instance.new("TextLabel", PredictHUD)
		L_CPS.Name = "L_CPS"
		L_CPS.Size = UDim2.new(1, -12, 0, 18)
		L_CPS.BackgroundTransparency = 1
		L_CPS.Font = Enum.Font.GothamMedium
		L_CPS.TextSize = 11
		L_CPS.TextColor3 = Color3.fromRGB(210, 210, 210)
		L_CPS.TextXAlignment = Enum.TextXAlignment.Left
		L_CPS.RichText = true
		L_CPS.TextWrapped = true
		L_CPS.AutomaticSize = Enum.AutomaticSize.Y
		L_CPS.ZIndex = 401
 
		-- Smooth drag-and-drop feature
		local draggingHUD, dragInputHUD, dragStartHUD, startPosHUD
		PredictHUD.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				draggingHUD = true
				dragStartHUD = input.Position
				startPosHUD = PredictHUD.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						draggingHUD = false
					end
				end)
			end
		end)
		PredictHUD.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInputHUD = input
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if input == dragInputHUD and draggingHUD then
				local delta = input.Position - dragStartHUD
				PredictHUD.Position = UDim2.new(
					startPosHUD.X.Scale,
					startPosHUD.X.Offset + delta.X,
					startPosHUD.Y.Scale,
					startPosHUD.Y.Offset + delta.Y
				)
			end
		end)
 
		-- RESIZE GRIP: bottom-right resize handle
		local ResizeGrip = Instance.new("TextButton", PredictHUD)
		ResizeGrip.Name = "ResizeGrip"
		ResizeGrip.Size = UDim2.new(0, 15, 0, 15)
		ResizeGrip.Position = UDim2.new(1, 0, 1, 0)
		ResizeGrip.AnchorPoint = Vector2.new(1, 1)
		ResizeGrip.BackgroundTransparency = 1
		ResizeGrip.Text = "◢"
		ResizeGrip.Font = Enum.Font.GothamBold
		ResizeGrip.TextSize = 10
		ResizeGrip.TextColor3 = Color3.fromRGB(121, 121, 121)
		ResizeGrip.ZIndex = 402
 
		local resizingHUD, rDragStartHUD, startSizeHUD
		ResizeGrip.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				resizingHUD = true
				rDragStartHUD = input.Position
				startSizeHUD = PredictHUD.Size
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						resizingHUD = false
					end
				end)
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if resizingHUD and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local delta = input.Position - rDragStartHUD
				local newX = math.clamp(startSizeHUD.X.Offset + delta.X, 180, 500)
				local newY = math.clamp(startSizeHUD.Y.Offset + delta.Y, 95, 300)
				PredictHUD.Size = UDim2.new(0, newX, 0, newY)
			end
		end)
	end
	
	-- Update text
	PredictHUD.Visible = true
	PredictHUD.L_Brainrot.Text = "<b>BRAINROT:</b> " .. tostring(brainrot):upper()
	PredictHUD.L_Rarity.Text = "<b>RARITY:</b> " .. tostring(rarity):upper()
	PredictHUD.L_Mutation.Text = "<b>MUTATION:</b> " .. tostring(mutation):upper()
	-- Display the latest estimated Cash Per Second
	PredictHUD.L_CPS.Text = "<b>CASH/SEC:</b> " .. tostring(cps or "N/A"):upper()
end
 
-- ==========================================
-- [⚡] DYNAMIC VISUAL ENGINE (EXTREME POTATO MODE) - LOW-END & ANTI-CRASH
-- ==========================================
function punishgoatby97mzu:SetPotatoMode(state)
    task.spawn(function()
        local Lighting = game:GetService("Lighting")
        local Workspace = game:GetService("Workspace")
        local Terrain = Workspace:FindFirstChildOfClass("Terrain")
 
        if state then
            if self.VisualConnections.Potato then self.VisualConnections.Potato:Disconnect() end
 
            -- [BUG FIX] Build a "protected" check (characters + camera) so Potato Mode only
            -- strips the map/props, not the player's own avatar or viewmodel.
            -- With StreamingEnabled, DescendantAdded fires for every part that streams in,
            -- including character parts respawning — without this guard those get flattened too.
            local function IsProtected(obj)
                local camera = Workspace.CurrentCamera
                if camera and obj:IsDescendantOf(camera) then
                    return true
                end
                for _, player in ipairs(Players:GetPlayers()) do
                    if player.Character and obj:IsDescendantOf(player.Character) then
                        return true
                    end
                end
                return false
            end
 
            -- 1. Aggressively disable global lighting
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            Lighting.GlobalShadows = false
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0
            Lighting.Brightness = 2 -- Slightly raised so the map isn't pitch black once it's stripped down
            Lighting.FogEnd = 9e9
 
            -- [FIX CRASH]: every Terrain property change must be wrapped in its own pcall!
            if Terrain then
                pcall(function() Terrain.WaterWaveSize = 0 end)
                pcall(function() Terrain.WaterWaveSpeed = 0 end)
                pcall(function() Terrain.WaterReflectance = 0 end)
                pcall(function() Terrain.WaterTransparency = 0 end)
                pcall(function() Terrain.Decoration = false end)
            end
 
            -- 2. Core function that strips down every visual (extreme low-end mode)
            local function AnnihilateVisuals(obj)
                if IsProtected(obj) then return end
                pcall(function()
                    if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                        -- Flatten the material (remove reflections)
                        obj.Material = Enum.Material.SmoothPlastic
                        obj.Reflectance = 0
                        obj.CastShadow = false
                        
                        -- [TARGET: BRAINROT & MAP TEXTURES]: strip the original 3D model appearance
                        if obj:IsA("MeshPart") then
                            obj.TextureID = "" 
                        end
                    elseif obj:IsA("SpecialMesh") then
                        obj.TextureId = "" 
                    elseif obj:IsA("SurfaceAppearance") then
                        -- Destroy Roblox's built-in HD/PBR texture system
                        obj:Destroy() 
                    elseif obj:IsA("Decal") or obj:IsA("Texture") then
                        obj.Transparency = 1 
                    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Highlight") then
                        -- Disable ALL VFX including Highlight/Outline
                        obj.Enabled = false 
                    elseif obj:IsA("PostEffect") or obj:IsA("Atmosphere") or obj:IsA("Sky") then
                        obj.Enabled = false 
                    elseif obj:IsA("Light") then
                        -- Disable PointLight/SpotLight so the GPU skips lighting calculations
                        obj.Enabled = false 
                    end
                end)
            end
 
            -- 3. Run an O(N) chunked pass across the whole map (freeze-free)
            local allObjects = Workspace:GetDescendants()
            for i, obj in ipairs(allObjects) do
                AnnihilateVisuals(obj)
                -- Yield every 500 objects so the frame rate doesn't drop during the forced re-render
                if i % 500 == 0 then task.wait() end 
            end
 
            for _, obj in ipairs(Lighting:GetChildren()) do
                AnnihilateVisuals(obj)
            end
 
            -- 4. Real-time O(1) guard (auto-strips new Brainrot/VFX the moment they spawn)
            self.VisualConnections.Potato = Workspace.DescendantAdded:Connect(function(obj)
                AnnihilateVisuals(obj)
            end)
 
        else
            -- DISABLE POTATO MODE
            if self.VisualConnections.Potato then 
                self.VisualConnections.Potato:Disconnect() 
                self.VisualConnections.Potato = nil 
            end
            Lighting.GlobalShadows = true
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end)
end
 
function punishgoatby97mzu:SetRTXMode(state)
    -- [FIX]: wrapped in task.spawn
    task.spawn(function()
        local Lighting = game:GetService("Lighting")
        local Workspace = game:GetService("Workspace")
        local Terrain = Workspace:FindFirstChildOfClass("Terrain")
 
        if state then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level21
            Lighting.GlobalShadows = true
            Lighting.ShadowSoftness = 0.2
            Lighting.Brightness = 3
            Lighting.EnvironmentDiffuseScale = 1.2
            Lighting.EnvironmentSpecularScale = 1.5 
            
            Lighting.Ambient = Color3.fromRGB(130, 145, 165) 
            Lighting.OutdoorAmbient = Color3.fromRGB(180, 190, 210) 
            Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
            Lighting.ColorShift_Top = Color3.fromRGB(255, 240, 245)
 
            if Terrain then
                Terrain.WaterWaveSize = 0.8
                Terrain.WaterWaveSpeed = 10
                Terrain.WaterReflectance = 1
                Terrain.WaterTransparency = 0.6
                Terrain.Decoration = true
            end
 
            for _, effect in ipairs(Lighting:GetChildren()) do
                if (effect:IsA("PostEffect") or effect:IsA("Atmosphere")) and effect.Name:match("punishgoat") then
                    effect:Destroy()
                end
            end
 
            local cc = Instance.new("ColorCorrectionEffect")
            cc.Name = "punishgoatColor"
            cc.Brightness = 0.05
            cc.Contrast = 0.15 
            cc.Saturation = 0.65 
            cc.TintColor = Color3.fromRGB(255, 245, 255) 
            cc.Parent = Lighting
 
            local bloom = Instance.new("BloomEffect")
            bloom.Name = "punishgoatBloom"
            bloom.Intensity = 0.5
            bloom.Size = 40
            bloom.Threshold = 2
            bloom.Parent = Lighting
 
            local sun = Instance.new("SunRaysEffect")
            sun.Name = "punishgoatSunRays"
            sun.Intensity = 0.25
            sun.Spread = 0.75
            sun.Parent = Lighting
 
            local atmos = Instance.new("Atmosphere")
            atmos.Name = "punishgoatAtmosphere"
            atmos.Density = 0.25
            atmos.Offset = 0.25
            atmos.Color = Color3.fromRGB(150, 180, 220)
            atmos.Decay = Color3.fromRGB(255, 180, 200)
            atmos.Glare = 0.2
            atmos.Haze = 0.4
            atmos.Parent = Lighting
            
            local dof = Instance.new("DepthOfFieldEffect")
            dof.Name = "punishgoatDOF"
            dof.FarIntensity = 0.25
            dof.FocusDistance = 25
            dof.InFocusRadius = 40
            dof.NearIntensity = 0
            dof.Parent = Lighting
        else
            for _, effect in ipairs(Lighting:GetChildren()) do
                if (effect:IsA("PostEffect") or effect:IsA("Atmosphere")) and effect.Name:match("punishgoat") then
                    effect:Destroy()
                end
            end
        end
    end)
end
return punishgoatby97mzu
