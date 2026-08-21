local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- إزالة الواجهة القديمة
local Old = PlayerGui:FindFirstChild("A7medHub")
if Old then Old:Destroy() end

--// إعدادات الألوان (Neon Blue Theme)
local NeonBlue = Color3.fromRGB(0, 170, 255)
local DarkBg = Color3.fromRGB(10, 10, 16)
local DarkerBg = Color3.fromRGB(6, 6, 10)
local TextColor = Color3.fromRGB(240, 240, 255)

--// إنشاء الواجهة الرئيسية
local Gui = Instance.new("ScreenGui")
Gui.Name = "A7medHub"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--// الإطار الرئيسي
local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.fromOffset(480, 460)
Frame.Position = UDim2.new(0.5, 0, 1.5, 0) -- يبدأ من الأسفل للأنيميشن
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = DarkBg
Frame.BorderSizePixel = 0
Frame.Parent = Gui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 16)
FrameCorner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.Transparency = 0.2
Stroke.Color = NeonBlue
Stroke.Parent = Frame

-- ==========================================
-- TopBar + GIF Logo
-- ==========================================
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopBar.BackgroundColor3 = DarkerBg
TopBar.BorderSizePixel = 0
TopBar.Parent = Frame
local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 16)
TopBarCorner.Parent = TopBar

--// GIF Logo في الـ TopBar
local GIFFrames = {
    "107268249992959", "104444112835205", "115157039177204", "111931487689142",
    "139619104460573", "117772948212179", "123663025657786", "138532394395836"
}
local GIF = Instance.new("ImageLabel")
GIF.Name = "AnimatedLogo"
GIF.Size = UDim2.fromOffset(35, 35)
GIF.Position = UDim2.fromOffset(15, 10)
GIF.BackgroundTransparency = 1
GIF.Image = "rbxassetid://" .. GIFFrames[1]
GIF.Parent = TopBar

task.spawn(function()
    local Assets = {}
    for _, ID in ipairs(GIFFrames) do
        local Img = Instance.new("ImageLabel")
        Img.Image = "rbxassetid://" .. ID
        table.insert(Assets, Img)
    end
    pcall(function() ContentProvider:PreloadAsync(Assets) end)
    for _, Img in ipairs(Assets) do Img:Destroy() end
    
    local FrameSpeed = 0.08
    while Gui.Parent do
        for _, ImageID in ipairs(GIFFrames) do
            if not Gui.Parent then break end
            GIF.Image = "rbxassetid://" .. ImageID
            task.wait(FrameSpeed)
        end
    end
end)

--// العنوان
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.fromOffset(60, 0)
Title.BackgroundTransparency = 1
Title.Text = "A7med Hub"
Title.TextColor3 = TextColor
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

--// زر الإغلاق
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.fromOffset(35, 35)
CloseButton.Position = UDim2.new(1, -10, 0.5, 0)
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.Parent = TopBar
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 60, 60), TextColor3 = Color3.fromRGB(255,255,255)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40), TextColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)

-- ==========================================
-- نظام التبويبات (Tabs)
-- ==========================================
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, -20, 0, 45)
TabContainer.Position = UDim2.fromOffset(10, 65)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Frame

local TabsList = Instance.new("UIListLayout")
TabsList.FillDirection = Enum.FillDirection.Horizontal
TabsList.SortOrder = Enum.SortOrder.LayoutOrder
TabsList.Padding = UDim.new(0, 10)
TabsList.Parent = TabContainer

local TabContentContainer = Instance.new("Frame")
TabContentContainer.Name = "TabContentContainer"
TabContentContainer.Size = UDim2.new(1, -20, 1, -120)
TabContentContainer.Position = UDim2.fromOffset(10, 120)
TabContentContainer.BackgroundColor3 = DarkerBg
TabContentContainer.BorderSizePixel = 0
TabContentContainer.Parent = Frame
local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 12)
ContentCorner.Parent = TabContentContainer
local ContentStroke = Instance.new("UIStroke")
ContentStroke.Color = Color3.fromRGB(30, 30, 40)
ContentStroke.Thickness = 1
ContentStroke.Parent = TabContentContainer

