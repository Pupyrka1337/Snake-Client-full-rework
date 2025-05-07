-- SNAKE CLIENT ASCII Logo
print([[
1
 SSSSS  N   N  AAAAA  K   K  EEEEE       CCCCC  L       III  EEEEE  N   N  TTTTT
 S      NN  N  A   A  K  K   E           C      L        I   E      NN  N    T
 SSSSS  N N N  AAAAA  KKK    EEEE        C      L        I   EEEE   N N N    T
     S  N  NN  A   A  K  K   E           C      L        I   E      N  NN    T
 SSSSS  N   N  A   A  K   K  EEEEE       CCCCC  LLLLL   III  EEEEE  N   N    T
2
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

-- SNAKE CLIENT ASCII Logo
print([[
 1
 SSSSS  N   N  AAAAA  K   K  EEEEE       CCCCC  L       III  EEEEE  N   N  TTTTT
 S      NN  N  A   A  K  K   E           C      L        I   E      NN  N    T
 SSSSS  N N N  AAAAA  KKK    EEEE        C      L        I   EEEE   N N N    T
     S  N  NN  A   A  K  K   E           C      L        I   E      N  NN    T
 SSSSS  N   N  A   A  K   K  EEEEE       CCCCC  LLLLL   III  EEEEE  N   N    T
 2
]])

-- Удаление старого GUI
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
if playerGui:FindFirstChild("SNAKE_CLIENT") then
    playerGui:FindFirstChild("SNAKE_CLIENT"):Destroy()
end

-- GUI
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "SNAKE_CLIENT"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 350)
Frame.Position = UDim2.new(0.5, -150, 0.5, -175)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true -- Перетаскивание

local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 255, 255)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🐍 SNAKE CLIENT"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.BackgroundTransparency = 1
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold

-- FOV Circle
local fovCircle = Drawing.new("Circle")
fovCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
fovCircle.Radius = 100
fovCircle.Thickness = 1
fovCircle.Transparency = 1
fovCircle.Color = Color3.fromRGB(0, 255, 255)
fovCircle.Visible = false

local silentAimEnabled = false
local espEnabled = false

-- Silent Aim функция (с FOV)
local function getClosestPlayer()
    local closest = nil
    local shortestDistance = fovCircle.Radius

    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - fovCircle.Position).Magnitude
                if dist < shortestDistance then
                    closest = v
                    shortestDistance = dist
                end
            end
        end
    end

    return closest
end

-- ESP функция
local espBoxes = {}

local function clearESP()
    for _, box in pairs(espBoxes) do
        box:Remove()
    end
    espBoxes = {}
end

local function createESP()
    clearESP()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local box = Drawing.new("Text")
            box.Text = plr.Name
            box.Size = 14
            box.Color = Color3.fromRGB(255, 255, 255)
            box.Center = true
            box.Outline = true
            box.Visible = true
            espBoxes[plr] = box
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if espEnabled then
        for plr, box in pairs(espBoxes) do
            if plr.Character and plr.Character:FindFirstChild("Head") then
                local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.Head.Position)
                box.Position = Vector2.new(pos.X, pos.Y - 20)
                box.Visible = onScreen
            else
                box.Visible = false
            end
        end
    else
        clearESP()
    end
end)

-- Кнопки
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

createButton("Toggle ESP", 60, function()
    espEnabled = not espEnabled
    if espEnabled then
        createESP()
        print("[SNAKE CLIENT] ESP ON")
    else
        clearESP()
        print("[SNAKE CLIENT] ESP OFF")
    end
end)

createButton("Toggle Silent Aim", 110, function()
    silentAimEnabled = not silentAimEnabled
    fovCircle.Visible = silentAimEnabled
    print("[SNAKE CLIENT] Silent Aim:", silentAimEnabled and "ON" or "OFF")
end)

createButton("Increase FOV", 160, function()
    fovCircle.Radius = fovCircle.Radius + 10
    print("[SNAKE CLIENT] FOV:", fovCircle.Radius)
end)

createButton("Decrease FOV", 210, function()
    fovCircle.Radius = math.max(10, fovCircle.Radius - 10)
    print("[SNAKE CLIENT] FOV:", fovCircle.Radius)
end)

createButton("Trigger Bot (demo)", 260, function()
    print("[SNAKE CLIENT] Trigger Bot activated! (demo only)")
end)

-- Уведомление
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "SNAKE CLIENT Loaded",
        Text = "GUI готово, брат!",
        Duration = 5
    })
end)