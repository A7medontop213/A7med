local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- تنظيف الواجهة القديمة
local Old = PlayerGui:FindFirstChild("A7medHub")
if Old then Old:Destroy() end

--// الألوان (ثيم داكن نظيف)
local DarkBg = Color3.fromRGB(12, 12, 18)
local DarkerBg = Color3.fromRGB(8, 8, 12)
local Accent = Color3.fromRGB(0, 162, 255)
local TextColor = Color3.fromRGB(220, 220, 230)
local TextMuted = Color3.fromRGB(140, 140, 150)

--// إنشاء الواجهة
local Gui = Instance.new("ScreenGui")
Gui.Name = "A7medHub"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--// الإطار الرئيسي
local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.fromOffset(520, 480) -- عرض أكبر لراحة العين عند كتابة الأكواد
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = DarkBg
Frame.BorderSizePixel = 0
Frame.Parent = Gui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 12)
FrameCorner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 1.5
Stroke.Color = Accent
Stroke.Transparency = 0.7
Stroke.Parent = Frame

--// شريط العنوان (بسيط ونظيف)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = DarkerBg
TopBar.BorderSizePixel = 0
TopBar.Parent = Frame
local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.fromOffset(15, 0)
Title.BackgroundTransparency = 1
Title.Text = "A7med Hub"
Title.TextColor3 = TextColor
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(35, 35)
CloseBtn.Position = UDim2.new(1, -5, 0.5, 0)
CloseBtn.AnchorPoint = Vector2.new(1, 0.5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar

CloseBtn.MouseEnter:Connect(function() CloseBtn.TextColor3 = Color3.fromRGB(255, 120, 120) end)
CloseBtn.MouseLeave:Connect(function() CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80) end)

--// نظام التبويبات
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 40)
TabContainer.Position = UDim2.fromOffset(10, 55)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = Frame

local TabList = Instance.new("UIListLayout")
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 5)
TabList.Parent = TabContainer

local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, -20, 1, -105)
ContentContainer.Position = UDim2.fromOffset(10, 105)
ContentContainer.BackgroundTransparency = 1
ContentContainer.BorderSizePixel = 0
ContentContainer.ScrollBarThickness = 4
ContentContainer.ScrollBarImageColor3 = Accent
ContentContainer.Parent = Frame

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 10)
ContentPadding.PaddingLeft = UDim.new(0, 10)
ContentPadding.PaddingRight = UDim.new(0, 10)
ContentPadding.PaddingBottom = UDim.new(0, 10)
ContentPadding.Parent = ContentContainer

local ContentList = Instance.new("UIListLayout")
ContentList.SortOrder = Enum.SortOrder.LayoutOrder
ContentList.Padding = UDim.new(0, 12)
ContentList.Parent = ContentContainer

--// دالة إنشاء التبويبات
local function CreateTab(Name, Text, Order)
    local Btn = Instance.new("TextButton")
    Btn.Name = Name
    Btn.Size = UDim2.fromOffset(110, 36)
    Btn.LayoutOrder = Order
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    Btn.BorderSizePixel = 0
    Btn.Text = Text
    Btn.TextColor3 = TextMuted
    Btn.TextSize = 14
    Btn.Font = Enum.Font.GothamBold
    Btn.AutoButtonColor = false
    Btn.Parent = TabContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn
    
    return Btn
end

local TabMain = CreateTab("TabMain", "الرئيسية", 1)
local TabFootball = CreateTab("TabFootball", "Football", 2)
local TabFun = CreateTab("TabFun", "Fun", 3)
local TabFFS = CreateTab("TabFFS", "FFS", 4)

local function CreateContent(Name)
    local Content = Instance.new("Frame")
    Content.Name = Name
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.BackgroundTransparency = 1
    Content.Visible = false
    Content.Parent = ContentContainer
    
    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 12)
    Layout.Parent = Content
    
    return Content
end

local ContentMain = CreateContent("ContentMain")
local ContentFootball = CreateContent("ContentFootball")
local ContentFun = CreateContent("ContentFun")
local ContentFFS = CreateContent("ContentFFS")

