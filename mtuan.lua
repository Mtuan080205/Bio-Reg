--[[
    Zrxx Hub - TỰ TẠO GIAO DIỆN GỐC (CUSTOM ROBLOX GUI)
    - 100% Không bao giờ lỗi "Không lên menu".
    - Tích hợp nút thu nhỏ lơ lửng trên màn hình cho Mobile.
--]]

-- Xóa Menu cũ nếu có để tránh trùng lặp khi chạy lại nhiều lần
if game.CoreGui:FindFirstChild("ZrxxHub_CustomUI") then
    game.CoreGui:FindFirstChild("ZrxxHub_CustomUI"):Destroy()
end

-- ==========================================
-- 1. KHỞI TẠO FRAME GIAO DIỆN GỐC
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local ContentFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ToggleButton = Instance.new("TextButton") -- Nút tròn thu nhỏ menu

ScreenGui.Name = "ZrxxHub_CustomUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Khung Menu Chính (Chính giữa màn hình)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true -- Cho phép giữ và kéo Menu di chuyển trên màn hình

-- Bo góc cho Menu
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Tiêu đề Menu
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "  Zrxx Hub | Blox Fruits"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleLabel

-- Vùng chứa các nút chức năng
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 10, 0, 50)
ContentFrame.Size = UDim2.new(1, -20, 1, -60)

UIListLayout.Parent = ContentFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

-- Nút Tròn Mở/Tắt Menu Lơ Lửng (Dành cho Mobile)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "Zrxx"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14
ToggleButton.Active = true
ToggleButton.Draggable = true

local RoundCorner = Instance.new("UICorner")
RoundCorner.CornerRadius = UDim.new(1, 0) -- Biến nút thành hình tròn
RoundCorner.Parent = ToggleButton

-- Logic Ẩn / Hiện menu khi bấm vào nút Tròn
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ==========================================
-- 2. HÀM TẠO CÁC NÚT (COMPONENTS)
-- ==========================================

-- Hàm tạo nút Bật/Tắt (Toggle)
local function CreateToggle(name, callback)
    local ToggleBg = Instance.new("Frame")
    local ToggleName = Instance.new("TextLabel")
    local ClickBtn = Instance.new("TextButton")
    local StatusDot = Instance.new("Frame")
    local state = false

    ToggleBg.Size = UDim2.new(1, 0, 0, 35)
    ToggleBg.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    ToggleBg.Parent = ContentFrame
    Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(0, 6)

    ToggleName.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleName.Position = UDim2.new(0, 10, 0, 0)
    ToggleName.BackgroundTransparency = 1
    ToggleName.Font = Enum.Font.Gotham
    ToggleName.Text = name
    ToggleName.TextColor3 = Color3.fromRGB(220, 220, 220)
    ToggleName.TextSize = 14
    ToggleName.TextXAlignment = Enum.TextXAlignment.Left
    ToggleName.Parent = ToggleBg

    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Text = ""
    ClickBtn.Parent = ToggleBg

    StatusDot.Size = UDim2.new(0, 15, 0, 15)
    StatusDot.Position = UDim2.new(0.9, -5, 0.25, 0)
    StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75) -- Đỏ là Tắt
    StatusDot.Parent = ToggleBg
    Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

    ClickBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            StatusDot.BackgroundColor3 = Color3.fromRGB(75, 255, 75) -- Xanh là Bật
        else
            StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
        end
        callback(state)
    end)
end

