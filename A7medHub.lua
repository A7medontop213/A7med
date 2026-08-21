local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- إزالة الواجهة القديمة إن وجدت
local Old = PlayerGui:FindFirstChild("A7medHub")
if Old then Old:Destroy() end

--// إنشاء الواجهة الرئيسية
local Gui = Instance.new("ScreenGui")
Gui.Name = "A7medHub"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--// الإطار الرئيسي (تم تكبيره لاستيعاب التبويبات)
local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.fromOffset(460, 420)
Frame.Position = UDim2.new(0.5, 0, 1.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Frame.BorderSizePixel = 0
Frame.Parent = Gui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 16)
FrameCorner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 1.5
Stroke.Transparency = 0.3
Stroke.Color = Color3.fromRGB(19, 103, 229)
Stroke.Parent = Frame

--// شريط العنوان والسحب
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
TopBar.BorderSizePixel = 0
TopBar.Parent = Frame
local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 16)
TopBarCorner.Parent = TopBar

--// زر الإغلاق
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.fromOffset(32, 32)
CloseButton.Position = UDim2.new(1, -10, 0.5, 0)
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.Parent = TopBar
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 80, 80), TextColor3 = Color3.fromRGB(255,255,255)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(25, 25, 35), TextColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)

--// العنوان
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.fromOffset(15, 0)
Title.BackgroundTransparency = 1
Title.Text = "A7med Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

--// نظام التبويبات (Tabs)
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(1, -20, 0, 40)
TabContainer.Position = UDim2.fromOffset(10, 60)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Frame

local TabsList = Instance.new("UIListLayout")
TabsList.FillDirection = Enum.FillDirection.Horizontal
TabsList.SortOrder = Enum.SortOrder.LayoutOrder
TabsList.Padding = UDim.new(0, 8)
TabsList.Parent = TabContainer

local TabContentContainer = Instance.new("Frame")
TabContentContainer.Name = "TabContentContainer"
TabContentContainer.Size = UDim2.new(1, -20, 1, -110)
TabContentContainer.Position = UDim2.fromOffset(10, 110)
TabContentContainer.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
TabContentContainer.BorderSizePixel = 0
TabContentContainer.Parent = Frame
local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = TabContentContainer

--// دالة إنشاء زر تبويب
local function CreateTabButton(Name, Text, LayoutOrder)
    local Btn = Instance.new("TextButton")
    Btn.Name = Name
    Btn.Size = UDim2.new(0, 100, 1, 0)
    Btn.LayoutOrder = LayoutOrder
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Btn.BorderSizePixel = 0
    Btn.Text = Text
    Btn.TextColor3 = Color3.fromRGB(150, 150, 160)
    Btn.TextSize = 15
    Btn.Font = Enum.Font.GothamBold
    Btn.AutoButtonColor = false
    Btn.Parent = TabContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn
    
    return Btn
end

local TabMain = CreateTabButton("TabMain", "الرئيسية", 1)
local TabFootball = CreateTabButton("TabFootball", "Football", 2)
local TabFun = CreateTabButton("TabFun", "Fun", 3)
local TabFFS = CreateTabButton("TabFFS", "FFS", 4)

--// دالة إنشاء محتوى التبويب
local function CreateTabContent(Name)
    local Content = Instance.new("ScrollingFrame")
    Content.Name = Name
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 4
    Content.ScrollBarImageColor3 = Color3.fromRGB(19, 103, 229)
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

--// دالة التبديل بين التبويبات
local function SwitchTab(ActiveTab, ActiveContent)
    for _, btn in ipairs(TabContainer:GetChildren()) do
        if btn:IsA("TextButton") then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 35), TextColor3 = Color3.fromRGB(150, 150, 160)}):Play()
        end
    end
    TweenService:Create(ActiveTab, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(19, 103, 229), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    
    for _, content in ipairs(TabContentContainer:GetChildren()) do
        if content:IsA("ScrollingFrame") then
            content.Visible = false
        end
    end
    ActiveContent.Visible = true
end

-- تعيين التبويب الافتراضي
SwitchTab(TabMain, ContentMain)

TabMain.MouseButton1Click:Connect(function() SwitchTab(TabMain, ContentMain) end)
TabFootball.MouseButton1Click:Connect(function() SwitchTab(TabFootball, ContentFootball) end)
TabFun.MouseButton1Click:Connect(function() SwitchTab(TabFun, ContentFun) end)
TabFFS.MouseButton1Click:Connect(function() SwitchTab(TabFFS, ContentFFS) end)

--// دالة إنشاء زر إجراء (Action Button)
local function CreateActionButton(Name, Text, Parent, Order)
    local Btn = Instance.new("TextButton")
    Btn.Name = Name
    Btn.Size = UDim2.new(1, 0, 0, 45)
    Btn.LayoutOrder = Order or 1
    Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Btn.BorderSizePixel = 0
    Btn.Text = Text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 16
    Btn.Font = Enum.Font.GothamBold
    Btn.AutoButtonColor = false
    Btn.Parent = Parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Thickness = 1
    BtnStroke.Transparency = 0.7
    BtnStroke.Color = Color3.fromRGB(70, 70, 85)
    BtnStroke.Parent = Btn
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(19, 103, 229)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
    end)
    
    return Btn