--// منطق التبديل بين التبويبات
local function SwitchTab(ActiveBtn, ActiveContent)
    for _, btn in ipairs(TabContainer:GetChildren()) do
        if btn:IsA("TextButton") then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 28), TextColor3 = TextMuted}):Play()
        end
    end
    TweenService:Create(ActiveBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 40, 60), TextColor3 = Accent}):Play()
    
    for _, content in ipairs(ContentContainer:GetChildren()) do
        if content:IsA("Frame") then content.Visible = false end
    end
    ActiveContent.Visible = true
end

SwitchTab(TabMain, ContentMain)
TabMain.MouseButton1Click:Connect(function() SwitchTab(TabMain, ContentMain) end)
TabFootball.MouseButton1Click:Connect(function() SwitchTab(TabFootball, ContentFootball) end)
TabFun.MouseButton1Click:Connect(function() SwitchTab(TabFun, ContentFun) end)
TabFFS.MouseButton1Click:Connect(function() SwitchTab(TabFFS, ContentFFS) end)

--// دالة إنشاء الأزرار
local function CreateActionBtn(Text, Parent, Order)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 42)
    Btn.LayoutOrder = Order or 1
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    Btn.BorderSizePixel = 0
    Btn.Text = Text
    Btn.TextColor3 = TextColor
    Btn.TextSize = 15
    Btn.Font = Enum.Font.GothamBold
    Btn.AutoButtonColor = false
    Btn.Parent = Parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Thickness = 1
    BtnStroke.Color = Accent
    BtnStroke.Transparency = 0.8
    BtnStroke.Parent = Btn
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 50, 70)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 28)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Transparency = 0.8}):Play()
    end)
    return Btn
end

-- ==========================================
-- محتوى التبويبات
-- ==========================================

-- 1. الرئيسية
local BtnMain = CreateActionBtn("⚡ تفعيل TPS & Touchline", ContentMain, 1)

-- نافذة منبثقة بسيطة للسؤال
local Prompt = Instance.new("Frame")
Prompt.Size = UDim2.fromOffset(300, 130)
Prompt.Position = UDim2.fromScale(0.5, 0.5)
Prompt.AnchorPoint = Vector2.new(0.5, 0.5)
Prompt.BackgroundColor3 = DarkerBg
Prompt.BorderSizePixel = 0
Prompt.Visible = false
Prompt.ZIndex = 50
Prompt.Parent = Frame
local PCorner = Instance.new("UICorner") PCorner.CornerRadius = UDim.new(0, 8) PCorner.Parent = Prompt
local PStroke = Instance.new("UIStroke") PStroke.Color = Accent PStroke.Thickness = 1.5 PStroke.Parent = Prompt

local PText = Instance.new("TextLabel")
PText.Size = UDim2.new(1, 0, 0, 50)
PText.BackgroundTransparency = 1
PText.Text = "هل تريد تشغيل البينج معهما؟"
PText.TextColor3 = TextColor
PText.TextSize = 16
PText.Font = Enum.Font.GothamBold
PText.ZIndex = 51
PText.Parent = Prompt

local PYes = Instance.new("TextButton")
PYes.Size = UDim2.fromOffset(100, 35)
PYes.Position = UDim2.fromOffset(40, 75)
PYes.BackgroundColor3 = Accent
PYes.BorderSizePixel = 0
PYes.Text = "Yes"
PYes.TextColor3 = Color3.fromRGB(255,255,255)
PYes.TextSize = 14
PYes.Font = Enum.Font.GothamBold
PYes.ZIndex = 51
PYes.Parent = Prompt
local PYCorner = Instance.new("UICorner") PYCorner.CornerRadius = UDim.new(0, 6) PYCorner.Parent = PYes

local PNo = Instance.new("TextButton")
PNo.Size = UDim2.fromOffset(100, 35)
PNo.Position = UDim2.fromOffset(160, 75)
PNo.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
PNo.BorderSizePixel = 0
PNo.Text = "No"
PNo.TextColor3 = Color3.fromRGB(255,255,255)
PNo.TextSize = 14
PNo.Font = Enum.Font.GothamBold
PNo.ZIndex = 51
PNo.Parent = Prompt
local PNCorner = Instance.new("UICorner") PNCorner.CornerRadius = UDim.new(0, 6) PNCorner.Parent = PNo

