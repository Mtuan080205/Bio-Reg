--[[
    Zrxx Hub - Blox Fruits Menu UI
    Tích hợp các hàm logic từ file nguồn hdanhhub sang cấu trúc Fluent UI mới.
--]]

-- ==========================================
-- INITIALIZATION & INJECT CHECK
-- ==========================================
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Addons/InterfaceManager.lua"))()

-- Window configuration
local Window = Fluent:CreateWindow({
    Title = "Zrxx Hub",
    SubTitle = "Blox Fruits Premium",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- ==========================================
-- GLOBAL VARIABLES & VARIABLES FROM SOURCE
-- ==========================================
_G.AutoFarmLevel = false
_G.FastAttack = false
_G.BringMob = false
_G.SelectWeapon = "Melee"

local Ms = ""
local NameQuest = ""
local QuestLv = 0
local NameMon = ""
local CFrameQ = CFrame.new(0,0,0)
local CFrameMon = CFrame.new(0,0,0)
local MonFarm = ""
local FarmPos = CFrame.new(0,0,0)
local bringmob = false

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- ==========================================
-- LOGIC FUNCTIONS (FROM SOURCE)
-- ==========================================

-- 1. Check Level & Quest Function
function CheckLevel()
    local v7 = Player.Data.Level.Value
    -- Giả lập logic cấu trúc Sea 1 từ file nguồn để nhận diện quái và nhiệm vụ
    if v7 >= 1 and v7 <= 9 then
        Ms = "Bandit"
        NameQuest = "BanditQuest1"
        QuestLv = 1
        NameMon = "Bandit"
        CFrameQ = CFrame.new(1060.938, 16.455, 1547.784)
        CFrameMon = CFrame.new(1038.553, 41.296, 1576.510)
    elseif v7 >= 10 and v7 <= 14 then
        Ms = "Monkey"
        NameQuest = "JungleQuest"
        QuestLv = 1
        NameMon = "Monkey"
        CFrameQ = CFrame.new(-1601.655, 36.852, 153.388)
        CFrameMon = CFrame.new(-1448.144, 50.852, 63.607)
    else
        -- Mặc định nếu vượt quá cấp độ demo trong file
        Ms = "Bandit"
        NameQuest = "BanditQuest1"
        QuestLv = 1
        NameMon = "Bandit"
        CFrameQ = CFrame.new(1060.938, 16.455, 1547.784)
        CFrameMon = CFrame.new(1038.553, 41.296, 1576.510)
    end
end

-- 2. Equip Weapon Function
function EquipTool(weaponType)
    local backpack = Player.Backpack
    local character = Player.Character
    if character then
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                -- Phân loại Tool theo thuộc tính hoặc tên từ danh sách chọn
                if weaponType == "Melee" and (tool.ToolTip == "Melee" or tool:FindFirstChild("Combat")) then
                    tool.Parent = character
                elseif weaponType == "Sword" and (tool.ToolTip == "Sword") then
                    tool.Parent = character
                elseif weaponType == "Fruit" and (tool.ToolTip == "Blox Fruit") then
                    tool.Parent = character
                end
            end
        end
    end
end

-- 3. Attack No Cool Down (Fast Attack Fake-Logic)
function AttackNoCoolDown()
    pcall(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(850, 520))
    end)
end

-- ==========================================
-- THREADS / BACKGROUND LOOPS
-- ==========================================

-- Loop Farm & Fast Attack
spawn(function()
    while true do
        task.wait()
        if _G.AutoFarmLevel then
            pcall(function()
                CheckLevel()
                -- Tìm quái vật trong Workspace mục Enemies
                local enemies = game.Workspace:FindFirstChild("Enemies")
                local targetMob = nil
                
                if enemies then
                    for _, v in pairs(enemies:GetChildren()) do
                        if v.Name == NameMon and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            targetMob = v
                            break
                        end
                    end
                end
                
                if targetMob then
                    repeat
                        task.wait()
                        if not _G.AutoFarmLevel then break end
                        
                        -- Set dữ liệu vị trí cho Bring Mob hoạt động
                        FarmPos = targetMob.HumanoidRootPart.CFrame
                        MonFarm = targetMob.Name
                        bringmob = true
                        
                        -- Tự động trang bị vũ khí đã chọn trong UI
                        EquipTool(_G.SelectWeapon)
                        
                        -- Di chuyển người chơi đến quái (Tween hoặc thay đổi CFrame khoảng cách an toàn)
                        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                            Player.Character.HumanoidRootPart.CFrame = targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                        end
                        
                        -- Kích hoạt Fast Attack nếu được bật
                        if _G.FastAttack then
                            AttackNoCoolDown()
                        end
                    until not _G.AutoFarmLevel or not targetMob.Parent or targetMob.Humanoid.Health <= 0
                    bringmob = false
                else
                    -- Nếu không tìm thấy quái, di chuyển tới điểm quái hồi sinh hoặc NPC nhận Quest
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        Player.Character.HumanoidRootPart.CFrame = CFrameMon
                    end
                end
            end)
        end
    end
end)

-- Loop Bring Mob
spawn(function()
    while true do
        task.wait()
        if _G.BringMob and bringmob then
            pcall(function()
                local enemies = game.Workspace:FindFirstChild("Enemies")
                if enemies then
                    for _, v302 in pairs(enemies:GetChildren()) do
                        if v302.Name == MonFarm and v302:FindFirstChild("Humanoid") and v302.Humanoid.Health > 0 and v302:FindFirstChild("HumanoidRootPart") then
                            if (v302.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= 500 then
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
-- UI ELEMENTS INTERACTION
-- ==========================================

-- Dropdown Chọn Vũ Khí
local WeaponDropdown = Tabs.Main:AddDropdown("WeaponSelect", {
    Title = "Select Weapon",
    Values = {"Melee", "Sword", "Fruit"},
    CurrentValue = "Melee",
    Callback = function(Value)
        _G.SelectWeapon = Value
    end
})

-- Toggle Auto Farm Level
local FarmToggle = Tabs.Main:AddToggle("AutoFarm", {
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmLevel = Value
    end
})

-- Toggle Fast Attack
local FastAttackToggle = Tabs.Main:AddToggle("FastAttack", {
    Title = "Fast Attack",
    Default = false,
    Callback = function(Value)
        _G.FastAttack = Value
    end
})

-- Toggle Bring Mob
local BringMobToggle = Tabs.Main:AddToggle("BringMob", {
    Title = "Bring Mob",
    Default = false,
    Callback = function(Value)
        _G.BringMob = Value
    end
})

-- Khởi tạo thông báo thành công
Fluent:Notify({
    Title = "Zrxx Hub",
    Content = "Menu loaded successfully!",
    Duration = 5
})

Window:SelectTab(1)
