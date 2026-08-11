
local H = game:GetService('TweenService')
local D = game:GetService('Players')
local E = {
    NEON = Color3.fromRGB(19, 103, 229),
    DARK = Color3.fromRGB(0, 42, 97),
    BLACK = Color3.fromRGB(0, 0, 0),
    WHITE = Color3.fromRGB(255, 255, 255),
}
local p = {
    MAIN = 'rbxassetid://7072716017',
    CLOSE = 'rbxassetid://7072725342',
}
local I = {
    {
        text = 'Touchline Script',
        icon = p.MAIN,
    },
    {
        text = 'Soon',
        icon = p.MAIN,
    },
    {
        text = 'Soon',
        icon = p.MAIN,
    },
    {
        text = 'Soon',
        icon = p.MAIN,
    },
    {
        text = 'Soon',
        icon = p.MAIN,
    },
    {
        text = 'Soon',
        icon = p.MAIN,
    },
    {
        text = 'Soon',
        icon = p.MAIN,
    },
}
local s = {
    'https://raw.githubusercontent.com/77Alone77/Null/refs/heads/main/Scripts/Touchline.lua',
    'a',
   'a',
    'a',
    'a',
    'a',
    'a'
}
local N = Instance.new('ScreenGui')

N.Name = 'NeonChooser'
N.Parent = D.LocalPlayer:WaitForChild('PlayerGui')

local v = Instance.new('Frame')

v.Size = UDim2.new(0, 400, 0, 300)
v.Position = UDim2.new(0.5, 0, 0.5, 0)
v.AnchorPoint = Vector2.new(0.5, 0.5)
v.BackgroundColor3 = E.BLACK
v.BorderSizePixel = 0
v.ClipsDescendants = true
v.Parent = N

local d = Instance.new('UICorner')

d.CornerRadius = UDim.new(0, 12)
d.Parent = v

local B = Instance.new('UIStroke')

B.Thickness = 2
B.Color = E.NEON
B.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
B.Parent = v

spawn(function()
    while v.Parent do
        for H = 0, 1, 0.05 do
            local D = Color3.new(math.lerp(0.094117647058824, 0.42745098039216, H), math.lerp(0.20392156862745, 0.70196078431373, H), math.lerp(0.4078431372549, 0.97254901960784, H))

            B.Color = D

            task.wait(0.1)
        end
    end
end)

local U = Instance.new('TextLabel')

U.Size = UDim2.new(1, 0, 0, 50)
U.Position = UDim2.new(0, 0, 0, 20)
U.BackgroundTransparency = 1
U.Font = Enum.Font.GothamBold
U.Text = '\u{1f4dc}Choose Script'
U.TextColor3 = E.NEON
U.TextSize = 28
U.Parent = v

local T = Instance.new('Frame')

T.Size = UDim2.new(0.8, 0, 0, 2)
T.Position = UDim2.new(0.5, 0, 0, 70)
T.AnchorPoint = Vector2.new(0.5, 0)
T.BackgroundColor3 = E.WHITE
T.BorderSizePixel = 0
T.Parent = v

local g = Instance.new('ScrollingFrame')

g.Size = UDim2.new(1, -20, 1, -100)
g.Position = UDim2.new(0, 10, 0, 80)
g.CanvasSize = UDim2.new(0, 0, 0, #I * 55)
g.ScrollBarThickness = 5
g.BackgroundTransparency = 1
g.BorderSizePixel = 0
g.Parent = v

local q = Instance.new('UIListLayout')

q.SortOrder = Enum.SortOrder.LayoutOrder
q.Padding = UDim.new(0, 10)
q.Parent = g

local function O(D, p, I)
    local s = Instance.new('TextButton')

    s.Size = UDim2.new(1, -10, 0, 45)
    s.Text = ''
    s.BackgroundColor3 = E.DARK
    s.Parent = g

    local N = Instance.new('ImageLabel')

    N.Size = UDim2.new(0, 30, 0, 30)
    N.Position = UDim2.new(0, 20, 0.5, 0)
    N.AnchorPoint = Vector2.new(0, 0.5)
    N.BackgroundTransparency = 1
    N.Image = p.icon
    N.ImageColor3 = E.WHITE
    N.Parent = s

    local v = Instance.new('TextLabel')

    v.Size = UDim2.new(1, -70, 1, 0)
    v.Position = UDim2.new(0, 60, 0, 0)
    v.BackgroundTransparency = 1
    v.Text = p.text
    v.TextColor3 = E.WHITE
    v.TextSize = 18
    v.Font = Enum.Font.GothamSemibold
    v.TextXAlignment = Enum.TextXAlignment.Left
    v.Parent = s;
    (Instance.new('UICorner', s)).CornerRadius = UDim.new(0, 8)

    s.MouseEnter:Connect(function()
        (H:Create(s, TweenInfo.new(0.2), {
            BackgroundColor3 = E.NEON,
        })):Play();
        (H:Create(N, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 25, 0.5, 0),
        })):Play()
    end)
    s.MouseLeave:Connect(function()
        (H:Create(s, TweenInfo.new(0.2), {
            BackgroundColor3 = E.DARK,
        })):Play();
        (H:Create(N, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 20, 0.5, 0),
        })):Play()
    end)
    s.MouseButton1Click:Connect(function()
        animateOut()
        task.wait(0.2);
        (loadstring(game:HttpGet(I)))()
    end)
end

local X = Instance.new('ImageButton')

X.Size = UDim2.new(0, 30, 0, 30)
X.Position = UDim2.new(1, -20, 0, 20)
X.AnchorPoint = Vector2.new(1, 0)
X.BackgroundTransparency = 1
X.Image = p.CLOSE
X.ImageColor3 = E.NEON
X.ImageTransparency = 0.2
X.Parent = v

X.MouseEnter:Connect(function()
    (H:Create(X, TweenInfo.new(0.2), {
        ImageColor3 = E.WHITE,
        Rotation = 90,
    })):Play()
end)
X.MouseLeave:Connect(function()
    (H:Create(X, TweenInfo.new(0.2), {
        ImageColor3 = E.NEON,
        Rotation = 0,
    })):Play()
end)
X.MouseButton1Click:Connect(function()
    animateOut()
end)

function animateIn()
    v.Position = UDim2.new(0.5, 0, 1.5, 0);

    (H:Create(v, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0.5, 0),
    })):Play()
end
function animateOut()
    (H:Create(v, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, 0, 1.5, 0),
    })):Play()
    task.wait(1)
    N:Destroy()
end

local w = Instance.new('BlurEffect')

w.Size = 15
w.Parent = game.Lighting

for H, D in ipairs(I)do
    O(H, D, s[H])
end

animateIn()
N.Destroying:Connect(function()
    w:Destroy()
end)
