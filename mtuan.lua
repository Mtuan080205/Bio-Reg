--[[
    Zrxx Hub - Blox Fruits Mobile UI (Rayfield Library)
    Tên Menu: Zrxx Hub
    Sử dụng Rayfield UI - Đẹp, chuyên nghiệp và tối ưu cho Mobile.
--]]

-- ==========================================
-- 1. KHỞI TẠO THƯ VIỆN RAYFIELD UI
-- ==========================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Zrxx Hub | Blox Fruits",
   LoadingTitle = "Zrxx Hub Loading...",
   LoadingSubtitle = "by YourName",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "ZrxxHubConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false -- Tắt hệ thống Key để vào thẳng Menu
})

-- Tạo Tab chính
local MainTab = Window:CreateTab("Main Farm", 4483345998) -- Icon ID

-- ==========================================
-- 2. BIẾN TOÀN CỤC KHỞI TẠO (TỪ FILE GỐC)
-- ==========================================
_G.AutoFarmLevel = false
_G.FastAttack = false
_G.BringMob = false
_G.SelectWeapon = "Melee"
_G.Fast_Delay = 0.1

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

local Sea1 = game.PlaceId == 2753915549

-- ==========================================
-- 3. CÁC HÀM XỬ LÝ LOGIC GỐC TỪ FILE CỦA BẠN
-- ==========================================

function CheckLevel()
    local v7 = Player.Data.Level.Value
    if Sea1 then
        if v7 == 1 or (v7 <= 9 or _G.SelectMonster == "Bandit") then
            Ms = "Bandit"
            NameQuest = "BanditQuest1"
            QuestLv = 1
            NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        elseif v7 == 10 or (v7 <= 14 or _G.SelectMonster == "Monkey") then
            Ms = "Monkey"
            NameQuest = "JungleQuest"
            QuestLv = 1
            NameMon = "Monkey"
            CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
        else
            Ms = "Bandit"
            NameQuest = "BanditQuest1"
            QuestLv = 1
            NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        end
    else
        Ms = "Bandit"
        NameQuest = "BanditQuest1"
        QuestLv = 1
        NameMon = "Bandit"
        CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
        CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
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

-- ==========================================
-- 4. VÒNG LẶP NỀN (SPAWN LOOPS)
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
-- 5. THIẾT LẬP NÚT BẤM GIAO DIỆN RAYFIELD
-- ==========================================

local Dropdown = MainTab:CreateDropdown({
   Name = "Chọn Vũ Khí (Select Weapon)",
   Options = {"Melee","Sword","Fruit"},
   CurrentOption = {"Melee"},
   MultipleOptions = false,
   Callback = function(Option)
      _G.SelectWeapon = Option[1]
   end,
})

local Toggle1 = MainTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "AutoFarm", 
   Callback = function(Value)
      _G.AutoFarmLevel = Value
   end,
})

local Toggle2 = MainTab:CreateToggle({
   Name = "Fast Attack",
   CurrentValue = false,
   Flag = "FastAttack", 
   Callback = function(Value)
      _G.FastAttack = Value
   end,
})

local Toggle3 = MainTab:CreateToggle({
   Name = "Gom Quái (Bring Mob)",
   CurrentValue = false,
   Flag = "BringMob", 
   Callback = function(Value)
      _G.BringMob = Value
   end,
})