BtnMain.MouseButton1Click:Connect(function()
    Prompt.Visible = true
    TweenService:Create(Prompt, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = UDim2.fromScale(0.5, 0.5)}):Play()
end)

PNo.MouseButton1Click:Connect(function()
    Prompt.Visible = false
    task.spawn(function()
        pcall(function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/07d323b4106c0dee4680725e35bef651.lua"))() end)
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/hf5DG9ce/raw"))() end)
    end)
end)

PYes.MouseButton1Click:Connect(function()
    Prompt.Visible = false
    task.spawn(function()
        pcall(function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/07d323b4106c0dee4680725e35bef651.lua"))() end)
        pcall(function() loadstring(game:HttpGet("https://pastefy.app/hf5DG9ce/raw"))() end)
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/0644609314z-collab/why-whozuld-u-even-crack-this/refs/heads/main/WHY%20R%20U%20STILLM%20HERE"))() end)
    end)
end)

-- 2. Football
local FbText = Instance.new("TextLabel")
FbText.Size = UDim2.new(1, 0, 0, 40)
FbText.BackgroundTransparency = 1
FbText.Text = "🎯 قسم Football قيد التطوير..."
FbText.TextColor3 = TextMuted
FbText.TextSize = 15
FbText.Font = Enum.Font.GothamMedium
FbText.Parent = ContentFootball

-- 3. Fun
local BtnVR7 = CreateActionBtn("🎮 تشغيل VR7", ContentFun, 1)
BtnVR7.MouseButton1Click:Connect(function()
    task.spawn(function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VR7ss/OMK/refs/heads/main/VR7-ON-TOP"))() end) end)
end)

-- 4. FFS (صندوق الأكواد غير المحدود)
local FFSLabel = Instance.new("TextLabel")
FFSLabel.Size = UDim2.new(1, 0, 0, 25)
FFSLabel.BackgroundTransparency = 1
FFSLabel.Text = "📋 الصق أكواد FastFlags (JSON) هنا:"
FFSLabel.TextColor3 = Accent
FFSLabel.TextSize = 14
FFSLabel.Font = Enum.Font.GothamBold
FFSLabel.TextXAlignment = Enum.TextXAlignment.Left
FFSLabel.Parent = ContentFFS

-- الحاوية التي تمنع اقتطاع النص مهما كان طوله
local FFSBoxContainer = Instance.new("ScrollingFrame")
FFSBoxContainer.Size = UDim2.new(1, 0, 1, -90)
FFSBoxContainer.BackgroundTransparency = 1
FFSBoxContainer.BorderSizePixel = 0
FFSBoxContainer.ScrollBarThickness = 5
FFSBoxContainer.ScrollBarImageColor3 = Accent
FFSBoxContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y -- هذا هو السر لعدم اقتطاع الأسطر
FFSBoxContainer.Parent = ContentFFS

local FFSBox = Instance.new("TextBox")
FFSBox.Size = UDim2.new(1, -10, 1, 0)
FFSBox.Position = UDim2.fromOffset(5, 0)
FFSBox.BackgroundTransparency = 1
FFSBox.TextColor3 = Color3.fromRGB(200, 220, 255)
FFSBox.TextSize = 13
FFSBox.Font = Enum.Font.Code -- خط مخصص للأكواد
FFSBox.TextXAlignment = Enum.TextXAlignment.Left
FFSBox.TextYAlignment = Enum.TextYAlignment.Top
FFSBox.ClearTextOnFocus = false
FFSBox.MultiLine = true
FFSBox.TextWrapped = true -- يمنع اقتطاع النص ويجعله ينزل لسطر جديد
FFSBox.PlaceholderText = "-- الصق كود JSON هنا (يدعم آلاف الأسطر بدون أي اقتطاع)...\n{\n  \"FLogNetwork\": \"7\"\n}"
FFSBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 100)
FFSBox.Parent = FFSBoxContainer

local BtnApplyFFS = CreateActionBtn("✅ تطبيق الأكواد (Execute)", ContentFFS, 2)

-- زر مسح السجلات (أسفل اليسار)
local BtnRemoveLog = Instance.new("TextButton")
BtnRemoveLog.Size = UDim2.fromOffset(130, 35)
BtnRemoveLog.Position = UDim2.fromOffset(0, 410)
BtnRemoveLog.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
BtnRemoveLog.BorderSizePixel = 0
BtnRemoveLog.Text = "🗑️ مسح السجلات"
BtnRemoveLog.TextColor3 = Color3.fromRGB(255, 100, 100)
BtnRemoveLog.TextSize = 13
BtnRemoveLog.Font = Enum.Font.GothamBold
BtnRemoveLog.AutoButtonColor = false
BtnRemoveLog.Parent = ContentFFS
local RLCorner = Instance.new("UICorner") RLCorner.CornerRadius = UDim.new(0, 6) RLCorner.Parent = BtnRemoveLog

BtnRemoveLog.MouseEnter:Connect(function() TweenService:Create(BtnRemoveLog, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 15, 15)}):Play() end)
BtnRemoveLog.MouseLeave:Connect(function() TweenService:Create(BtnRemoveLog, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 10, 10)}):Play() end)