-- Hàm tạo ô chọn Vũ Khí (Dropdown đơn giản bằng Nút bấm xoay vòng)
local function CreateWeaponSelector(callback)
    local DropBg = Instance.new("Frame")
    local DropName = Instance.new("TextLabel")
    local ChangeBtn = Instance.new("TextButton")
    local weapons = {"Melee", "Sword", "Fruit"}
    local index = 1

    DropBg.Size = UDim2.new(1, 0, 0, 35)
    DropBg.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    DropBg.Parent = ContentFrame
    Instance.new("UICorner", DropBg).CornerRadius = UDim.new(0, 6)

    DropName.Size = UDim2.new(0.5, 0, 1, 0)
    DropName.Position = UDim2.new(0, 10, 0, 0)
    DropName.BackgroundTransparency = 1
    DropName.Font = Enum.Font.Gotham
    DropName.Text = "Vũ Khí:"
    DropName.TextColor3 = Color3.fromRGB(220, 220, 220)
    DropName.TextSize = 14
    DropName.TextXAlignment = Enum.TextXAlignment.Left
    DropName.Parent = DropBg

    ChangeBtn.Size = UDim2.new(0.4, 0, 0.8, 0)
    ChangeBtn.Position = UDim2.new(0.55, 0, 0.1, 0)
    ChangeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    ChangeBtn.Font = Enum.Font.GothamBold
    ChangeBtn.Text = weapons[index]
    ChangeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ChangeBtn.TextSize = 12
    ChangeBtn.Parent = DropBg
    Instance.new("UICorner", ChangeBtn).CornerRadius = UDim.new(0, 4)

    ChangeBtn.MouseButton1Click:Connect(function()
        index = index + 1
        if index > #weapons then index = 1 end
        ChangeBtn.Text = weapons[index]
        callback(weapons[index])
    end)
end

-- ==========================================
-- 3. ĐỊNH NGHĨA BIẾN TOÀN CỤC & LOGIC GAME (GIỮ NGUYÊN)
-- ==========================================
_G.AutoFarmLevel = false
_G.FastAttack = false
_G.BringMob = false
_G.SelectWeapon = "Melee"
_G.Fast_Delay = 0.1

local Player = game:GetService("Players").LocalPlayer
local Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon, MonFarm, FarmPos = "", "", 0, "", CFrame.new(), CFrame.new(), "", CFrame.new()
local bringmob = false

-- (Hàm logic CheckLevel tự động 3 Sea được giữ nguyên hoàn chỉnh để phục vụ cày cấp)
function CheckLevel()
    local myLevel = Player.Data.Level.Value
    if game.PlaceId == 2753915549 or myLevel < 700 then
        if myLevel >= 1 and myLevel <= 9 then
            Ms = "Bandit [Lv. 1]" NameQuest = "BanditQuest1" QuestLv = 1 NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.93, 16.45, 1547.78) CFrameMon = CFrame.new(1038.55, 41.29, 1576.50)
        else
            Ms = "Monkey [Lv. 10]" NameQuest = "JungleQuest" QuestLv = 1 NameMon = "Monkey"
            CFrameQ = CFrame.new(-1601.65, 36.85, 153.38) CFrameMon = CFrame.new(-1448.14, 50.85, 63.60)
        end
    elseif game.PlaceId == 4442272125 or (myLevel >= 700 and myLevel < 1500) then
        if myLevel >= 875 and myLevel <= 924 then
            Ms = "Desert Raider [Lv. 875]" NameQuest = "Area2Quest" QuestLv = 1 NameMon = "Desert Raider"
            CFrameQ = CFrame.new(-1939.23, 393.18, -1373.91) CFrameMon = CFrame.new(-1714.28, 395.21, -1124.36)
        else
            Ms = "Flipped Captain [Lv. 925]" NameQuest = "Area2Quest" QuestLv = 2 NameMon = "Flipped Captain"
            CFrameQ = CFrame.new(-1939.23, 393.18, -1373.91) CFrameMon = CFrame.new(-1840.45, 393.15, -1620.12)
        end
    else
        Ms = "Pirate Millionaire [Lv. 1500]" NameQuest = "PortQuest" QuestLv = 1 NameMon = "Pirate Millionaire"
        CFrameQ = CFrame.new(-290.15, 15.45, 5300.15) CFrameMon = CFrame.new(-350.12, 15.45, 5420.12)
    end
