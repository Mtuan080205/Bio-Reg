--[[
    Zrxx Hub - Blox Fruits Mobile (Bản Fix Hoàn Toàn Lỗi Không Lên Menu)
    Tên Menu: Zrxx Hub
    Hỗ trợ đầy đủ Quest hệ thống từ Sea 1 -> Sea 3
--]]

-- ==========================================
-- 1. KHỞI TẠO THƯ VIỆN GIAO DIỆN SIÊU NHẸ (REDZ UI MOBILE)
-- ==========================================
local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/skid12qp2/redzui/main/redzui.lua"))()

local Window = RedzLib:MakeWindow({
    Name = "Zrxx Hub | Blox Fruits",
    SubTitle = "Bản Sửa Lỗi Hiển Thị Mobile",
    Discord = ""
})

-- Tạo Tab chính trên giao diện
local MainTab = Window:CreateTab("Main Farm", "rbxassetid://4483345998")

-- ==========================================
-- 2. ĐỊNH NGHĨA CÁC BIẾN TOÀN CỤC CHẠY MENU
-- ==========================================
_G.AutoFarmLevel = false
_G.FastAttack = false
_G.BringMob = false
_G.SelectWeapon = "Melee"
_G.Fast_Delay = 0.05 -- Tối ưu hóa tốc độ đánh nhanh hơn

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Ms = ""
local NameQuest = ""
local QuestLv = 0
local NameMon = ""
local CFrameQ = CFrame.new(0,0,0)
local CFrameMon = CFrame.new(0,0,0)
local MonFarm = ""
local FarmPos = CFrame.new(0,0,0)
local bringmob = false

