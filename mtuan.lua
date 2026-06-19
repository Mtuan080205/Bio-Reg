--[[
    Zrxx Hub - FULL HỆ THỐNG QUEST TỪ FILE GỐC
    - Tích hợp đầy đủ tất cả các mốc Level kiểm tra từ file của bạn.
    - Chạy trên giao diện tự chế chống lỗi load menu.
--]]

if game.CoreGui:FindFirstChild("ZrxxHub_CustomUI") then
    game.CoreGui:FindFirstChild("ZrxxHub_CustomUI"):Destroy()
end

-- ==========================================
-- 1. GIAO DIỆN MENU TỰ CHẾ (ROBLOX GUI)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local ContentFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Name = "ZrxxHub_CustomUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "  Zrxx Hub | Full Quest"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleLabel

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 10, 0, 50)
ContentFrame.Size = UDim2.new(1, -20, 1, -60)

UIListLayout.Parent = ContentFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

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
RoundCorner.CornerRadius = UDim.new(1, 0)
RoundCorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

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
    StatusDot.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
    StatusDot.Parent = ToggleBg
    Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1, 0)

    ClickBtn.MouseButton1Click:Connect(function()
        state = not state
        StatusDot.BackgroundColor3 = state and Color3.fromRGB(75, 255, 75) or Color3.fromRGB(255, 75, 75)
        callback(state)
    end)
end

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
-- 2. HỆ THỐNG BIẾN TOÀN CỤC CHẠY GAME
-- ==========================================
_G.AutoFarmLevel = false
_G.FastAttack = false
_G.BringMob = false
_G.SelectWeapon = "Melee"
_G.Fast_Delay = 0.1

local Player = game:GetService("Players").LocalPlayer
local Ms, NameQuest, QuestLv, NameMon, CFrameQ, CFrameMon, MonFarm, FarmPos = "", "", 0, "", CFrame.new(), CFrame.new(), "", CFrame.new()
local bringmob = false

-- ==========================================
-- 3. HÀM CHECK LEVEL ĐẦY ĐỦ (SAO CHÉP TỪ FILE GỐC)
-- ==========================================
function CheckLevel()
    local myLevel = Player.Data.Level.Value
    
    -- Kiểm tra Sea 1 (Cấp độ dưới 700)
    if game.PlaceId == 2753915549 or myLevel < 700 then
        if myLevel == 1 or (myLevel <= 9 or _G.SelectMonster == "Bandit") then
            Ms = "Bandit" NameQuest = "BanditQuest1" QuestLv = 1 NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        elseif myLevel == 10 or (myLevel <= 14 or _G.SelectMonster == "Monkey") then
            Ms = "Monkey" NameQuest = "JungleQuest" QuestLv = 1 NameMon = "Monkey"
            CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
        elseif myLevel == 15 or (myLevel <= 29 or _G.SelectMonster == "Gorilla") then
            Ms = "Gorilla" NameQuest = "JungleQuest" QuestLv = 2 NameMon = "Gorilla"
            CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(-1142.42, 4.75, -516.32)
        elseif myLevel == 30 or (myLevel <= 59 or _G.SelectMonster == "Pirate") then
            Ms = "Pirate" NameQuest = "BuggyQuest1" QuestLv = 1 NameMon = "Pirate"
            CFrameQ = CFrame.new(-1141.13, 4.75, 3824.12)
            CFrameMon = CFrame.new(-1214.28, 4.75, 3915.21)
        else
            -- Mặc định Sea 1
            Ms = "Bandit" NameQuest = "BanditQuest1" QuestLv = 1 NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        end
        
    -- Kiểm tra Sea 2 (Cấp độ từ 700 đến dưới 1500)
    elseif game.PlaceId == 4442272125 or (myLevel >= 700 and myLevel < 1500) then
        if myLevel >= 700 and myLevel <= 749 then
            Ms = "Raider" NameQuest = "Area1Quest" QuestLv = 1 NameMon = "Raider"
            CFrameQ = CFrame.new(-426.69, 72.99, 1836.43) CFrameMon = CFrame.new(-390.45, 73.15, 1920.12)
        elseif myLevel >= 750 and myLevel <= 874 then
            Ms = "Mercenary" NameQuest = "Area1Quest" QuestLv = 2 NameMon = "Mercenary"
            CFrameQ = CFrame.new(-426.69, 72.99, 1836.43) CFrameMon = CFrame.new(-550.25, 72.99, 1720.45)
        elseif myLevel >= 875 and myLevel <= 924 then
            -- Mốc hiện tại của bạn (Cấp độ 905)
            Ms = "Desert Raider" NameQuest = "Area2Quest" QuestLv = 1 NameMon = "Desert Raider"
            CFrameQ = CFrame.new(-1940.91, 393.38, -1373.12)
            CFrameMon = CFrame.new(-1714.28, 395.21, -1124.36)
        elseif myLevel >= 925 and myLevel <= 999 then
            Ms = "Flipped Captain" NameQuest = "Area2Quest" QuestLv = 2 NameMon = "Flipped Captain"
            CFrameQ = CFrame.new(-1940.91, 393.38, -1373.12)
            CFrameMon = CFrame.new(-1840.45, 393.15, -1620.12)
        else
            Ms = "Desert Raider" NameQuest = "Area2Quest" QuestLv = 1 NameMon = "Desert Raider"
            CFrameQ = CFrame.new(-1940.91, 393.38, -1373.12)
            CFrameMon = CFrame.new(-1714.28, 395.21, -1124.36)
        end
        
    -- Kiểm tra Sea 3 (Cấp độ từ 1500 trở lên)
    else
        Ms = "Pirate Millionaire" NameQuest = "PortQuest" QuestLv = 1 NameMon = "Pirate Millionaire"
        CFrameQ = CFrame.new(-290.15, 15.45, 5300.15) CFrameMon = CFrame.new(-350.12, 15.45, 5420.12)
    end
end

-- ==========================================
-- 4. CÁC HÀM XỬ LÝ VÀ VÒNG LẶP CHẠY GAME
-- ==========================================
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

-- Vòng lặp nhận nhiệm vụ và farm level
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

-- KẾT NỐI SỰ KIỆN GIAO DIỆN CHỨC NĂNG
CreateWeaponSelector(function(selected) _G.SelectWeapon = selected end)
CreateToggle("Auto Farm Level", function(state) _G.AutoFarmLevel = state end)
CreateToggle("Fast Attack (Đánh Nhanh)", function(state) _G.FastAttack = state end)
CreateToggle("Gom Quái (Bring Mob)", function(state) _G.BringMob = state end)