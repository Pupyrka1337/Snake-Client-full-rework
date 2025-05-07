-- Silent Aim + Trigger Bot (упрощённый для теста)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")

local function getClosestTarget()
    local shortestDistance = math.huge
    local closestPlayer = nil

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local screenPoint, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character.Head.Position)
            local dist = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude

            if onScreen and dist < shortestDistance and dist < 150 then
                shortestDistance = dist
                closestPlayer = player
            end
        end
    end

    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    local target = getClosestTarget()
    if target and target.Character and target.Character:FindFirstChild("Head") then
        -- Trigger Bot
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            mouse1click()
        end
        -- Silent Aim logic (тестовая заготовка)
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.Head.Position)
    end
end)