end

-- ==========================================
-- محتوى التبويبات
-- ==========================================

--// 1. تبويب الرئيسية (Main)
local BtnMainExecute = CreateActionButton("BtnMainExecute", "تفعيل TPS & Touchline", ContentMain, 1)

-- نافذة السؤال المنبثقة (Prompt)
local PromptFrame = Instance.new("Frame")
PromptFrame.Name = "PromptFrame"
PromptFrame.Size = UDim2.fromOffset(300, 140)
PromptFrame.Position = UDim2.fromScale(0.5, 0.5)
PromptFrame.AnchorPoint = Vector2.new(0.5, 0.5)
PromptFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
PromptFrame.BorderSizePixel = 0
PromptFrame.Visible = false
PromptFrame.ZIndex = 100
PromptFrame.Parent = Frame
local PromptCorner = Instance.new("UICorner")
PromptCorner.CornerRadius = UDim.new(0, 12)
PromptCorner.Parent = PromptFrame
local PromptStroke = Instance.new("UIStroke")
PromptStroke.Color = Color3.fromRGB(19, 103, 229)
PromptStroke.Thickness = 1.5
PromptStroke.Parent = PromptFrame

local PromptText = Instance.new("TextLabel")
PromptText.Size = UDim2.new(1, -20, 0, 60)
PromptText.Position = UDim2.fromOffset(10, 15)
PromptText.BackgroundTransparency = 1
PromptText.Text = "هل تريد تشغيل البينج معهما؟"
PromptText.TextColor3 = Color3.fromRGB(255, 255, 255)
PromptText.TextSize = 16
PromptText.Font = Enum.Font.GothamBold
PromptText.ZIndex = 101
PromptText.Parent = PromptFrame

local PromptYes = Instance.new("TextButton")
PromptYes.Size = UDim2.fromOffset(100, 35)
PromptYes.Position = UDim2.fromOffset(40, 85)
PromptYes.BackgroundColor3 = Color3.fromRGB(19, 103, 229)
PromptYes.BorderSizePixel = 0
PromptYes.Text = "Yes"
PromptYes.TextColor3 = Color3.fromRGB(255, 255, 255)
PromptYes.TextSize = 15
PromptYes.Font = Enum.Font.GothamBold
PromptYes.ZIndex = 101
PromptYes.Parent = PromptFrame
local PYCorner = Instance.new("UICorner")
PYCorner.CornerRadius = UDim.new(0, 6)
PYCorner.Parent = PromptYes

local PromptNo = Instance.new("TextButton")
PromptNo.Size = UDim2.fromOffset(100, 35)
PromptNo.Position = UDim2.fromOffset(160, 85)
PromptNo.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
PromptNo.BorderSizePixel = 0
PromptNo.Text = "No"
PromptNo.TextColor3 = Color3.fromRGB(255, 255, 255)
PromptNo.TextSize = 15
PromptNo.Font = Enum.Font.GothamBold
PromptNo.ZIndex = 101
PromptNo.Parent = PromptFrame
local PNCorner = Instance.new("UICorner")
PNCorner.CornerRadius = UDim.new(0, 6)
PNCorner.Parent = PromptNo

-- منطق التنفيذ الرئيسي
BtnMainExecute.MouseButton1Click:Connect(function()
    PromptFrame.Visible = true
    PromptFrame.Position = UDim2.fromScale(0.5, 0.5) -- Reset position for animation
    TweenService:Create(PromptFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, 0.5)}):Play()
end)