-- ==========================================
-- 3. HÀM KIỂM TRA LEVEL & QUEST (FULL CẢ 3 SEA)
-- ==========================================
function CheckLevel()
    local myLevel = Player.Data.Level.Value
    
    -- ------------------------------------------
    -- TOÀN BỘ NHIỆM VỤ TẠI SEA 1
    -- ------------------------------------------
    if game.PlaceId == 2753915549 or myLevel < 700 then
        if myLevel >= 1 and myLevel <= 9 then
            Ms = "Bandit [Lv. 1]" NameQuest = "BanditQuest1" QuestLv = 1 NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.93, 16.45, 1547.78) CFrameMon = CFrame.new(1038.55, 41.29, 1576.50)
        elseif myLevel >= 10 and myLevel <= 14 then
            Ms = "Monkey [Lv. 10]" NameQuest = "JungleQuest" QuestLv = 1 NameMon = "Monkey"
            CFrameQ = CFrame.new(-1601.65, 36.85, 153.38) CFrameMon = CFrame.new(-1448.14, 50.85, 63.60)
        elseif myLevel >= 15 and myLevel <= 29 then
            Ms = "Gorilla [Lv. 15]" NameQuest = "JungleQuest" QuestLv = 2 NameMon = "Gorilla"
            CFrameQ = CFrame.new(-1601.65, 36.85, 153.38) CFrameMon = CFrame.new(-1142.12, 4.75, -516.32)
        elseif myLevel >= 30 and myLevel <= 59 then
            Ms = "Pirate [Lv. 30]" NameQuest = "BuggyQuest1" QuestLv = 1 NameMon = "Pirate"
            CFrameQ = CFrame.new(-1141.13, 4.75, 3824.12) CFrameMon = CFrame.new(-1214.28, 4.75, 3915.21)
        elseif myLevel >= 60 and myLevel <= 89 then
            Ms = "Desert Bandit [Lv. 60]" NameQuest = "DesertQuest" QuestLv = 1 NameMon = "Desert Bandit"
            CFrameQ = CFrame.new(894.12, 6.45, 4392.12) CFrameMon = CFrame.new(985.42, 6.45, 4425.16)
        elseif myLevel >= 90 and myLevel <= 119 then
            Ms = "Snow Bandit [Lv. 90]" NameQuest = "SnowQuest" QuestLv = 1 NameMon = "Snow Bandit"
            CFrameQ = CFrame.new(1386.12, 87.25, -1298.41) CFrameMon = CFrame.new(1294.15, 105.12, -1342.15)
        elseif myLevel >= 120 and myLevel <= 149 then
            Ms = "Chief Petty Officer [Lv. 120]" NameQuest = "MarineQuest" QuestLv = 1 NameMon = "Chief Petty Officer"
            CFrameQ = CFrame.new(-5039.12, 28.45, 4324.12) CFrameMon = CFrame.new(-4895.12, 22.15, 4265.18)
        elseif myLevel >= 150 and myLevel <= 192 then
            Ms = "Sky Bandit [Lv. 150]" NameQuest = "SkyQuest" QuestLv = 1 NameMon = "Sky Bandit"
            CFrameQ = CFrame.new(-1242.12, 354.75, -5902.12) CFrameMon = CFrame.new(-1180.12, 355.12, -5950.15)
        elseif myLevel >= 193 and myLevel <= 249 then
            Ms = "Toga Warrior [Lv. 225]" NameQuest = "ColosseumQuest" QuestLv = 1 NameMon = "Toga Warrior"
            CFrameQ = CFrame.new(-1580.21, 7.25, -2980.15) CFrameMon = CFrame.new(-1450.12, 7.25, -3020.15)
        elseif myLevel >= 250 and myLevel <= 299 then
            Ms = "Fishman Warrior [Lv. 250]" NameQuest = "FishmanQuest" QuestLv = 1 NameMon = "Fishman Warrior"
            CFrameQ = CFrame.new(61122.12, 18.45, 1545.12) CFrameMon = CFrame.new(61020.15, 18.45, 1620.15)
        elseif myLevel >= 300 and myLevel <= 449 then
            Ms = "Military Soldier [Lv. 300]" NameQuest = "MagmaQuest" QuestLv = 1 NameMon = "Military Soldier"
            CFrameQ = CFrame.new(-5212.15, 12.45, 8495.15) CFrameMon = CFrame.new(-5320.15, 12.45, 8560.15)
        elseif myLevel >= 450 and myLevel <= 624 then
            Ms = "God's Guard [Lv. 450]" NameQuest = "SkyQuest2" QuestLv = 1 NameMon = "God's Guard"
            CFrameQ = CFrame.new(-5650.12, 5.45, -6200.12) CFrameMon = CFrame.new(-5720.15, 5.45, -6280.15)
        else
            Ms = "Galley Pirate [Lv. 625]" NameQuest = "FountainQuest" QuestLv = 1 NameMon = "Galley Pirate"
            CFrameQ = CFrame.new(5250.15, 38.45, 4150.15) CFrameMon = CFrame.new(5340.12, 38.45, 4230.12)
        end

    -- ------------------------------------------
    -- TOÀN BỘ NHIỆM VỤ TẠI SEA 2
    -- ------------------------------------------
    elseif game.PlaceId == 4442272125 or (myLevel >= 700 and myLevel < 1500) then
        if myLevel >= 700 and myLevel <= 749 then
            Ms = "Raider [Lv. 700]" NameQuest = "Area1Quest" QuestLv = 1 NameMon = "Raider"
            CFrameQ = CFrame.new(-426.69, 72.99, 1836.43) CFrameMon = CFrame.new(-390.45, 73.15, 1920.12)
        elseif myLevel >= 750 and myLevel <= 874 then
            Ms = "Mercenary [Lv. 750]" NameQuest = "Area1Quest" QuestLv = 2 NameMon = "Mercenary"
            CFrameQ = CFrame.new(-426.69, 72.99, 1836.43) CFrameMon = CFrame.new(-550.25, 72.99, 1720.45)
        elseif myLevel >= 875 and myLevel <= 924 then
            -- Mốc cấp độ 905 hiện tại của bạn nằm ở đây
            Ms = "Desert Raider [Lv. 875]" NameQuest = "Area2Quest" QuestLv = 1 NameMon = "Desert Raider"
            CFrameQ = CFrame.new(-1939.23, 393.18, -1373.91) CFrameMon = CFrame.new(-1714.28, 395.21, -1124.36)
        elseif myLevel >= 925 and myLevel <= 999 then
            Ms = "Flipped Captain [Lv. 925]" NameQuest = "Area2Quest" QuestLv = 2 NameMon = "Flipped Captain"
            CFrameQ = CFrame.new(-1939.23, 393.18, -1373.91) CFrameMon = CFrame.new(-1840.45, 393.15, -1620.12)
        elseif myLevel >= 1000 and myLevel <= 1124 then
            Ms = "Snow Trooper [Lv. 1000]" NameQuest = "SnowMountainQuest" QuestLv = 1 NameMon = "Snow Trooper"
            CFrameQ = CFrame.new(650.15, 400.12, -5200.15) CFrameMon = CFrame.new(720.12, 402.15, -5340.12)
        elseif myLevel >= 1125 and myLevel <= 1249 then
            Ms = "Lab Subordinate [Lv. 1125]" NameQuest = "IceGraveyardQuest" QuestLv = 1 NameMon = "Lab Subordinate"
            CFrameQ = CFrame.new(-6050.12, 15.45, -5050.12) CFrameMon = CFrame.new(-6150.12, 15.45, -5150.15)
        elseif myLevel >= 1250 and myLevel <= 1349 then
            Ms = "Ship Pirate [Lv. 1250]" NameQuest = "ShipQuest1" QuestLv = 1 NameMon = "Ship Pirate"
            CFrameQ = CFrame.new(1030.15, 125.45, 3290.15) CFrameMon = CFrame.new(1120.15, 126.15, 3350.15)
        else
            Ms = "Arctic Warrior [Lv. 1350]" NameQuest = "IceGraveyardQuest" QuestLv = 2 NameMon = "Arctic Warrior"
            CFrameQ = CFrame.new(-6050.12, 15.45, -5050.12) CFrameMon = CFrame.new(-6250.15, 15.45, -5280.12)
        end

    -- ------------------------------------------
    -- TOÀN BỘ NHIỆM VỤ TẠI SEA 3
    -- ------------------------------------------
    elseif game.PlaceId == 7405815058 or myLevel >= 1500 then
        if myLevel >= 1500 and myLevel <= 1574 then
            Ms = "Pirate Millionaire [Lv. 1500]" NameQuest = "PortQuest" QuestLv = 1 NameMon = "Pirate Millionaire"
            CFrameQ = CFrame.new(-290.15, 15.45, 5300.15) CFrameMon = CFrame.new(-350.12, 15.45, 5420.12)
        elseif myLevel >= 1575 and myLevel <= 1699 then
            Ms = "Pistol Billionaire [Lv. 1575]" NameQuest = "PortQuest" QuestLv = 2 NameMon = "Pistol Billionaire"
            CFrameQ = CFrame.new(-290.15, 15.45, 5300.15) CFrameMon = CFrame.new(-420.15, 15.45, 5510.15)
        elseif myLevel >= 1700 and myLevel <= 1824 then
            Ms = "Dragon Crew Warrior [Lv. 1700]" NameQuest = "HydraQuest" QuestLv = 1 NameMon = "Dragon Crew Warrior"
            CFrameQ = CFrame.new(5700.12, 15.45, -1200.12) CFrameMon = CFrame.new(5820.12, 15.45, -1340.15)
        elseif myLevel >= 1825 and myLevel <= 1974 then
            Ms = "Fishman Raider [Lv. 1825]" NameQuest = "FloatingTurtleQuest" QuestLv = 1 NameMon = "Fishman Raider"
            CFrameQ = CFrame.new(-10500.15, 15.45, -8500.15) CFrameMon = CFrame.new(-10620.12, 15.45, -8640.12)
        elseif myLevel >= 1975 and myLevel <= 2199 then
            Ms = "Cookie Crafter [Lv. 1975]" NameQuest = "IceCreamIslandQuest" QuestLv = 1 NameMon = "Cookie Crafter"
            CFrameQ = CFrame.new(-12000.12, 15.45, -10500.12) CFrameMon = CFrame.new(-12120.15, 15.45, -10640.15)
        else
            Ms = "Reborn Skeleton [Lv. 2200]" NameQuest = "HauntedCastleQuest" QuestLv = 1 NameMon = "Reborn Skeleton"
            CFrameQ = CFrame.new(-15000.15, 15.45, 12000.15) CFrameMon = CFrame.new(-15150.12, 15.45, 12150.12)
        end
    end
