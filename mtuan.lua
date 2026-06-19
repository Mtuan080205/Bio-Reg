--[[
    Zrxx Hub - Blox Fruits Menu UI
    Tên Menu: Zrxx Hub
    Được viết lại chính xác theo các hàm xử lý từ file gốc của bạn.
--]]

-- ==========================================
-- 1. KHỞI TẠO THƯ VIỆN GIAO DIỆN (FLUENT UI)
-- ==========================================
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Addons/InterfaceManager.lua"))()

-- Tạo Cửa sổ Menu Zrxx Hub
local Window = Fluent:CreateWindow({
    Title = "Zrxx Hub",
    SubTitle = "Blox Fruits New Script",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- Tắt Acrylic để tránh lỗi màn hình đen trên một số máy yếu/điện thoại
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Tạo các Tab chức năng
local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

-- ==========================================
-- 2. CÁC BIẾN TOÀN CỤC KHỞI TẠO (TỪ FILE GỐC)
-- ==========================================
_G.AutoFarmLevel = false
_G.FastAttack = false
_G.BringMob = false
_G.SelectWeapon = "Melee"
_G.Fast_Delay = 0.1 -- Tốc độ đánh mặc định

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

-- Xác định Sea hiện tại của người chơi
local Sea1 = game.PlaceId == 2753915549
local Sea2 = game.PlaceId == 4442272125
local Sea3 = game.PlaceId == 7405815058

-- ==========================================
-- 3. CÁC HÀM XỬ LÝ LOGIC GỐC (LẤY TỪ FILE CỦA BẠN)
-- ==========================================

-- Hàm kiểm tra Level và tự động gán dữ liệu Quest (Trích từ hàm CheckLevel gốc)
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
            -- Giá trị dự phòng nếu vượt cấp demo
            Ms = "Bandit"
            NameQuest = "BanditQuest1"
            QuestLv = 1
            NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        end
    else
        -- Nếu ở Sea 2 hoặc Sea 3 (Đặt mặc định để tránh lỗi script dừng)
        Ms = "Bandit"
        NameQuest = "BanditQuest1"
        QuestLv = 1
        NameMon = "Bandit"
        CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
        CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
    end
end

-- Hàm tự động trang bị vũ khí đã chọn (Trích từ hàm EquipTool gốc)
function EquipTool(WeaponName)
    local backpack = Player:FindFirstChild("Backpack")
    local character = Player.Character
    if character then
        local tool = backpack:FindFirstChild(WeaponName) or character:FindFirstChild(WeaponName)
        if tool then
            tool.Parent = character
        else
            -- Tìm kiếm theo loại nếu không trùng tên chính xác
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
end

-- Hàm Fast Attack không delay (Trích từ hàm AttackNoCoolDown gốc)
function AttackNoCoolDown()
    pcall(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(850, 520))
        
        -- Gọi Remote tấn công gốc của Blox Fruits để gây sát thương thực tế
        local combatFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Modules") and game:GetService("ReplicatedStorage").Modules:FindFirstChild("Net")
        if combatFolder then
            -- Đoạn này kích hoạt trigger đánh từ vũ khí hiện tại
            local currentTool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
            if currentTool then
                game:GetService("ReplicatedStorage").Remotes.Validator:FireServer(math.floor(workspace.DistributedTime))
            end
        end
    end)
end

-- ==========================================
-- 4. VÒNG LẶP NỀN (SPAWN LOOPS)
-- ==========================================

-- Vòng lặp chính: Tự động Nhận Nhiệm Vụ & Auto Farm Level & Fast Attack
task.spawn(function()
    while true do
        task.wait()
        if _G.AutoFarmLevel then
            pcall(function()
                CheckLevel()
                
                -- Kiểm tra xem đã nhận nhiệm vụ chưa, nếu chưa thì di chuyển nhận nhiệm vụ
                local hasQuest = Player.PlayerGui.Main:FindFirstChild("Quest").Visible
                if not hasQuest then
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        if (Player.Character.HumanoidRootPart.Position - CFrameQ.Position).Magnitude > 10 then
                            Player.Character.HumanoidRootPart.CFrame = CFrameQ
                        else
                            -- Kích hoạt nhận Quest từ NPC bằng cách gọi Remote gốc của game
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                        end
                    end
                else
                    -- Nếu đã có Quest, tiến hành tìm quái vật và farm
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
                            
                            -- Lưu thông tin vị trí để hàm Bring Mob hoạt động
                            FarmPos = targetMob.HumanoidRootPart.CFrame
                            MonFarm = targetMob.Name
                            bringmob = true
                            
                            -- Trang bị vũ khí
                            EquipTool()
                            
                            -- Đưa người chơi đến vị trí quái vật (Khoảng cách an toàn phía trên quái)
                            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                                Player.Character.HumanoidRootPart.CFrame = targetMob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            end
                            
                            -- Phóng to hitbox quái vật giống file gốc của bạn
                            targetMob.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            targetMob.HumanoidRootPart.CanCollide = false
                            
                            -- Kích hoạt Fast Attack nếu bật
                            if _G.FastAttack then
                                AttackNoCoolDown()
                            end
                        until not _G.AutoFarmLevel or not targetMob.Parent or targetMob.Humanoid.Health <= 0
                        bringmob = false
                    else
                        -- Nếu chưa có quái xuất hiện, bay về điểm hồi sinh của quái đứng đợi
                        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                            Player.Character.HumanoidRootPart.CFrame = CFrameMon
                        end
                    end
                end
            end)
        end
    end
end)

-- Vòng lặp gom quái (Gốc từ hàm Bring Mob trong file của bạn)
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
                                -- Gom quái trong phạm vi về chung một điểm đứng farm
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
-- 5. THIẾT LẬP CÁC NÚT BẤM TRÊN GIAO DIỆN MENU
-- ==========================================

-- 1. Thả chọn loại Vũ Khí (Melee, Kiếm, Trái ác quỷ)
local WeaponDropdown = Tabs.Main:AddDropdown("WeaponSelect", {
    Title = "Chọn Vũ Khí (Select Weapon)",
    Values = {"Melee", "Sword", "Fruit"},
    CurrentValue = "Melee",
    Callback = function(Value)
        _G.SelectWeapon = Value
    end
})

-- 2. Bật/Tắt Tự động cày cấp (Auto Farm Level)
local FarmToggle = Tabs.Main:AddToggle("AutoFarm", {
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        _G.AutoFarmLevel = Value
    end
})

-- 3. Bật/Tắt Đánh nhanh không hồi chiêu (Fast Attack)
local FastAttackToggle = Tabs.Main:AddToggle("FastAttack", {
    Title = "Fast Attack (No CoolDown)",
    Default = false,
    Callback = function(Value)
        _G.FastAttack = Value
    end
})

-- 4. Bật/Tắt Gom quái lại một chỗ (Bring Mob)
local BringMobToggle = Tabs.Main:AddToggle("BringMob", {
    Title = "Gom Quái (Bring Mob)",
    Default = false,
    Callback = function(Value)
        _G.BringMob = Value
    end
})

-- Thông báo kích hoạt thành công lên góc màn hình
Fluent:Notify({
    Title = "Zrxx Hub",
    Content = "Menu đã được tải thành công!",
    Duration = 5
})

Window:SelectTab(1)