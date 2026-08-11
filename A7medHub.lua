local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove old GUI
local Old = PlayerGui:FindFirstChild("A7medHub")
if Old then
    Old:Destroy()
end

--// GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "A7medHub"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--// Main Frame
local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.fromOffset(420, 330)
Frame.Position = UDim2.new(0.5, 0, 1.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Frame.BorderSizePixel = 0
Frame.Parent = Gui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 16)
FrameCorner.Parent = Frame

--// Border
local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 1.5
Stroke.Transparency = 0.25
Stroke.Color = Color3.fromRGB(19, 103, 229)
Stroke.Parent = Frame

--// GIF Frames
local GIFFrames = {
    "107268249992959",
    "104444112835205",
    "115157039177204",
    "111931487689142",
    "139619104460573",
    "117772948212179",
    "123663025657786",
    "138532394395836",
    "89671915374868",
    "97768644671894",
    "135444330442491",
    "117135674743180",
    "130369354331313",
    "70714410933656",
    "117791680841696",
    "101796483414639",
    "118219530086303",
    "128892414149593",
    "135225311464064",
    "82383377492088",
    "123769817479313",
    "111514118037660",
    "138018420561221"
}

--// GIF Image
local GIF = Instance.new("ImageLabel")
GIF.Name = "AnimatedLogo"
GIF.Size = UDim2.fromOffset(90, 90)
GIF.Position = UDim2.new(0.5, 0, 0, 10)
GIF.AnchorPoint = Vector2.new(0.5, 0)
GIF.BackgroundTransparency = 1
GIF.BorderSizePixel = 0
GIF.ScaleType = Enum.ScaleType.Fit
GIF.ImageTransparency = 0
GIF.Image = "rbxassetid://" .. GIFFrames[1]
GIF.Parent = Frame

--// Preload images
task.spawn(function()
    local Assets = {}

    for _, ID in ipairs(GIFFrames) do
        local Image = Instance.new("ImageLabel")
        Image.BackgroundTransparency = 1
        Image.Size = UDim2.fromOffset(1, 1)
        Image.Image = "rbxassetid://" .. ID
        Image.Parent = Gui

        table.insert(Assets, Image)
    end

    pcall(function()
        ContentProvider:PreloadAsync(Assets)
    end)

    for _, Image in ipairs(Assets) do
        Image:Destroy()
    end
end)

--// GIF Animation
task.spawn(function()
    local FrameSpeed = 0.07

    while Gui.Parent do
        for _, ImageID in ipairs(GIFFrames) do
            if not Gui.Parent then
                break
            end

            GIF.Image = "rbxassetid://" .. ImageID
            task.wait(FrameSpeed)
        end
    end
end)

--// Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -60, 0, 40)
Title.Position = UDim2.fromOffset(30, 102)
Title.BackgroundTransparency = 1
Title.Text = "A7med Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 25
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

--// Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.fromOffset(0, 137)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "A7med"
Subtitle.TextColor3 = Color3.fromRGB(130, 130, 140)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.Parent = Frame

--// Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.fromOffset(30, 30)
CloseButton.Position = UDim2.new(1, -12, 0, 12)
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.AutoButtonColor = false
CloseButton.ZIndex = 20
CloseButton.Parent = Frame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Thickness = 1
CloseStroke.Transparency = 0.5
CloseStroke.Color = Color3.fromRGB(80, 80, 95)
CloseStroke.Parent = CloseButton

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(
        CloseButton,
        TweenInfo.new(0.15),
        {
            BackgroundColor3 = Color3.fromRGB(200, 45, 45)
        }
    ):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(
        CloseButton,
        TweenInfo.new(0.15),
        {
            BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        }
    ):Play()
end)

--// Create Button
local function CreateButton(Name, Text, Position)

    local Button = Instance.new("TextButton")

    Button.Name = Name
    Button.Size = UDim2.new(1, -60, 0, 48)
    Button.Position = Position
    Button.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Button.BorderSizePixel = 0
    Button.Text = Text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 17
    Button.Font = Enum.Font.GothamBold
    Button.AutoButtonColor = false
    Button.Parent = Frame

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button

    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Thickness = 1
    ButtonStroke.Transparency = 0.7
    ButtonStroke.Color = Color3.fromRGB(70, 70, 85)
    ButtonStroke.Parent = Button

    Button.MouseEnter:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = Color3.fromRGB(19, 103, 229)
            }
        ):Play()

        TweenService:Create(
            ButtonStroke,
            TweenInfo.new(0.2),
            {
                Transparency = 0
            }
        ):Play()

    end)

    Button.MouseLeave:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            }
        ):Play()

        TweenService:Create(
            ButtonStroke,
            TweenInfo.new(0.2),
            {
                Transparency = 0.7
            }
        ):Play()

    end)

    return Button
end

--// Buttons
local TPS = CreateButton(
    "TPS",
    "TPS",
    UDim2.fromOffset(30, 170)
)

local Touchline = CreateButton(
    "Touchline",
    "Touchline",
    UDim2.fromOffset(30, 228)
)

--// Copyright
local Copyright = Instance.new("TextLabel")
Copyright.Name = "Copyright"
Copyright.Size = UDim2.new(1, 0, 0, 20)
Copyright.Position = UDim2.fromOffset(0, 294)
Copyright.BackgroundTransparency = 1
Copyright.Text = "A7med"
Copyright.TextColor3 = Color3.fromRGB(90, 90, 100)
Copyright.TextSize = 11
Copyright.Font = Enum.Font.GothamMedium
Copyright.Parent = Frame

--// Button Events
TPS.MouseButton1Click:Connect(function()
    warn("TPS SELECTED")
    -- اربط TPS هنا داخل بيئتك
end)

Touchline.MouseButton1Click:Connect(function()
    warn("TOUCHLINE SELECTED")
    -- اربط Touchline هنا داخل بيئتك
end)

--// Drag System
local Dragging = false
local DragStart = nil
local StartPosition = nil

local function UpdateDrag(Input)

    if not DragStart or not StartPosition then
        return
    end

    local Delta = Input.Position - DragStart

    Frame.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end

Frame.InputBegan:Connect(function(Input)

    if Input.UserInputType == Enum.UserInputType.MouseButton1
        or Input.UserInputType == Enum.UserInputType.Touch then

        -- منع السحب لو الضغط على X
        if Input.Target == CloseButton then
            return
        end

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

UserInputService.InputChanged:Connect(function(Input)

    if not Dragging then
        return
    end

    if Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch then

        UpdateDrag(Input)
    end
end)

--// Close Animation
CloseButton.MouseButton1Click:Connect(function()

    Dragging = false

    local CloseTween = TweenService:Create(
        Frame,
        TweenInfo.new(
            0.35,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
        ),
        {
            Position = UDim2.new(0.5, 0, 1.5, 0)
        }
    )

    CloseTween:Play()

    CloseTween.Completed:Connect(function()

        if Gui and Gui.Parent then
            Gui:Destroy()
        end

    end)
end)

--// Opening Animation
TweenService:Create(
    Frame,
    TweenInfo.new(
        1,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    ),
    {
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }
):Play()
