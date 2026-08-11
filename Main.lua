local H = game:GetService("TweenService")
local D = game:GetService("Players")

local E = {
    NEON = Color3.fromRGB(19, 103, 229),
    DARK = Color3.fromRGB(0, 42, 97),
    BLACK = Color3.fromRGB(0, 0, 0),
    WHITE = Color3.fromRGB(255, 255, 255),
}

local p = {
    MAIN = "rbxassetid://7072716017",
    CLOSE = "rbxassetid://7072725342",
}

local I = {
    {
        text = "Touchline Script",
        icon = p.MAIN,
        url = "https://raw.githubusercontent.com/A7medontop213/A7med/refs/heads/main/Touchline.lua",
    },

    {
        text = "Soon",
        icon = p.MAIN,
    },

    {
        text = "Soon",
        icon = p.MAIN,
    },

    {
        text = "Soon",
        icon = p.MAIN,
    },

    {
        text = "Soon",
        icon = p.MAIN,
    },

    {
        text = "Soon",
        icon = p.MAIN,
    },

    {
        text = "Soon",
        icon = p.MAIN,
    },
}

local N = Instance.new("ScreenGui")
N.Name = "NeonChooser"
N.ResetOnSpawn = false
N.Parent = D.LocalPlayer:WaitForChild("PlayerGui")

local v = Instance.new("Frame")
v.Size = UDim2.new(0, 400, 0, 300)
v.Position = UDim2.new(0.5, 0, 0.5, 0)
v.AnchorPoint = Vector2.new(0.5, 0.5)
v.BackgroundColor3 = E.BLACK
v.BorderSizePixel = 0
v.ClipsDescendants = true
v.Parent = N

local d = Instance.new("UICorner")
d.CornerRadius = UDim.new(0, 12)
d.Parent = v

local B = Instance.new("UIStroke")
B.Thickness = 2
B.Color = E.NEON
B.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
B.Parent = v

task.spawn(function()
    while v.Parent do
        for x = 0, 1, 0.05 do
            if not v.Parent then
                break
            end

            local color = Color3.new(
                math.lerp(0.094117647058824, 0.42745098039216, x),
                math.lerp(0.20392156862745, 0.70196078431373, x),
                math.lerp(0.4078431372549, 0.97254901960784, x)
            )

            B.Color = color
            task.wait(0.1)
        end
    end
end)

local U = Instance.new("TextLabel")
U.Size = UDim2.new(1, 0, 0, 50)
U.Position = UDim2.new(0, 0, 0, 20)
U.BackgroundTransparency = 1
U.Font = Enum.Font.GothamBold
U.Text = "📜Choose Script"
U.TextColor3 = E.NEON
U.TextSize = 28
U.Parent = v

local T = Instance.new("Frame")
T.Size = UDim2.new(0.8, 0, 0, 2)
T.Position = UDim2.new(0.5, 0, 0, 70)
T.AnchorPoint = Vector2.new(0.5, 0)
T.BackgroundColor3 = E.WHITE
T.BorderSizePixel = 0
T.Parent = v

local g = Instance.new("ScrollingFrame")
g.Size = UDim2.new(1, -20, 1, -100)
g.Position = UDim2.new(0, 10, 0, 80)
g.CanvasSize = UDim2.new(0, 0, 0, #I * 55)
g.ScrollBarThickness = 5
g.BackgroundTransparency = 1
g.BorderSizePixel = 0
g.Parent = v

local q = Instance.new("UIListLayout")
q.SortOrder = Enum.SortOrder.LayoutOrder
q.Padding = UDim.new(0, 10)
q.Parent = g

local function animateOut()
    (H:Create(v, TweenInfo.new(
        1,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.In
    ), {
        Position = UDim2.new(0.5, 0, 1.5, 0),
    })):Play()

    task.wait(1)

    if N then
        N:Destroy()
    end
end

local function O(index, data)
    local s = Instance.new("TextButton")

    s.Size = UDim2.new(1, -10, 0, 45)
    s.Text = ""
    s.BackgroundColor3 = E.DARK
    s.Parent = g

    local N2 = Instance.new("ImageLabel")
    N2.Size = UDim2.new(0, 30, 0, 30)
    N2.Position = UDim2.new(0, 20, 0.5, 0)
    N2.AnchorPoint = Vector2.new(0, 0.5)
    N2.BackgroundTransparency = 1
    N2.Image = data.icon
    N2.ImageColor3 = E.WHITE
    N2.Parent = s

    local v2 = Instance.new("TextLabel")
    v2.Size = UDim2.new(1, -70, 1, 0)
    v2.Position = UDim2.new(0, 60, 0, 0)
    v2.BackgroundTransparency = 1
    v2.Text = data.text
    v2.TextColor3 = E.WHITE
    v2.TextSize = 18
    v2.Font = Enum.Font.GothamSemibold
    v2.TextXAlignment = Enum.TextXAlignment.Left
    v2.Parent = s

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = s

    s.MouseEnter:Connect(function()
        H:Create(s, TweenInfo.new(0.2), {
            BackgroundColor3 = E.NEON,
        }):Play()

        H:Create(N2, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 25, 0.5, 0),
        }):Play()
    end)

    s.MouseLeave:Connect(function()
        H:Create(s, TweenInfo.new(0.2), {
            BackgroundColor3 = E.DARK,
        }):Play()

        H:Create(N2, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 20, 0.5, 0),
        }):Play()
    end)

s.MouseButton1Click:Connect(function()
    if not data.url then
        warn("[A7med Hub] No URL found")
        return
    end

    print("[A7med Hub] Loading Touchline...")
    print("[A7med Hub] URL:", data.url)

    local success, result = pcall(function()
        local code = game:HttpGet(data.url)

        print("[A7med Hub] Downloaded:", #code, "characters")

        local func, err = loadstring(code)

        if not func then
            error("Compile Error: " .. tostring(err))
        end

        print("[A7med Hub] Compile successful")
        func()

        print("[A7med Hub] Touchline finished")
    end)

    if not success then
        warn("[A7med Hub] ERROR:")
        warn(result)
    end
end)
end

local X = Instance.new("ImageButton")
X.Size = UDim2.new(0, 30, 0, 30)
X.Position = UDim2.new(1, -20, 0, 20)
X.AnchorPoint = Vector2.new(1, 0)
X.BackgroundTransparency = 1
X.Image = p.CLOSE
X.ImageColor3 = E.NEON
X.ImageTransparency = 0.2
X.Parent = v

X.MouseEnter:Connect(function()
    H:Create(X, TweenInfo.new(0.2), {
        ImageColor3 = E.WHITE,
        Rotation = 90,
    }):Play()
end)

X.MouseLeave:Connect(function()
    H:Create(X, TweenInfo.new(0.2), {
        ImageColor3 = E.NEON,
        Rotation = 0,
    }):Play()
end)

X.MouseButton1Click:Connect(function()
    animateOut()
end)

local function animateIn()
    v.Position = UDim2.new(0.5, 0, 1.5, 0)

    H:Create(v, TweenInfo.new(
        1.2,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out
    ), {
        Position = UDim2.new(0.5, 0, 0.5, 0),
    }):Play()
end

local w = Instance.new("BlurEffect")
w.Size = 15
w.Parent = game.Lighting

for index, data in ipairs(I) do
    O(index, data)
end

animateIn()

N.Destroying:Connect(function()
    if w then
        w:Destroy()
    end
end)