local function CreateTabButton(Name, Text, LayoutOrder)
    local Btn = Instance.new("TextButton")
    Btn.Name = Name
    Btn.Size = UDim2.new(0, 105, 1, 0)
    Btn.LayoutOrder = LayoutOrder
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Btn.BorderSizePixel = 0
    Btn.Text = Text
    Btn.TextColor3 = Color3.fromRGB(130, 130, 150)
    Btn.TextSize = 15
    Btn.Font = Enum.Font.GothamBold
    Btn.AutoButtonColor = false
    Btn.Parent = TabContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(40, 40, 50)
    BtnStroke.Thickness = 1
    BtnStroke.Parent = Btn
    
    return Btn, BtnStroke
end

local TabMain, StrokeMain = CreateTabButton("TabMain", "الرئيسية", 1)
local TabFootball, StrokeFootball = CreateTabButton("TabFootball", "Football", 2)
local TabFun, StrokeFun = CreateTabButton("TabFun", "Fun", 3)
local TabFFS, StrokeFFS = CreateTabButton("TabFFS", "FFS", 4)

local function CreateTabContent(Name)
    local Content = Instance.new("ScrollingFrame")
    Content.Name = Name
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 5
    Content.ScrollBarImageColor3 = NeonBlue
    Content.Visible = false
    Content.Parent = TabContentContainer
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 15)
    Padding.PaddingLeft = UDim.new(0, 15)
    Padding.PaddingRight = UDim.new(0, 15)
    Padding.PaddingBottom = UDim.new(0, 15)
    Padding.Parent = Content
    
    local List = Instance.new("UIListLayout")
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Padding = UDim.new(0, 12)
    List.Parent = Content
    
    return Content
end

local ContentMain = CreateTabContent("ContentMain")
local ContentFootball = CreateTabContent("ContentFootball")
local ContentFun = CreateTabContent("ContentFun")
local ContentFFS = CreateTabContent("ContentFFS")

local function SwitchTab(ActiveTab, ActiveStroke, ActiveContent)
    local tabs = {TabMain, TabFootball, TabFun, TabFFS}
    local strokes = {StrokeMain, StrokeFootball, StrokeFun, StrokeFFS}
    
    for i, btn in ipairs(tabs) do
        TweenService:Create(btn, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(20, 20, 30), TextColor3 = Color3.fromRGB(130, 130, 150)}):Play()
        TweenService:Create(strokes[i], TweenInfo.new(0.25), {Color = Color3.fromRGB(40, 40, 50)}):Play()
    end
    
    TweenService:Create(ActiveTab, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(0, 30, 50), TextColor3 = NeonBlue}):Play()
    TweenService:Create(ActiveStroke, TweenInfo.new(0.25), {Color = NeonBlue}):Play()
    
    for _, content in ipairs(TabContentContainer:GetChildren()) do
        if content:IsA("ScrollingFrame") then
            content.Visible = false
        end
    end
    ActiveContent.Visible = true
end

SwitchTab(TabMain, StrokeMain, ContentMain)

TabMain.MouseButton1Click:Connect(function() SwitchTab(TabMain, StrokeMain, ContentMain) end)
TabFootball.MouseButton1Click:Connect(function() SwitchTab(TabFootball, StrokeFootball, ContentFootball) end)
TabFun.MouseButton1Click:Connect(function() SwitchTab(TabFun, StrokeFun, ContentFun) end)
TabFFS.MouseButton1Click:Connect(function() SwitchTab(TabFFS, StrokeFFS, ContentFFS) end)

-- ==========================================
-- دالة إنشاء الأزرار (Neon Style)
-- ==========================================
local function CreateActionButton(Name, Text, Parent, Order)
    local Btn = Instance.new("TextButton")
    Btn.Name = Name
    Btn.Size = UDim2.new(1, 0, 0, 48)
    Btn.LayoutOrder = Order or 1
    Btn.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    Btn.BorderSizePixel = 0
    Btn.Text = Text
    Btn.TextColor3 = TextColor
    Btn.TextSize = 16
    Btn.Font = Enum.Font.GothamBold
    Btn.AutoButtonColor = false
    Btn.Parent = Parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Thickness = 1.5
    BtnStroke.Transparency = 0.6
    BtnStroke.Color = NeonBlue
    BtnStroke.Parent = Btn
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 40, 60)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0, Color = Color3.fromRGB(50, 200, 255)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 15, 25)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.6, Color = NeonBlue}):Play()
    end)
    
    return Btn
