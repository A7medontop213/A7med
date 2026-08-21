-- ==========================================
-- 1. Services & Safe Environment Setup
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local StatsService = game:GetService("Stats")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

-- Clean previous instances safely
local function CleanPrevious()
    local parent = gethui and gethui() or CoreGui
    if parent:FindFirstChild("A7medExecutorUI") then parent.A7medExecutorUI:Destroy() end
    if parent:FindFirstChild("A7medHub_Notifications") then parent.A7medHub_Notifications:Destroy() end
end
CleanPrevious()

-- Cleanup Registries (من كودك الممتاز)
local running = true
local workers = {}
local activeTimers = {}
local connections = {}

local function TrackThread(thread) table.insert(workers, thread) return thread end
local function TrackTimer(thread) activeTimers[thread] = true return thread end
local function CleanupTimer(thread) activeTimers[thread] = nil end
local function TrackConnection(connection) table.insert(connections, connection) return connection end

-- ==========================================
-- 2. Theme & Config (Neon Blue)
-- ==========================================
local Theme = {
    Background = Color3.fromRGB(10, 11, 16),
    Surface = Color3.fromRGB(17, 19, 27),
    SurfaceHover = Color3.fromRGB(24, 27, 38),
    Accent = Color3.fromRGB(0, 170, 255),
    Text = Color3.fromRGB(240, 242, 248),
    Muted = Color3.fromRGB(145, 150, 165),
    Success = Color3.fromRGB(60, 210, 130),
    Danger = Color3.fromRGB(240, 75, 85),
}

local UIConfig = {
    WindowWidth = 720,
    WindowHeight = 480,
    SidebarWidth = 180,
    Radius = 12,
    ButtonHeight = 64,
    AnimSpeed = 0.2,
}

-- ==========================================
-- 3. ScreenGui Setup with Protected Parent Logic
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "A7medExecutorUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

-- ==========================================
-- 4. UI Helper Functions
-- ==========================================
local function CreateShadow(parent)
    local Shadow = Instance.new("Frame")
    Shadow.Size = UDim2.new(1, 10, 1, 10)
    Shadow.Position = UDim2.fromOffset(-5, 5)
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 0.6
    Shadow.BorderSizePixel = 0
    Shadow.ZIndex = parent.ZIndex - 1
    Shadow.Parent = parent
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, UIConfig.Radius)
    Corner.Parent = Shadow
end

local function Notify(title, message, type)
    local NotifContainer = ScreenGui.Parent:FindFirstChild("A7medHub_Notifications")
    if not NotifContainer then
        NotifContainer = Instance.new("ScreenGui")
        NotifContainer.Name = "A7medHub_Notifications"
        NotifContainer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        NotifContainer.Parent = ScreenGui.Parent
    end

    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.fromOffset(300, 70)
    Notif.Position = UDim2.new(1, -30, 1, 10)
    Notif.AnchorPoint = Vector2.new(1, 1)
    Notif.BackgroundColor3 = Theme.Surface
    Notif.BorderSizePixel = 0
    Notif.Parent = NotifContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Notif
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = type == "success" and Theme.Success or Theme.Danger
    Stroke.Thickness = 2
    Stroke.Parent = Notif

    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Size = UDim2.new(1, -40, 0, 30)
    TitleLbl.Position = UDim2.fromOffset(40, 10)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text = (type == "success" and "✅ " or "❌ ") .. title
    TitleLbl.TextColor3 = Theme.Text
    TitleLbl.TextSize = 15
    TitleLbl.Font = Enum.Font.GothamBold
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    TitleLbl.Parent = Notif

    local MsgLbl = Instance.new("TextLabel")
    MsgLbl.Size = UDim2.new(1, -40, 0, 30)
    MsgLbl.Position = UDim2.fromOffset(40, 35)
    MsgLbl.BackgroundTransparency = 1
    MsgLbl.Text = message
    MsgLbl.TextColor3 = Theme.Muted
    MsgLbl.TextSize = 13
    MsgLbl.Font = Enum.Font.GothamMedium
    MsgLbl.TextXAlignment = Enum.TextXAlignment.Left
    MsgLbl.Parent = Notif

    TweenService:Create(Notif, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(1, -30, 1, -30)}):Play()

    local delayThread = task.delay(3, function()
        if Notif and Notif.Parent then
            TweenService:Create(Notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -30, 1, 10), BackgroundTransparency = 1}):Play()
            task.wait(0.3)
            Notif:Destroy()
        end
        CleanupTimer(delayThread)
    end)
    TrackTimer(delayThread)
end