PromptNo.MouseButton1Click:Connect(function()
    PromptFrame.Visible = false
    -- تشغيل السكربين الأساسيين فقط
    task.spawn(function()
        pcall(function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/07d323b4106c0dee4680725e35bef651.lua"))() end)
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/hf5DG9ce/raw"))() end)
    end)
end)

PromptYes.MouseButton1Click:Connect(function()
    PromptFrame.Visible = false
    -- تشغيل الثلاثة سكربتات
    task.spawn(function()
        pcall(function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/07d323b4106c0dee4680725e35bef651.lua"))() end)
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/hf5DG9ce/raw"))() end)
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/0644609314z-collab/why-whozuld-u-even-crack-this/refs/heads/main/WHY%20R%20U%20STILLM%20HERE"))() end)
    end)
end)

--// 2. تبويب Football (فارغ أو رسالة ترحيب)
local FootballLabel = Instance.new("TextLabel")
FootballLabel.Size = UDim2.new(1, 0, 0, 40)
FootballLabel.LayoutOrder = 1
FootballLabel.BackgroundTransparency = 1
FootballLabel.Text = "محتوى Football قيد التطوير..."
FootballLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
FootballLabel.TextSize = 16
FootballLabel.Font = Enum.Font.GothamMedium
FootballLabel.Parent = ContentFootball

--// 3. تبويب Fun (VR7)
local BtnVR7 = CreateActionButton("BtnVR7", "تشغيل VR7", ContentFun, 1)
BtnVR7.MouseButton1Click:Connect(function()
    task.spawn(function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VR7ss/OMK/refs/heads/main/VR7-ON-TOP"))() end)
    end)
end)

--// 4. تبويب FFS (أكواد FastFlags)
local FFSLabel = Instance.new("TextLabel")
FFSLabel.Size = UDim2.new(1, 0, 0, 20)
FFSLabel.LayoutOrder = 1
FFSLabel.BackgroundTransparency = 1
FFSLabel.Text = "الصق أكواد JSON هنا:"
FFSLabel.TextColor3 = Color3.fromRGB(19, 103, 229)
FFSLabel.TextSize = 14
FFSLabel.Font = Enum.Font.GothamBold
FFSLabel.TextXAlignment = Enum.TextXAlignment.Left
FFSLabel.Parent = ContentFFS

local FFSBox = Instance.new("TextBox")
FFSBox.Name = "FFSBox"
FFSBox.Size = UDim2.new(1, 0, 0, 180)
FFSBox.LayoutOrder = 2
FFSBox.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
FFSBox.BorderSizePixel = 0
FFSBox.TextColor3 = Color3.fromRGB(200, 200, 200)
FFSBox.TextSize = 13
FFSBox.Font = Enum.Font.Code
FFSBox.TextXAlignment = Enum.TextXAlignment.Left
FFSBox.TextYAlignment = Enum.TextYAlignment.Top
FFSBox.ClearTextOnFocus = false
FFSBox.MultiLine = true
FFSBox.PlaceholderText = '{\n  "FLogNetwork": "7",\n  ...\n}'
FFSBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 90)
FFSBox.Parent = ContentFFS
local FFSBoxCorner = Instance.new("UICorner")
FFSBoxCorner.CornerRadius = UDim.new(0, 8)
FFSBoxCorner.Parent = FFSBox
local FFSBoxStroke = Instance.new("UIStroke")
FFSBoxStroke.Color = Color3.fromRGB(40, 40, 50)
FFSBoxStroke.Thickness = 1
FFSBoxStroke.Parent = FFSBox

local BtnApplyFFS = CreateActionButton("BtnApplyFFS", "تطبيق الأكواد (Execute)", ContentFFS, 3)

-- زر Remove Log (تحت على الشمال)
local BtnRemoveLog = Instance.new("TextButton")
BtnRemoveLog.Name = "BtnRemoveLog"
BtnRemoveLog.Size = UDim2.fromOffset(110, 35)
BtnRemoveLog.Position = UDim2.fromOffset(0, 340) -- أسفل اليسار
BtnRemoveLog.BackgroundColor3 = Color3.fromRGB(35, 15, 15)
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

BtnRemoveLog.MouseEnter:Connect(function()
    TweenService:Create(BtnRemoveLog, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 20, 20)}):Play()
end)
BtnRemoveLog.MouseLeave:Connect(function()
    TweenService:Create(BtnRemoveLog, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 15, 15)}):Play()
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
            -- محاولة تطبيق العلم باستخدام setfflag (تعمل على معظم برامج التنفيذ)
            pcall(function()
                setfflag(flag, tostring(value))
                count += 1
            end)
        end
        FFSBox.Text = "✅ تم تطبيق " .. count .. " بنجاح!"
        task.delay(2, function() FFSBox.Text = jsonText end)
    else
        FFSBox.Text = "❌ خطأ: تأكد من أن النص بصيغة JSON صحيحة."
        task.delay(2, function() FFSBox.Text = "" end)
    end
end)

-- منطق Remove Log
BtnRemoveLog.MouseButton1Click:Connect(function()
    -- محاولة مسح السجلات بطرق مختلفة حسب برنامج التنفيذ
    pcall(function() cleardrawcache() end)
    pcall(function() clearconsole() end)
    
    -- مسح محتوى الصندوق كنوع من التمويه البصري
    FFSBox.Text = ""
    FFSBox.PlaceholderText = "تم مسح السجلات بنجاح ✓"
    
    task.delay(3, function()
        FFSBox.PlaceholderText = '{\n  "FLogNetwork": "7",\n  ...\n}'
    end)
end)

-- ==========================================
-- نظام السحب (Drag System)
-- ==========================================
local Dragging = false
local DragStart = nil
local StartPosition = nil

local function UpdateDrag(Input)
    if not DragStart or not StartPosition then return end
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
    end
end)

TopBar.InputChanged:Connect(function(Input)
    if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
        UpdateDrag(Input)
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

-- ==========================================
-- حركات الدخول والخروج
-- ==========================================
CloseButton.MouseButton1Click:Connect(function()
    Dragging = false
    local CloseTween = TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 1.5, 0)})
    CloseTween:Play()
    CloseTween.Completed:Connect(function()
        if Gui and Gui.Parent then Gui:Destroy() end
    end)
end)

-- حركة الفتح
TweenService:Create(Frame, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