end

-- ==========================================
-- 4. HÀM TỰ ĐỘNG TRANG BỊ VŨ KHÍ
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

-- ==========================================
-- 5. HÀM TỰ ĐỘNG ĐÁNH SIÊU TỐC (FAST ATTACK GỐC)
-- ==========================================
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

-- ==========================================
-- 6. VÒNG LẶP CHÍNH: AUTO NHẬN QUEST & FARM LEVEL
-- ==========================================
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
                            
                            if _G.FastAttack then
                                AttackNoCoolDown()
                            end
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

-- ==========================================
-- 7. VÒNG LẶP GOM QUÁI (BRING MOB GỐC)
-- ==========================================
task.spawn(function()
    while true do
        task.wait()
        if _G.BringMob and bringmob then
            pcall(function()
                local enemies = game.Workspace:FindFirstChild("Enemies")
                if enemies then
                    for _, v302 in pairs(enemies:GetChildren()) do
                        if v302.Name == MonFarm and v302:FindFirstChild("Humanoid") and v302.Humanoid.Health > 0 and v302:FindFirstChild("HumanoidRootPart") then
                            if v302.Name ~= "Factory Staff" then
                                if (v302.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= 1000 then
                                    v302.HumanoidRootPart.CFrame = FarmPos
                                    v302.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v302.HumanoidRootPart.CanCollide = false
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- 8. THIẾT LẬP NÚT BẤM GIAO DIỆN REDZ UI
-- ==========================================

-- Thả xuống chọn vũ khí
MainTab:AddDropdown({
    Name = "Chọn Vũ Khí (Select Weapon)",
    Options = {"Melee", "Sword", "Fruit"},
    Default = "Melee",
    Callback = function(Value)
        _G.SelectWeapon = Value
    end
})

-- Công tắc bật tắt Auto Farm
MainTab:AddToggle({
    Name = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmLevel = Value
    end
})

-- Công tắc bật tắt Fast Attack
MainTab:AddToggle({
    Name = "Fast Attack (Đánh Nhanh)",
    Default = false,
    Callback = function(Value)
        _G.FastAttack = Value
    end
})

-- Công tắc bật tắt Gom Quái
MainTab:AddToggle({
    Name = "Gom Quái (Bring Mob)",
    Default = false,
    Callback = function(Value)
        _G.BringMob = Value
    end
})