-- ==========================================
-- 5. Main GUI Construction
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.fromOffset(UIConfig.WindowWidth, UIConfig.WindowHeight)
MainFrame.Position = UDim2.fromScale(0.5, 0.55)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

CreateShadow(MainFrame)
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, UIConfig.Radius)
MainCorner.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Theme.Surface
Header.BorderSizePixel = 0
Header.Parent = MainFrame
local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, UIConfig.Radius)
HeaderCorner.Parent = Header

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 24, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 14, 20))
})
Gradient.Rotation = 90
Gradient.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 0, 30)
Title.Position = UDim2.fromOffset(20, 10)
Title.BackgroundTransparency = 1
Title.Text = "A7med Hub"
Title.TextColor3 = Theme.Text
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -100, 0, 20)
Subtitle.Position = UDim2.fromOffset(20, 35)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Premium Utility Interface"
Subtitle.TextColor3 = Theme.Muted
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

-- Ping Label (من كودك)
local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.fromOffset(100, 24)
PingLabel.Position = UDim2.new(1, -120, 0.5, 0)
PingLabel.AnchorPoint = Vector2.new(0.5, 0.5)
PingLabel.BackgroundColor3 = Color3.fromRGB(0, 40, 30)
PingLabel.BorderSizePixel = 0
PingLabel.Text = "Ping: ..."
PingLabel.TextColor3 = Theme.Success
PingLabel.TextSize = 12
PingLabel.Font = Enum.Font.GothamBold
PingLabel.Parent = Header
local PingCorner = Instance.new("UICorner")
PingCorner.CornerRadius = UDim.new(1, 0)
PingCorner.Parent = PingLabel

TrackThread(task.spawn(function()
    while running do
        task.wait(2)
        if not running then break end
        local success, pingVal = pcall(function()
            return math.floor(StatsService.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        if success then
            PingLabel.Text = "Ping: " .. pingVal .. " ms"
        else
            PingLabel.Text = "Ping: N/A"
        end
    end
end))

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(40, 40)
CloseBtn.Position = UDim2.new(1, -10, 0.5, 0)
CloseBtn.AnchorPoint = Vector2.new(1, 0.5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.Danger
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = Header

CloseBtn.MouseEnter:Connect(function() CloseBtn.TextColor3 = Color3.fromRGB(255, 120, 120) end)
CloseBtn.MouseLeave:Connect(function() CloseBtn.TextColor3 = Theme.Danger end)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.fromOffset(UIConfig.SidebarWidth, 1, -60)
Sidebar.Position = UDim2.fromOffset(0, 60)
Sidebar.BackgroundColor3 = Theme.Surface
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarList = Instance.new("UIListLayout")
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Padding = UDim.new(0, 4)
SidebarList.Parent = Sidebar
local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 15)
SidebarPadding.PaddingLeft = UDim.new(0, 15)
SidebarPadding.PaddingRight = UDim.new(0, 15)
SidebarPadding.PaddingBottom = UDim.new(0, 15)
SidebarPadding.Parent = Sidebar

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -UIConfig.SidebarWidth, 1, -60)
ContentArea.Position = UDim2.fromOffset(UIConfig.SidebarWidth, 60)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 25)
ContentPadding.PaddingLeft = UDim.new(0, 25)
ContentPadding.PaddingRight = UDim.new(0, 25)
ContentPadding.PaddingBottom = UDim.new(0, 25)
ContentPadding.Parent = ContentArea

local ContentList = Instance.new("UIListLayout")
ContentList.SortOrder = Enum.SortOrder.LayoutOrder
ContentList.Padding = UDim.new(0, 15)
ContentList.Parent = ContentArea

-- ==========================================
-- 6. Pages & Logic
-- ==========================================
local Pages = {}
local ActiveTabBtn = nil

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 4
    Page.ScrollBarImageColor3 = Theme.Accent
    Page.Visible = false
    Page.Parent = ContentArea
    
    local Layout = Instance.new("UIListLayout")
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 15)
    Layout.Parent = Page
    Pages[name] = Page
    return Page
end

local function SwitchPage(pageName, btn)
    for _, page in pairs(Pages) do page.Visible = false end
    Pages[pageName].Visible = true
    
    if ActiveTabBtn then
        TweenService:Create(ActiveTabBtn, TweenInfo.new(UIConfig.AnimSpeed), {BackgroundColor3 = Theme.Surface, TextColor3 = Theme.Muted}):Play()
    end
    ActiveTabBtn = btn
    TweenService:Create(ActiveTabBtn, TweenInfo.new(UIConfig.AnimSpeed), {BackgroundColor3 = Color3.fromRGB(0, 30, 50), TextColor3 = Theme.Accent}):Play()