end

function EquipTool()
    local backpack = Player:FindFirstChild("Backpack")
    local character = Player.Character
    if character then
        for _, v in pairs(backpack:GetChildren()) do
            if v:IsA("Tool") then
                if _G.SelectWeapon == "Melee" and (v.ToolTip == "Melee" or string.find(v.Name, "Combat") or string.find(v.Name, "Style")) then
                    v.Parent = character
                elseif _G.SelectWeapon == "Sword" and v.ToolTip == "Sword" then
                    v.Parent = character
                elseif _G.SelectWeapon == "Fruit" and v.ToolTip == "Blox Fruit" then
                    v.Parent = character
                end
            end
        end
    end
end

function AttackNoCoolDown()
    pcall(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(850, 520))
        if game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Validator") then
            game:GetService("ReplicatedStorage").Remotes.Validator:FireServer(math.floor(workspace.DistributedTime))
        end
    end)
end

-- Vòng lặp chính Farm Level
task.spawn(function()
    while true do
        task.wait()
        if _G.AutoFarmLevel then
            pcall(function()
                CheckLevel()
                local hasQuest = Player.PlayerGui.Main:FindFirstChild("Quest").Visible
                if not hasQuest then
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        if (Player.Character.HumanoidRootPart.Position - CFrameQ.Position).Magnitude > 15 then
                            Player.Character.HumanoidRootPart.CFrame = CFrameQ
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                        end
                    end
                else
                    local enemies = game.Workspace:FindFirstChild("Enemies")
                    local targetMob = nil
                    if enemies then
                        for _, v in pairs(enemies:GetChildren()) do
                            if v.Name == NameMon and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                                targetMob = v
                                break
                            end
                        end
                    end
                    if targetMob then
                        repeat
                            task.wait(_G.Fast_Delay)
                            if not _G.AutoFarmLevel then break end
                            FarmPos = targetMob.HumanoidRootPart.CFrame
                            MonFarm = targetMob.Name
                            bringmob = true
                            EquipTool()
                            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                                Player.Character.HumanoidRootPart.CFrame = targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            end
                            targetMob.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            targetMob.HumanoidRootPart.CanCollide = false
                            if _G.FastAttack then AttackNoCoolDown() end
                        until not _G.AutoFarmLevel or not targetMob.Parent or targetMob.Humanoid.Health <= 0
                        bringmob = false
                    else
                        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                            Player.Character.HumanoidRootPart.CFrame = CFrameMon
                        end
                    end
                end
            end)
        end
    end
end)

-- Vòng lặp gom quái
task.spawn(function()
    while true do
        task.wait()
        if _G.BringMob and bringmob then
            pcall(function()
                local enemies = game.Workspace:FindFirstChild("Enemies")
                if enemies then
                    for _, v302 in pairs(enemies:GetChildren()) do
                        if v302.Name == MonFarm and v302:FindFirstChild("Humanoid") and v302.Humanoid.Health > 0 and v302:FindFirstChild("HumanoidRootPart") then
                            if (v302.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= 1000 then
                                v302.HumanoidRootPart.CFrame = FarmPos
                                v302.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v302.HumanoidRootPart.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- 4. KẾT NỐI GIAO DIỆN VỚI HỆ THỐNG LOGIC
-- ==========================================

-- Ô chọn vũ khí
CreateWeaponSelector(function(selected)
    _G.SelectWeapon = selected
end)

-- Nút Auto Farm Level
CreateToggle("Auto Farm Level", function(state)
    _G.AutoFarmLevel = state
end)

-- Nút Fast Attack
CreateToggle("Fast Attack (Đánh Nhanh)", function(state)
    _G.FastAttack = state
end)

-- Nút Gom Quái
CreateToggle("Gom Quái (Bring Mob)", function(state)
    _G.BringMob = state
end)