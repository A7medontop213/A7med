local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local Old = PlayerGui:FindFirstChild("A7medHub")
if Old then
    Old:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "A7medHub"
Gui.ResetOnSpawn = false
Gui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(400, 260)
Frame.Position = UDim2.new(0.5, 0, 1.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Frame.BorderSizePixel = 0
Frame.Parent = Gui

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "A7med Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 26
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

local TPS = Instance.new("TextButton")
TPS.Size = UDim2.new(1, -60, 0, 55)
TPS.Position = UDim2.fromOffset(30, 70)
TPS.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TPS.Text = "TPS"
TPS.TextColor3 = Color3.fromRGB(255, 255, 255)
TPS.TextSize = 20
TPS.Font = Enum.Font.GothamBold
TPS.Parent = Frame

Instance.new("UICorner", TPS).CornerRadius = UDim.new(0, 10)

local Touchline = Instance.new("TextButton")
Touchline.Size = UDim2.new(1, -60, 0, 55)
Touchline.Position = UDim2.fromOffset(30, 140)
Touchline.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Touchline.Text = "Touchline"
Touchline.TextColor3 = Color3.fromRGB(255, 255, 255)
Touchline.TextSize = 20
Touchline.Font = Enum.Font.GothamBold
Touchline.Parent = Frame

Instance.new("UICorner", Touchline).CornerRadius = UDim.new(0, 10)

TPS.MouseButton1Click:Connect(function()
    warn("TPS SELECTED")
end)

Touchline.MouseButton1Click:Connect(function()
    warn("TOUCHLINE SELECTED")
end)

TweenService:Create(
    Frame,
    TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    {
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }
):Play()
