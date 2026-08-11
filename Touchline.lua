local a = game:GetService("Players")
local b = game:GetService("UserInputService")
local c = "Null_key.txt"
local d = "null01"

local function e()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/77Alone77/Null/refs/heads/main/Scripts/01.lua"))()
end

local function f()
    local g, h = pcall(function()
        return readfile(c)
    end)
    return g and h or ""
end

local function i(j)
    pcall(function()
        writefile(c, j)
    end)
end

local function k(l, m, n, o, p)
    n = n or 5
    o = o or Color3.fromRGB(255, 188, 254)
    
    local q = Instance.new("Frame")
    q.Name = "Notification"
    q.AnchorPoint = Vector2.new(1, 1)
    q.BackgroundTransparency = 0.06
    q.AutomaticSize = Enum.AutomaticSize.XY
    q.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    q.BorderSizePixel = 0
    q.Position = UDim2.new(1, -25, 1, -25)
    q.Size = UDim2.fromOffset(232, 59)
    q.Parent = p
    
    local r = Instance.new("UIStroke")
    r.Name = "_CHILD"
    r.Color = Color3.fromRGB(158, 114, 158)
    r.Transparency = 0.9
    r.Parent = q
    
    local s = Instance.new("ImageLabel")
    s.Name = "acrylicthing"
    s.Image = "rbxassetid://9968344105"
    s.ImageTransparency = 0.98
    s.ScaleType = Enum.ScaleType.Tile
    s.TileSize = UDim2.fromOffset(128, 128)
    s.BackgroundTransparency = 1
    s.Size = UDim2.fromScale(1, 1)
    
    local t = Instance.new("UICorner")
    t.CornerRadius = UDim.new(0, 12)
    t.Parent = s
    
    s.Parent = q
    
    local u = Instance.new("ImageLabel")
    u.Name = "acrylicthing"
    u.Image = "rbxassetid://9968344227"
    u.ImageTransparency = 0.9
    u.ScaleType = Enum.ScaleType.Tile
    u.TileSize = UDim2.fromOffset(128, 128)
    u.BackgroundTransparency = 1
    u.Size = UDim2.fromScale(1, 1)
    
    local v = Instance.new("UICorner")
    v.CornerRadius = UDim.new(0, 12)
    v.Parent = u
    
    u.Parent = q
    
    local w = Instance.new("Frame")
    w.Name = "TextHolder"
    w.AutomaticSize = Enum.AutomaticSize.XY
    w.BackgroundTransparency = 1
    w.Position = UDim2.new(0, 7, 0.12, 0)
    w.Size = UDim2.fromOffset(20, 12)
    
    local x = Instance.new("UIListLayout")
    x.Padding = UDim.new(0, -4)
    x.SortOrder = Enum.SortOrder.LayoutOrder
    x.Parent = w
    
    local y = Instance.new("TextLabel")
    y.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)
    y.Text = l
    y.TextColor3 = Color3.fromRGB(199, 199, 203)
    y.TextSize = 14
    y.TextXAlignment = Enum.TextXAlignment.Left
    y.AutomaticSize = Enum.AutomaticSize.X
    y.BackgroundTransparency = 1
    y.Position = UDim2.fromOffset(10, 8)
    y.Size = UDim2.fromOffset(212, 20)
    y.Parent = w
    
    local z = Instance.new("TextLabel")
    z.Name = "TextLabel"
    z.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    z.Text = m
    z.TextColor3 = Color3.fromRGB(127, 127, 130)
    z.TextSize = 12
    z.TextXAlignment = Enum.TextXAlignment.Left
    z.AutomaticSize = Enum.AutomaticSize.X
    z.BackgroundTransparency = 1
    z.Position = UDim2.fromOffset(10, 8)
    z.Size = UDim2.fromOffset(212, 20)
    z.Parent = w
    
    local aa = Instance.new("UIPadding")
    aa.PaddingBottom = UDim.new(0, 25)
    aa.Parent = w
    
    w.Parent = q
    
    local ab = Instance.new("Frame")
    ab.BackgroundColor3 = Color3.fromRGB(44, 38, 44)
    ab.BorderSizePixel = 0
    ab.Position = UDim2.fromScale(0.0282, 0.8)
    ab.Size = UDim2.new(1, -20, 0, 7)
    
    local ac = Instance.new("UIListLayout")
    ac.Name = "UIListLayout"
    ac.Wraps = true
    ac.FillDirection = Enum.FillDirection.Horizontal
    ac.SortOrder = Enum.SortOrder.LayoutOrder
    ac.VerticalAlignment = Enum.VerticalAlignment.Bottom
    ac.Parent = ab
    
    local ad = Instance.new("Frame")
    ad.BackgroundColor3 = o
    ad.BorderSizePixel = 0
    ad.Size = UDim2.fromScale(1, 1)
    
    local ae = Instance.new("UICorner")
    ae.Parent = ad
    
    local af = Instance.new("UIGradient")
    af.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.752, Color3.fromRGB(147, 147, 147)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 127, 127))
    }
    af.Parent = ad
    
    ad.Parent = ab
    
    local ag = Instance.new("UICorner")
    ag.Parent = ab
    
    ab.Parent = q
    
    local ah = Instance.new("UICorner")
    ah.CornerRadius = UDim.new(0, 4)
    ah.Parent = q
    
    local ai = Instance.new("UIPadding")
    ai.PaddingBottom = UDim.new(0, 12)
    ai.Parent = q
    
    local aj = Instance.new("TextButton")
    aj.Name = "DismissButton"
    aj.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    aj.BackgroundTransparency = 1
    aj.Size = UDim2.fromScale(1, 1)
    aj.Text = ""
    aj.Parent = q
    
    task.spawn(function()
        local ak = 60
        local al = n / ak
        for am = 0, ak do
            if not ad.Parent then break end
            local an = 1 - (am / ak)
            ad.Size = UDim2.new(an, 0, 1, 0)
            task.wait(al)
        end
    end)
    
    task.delay(n, function()
        if q and q.Parent then
            for ao = 1, 10 do
                if not q.Parent then break end
                q.Position = UDim2.new(1, -25 + (ao * 5), 1, -25)
                task.wait(0.05)
            end
            q:Destroy()
        end
    end)
    
    aj.MouseButton1Click:Connect(function()
        if q and q.Parent then
            for ao = 1, 10 do
                if not q.Parent then break end
                q.Position = UDim2.new(1, -25 + (ao * 5), 1, -25)
                task.wait(0.05)
            end
            q:Destroy()
        end
    end)
    
    aj.MouseEnter:Connect(function()
        aj.BackgroundTransparency = 0.65
    end)
    
    aj.MouseLeave:Connect(function()
        aj.BackgroundTransparency = 1
    end)

    return q