end

local function CreateTab(name, icon, text, order)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.LayoutOrder = order
    Btn.BackgroundColor3 = Theme.Surface
    Btn.BorderSizePixel = 0
    Btn.Text = icon .. "  " .. text
    Btn.TextColor3 = Theme.Muted
    Btn.TextSize = 15
    Btn.Font = Enum.Font.GothamBold
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.AutoButtonColor = false
    Btn.Parent = Sidebar
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function() SwitchPage(name, Btn) end)
    return Btn
end

local TabHome = CreateTab("Home", "◈", "الرئيسية", 1)
local TabFootball = CreateTab("Football", "⚽", "Football", 2)
local TabFun = CreateTab("Fun", "🎮", "Fun", 3)
local TabFFS = CreateTab("FFS", "⚙", "FFS", 4)

-- Card Button Helper
local function CreateCardButton(parent, icon, title, desc, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, UIConfig.ButtonHeight)
    Btn.BackgroundColor3 = Theme.Surface
    Btn.BorderSizePixel = 0
    Btn.Text = ""
    Btn.AutoButtonColor = false
    Btn.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, UIConfig.Radius)
    Corner.Parent = Btn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(30, 35, 45)
    Stroke.Thickness = 1
    Stroke.Parent = Btn

    local IconLbl = Instance.new("TextLabel")
    IconLbl.Size = UDim2.fromOffset(40, 40)
    IconLbl.Position = UDim2.fromOffset(12, 12)
    IconLbl.BackgroundTransparency = 1
    IconLbl.Text = icon
    IconLbl.TextSize = 22
    IconLbl.TextColor3 = Theme.Accent
    IconLbl.Font = Enum.Font.GothamBold
    IconLbl.Parent = Btn

    local TextContainer = Instance.new("Frame")
    TextContainer.Size = UDim2.new(1, -70, 1, 0)
    TextContainer.Position = UDim2.fromOffset(60, 0)
    TextContainer.BackgroundTransparency = 1
    TextContainer.Parent = Btn

    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Size = UDim2.new(1, 0, 0.5, 0)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text = title
    TitleLbl.TextColor3 = Theme.Text
    TitleLbl.TextSize = 16
    TitleLbl.Font = Enum.Font.GothamBold
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    TitleLbl.Parent = TextContainer

    local DescLbl = Instance.new("TextLabel")
    DescLbl.Size = UDim2.new(1, 0, 0.5, 0)
    DescLbl.Position = UDim2.fromScale(0, 0.5)
    DescLbl.BackgroundTransparency = 1
    DescLbl.Text = desc
    DescLbl.TextColor3 = Theme.Muted
    DescLbl.TextSize = 13
    DescLbl.Font = Enum.Font.GothamMedium
    DescLbl.TextXAlignment = Enum.TextXAlignment.Left
    DescLbl.Parent = TextContainer

    local Arrow = Instance.new("TextLabel")
    Arrow.Size = UDim2.fromOffset(20, 20)
    Arrow.Position = UDim2.new(1, -20, 0.5, 0)
    Arrow.AnchorPoint = Vector2.new(0.5, 0.5)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "›"
    Arrow.TextColor3 = Theme.Muted
    Arrow.TextSize = 24
    Arrow.Font = Enum.Font.GothamBold
    Arrow.Parent = Btn

    local NormalSize = UDim2.new(1, 0, 0, UIConfig.ButtonHeight)
    local HoverSize = UDim2.new(1, 0, 0, UIConfig.ButtonHeight + 4)

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(UIConfig.AnimSpeed, Enum.EasingStyle.Quint), {Size = HoverSize, BackgroundColor3 = Theme.SurfaceHover}):Play()
        TweenService:Create(Stroke, TweenInfo.new(UIConfig.AnimSpeed), {Color = Theme.Accent}):Play()
        TweenService:Create(Arrow, TweenInfo.new(UIConfig.AnimSpeed), {TextColor3 = Theme.Accent}):Play()
    end)

    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(UIConfig.AnimSpeed, Enum.EasingStyle.Quint), {Size = NormalSize, BackgroundColor3 = Theme.Surface}):Play()
        TweenService:Create(Stroke, TweenInfo.new(UIConfig.AnimSpeed), {Color = Color3.fromRGB(30, 35, 45)}):Play()
        TweenService:Create(Arrow, TweenInfo.new(UIConfig.AnimSpeed), {TextColor3 = Theme.Muted}):Play()
    end)

    TrackConnection(Btn.MouseButton1Click:Connect(function() 
        if callback then callback() end 
    end))
    return Btn
