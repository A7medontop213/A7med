-- ==========================================
-- 1. Services & Setup
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Old = PlayerGui:FindFirstChild("A7medHub")
if Old then Old:Destroy() end

-- ==========================================
-- 2. Design System & Theme
-- ==========================================
local UIConfig = {
    WindowWidth = 720,
    WindowHeight = 480,
    SidebarWidth = 180,
    Radius = 12,
    ButtonHeight = 64,
    AnimSpeed = 0.2,
}

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

-- ==========================================
-- 3. UI Module System
-- ==========================================
local UI = {}

function UI.CreateShadow(parent)
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

function UI.CreateCardButton(parent, icon, title, desc, callback)
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

    Btn.MouseButton1Click:Connect(function() if callback then callback() end end)
    return Btn
end

function UI.Notify(title, message, type)
    local NotifContainer = PlayerGui:FindFirstChild("A7medHub_Notifications")
    if not NotifContainer then
        NotifContainer = Instance.new("ScreenGui")
        NotifContainer.Name = "A7medHub_Notifications"
        NotifContainer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        NotifContainer.Parent = PlayerGui
    end

    local Notif = Instance.new("Frame")
    Notif.Size = UDim2.fromOffset(300, 70)
    Notif.Position = UDim2.new(1, -30, 1, -30)
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

    Notif.Position = UDim2.new(1, -30, 1, 10)
    TweenService:Create(Notif, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(1, -30, 1, -30)}):Play()

    task.delay(3, function()
        TweenService:Create(Notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -30, 1, 10), BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        Notif:Destroy()
    end)
end

-- ==========================================
-- 4. Main GUI Construction
-- ==========================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "A7medHub"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.fromOffset(UIConfig.WindowWidth, UIConfig.WindowHeight)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = Gui

UI.CreateShadow(MainFrame)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, UIConfig.Radius)
MainCorner.Parent = MainFrame

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

local Status = Instance.new("TextLabel")
Status.Size = UDim2.fromOffset(80, 24)
Status.Position = UDim2.new(1, -110, 0.5, 0)
Status.AnchorPoint = Vector2.new(0.5, 0.5)
Status.BackgroundColor3 = Color3.fromRGB(0, 40, 30)
Status.BorderSizePixel = 0
Status.Text = "● ONLINE"
Status.TextColor3 = Theme.Success
Status.TextSize = 12
Status.Font = Enum.Font.GothamBold
Status.Parent = Header
local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(1, 0)
StatusCorner.Parent = Status

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
-- 5. Pages & Logic
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