end

-- ==========================================
-- 1. محتوى الرئيسية (Main)
-- ==========================================
local BtnMainExecute = CreateActionButton("BtnMainExecute", "⚡ تفعيل TPS & Touchline", ContentMain, 1)

-- نافذة السؤال المنبثقة (Prompt)
local PromptFrame = Instance.new("Frame")
PromptFrame.Name = "PromptFrame"
PromptFrame.Size = UDim2.fromOffset(320, 150)
PromptFrame.Position = UDim2.fromScale(0.5, 0.5)
PromptFrame.AnchorPoint = Vector2.new(0.5, 0.5)
PromptFrame.BackgroundColor3 = DarkerBg
PromptFrame.BorderSizePixel = 0
PromptFrame.Visible = false
PromptFrame.ZIndex = 100
PromptFrame.Parent = Frame
local PromptCorner = Instance.new("UICorner")
PromptCorner.CornerRadius = UDim.new(0, 12)
PromptCorner.Parent = PromptFrame
local PromptStroke = Instance.new("UIStroke")
PromptStroke.Color = NeonBlue
PromptStroke.Thickness = 2
PromptStroke.Parent = PromptFrame

local PromptText = Instance.new("TextLabel")
PromptText.Size = UDim2.new(1, -20, 0, 60)
PromptText.Position = UDim2.fromOffset(10, 15)
PromptText.BackgroundTransparency = 1
PromptText.Text = "هل تريد تشغيل البينج معهما؟"
PromptText.TextColor3 = TextColor
PromptText.TextSize = 17
PromptText.Font = Enum.Font.GothamBold
PromptText.ZIndex = 101
PromptText.Parent = PromptFrame

local PromptYes = Instance.new("TextButton")
PromptYes.Size = UDim2.fromOffset(110, 38)
PromptYes.Position = UDim2.fromOffset(40, 90)
PromptYes.BackgroundColor3 = Color3.fromRGB(0, 100, 150)
PromptYes.BorderSizePixel = 0
PromptYes.Text = "Yes (تشغيل)"
PromptYes.TextColor3 = Color3.fromRGB(255, 255, 255)
PromptYes.TextSize = 15
PromptYes.Font = Enum.Font.GothamBold
PromptYes.ZIndex = 101
PromptYes.Parent = PromptFrame
local PYCorner = Instance.new("UICorner")
PYCorner.CornerRadius = UDim.new(0, 6)
PYCorner.Parent = PromptYes

local PromptNo = Instance.new("TextButton")
PromptNo.Size = UDim2.fromOffset(110, 38)
PromptNo.Position = UDim2.fromOffset(170, 90)
PromptNo.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
PromptNo.BorderSizePixel = 0
PromptNo.Text = "No (إلغاء)"
PromptNo.TextColor3 = Color3.fromRGB(255, 255, 255)
PromptNo.TextSize = 15
PromptNo.Font = Enum.Font.GothamBold
PromptNo.ZIndex = 101
PromptNo.Parent = PromptFrame
local PNCorner = Instance.new("UICorner")
PNCorner.CornerRadius = UDim.new(0, 6)
PNCorner.Parent = PromptNo

BtnMainExecute.MouseButton1Click:Connect(function()
    PromptFrame.Visible = true
    PromptFrame.Position = UDim2.fromScale(0.5, 0.6)
    TweenService:Create(PromptFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, 0.5)}):Play()
end)

