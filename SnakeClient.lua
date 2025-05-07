-- SNAKE CLIENT ASCII Logo
print([[
 SSSSS  N   N  AAAAA  K   K  EEEEE       CCCCC  L       III  EEEEE  N   N  TTTTT
 S      NN  N  A   A  K  K   E           C      L        I   E      NN  N    T
 SSSSS  N N N  AAAAA  KKK    EEEE        C      L        I   EEEE   N N N    T
    S  N  NN  A   A  K  K   E           C      L        I   E      N  NN    T
 SSSSS  N   N  A   A  K   K  EEEEE       CCCCC  LLLLL   III  EEEEE  N   N    T
]])

-- Remove old GUI if it exists
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
if playerGui:FindFirstChild("SNAKE_CLIENT") then
    playerGui:FindFirstChild("SNAKE_CLIENT"):Destroy()
end

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SNAKE_CLIENT"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 300)
Frame.Position = UDim2.new(0.5, -150, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Frame.BorderSizePixel = 0

-- Neon Border
local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 255, 255)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🐍 SNAKE CLIENT"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.BackgroundTransparency = 1
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold

-- Button Template Function
local function createButton(name, position, callback)
    local button = Instance.new("TextButton", Frame)
    button.Size = UDim2.new(0.8, 0, 0, 40)
    button.Position = UDim2.new(0.1, 0, 0, position)
    button.Text = name
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.MouseButton1Click:Connect(callback)
end

-- Dummy Feature Functions
local function toggleESP()
    print("[SNAKE CLIENT] ESP toggled!")
end

local function toggleSilentAim()
    print("[SNAKE CLIENT] Silent Aim toggled!")
end

local function toggleTriggerBot()
    print("[SNAKE CLIENT] Trigger Bot toggled!")
end

-- Create buttons
createButton("Toggle ESP", 60, toggleESP)
createButton("Toggle Silent Aim", 110, toggleSilentAim)
createButton("Toggle Trigger Bot", 160, toggleTriggerBot)

-- Notification
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "SNAKE CLIENT Loaded",
        Text = "Добро пожаловать!",
        Duration = 5
    })
end)