BtnApplyFFS.MouseButton1Click:Connect(function()
    local jsonText = FFSBox.Text
    if jsonText == "" or jsonText:find("الصق كود") then return end
    
    local success, parsed = pcall(function() return HttpService:JSONDecode(jsonText) end)
    if success then
        local count = 0
        for flag, value in pairs(parsed) do
            pcall(function() setfflag(flag, tostring(value)) count += 1 end)
        end
        local original = FFSBox.Text
        FFSBox.Text = "✅ تم تطبيق " .. count .. " فلاج بنجاح!"
        task.delay(2, function() if FFSBox.Text:find("تم تطبيق") then FFSBox.Text = original end end)
    else
        local original = FFSBox.Text
        FFSBox.Text = "❌ خطأ: تأكد من أن النص بصيغة JSON صحيحة."
        task.delay(2.5, function() if FFSBox.Text:find("خطأ") then FFSBox.Text = original end end)
    end
end)

BtnRemoveLog.MouseButton1Click:Connect(function()
    pcall(function() cleardrawcache() end)
    pcall(function() clearconsole() end)
    FFSBox.Text = ""
    local originalPH = FFSBox.PlaceholderText
    FFSBox.PlaceholderText = "✅ تم مسح السجلات والآثار بنجاح"
    task.delay(2.5, function() FFSBox.PlaceholderText = originalPH end)
end)

-- ==========================================
-- نظام السحب (Drag)
-- ==========================================
local Dragging, DragStart, StartPos = false, nil, nil
TopBar.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        if Input.Target == CloseBtn then return end
        Dragging = true
        DragStart = Input.Position
        StartPos = Frame.Position
    end
end)
TopBar.InputChanged:Connect(function(Input)
    if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
        local Delta = Input.Position - DragStart
        Frame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then Dragging = false end
end)

-- ==========================================
-- نظام الإخفاء والإظهار (Home / End)
-- ==========================================
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then return end -- تجاهل الضغط إذا كان اللاعب يكتب في شات اللعبة
    
    if Input.KeyCode == Enum.KeyCode.End then
        Gui.Enabled = false -- إخفاء كامل (يوفر الأداء)
    elseif Input.KeyCode == Enum.KeyCode.Home then
        Gui.Enabled = true -- إظهار فوري
    end
end)

-- ==========================================
-- حركات الدخول والخروج
-- ==========================================
CloseBtn.MouseButton1Click:Connect(function()
    Dragging = false
    local CloseTween = TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 1.5, 0)})
    CloseTween:Play()
    CloseTween.Completed:Connect(function() if Gui and Gui.Parent then Gui:Destroy() end end)
end)

-- حركة الفتح
TweenService:Create(Frame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