PromptNo.MouseButton1Click:Connect(function()
    TweenService:Create(PromptFrame, TweenInfo.new(0.2), {Position = UDim2.fromScale(0.5, 0.6)}):Play()
    task.wait(0.2)
    PromptFrame.Visible = false
    task.spawn(function()
        pcall(function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/07d323b4106c0dee4680725e35bef651.lua"))() end)
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/hf5DG9ce/raw"))() end)
    end)
end)

PromptYes.MouseButton1Click:Connect(function()
    TweenService:Create(PromptFrame, TweenInfo.new(0.2), {Position = UDim2.fromScale(0.5, 0.6)}):Play()
    task.wait(0.2)
    PromptFrame.Visible = false
    task.spawn(function()
        pcall(function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/07d323b4106c0dee4680725e35bef651.lua"))() end)
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/hf5DG9ce/raw"))() end)
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/0644609314z-collab/why-whozuld-u-even-crack-this/refs/heads/main/WHY%20R%20U%20STILLM%20HERE"))() end)
    end)
end)

-- ==========================================
-- 2. محتوى Football
-- ==========================================
local FootballLabel = Instance.new("TextLabel")
FootballLabel.Size = UDim2.new(1, 0, 0, 40)
FootballLabel.LayoutOrder = 1
FootballLabel.BackgroundTransparency = 1
FootballLabel.Text = "🎯 محتوى Football قيد التطوير..."
FootballLabel.TextColor3 = Color3.fromRGB(130, 130, 150)
FootballLabel.TextSize = 16
FootballLabel.Font = Enum.Font.GothamMedium
FootballLabel.Parent = ContentFootball

-- ==========================================
-- 3. محتوى Fun (VR7)
-- ==========================================
local BtnVR7 = CreateActionButton("BtnVR7", "🎮 تشغيل VR7", ContentFun, 1)
BtnVR7.MouseButton1Click:Connect(function()
    task.spawn(function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VR7ss/OMK/refs/heads/main/VR7-ON-TOP"))() end)
    end)
end)

-- ==========================================
-- 4. محتوى FFS (محسّن لمنع الاقتطاع)
-- ==========================================
local FFSLabel = Instance.new("TextLabel")
FFSLabel.Size = UDim2.new(1, 0, 0, 25)
FFSLabel.LayoutOrder = 1
FFSLabel.BackgroundTransparency = 1
FFSLabel.Text = "📋 الصق أكواد FastFlags (JSON) هنا:"
FFSLabel.TextColor3 = NeonBlue
FFSLabel.TextSize = 15
FFSLabel.Font = Enum.Font.GothamBold
FFSLabel.TextXAlignment = Enum.TextXAlignment.Left
FFSLabel.Parent = ContentFFS

-- حاوية التمرير لمنع اقتطاع النص
local FFSContainer = Instance.new("ScrollingFrame")
FFSContainer.Name = "FFSContainer"
FFSContainer.Size = UDim2.new(1, 0, 0, 260) -- حجم كبير يكفي للأكواد الطويلة
FFSContainer.LayoutOrder = 2
FFSContainer.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
FFSContainer.BorderSizePixel = 0
FFSContainer.ScrollBarThickness = 6
FFSContainer.ScrollBarImageColor3 = NeonBlue
FFSContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
FFSContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
FFSContainer.Parent = ContentFFS
local FFSContCorner = Instance.new("UICorner")
FFSContCorner.CornerRadius = UDim.new(0, 8)
FFSContCorner.Parent = FFSContainer
local FFSContStroke = Instance.new("UIStroke")
FFSContStroke.Color = Color3.fromRGB(40, 40, 60)
FFSContStroke.Thickness = 1
FFSContStroke.Parent = FFSContainer

local FFSBox = Instance.new("TextBox")
FFSBox.Name = "FFSBox"
FFSBox.Size = UDim2.new(1, -15, 1, -15)
FFSBox.Position = UDim2.fromOffset(7, 7)
FFSBox.BackgroundTransparency = 1
FFSBox.TextColor3 = Color3.fromRGB(200, 220, 255)
FFSBox.TextSize = 14
FFSBox.Font = Enum.Font.Code
FFSBox.TextXAlignment = Enum.TextXAlignment.Left
FFSBox.TextYAlignment = Enum.TextYAlignment.Top
FFSBox.ClearTextOnFocus = false
FFSBox.MultiLine = true
FFSBox.TextWrapped = true -- ضروري جداً لمنع الاقتطاع
FFSBox.PlaceholderText = '{\n  "FLogNetwork": "7",\n  "DFIntTaskSchedulerTargetFps": "9999"\n}'
FFSBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 100)
FFSBox.Parent = FFSContainer

local BtnApplyFFS = CreateActionButton("BtnApplyFFS", "✅ تطبيق الأكواد (Execute)", ContentFFS, 3)

-- زر Remove Log (تحت على الشمال)
local BtnRemoveLog = Instance.new("TextButton")
BtnRemoveLog.Name = "BtnRemoveLog"
BtnRemoveLog.Size = UDim2.fromOffset(130, 38)
BtnRemoveLog.Position = UDim2.fromOffset(0, 395) -- أسفل اليسار بالضبط
BtnRemoveLog.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
BtnRemoveLog.BorderSizePixel = 0
BtnRemoveLog.Text = "🗑 remove log"
BtnRemoveLog.TextColor3 = Color3.fromRGB(255, 100, 100)
BtnRemoveLog.TextSize = 14
BtnRemoveLog.Font = Enum.Font.GothamBold
BtnRemoveLog.AutoButtonColor = false
BtnRemoveLog.Parent = ContentFFS
local RLCorner = Instance.new("UICorner")
RLCorner.CornerRadius = UDim.new(0, 6)
RLCorner.Parent = BtnRemoveLog
local RLStroke = Instance.new("UIStroke")
RLStroke.Color = Color3.fromRGB(100, 30, 30)
RLStroke.Thickness = 1
RLStroke.Parent = BtnRemoveLog

BtnRemoveLog.MouseEnter:Connect(function()
    TweenService:Create(BtnRemoveLog, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 15, 15)}):Play()
    TweenService:Create(RLStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 100, 100)}):Play()