end

-- --- Page: Home ---
local PageHome = CreatePage("Home")
CreateCardButton(PageHome, "⚡", "تحميل A7med Hub", "تشغيل السكربت الرئيسي مع حماية كاملة", function()
    Notify("جاري التحميل", "يتم الآن تحميل A7med Hub...", "success")
    task.spawn(function()
        local success, scriptContent = pcall(function()
            return game:HttpGet("https://raw.githubusercontent.com/A7medontop213/A7med/refs/heads/main/A7medHub.lua")
        end)
        if success and scriptContent then
            local loadedFunc, compileErr = loadstring(scriptContent)
            if loadedFunc then
                local execSuccess, execErr = pcall(loadedFunc)
                if execSuccess then
                    Notify("تم بنجاح", "تم تشغيل A7med Hub بنجاح", "success")
                else
                    Notify("خطأ", "خطأ أثناء التشغيل: " .. tostring(execErr), "danger")
                end
            else
                Notify("خطأ", "خطأ في التجميع: " .. tostring(compileErr), "danger")
            end
        else
            Notify("فشل", "فشل جلب السكربت من الرابط", "danger")
        end
    end)
end)

-- --- Page: Football ---
local PageFootball = CreatePage("Football")
local FbPlaceholder = Instance.new("TextLabel")
FbPlaceholder.Size = UDim2.new(1, 0, 0, 40)
FbPlaceholder.BackgroundTransparency = 1
FbPlaceholder.Text = "🎯 قسم Football قيد التطوير..."
FbPlaceholder.TextColor3 = Theme.Muted
FbPlaceholder.TextSize = 15
FbPlaceholder.Font = Enum.Font.GothamMedium
FbPlaceholder.Parent = PageFootball

-- --- Page: Fun ---
local PageFun = CreatePage("Fun")
CreateCardButton(PageFun, "🕶", "تشغيل VR7", "Utility script for enhanced experience", function()
    Notify("جاري التحميل", "يتم الآن تشغيل VR7...", "success")
    task.spawn(function()
        local success, scriptContent = pcall(function()
            return game:HttpGet("https://raw.githubusercontent.com/VR7ss/OMK/refs/heads/main/VR7-ON-TOP")
        end)
        if success and scriptContent then
            local loadedFunc, compileErr = loadstring(scriptContent)
            if loadedFunc then
                pcall(loadedFunc)
                Notify("تم بنجاح", "تم تشغيل VR7 بنجاح", "success")
            else
                Notify("خطأ", "خطأ في التجميع: " .. tostring(compileErr), "danger")
            end
        else
            Notify("فشل", "فشل جلب السكربت", "danger")
        end
    end)
end)

-- --- Page: FFS (Infinite JSON Box) ---
local PageFFS = CreatePage("FFS")

local FFSLabel = Instance.new("TextLabel")
FFSLabel.Size = UDim2.new(1, 0, 0, 25)
FFSLabel.BackgroundTransparency = 1
FFSLabel.Text = "📋 الصق أكواد FastFlags (JSON) الضخمة هنا:"
FFSLabel.TextColor3 = Theme.Accent
FFSLabel.TextSize = 14
FFSLabel.Font = Enum.Font.GothamBold
FFSLabel.TextXAlignment = Enum.TextXAlignment.Left
FFSLabel.Parent = PageFFS

local FFSBoxContainer = Instance.new("ScrollingFrame")
FFSBoxContainer.Size = UDim2.new(1, 0, 0, 320)
FFSBoxContainer.BackgroundTransparency = 1
FFSBoxContainer.BorderSizePixel = 0
FFSBoxContainer.ScrollBarThickness = 6
FFSBoxContainer.ScrollBarImageColor3 = Theme.Accent
FFSBoxContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y -- السر في عدم الاقتطاع
FFSBoxContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
FFSBoxContainer.Parent = PageFFS

local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 8)
ContainerCorner.Parent = FFSBoxContainer

local ContainerStroke = Instance.new("UIStroke")
ContainerStroke.Color = Color3.fromRGB(30, 35, 45)
ContainerStroke.Thickness = 1
ContainerStroke.Parent = FFSBoxContainer

