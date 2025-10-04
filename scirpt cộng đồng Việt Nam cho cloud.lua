-- ==============================================================
--  SCRIPT AFK FARM "Treo tiền by Thái Vũ"
--  Có: Teleport ngẫu nhiên + AFK chống kick + UI ẩn/hiện
-- ==============================================================

local plr = game.Players.LocalPlayer
local vu = game:GetService("VirtualUser")

-- =========== Tọa độ Auto Farm ===========
local AUTO_FARM_COORDINATES = {
    Vector3.new(598.6, 21.2, -398.2),   -- Farm 1
    Vector3.new(575.0, 19.7, -427.9),   -- Farm 2
    Vector3.new(1677.7, 19.2, -391.4),  -- Farm 3
    Vector3.new(1723.6, 19.2, -389.5),  -- Farm 4
    Vector3.new(1723.6, 19.2, -288.7),  -- Farm 5
    Vector3.new(1677.7, 19.2, -290.6),  -- Farm 6
    Vector3.new(1657.9, 19.2, -224.0),  -- Farm 7
}

-- =========== Notification ===========
local function notify(title, text, duration)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

-- =========== Hàm Teleport ===========
local function perform_single_teleport()
    local char = plr.Character or plr.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")

    local num = #AUTO_FARM_COORDINATES
    local idx = math.random(1, num)
    local pos = AUTO_FARM_COORDINATES[idx]

    local success, err = pcall(function()
        root.CFrame = CFrame.new(pos)
    end)

    if success and not err then
        notify("📍 Dịch Chuyển OK!", "Đến điểm Farm #" .. idx, 4)
    else
        notify("❌ Lỗi Teleport", "Không dịch chuyển được!", 4)
    end
end

-- =========== Hàm AFK ===========
local afk_active = false
local cam = workspace.CurrentCamera

local function toggle_afk()
    if afk_active then
        afk_active = false
        notify("🚫 AFK OFF", "Chống kick AFK đã tắt.", 4)
    else
        afk_active = true
        notify("✅ AFK ON", "Chống kick AFK đã bật!", 4)

        -- chống kick
        plr.Idled:Connect(function()
            if afk_active then
                vu:Button2Down(Vector2.new(), cam.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(), cam.CFrame)
            end
        end)

        -- xoay camera
        task.spawn(function()
            while afk_active do
                cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(15), 0)
                task.wait(20)
            end
        end)
    end
end

-- =========== UI ===========
local gui = Instance.new("ScreenGui")
gui.Name = "TreoTienUI"
gui.Parent = plr:WaitForChild("PlayerGui")

local f = Instance.new("Frame")
f.Size = UDim2.new(0, 220, 0, 240)
f.Position = UDim2.new(0, 20, 0, 100)
f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
f.Active = true
f.Draggable = true
f.Parent = gui

Instance.new("UICorner", f)

-- Tiêu đề
local title = Instance.new("TextLabel", f)
title.Size = UDim2.new(1, -10, 0, 30)
title.Position = UDim2.new(0, 5, 0, 5)
title.Text = "💸 Treo tiền by Thái Vũ"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.BackgroundTransparency = 1

-- Nút Teleport
local tpButton = Instance.new("TextButton", f)
tpButton.Position = UDim2.new(0, 10, 0, 50)
tpButton.Size = UDim2.new(1, -20, 0, 30)
tpButton.Text = "⚡ Teleport Ngẫu nhiên"
tpButton.BackgroundColor3 = Color3.fromRGB(35, 150, 250)
tpButton.TextColor3 = Color3.new(1,1,1)
tpButton.Font = Enum.Font.GothamBold
tpButton.TextScaled = true
Instance.new("UICorner", tpButton)

tpButton.MouseButton1Click:Connect(perform_single_teleport)

-- Nút AFK
local afkButton = Instance.new("TextButton", f)
afkButton.Position = UDim2.new(0, 10, 0, 90)
afkButton.Size = UDim2.new(1, -20, 0, 30)
afkButton.Text = "🤖 Bật/Tắt AFK"
afkButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
afkButton.TextColor3 = Color3.new(1,1,1)
afkButton.Font = Enum.Font.GothamBold
afkButton.TextScaled = true
Instance.new("UICorner", afkButton)

afkButton.MouseButton1Click:Connect(toggle_afk)

-- Nút Ẩn/Hiện
local toggleUI = Instance.new("TextButton", gui)
toggleUI.Size = UDim2.new(0, 100, 0, 30)
toggleUI.Position = UDim2.new(0, 20, 0, 350)
toggleUI.Text = "Ẩn/Hiện UI"
toggleUI.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleUI.TextColor3 = Color3.new(1,1,1)
toggleUI.Font = Enum.Font.GothamBold
toggleUI.TextScaled = true
Instance.new("UICorner", toggleUI)

toggleUI.MouseButton1Click:Connect(function()
    f.Visible = not f.Visible
end)