end)
BtnRemoveLog.MouseLeave:Connect(function()
    TweenService:Create(BtnRemoveLog, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 10, 10)}):Play()
    TweenService:Create(RLStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(100, 30, 30)}):Play()
end)

-- منطق تطبيق الأكواد
BtnApplyFFS.MouseButton1Click:Connect(function()
    local jsonText = FFSBox.Text
    if jsonText == "" or jsonText == FFSBox.PlaceholderText then return end
    
    local success, parsed = pcall(function()
        return HttpService:JSONDecode(jsonText)
    end)
    
    if success then
        local count = 0
        for flag, value in pairs(parsed) do
            pcall(function()
                setfflag(flag, tostring(value))
                count += 1
            end)
        end
        local originalText = FFSBox.Text
        FFSBox.Text = "✅ تم تطبيق " .. count .. " فلاج بنجاح!"
        task.delay(2.5, function() if FFSBox.Text == "✅ تم تطبيق " .. count .. " فلاج بنجاح!" then FFSBox.Text = originalText end end)
    else
        local originalText = FFSBox.Text
        FFSBox.Text = "❌ خطأ: تأكد من أن النص بصيغة JSON صحيحة (أقواس، فواصل)."
        task.delay(3, function() if FFSBox.Text:find("❌") then FFSBox.Text = originalText end end)
    end
end)

-- منطق Remove Log
BtnRemoveLog.MouseButton1Click:Connect(function()
    pcall(function() cleardrawcache() end)
    pcall(function() clearconsole() end)
    
    FFSBox.Text = ""
    local originalPlaceholder = FFSBox.PlaceholderText
    FFSBox.PlaceholderText = "✅ تم مسح السجلات والآثار بنجاح"
    
    task.delay(3, function()
        FFSBox.PlaceholderText = originalPlaceholder
    end)
end)

-- ==========================================
-- نظام السحب (Drag System) المحسّن
-- ==========================================
local Dragging = false
local DragInput = nil
local DragStart = nil
local StartPosition = nil

local function UpdateDrag(Input)
    local Delta = Input.Position - DragStart
    Frame.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end

TopBar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        if Input.Target == CloseButton then return end
        Dragging = true
        DragStart = Input.Position
        StartPosition = Frame.Position
        
        Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
        DragInput = Input
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Input == DragInput and Dragging then
        UpdateDrag(Input)
    end
end)

-- ==========================================
-- حركات الدخول والخروج (Animations)
-- ==========================================
CloseButton.MouseButton1Click:Connect(function()
    Dragging = false
    local CloseTween = TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, 0, 1.5, 0),
        Transparency = 0
    })
    CloseTween:Play()
    CloseTween.Completed:Connect(function()
        if Gui and Gui.Parent then Gui:Destroy() end
    end)
end)

-- حركة الفتح الانسيابية
TweenService:Create(Frame, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, 0, 0.5, 0)
}):Play()
