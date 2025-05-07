-- ESP функция
local espData = {}

local function clearESP()
    for _, data in pairs(espData) do
        data.box:Remove()
        data.hp:Remove()
    end
    espData = {}
end

local function createESP()
    clearESP()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local box = Drawing.new("Square")
            box.Thickness = 1.5
            box.Color = Color3.fromRGB(0, 255, 0)
            box.Filled = false
            box.Visible = false

            local hpText = Drawing.new("Text")
            hpText.Size = 14
            hpText.Color = Color3.fromRGB(255, 0, 0)
            hpText.Center = true
            hpText.Outline = true
            hpText.Visible = false

            espData[plr] = { box = box, hp = hpText }
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if espEnabled then
        for plr, drawings in pairs(espData) do
            local char = plr.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Head") and char:FindFirstChild("Humanoid") then
                local hrp = char.HumanoidRootPart
                local head = char.Head
                local humanoid = char.Humanoid

                local hrpPos, onScreen1 = workspace.CurrentCamera:WorldToViewportPoint(hrp.Position)
                local headPos, onScreen2 = workspace.CurrentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.3, 0))

                if onScreen1 and onScreen2 then
                    local height = math.abs(headPos.Y - hrpPos.Y)
                    local width = height / 2
                    local topLeft = Vector2.new(hrpPos.X - width / 2, hrpPos.Y - height)

                    drawings.box.Size = Vector2.new(width, height)
                    drawings.box.Position = topLeft
                    drawings.box.Visible = true

                    drawings.hp.Text = "HP: " .. math.floor(humanoid.Health)
                    drawings.hp.Position = Vector2.new(hrpPos.X, topLeft.Y - 16)
                    drawings.hp.Visible = true
                else
                    drawings.box.Visible = false
                    drawings.hp.Visible = false
                end
            else
                drawings.box.Visible = false
                drawings.hp.Visible = false
            end
        end
    else
        clearESP()
    end
end)