local FFSBox = Instance.new("TextBox")
FFSBox.Size = UDim2.new(1, -15, 0, 0) -- الارتفاع 0 ليتمدد تلقائياً
FFSBox.Position = UDim2.fromOffset(7, 7)
FFSBox.BackgroundTransparency = 1
FFSBox.TextColor3 = Color3.fromRGB(200, 220, 255)
FFSBox.TextSize = 13
FFSBox.Font = Enum.Font.Code
FFSBox.TextXAlignment = Enum.TextXAlignment.Left
FFSBox.TextYAlignment = Enum.TextYAlignment.Top
FFSBox.ClearTextOnFocus = false
FFSBox.MultiLine = true
FFSBox.TextWrapped = true
FFSBox.PlaceholderText = "-- الصق كود JSON الضخم هنا (يدعم آلاف الأسطر)...\n{\n  \"FLogNetwork\": \"7\"\n}"
FFSBox.PlaceholderColor3 = Theme.Muted
FFSBox.Parent = FFSBoxContainer

CreateCardButton(PageFFS, "✅", "تطبيق الأكواد (Execute)", "يقوم بتحليل وتطبيق جميع المفاتيح دفعة واحدة", function()
    local jsonText = FFSBox.Text
    if jsonText == "" or jsonText:find("الصق كود") then
        Notify("تنبيه", "الصندوق فارغ!", "danger")
        return 
    end

    local success, parsed = pcall(function() return HttpService:JSONDecode(jsonText) end)
    if success then
        local count = 0
        for flag, value in pairs(parsed) do
            pcall(function()
                setfflag(flag, tostring(value))
                count += 1
            end)
        end
        Notify("نجاح", "تم تطبيق " .. count .. " فلاج بنجاح!", "success")
    else
        Notify("خطأ", "تأكد من أن النص بصيغة JSON صحيحة", "danger")
    end
end)

local BtnRemoveLog = Instance.new("TextButton")
BtnRemoveLog.Size = UDim2.new(1, 0, 0, 42)
BtnRemoveLog.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
BtnRemoveLog.BorderSizePixel = 0
BtnRemoveLog.Text = "🗑️ مسح السجلات والآثار"
BtnRemoveLog.TextColor3 = Theme.Danger
BtnRemoveLog.TextSize = 14
BtnRemoveLog.Font = Enum.Font.GothamBold
BtnRemoveLog.AutoButtonColor = false
BtnRemoveLog.Parent = PageFFS
local RLCorner = Instance.new("UICorner") RLCorner.CornerRadius = UDim.new(0, 8) RLCorner.Parent = BtnRemoveLog

BtnRemoveLog.MouseEnter:Connect(function() TweenService:Create(BtnRemoveLog, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 15, 15)}):Play() end)
BtnRemoveLog.MouseLeave:Connect(function() TweenService:Create(BtnRemoveLog, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 10, 10)}):Play() end)
TrackConnection(BtnRemoveLog.MouseButton1Click:Connect(function()
    pcall(function() cleardrawcache() end)
    pcall(function() clearconsole() end)
    FFSBox.Text = ""
    Notify("تم التنظيف", "تم مسح السجلات والآثار بنجاح", "success")
end))

-- ==========================================
-- 7. Dragging System (من كودك الممتاز)
-- ==========================================
local dragging = false
local dragInput, dragStart, startPos

TrackConnection(Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if input.Target == CloseBtn then return end
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end))

TrackConnection(Header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end))

TrackConnection(Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end))

TrackConnection(UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end))

-- ==========================================
-- 8. Keyboard Shortcuts (Home / End)
-- ==========================================
TrackConnection(UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.End then
        ScreenGui.Enabled = false
    elseif input.KeyCode == Enum.KeyCode.Home then
        ScreenGui.Enabled = true
    end
end))

-- ==========================================
-- 9. Opening Animation & Close Cleanup
-- ==========================================
TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Size = UDim2.fromOffset(UIConfig.WindowWidth, UIConfig.WindowHeight),
    BackgroundTransparency = 0,
    Position = UDim2.fromScale(0.5, 0.5)
}):Play()

TrackConnection(CloseBtn.MouseButton1Click:Connect(function()
    running = false

    -- Disconnect all UI Connections
    for _, conn in ipairs(connections) do
        if conn and conn.Connected then conn:Disconnect() end
    end

    -- Cancel all active worker threads
    for _, thread in ipairs(workers) do
        if coroutine.status(thread) ~= "dead" then task.cancel(thread) end
    end

    -- Cancel active timers
    for thread, _ in pairs(activeTimers) do
        if coroutine.status(thread) ~= "dead" then task.cancel(thread) end
    end

    table.clear(connections)
    table.clear(workers)
    table.clear(activeTimers)

    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Size = UDim2.fromScale(0.9, 0.9),
        BackgroundTransparency = 1
    }):Play()
    
    task.delay(0.3, function()
        ScreenGui:Destroy()
    end)
end))

SwitchPage("Home", TabHome)