end

local ap = Instance.new("ScreenGui")
ap.Name = "NullLogin"
ap.ResetOnSpawn = false
ap.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ap.Parent = a.LocalPlayer:WaitForChild("PlayerGui")

local aq = Instance.new("Frame")
aq.Name = "MainFrame"
aq.AnchorPoint = Vector2.new(0.5, 0.5)
aq.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
aq.BackgroundTransparency = 0.06
aq.BorderSizePixel = 0
aq.Position = UDim2.fromScale(0.5, 0.5)
aq.Size = UDim2.fromOffset(400, 240)
aq.Parent = ap

local ar = Instance.new("UICorner")
ar.CornerRadius = UDim.new(0, 12)
ar.Parent = aq

local as = Instance.new("ImageLabel")
as.Name = "acrylicthing"
as.Image = "rbxassetid://9968344105"
as.ImageTransparency = 0.98
as.ScaleType = Enum.ScaleType.Tile
as.TileSize = UDim2.fromOffset(128, 128)
as.BackgroundTransparency = 1
as.Size = UDim2.fromScale(1, 1)
as.ZIndex = 0
as.Parent = aq

local at = Instance.new("UICorner")
at.CornerRadius = UDim.new(0, 12)
at.Parent = as

local au = Instance.new("ImageLabel")
au.Name = "acrylicthing"
au.Image = "rbxassetid://9968344227"
au.ImageTransparency = 0.9
au.ScaleType = Enum.ScaleType.Tile
au.TileSize = UDim2.fromOffset(128, 128)
au.BackgroundTransparency = 1
au.Size = UDim2.fromScale(1, 1)
au.ZIndex = 0
au.Parent = aq

local av = Instance.new("UICorner")
av.CornerRadius = UDim.new(0, 12)
av.Parent = au

local aw = Instance.new("UIStroke")
aw.Name = "_CHILD"
aw.Color = Color3.fromRGB(158, 114, 158)
aw.Transparency = 0.9
aw.Parent = aq