-- --- Page: Home ---
local PageHome = CreatePage("Home")
UI.CreateCardButton(PageHome, "⚡", "تفعيل TPS & Touchline", "يقوم بتشغيل السكربتات الأساسية مع خيار البينج", function()
    local Modal = Instance.new("Frame")
    Modal.Size = UDim2.fromOffset(320, 140)
    Modal.Position = UDim2.fromScale(0.5, 0.5)
    Modal.AnchorPoint = Vector2.new(0.5, 0.5)
    Modal.BackgroundColor3 = Theme.Surface
    Modal.BorderSizePixel = 0
    Modal.ZIndex = 100
    Modal.Parent = MainFrame
    local MCorner = Instance.new("UICorner") MCorner.CornerRadius = UDim.new(0, 8) MCorner.Parent = Modal
    local MStroke = Instance.new("UIStroke") MStroke.Color = Theme.Accent MStroke.Thickness = 1.5 MStroke.Parent = Modal
    
    local MText = Instance.new("TextLabel")
    MText.Size = UDim2.new(1, 0, 0, 50)
    MText.BackgroundTransparency = 1
    MText.Text = "هل تريد تشغيل البينج معهما؟"
    MText.TextColor3 = Theme.Text
    MText.TextSize = 16
    MText.Font = Enum.Font.GothamBold
    MText.ZIndex = 101
    MText.Parent = Modal
    
    local function Execute(withPing)
        Modal:Destroy()
        task.spawn(function()
            pcall(function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/07d323b4106c0dee4680725e35bef651.lua"))() end)
            pcall(function() loadstring(game:HttpGet("https://pastefy.app/hf5DG9ce/raw"))() end)
            if withPing then
                pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/0644609314z-collab/why-whozuld-u-even-crack-this/refs/heads/main/WHY%20R%20U%20STILLM%20HERE"))() end)
            end
            UI.Notify("تم التنفيذ", "تم تشغيل السكربتات بنجاح", "success")
        end)
    end

    local BtnYes = Instance.new("TextButton")
    BtnYes.Size = UDim2.fromOffset(110, 36)
    BtnYes.Position = UDim2.fromOffset(40, 85)
    BtnYes.BackgroundColor3 = Theme.Accent
    BtnYes.BorderSizePixel = 0
    BtnYes.Text = "Yes"
    BtnYes.TextColor3 = Color3.fromRGB(255,255,255)
    BtnYes.TextSize = 14
    BtnYes.Font = Enum.Font.GothamBold
    BtnYes.ZIndex = 101
    BtnYes.Parent = Modal
    local YCorner = Instance.new("UICorner") YCorner.CornerRadius = UDim.new(0, 6) YCorner.Parent = BtnYes
    BtnYes.MouseButton1Click:Connect(function() Execute(true) end)

    local BtnNo = Instance.new("TextButton")
    BtnNo.Size = UDim2.fromOffset(110, 36)
    BtnNo.Position = UDim2.fromOffset(170, 85)
    BtnNo.BackgroundColor3 = Theme.Danger
    BtnNo.BorderSizePixel = 0
    BtnNo.Text = "No"
    BtnNo.TextColor3 = Color3.fromRGB(255,255,255)
    BtnNo.TextSize = 14
    BtnNo.Font = Enum.Font.GothamBold
    BtnNo.ZIndex = 101
    BtnNo.Parent = Modal
    local NCorner = Instance.new("UICorner") NCorner.CornerRadius = UDim.new(0, 6) NCorner.Parent = BtnNo
    BtnNo.MouseButton1Click:Connect(function() Execute(false) end)
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
UI.CreateCardButton(PageFun, "🕶", "تشغيل VR7", "Utility script for enhanced experience", function()
    task.spawn(function()
        local success = pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/VR7ss/OMK/refs/heads/main/VR7-ON-TOP"))() end)
        if success then UI.Notify("VR7", "تم تشغيل السكربت بنجاح", "success")
        else UI.Notify("VR7", "فشل في تحميل السكربت", "danger") end
    end)
end)

-- ==========================================
-- 6. Page: FFS (تم التعديل الجذري هنا لدعم الأكواد الضخمة)
-- ==========================================
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

-- الحاوية التي تسمح بالتمدد اللانهائي
local FFSBoxContainer = Instance.new("ScrollingFrame")
FFSBoxContainer.Size = UDim2.new(1, 0, 0, 320) -- ارتفاع أكبر لرؤية أكثر
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

-- صندوق النص نفسه
local FFSBox = Instance.new("TextBox")
FFSBox.Size = UDim2.new(1, -15, 0, 0) -- الارتفاع 0 هو السر ليتمدد تلقائياً مع AutomaticSize
FFSBox.Position = UDim2.fromOffset(7, 7)
FFSBox.BackgroundTransparency = 1
FFSBox.TextColor3 = Color3.fromRGB(200, 220, 255)
FFSBox.TextSize = 13
FFSBox.Font = Enum.Font.Code -- خط مخصص للأكواد
FFSBox.TextXAlignment = Enum.TextXAlignment.Left
FFSBox.TextYAlignment = Enum.TextYAlignment.Top
FFSBox.ClearTextOnFocus = false -- يمنع مسح النص عند الضغط عليه مجدداً
FFSBox.MultiLine = true
FFSBox.TextWrapped = true -- يسمح للنزول لسطر جديد بدلاً من الاقتطاع
FFSBox.PlaceholderText = "-- الصق كود JSON الضخم هنا (يدعم آلاف الأسطر)...\n{\n  \"FLogNetwork\": \"7\"\n}"
FFSBox.PlaceholderColor3 = Theme.Muted
FFSBox.Parent = FFSBoxContainer

-- زر التطبيق في الأسفل
UI.CreateCardButton(PageFFS, "✅", "تطبيق الأكواد (Execute)", "يقوم بتحليل وتطبيق جميع المفاتيح دفعة واحدة", function()
    local jsonText = FFSBox.Text
    if jsonText == "" or jsonText:find("الصق كود") then
        UI.Notify("تنبيه", "الصندوق فارغ!", "danger")
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
        UI.Notify("نجاح", "تم تطبيق " .. count .. " فلاج بنجاح!", "success")
    else
        UI.Notify("خطأ", "تأكد من أن النص بصيغة JSON صحيحة (أقواس، فواصل)", "danger")
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
BtnRemoveLog.MouseButton1Click:Connect(function()
    pcall(function() cleardrawcache() end)
    pcall(function() clearconsole() end)
    FFSBox.Text = ""
    UI.Notify("تم التنظيف", "تم مسح السجلات والآثار بنجاح", "success")
end)

-- ==========================================
-- 7. Events & Initialization
-- ==========================================
local Dragging, DragStart, StartPos = false, nil, nil
Header.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        if Input.Target == CloseBtn then return end
        Dragging = true
        DragStart = Input.Position
        StartPos = MainFrame.Position
    end
end)
Header.InputChanged:Connect(function(Input)
    if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
        local Delta = Input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then Dragging = false end
end)

UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then return end
    if Input.KeyCode == Enum.KeyCode.End then Gui.Enabled = false
    elseif Input.KeyCode == Enum.KeyCode.Home then Gui.Enabled = true end
end)

CloseBtn.MouseButton1Click:Connect(function()
    Dragging = false
    local CloseTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Size = UDim2.fromScale(0.9, 0.9), BackgroundTransparency = 1})
    CloseTween:Play()
    CloseTween.Completed:Connect(function() if Gui and Gui.Parent then Gui:Destroy() end end)
end)

MainFrame.Size = UDim2.fromScale(0.9, 0.9)
MainFrame.BackgroundTransparency = 1
MainFrame.Position = UDim2.fromScale(0.5, 0.55)

TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Size = UDim2.fromOffset(UIConfig.WindowWidth, UIConfig.WindowHeight),
    BackgroundTransparency = 0,
    Position = UDim2.fromScale(0.5, 0.5)
}):Play()

SwitchPage("Home", TabHome)