local ax = Instance.new("Frame")
ax.Name = "sideindicator"
ax.AnchorPoint = Vector2.new(0.5, 0)
ax.BackgroundColor3 = Color3.fromRGB(255, 188, 254)
ax.BorderSizePixel = 0
ax.Position = UDim2.fromScale(0.5, 0)
ax.Size = UDim2.new(1, -50, 0, 2)
ax.Parent = aq

local ay = Instance.new("UICorner")
ay.CornerRadius = UDim.new(0, 634)
ay.Parent = ax

local az = Instance.new("TextLabel")
az.Name = "title"
az.FontFace = Font.new("rbxassetid://12187361378", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
az.Text = "Null"
az.TextColor3 = Color3.fromRGB(255, 255, 255)
az.TextSize = 19
az.BackgroundTransparency = 1
az.Position = UDim2.fromOffset(37, 15)
az.Size = UDim2.new(0, 88, 0, 30)
az.TextXAlignment = Enum.TextXAlignment.Left
az.Parent = aq

local ba = Instance.new("Frame")
ba.Name = "Frame"
ba.BackgroundTransparency = 1
ba.Position = UDim2.new(1, -75, 0, 15)
ba.Size = UDim2.new(0, 60, 0, 30)
ba.Parent = aq

local bb = Instance.new("UIListLayout")
bb.FillDirection = Enum.FillDirection.Horizontal
bb.HorizontalAlignment = Enum.HorizontalAlignment.Center
bb.Padding = UDim.new(0, 6)
bb.SortOrder = Enum.SortOrder.LayoutOrder
bb.VerticalAlignment = Enum.VerticalAlignment.Center
bb.Parent = ba

local bc = Instance.new("TextButton")
bc.Name = "Close"
bc.Text = ""
bc.BackgroundColor3 = Color3.fromRGB(252, 95, 83)
bc.Size = UDim2.fromOffset(7, 7)
bc.AutoButtonColor = false
bc.Parent = ba

local bd = Instance.new("UICorner")
bd.CornerRadius = UDim.new(0, 50)
bd.Parent = bc

local be = Instance.new("TextButton")
be.Name = "Minimize"
be.Text = ""
be.BackgroundColor3 = Color3.fromRGB(242, 191, 60)
be.Size = UDim2.fromOffset(7, 7)
be.AutoButtonColor = false
be.Parent = ba

local bf = Instance.new("UICorner")
bf.CornerRadius = UDim.new(0, 50)
bf.Parent = be

local bg = Instance.new("TextButton")
bg.Name = "Fullscreen"
bg.Text = ""
bg.BackgroundColor3 = Color3.fromRGB(117, 166, 87)
bg.Size = UDim2.fromOffset(7, 7)
bg.AutoButtonColor = false
bg.Parent = ba

local bh = Instance.new("UICorner")
bh.CornerRadius = UDim.new(0, 50)
bh.Parent = bg

local bi = false
local bj = aq.Size
local bk = aq.Position

bg.MouseButton1Click:Connect(function()
    bi = not bi
    if bi then
        aq.Size = UDim2.new(0.9, 0, 0.9, 0)
        aq.Position = UDim2.new(0.5, 0, 0.5, 0)
    else
        aq.Size = bj
        aq.Position = bk
    end
    k("FullScreen", bi and "Enabled" or "Disabled", 1.5, 
    Color3.fromRGB(117, 166, 87), ap)
end)

local bl = Instance.new("Frame")
bl.Name = "ContentFrame"
bl.BackgroundTransparency = 1
bl.Position = UDim2.fromOffset(0, 55)
bl.Size = UDim2.new(1, 0, 1, -55)
bl.Parent = aq

local bm = Instance.new("Frame")
bm.Name = "KeySection"
bm.BackgroundTransparency = 1
bm.Position = UDim2.fromOffset(20, 0)
bm.Size = UDim2.new(1, -40, 0, 70)
bm.Parent = bl

local bn = Instance.new("TextLabel")
bn.Name = "KeyLabel"
bn.FontFace = Font.new("rbxassetid://12187365364")
bn.Text = "Key"
bn.TextColor3 = Color3.fromRGB(122, 122, 122)
bn.TextSize = 12
bn.TextXAlignment = Enum.TextXAlignment.Left
bn.BackgroundTransparency = 1
bn.Position = UDim2.fromOffset(0, 0)
bn.Size = UDim2.new(1, 0, 0, 20)
bn.Parent = bm

local bo = Instance.new("Frame")
bo.Name = "TextboxHolder"
bo.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
bo.BackgroundTransparency = 0.95
bo.BorderSizePixel = 0
bo.Position = UDim2.fromOffset(0, 25)
bo.Size = UDim2.new(1, -80, 0, 30)
bo.Parent = bm

local bp = Instance.new("UICorner")
bp.CornerRadius = UDim.new(0, 4)
bp.Parent = bo

local bq = Instance.new("UIStroke")
bq.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
bq.Color = Color3.fromRGB(56, 56, 56)
bq.Transparency = 0.5
bq.Parent = bo

local br = Instance.new("TextBox")
br.Name = "TextBox"
br.ClearTextOnFocus = false
br.FontFace = Font.new("rbxassetid://12187365364")
br.PlaceholderColor3 = Color3.fromRGB(170, 170, 170)
br.PlaceholderText = "Enter your key..."
br.Text = f()
br.TextColor3 = Color3.fromRGB(240, 240, 240)
br.TextSize = 12
br.TextXAlignment = Enum.TextXAlignment.Left
br.BackgroundTransparency = 1
br.Position = UDim2.fromOffset(10, 0)
br.Size = UDim2.fromScale(1, 1)
br.Parent = bo

local bs = Instance.new("TextButton")
bs.Name = "CheckButton"
bs.FontFace = Font.new("rbxassetid://12187365364")
bs.Text = "Check"
bs.TextColor3 = Color3.fromRGB(0, 0, 0)
bs.TextSize = 12
bs.BackgroundColor3 = Color3.fromRGB(255, 188, 254)
bs.BorderSizePixel = 0
bs.Position = UDim2.new(1, -70, 0, 25)
bs.Size = UDim2.fromOffset(70, 30)
bs.Parent = bm

local bt = Instance.new("UICorner")
bt.CornerRadius = UDim.new(0, 4)
bt.Parent = bs

local bu = Instance.new("TextLabel")
bu.Name = "StatusLabel"
bu.FontFace = Font.new("rbxassetid://12187365364")
bu.Text = "Key Status: Not Checked"
bu.TextColor3 = Color3.fromRGB(120, 120, 120)
bu.TextSize = 12
bu.BackgroundTransparency = 1
bu.Position = UDim2.fromOffset(0, 60)
bu.Size = UDim2.new(1, 0, 0, 20)
bu.Parent = bm

local bv = Instance.new("Frame")
bv.Name = "ButtonsSection"
bv.BackgroundTransparency = 1
bv.Position = UDim2.fromOffset(20, 80)
bv.Size = UDim2.new(1, -40, 0, 80)
bv.Parent = bl

local bw = Instance.new("TextButton")
bw.Name = "DiscordButton"
bw.FontFace = Font.new("rbxassetid://12187365364")
bw.Text = "Join Discord"
bw.TextColor3 = Color3.fromRGB(240, 240, 240)
bw.TextSize = 12
bw.BackgroundColor3 = Color3.fromRGB(28, 29, 32)
bw.BackgroundTransparency = 0.5
bw.BorderSizePixel = 0
bw.Position = UDim2.fromOffset(0, 0)
bw.Size = UDim2.new(1, 0, 0, 40)
bw.Parent = bv

local bx = Instance.new("UICorner")
bx.CornerRadius = UDim.new(0, 6)
bx.Parent = bw

local by = Instance.new("TextLabel")
by.Name = "FooterLabel"
by.FontFace = Font.new("rbxassetid://12187365364")
by.Text = "Key system will be removed soon"
by.TextColor3 = Color3.fromRGB(255, 188, 254)
by.TextSize = 12
by.BackgroundTransparency = 1
by.Position = UDim2.fromOffset(0, 50)
by.Size = UDim2.new(1, 0, 0, 20)
by.Parent = bv

local bz = false
local ca
local cb
local cc

local function cd(ce)
    local cf = ce.Position - cb
    aq.Position = UDim2.new(cc.X.Scale, cc.X.Offset + cf.X, cc.Y.Scale, cc.Y.Offset + cf.Y)
end

aq.InputBegan:Connect(function(ce)
    if ce.UserInputType == Enum.UserInputType.MouseButton1 or ce.UserInputType == Enum.UserInputType.Touch then
        bz = true
        cb = ce.Position
        cc = aq.Position
        
        ce.Changed:Connect(function()
            if ce.UserInputState == Enum.UserInputState.End then
                bz = false
            end
        end)
    end
end)

aq.InputChanged:Connect(function(ce)
    if ce.UserInputType == Enum.UserInputType.MouseMovement or ce.UserInputType == Enum.UserInputType.Touch then
        ca = ce
    end
end)

b.InputChanged:Connect(function(ce)
    if ce == ca and bz then
        cd(ce)
    end
end)

local function cg(ch)
    ch.MouseEnter:Connect(function()
        ch.BackgroundTransparency = 0.4
    end)
    
    ch.MouseLeave:Connect(function()
        ch.BackgroundTransparency = 0.5
    end)
end

cg(bw)

local function ci(cj)
    if cj == "" then
        k("Error", "Please input the key", 3, Color3.fromRGB(255, 85, 85), ap)
        bu.Text = "Status: Input Key"
        bu.TextColor3 = Color3.fromRGB(255, 85, 85)
        return false
    end
    
    if cj == d then
        i(d)
        
        k("Success", "Key is valid!", 5, Color3.fromRGB(85, 255, 127), ap)
        bu.Text = "Status: Valid Key!"
        bu.TextColor3 = Color3.fromRGB(85, 255, 127)
        
        task.delay(2, function()
            k("Welcome", "Enjoy using the best touchline script", 3, Color3.fromRGB(255, 188, 254), ap)
            task.wait(1)
            ap:Destroy()
            e()
        end)
        return true
    else
        k("Error", "Wrong Key, please try again", 3, Color3.fromRGB(255, 85, 85), ap)
        bu.Text = "Status: Invalid Key"
        bu.TextColor3 = Color3.fromRGB(255, 85, 85)
        br.Text = ""
        return false
    end
end

local ck = f()
if ck ~= "" and ck == d then
    bu.Text = "Status: Key Found!"
    bu.TextColor3 = Color3.fromRGB(85, 255, 127)
    br.Text = ck
    
    k("Auto-Login", "Valid key found!", 3, Color3.fromRGB(85, 255, 127), ap)
    
    task.delay(2, function()
        k("Welcome", "Enjoy using the best touchline script", 3, Color3.fromRGB(255, 188, 254), ap)
        task.wait(1)
        ap:Destroy()
        e()
    end)
else
    if ck ~= "" then
        br.Text = ""
        bu.Text = "Status: Invalid Saved Key"
        bu.TextColor3 = Color3.fromRGB(255, 85, 85)
        k("Warning", "Saved key is invalid, please re-enter", 3, Color3.fromRGB(255, 188, 254), ap)
    end
end

bs.MouseButton1Click:Connect(function()
    local cl = br.Text:gsub("%s+", "") 
    ci(cl)
end)

br.FocusLost:Connect(function(cm)
    if cm then
        local cl = br.Text:gsub("%s+", "") 
        ci(cl)
    end
end)

bw.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/x9kK3tvgHT")
    k("Copied", "The Discord server link was copied", 3, Color3.fromRGB(88, 101, 242), ap)
end)

br.Focused:Connect(function()
    bo.BackgroundTransparency = 0.87
    bn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

br.FocusLost:Connect(function()
    bo.BackgroundTransparency = 0.95
    bn.TextColor3 = Color3.fromRGB(122, 122, 122)
end)

bc.MouseButton1Click:Connect(function()
    ap:Destroy()
end)

be.MouseButton1Click:Connect(function()
    aq.Visible = false
    
    local cn = Instance.new("TextButton")
    cn.Name = "RestoreButton"
    cn.Text = "Null"
    cn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cn.TextSize = 14
    cn.Font = Enum.Font.Gotham
    cn.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    cn.BackgroundTransparency = 0.1
    cn.BorderSizePixel = 0
    cn.Position = UDim2.new(0, 10, 0, 10)
    cn.Size = UDim2.fromOffset(100, 30)
    cn.Parent = ap
    
    local co = Instance.new("UICorner")
    co.CornerRadius = UDim.new(0, 6)
    co.Parent = cn
    
    cn.MouseButton1Click:Connect(function()
        aq.Visible = true
        cn:Destroy()
    end)
end)

aq.Visible = true
