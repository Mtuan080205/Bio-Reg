-- ==========================================
-- CẤU HÌNH BAN ĐẦU & TẢI THƯ VIỆN RAYFIELD (IMGUI STYLE)
-- ==========================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

Settings = Settings or {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

local Plr = Players.LocalPlayer
local PlaceId = game.PlaceId
local JobId = game.JobId

-- Đổi thương hiệu Translator từ Redz sang Mtuan theo yêu cầu
if Settings.Translator == true then
    pcall(function()
        _G.MtuanTranslator = HttpService:JSONDecode(game:HttpGet("https://raw.githubusercontent.com/PlockScripts/newredz/refs/heads/main/NewTranslator/NewBloxFruits/NewPortuguese.json"))
    end)
end

local function JoinTeam()
    local targetTeam = "Marines"
    if Settings.JoinTeam == "Pirates" then
        targetTeam = "Pirates"
    end

    if not Plr.Team or (Plr.Team.Name ~= "Marines" and Plr.Team.Name ~= "Pirates") then
        pcall(function()
            ReplicatedStorage
                :WaitForChild("Remotes")
                :WaitForChild("CommF_")
                :InvokeServer("SetTeam", targetTeam)
        end)
    end
end

JoinTeam()

hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death), function()
    -- empty block
end)
hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Respawn), function()
    -- empty block
end)

if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
    World1 = true
elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then
    World2 = true
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
    World3 = true
end

-- ==========================================
-- GIỮ NGUYÊN TOÀN BỘ LOGIC HÀM & CHỨC NĂNG CŨ (100% KHÔNG ĐỔI)
-- ==========================================
function MaterialMon()
    if _G.SelectMaterial ~= "Radiactive Material" then
        if _G.SelectMaterial ~= "Leather + Scrap Metal" then
            if _G.SelectMaterial ~= "Magma Ore" then
                if _G.SelectMaterial ~= "Fish Tail" then
                    if _G.SelectMaterial == "Angel Wings" then
                        MMon = "Royal Soldier"
                        MPos = CFrame.new(-7759.45898, 5606.93652, -1862.70276, -0.866007447, 0, -0.500031412, 0, 1, 0, 0.500031412, 0, -0.866007447)
                        SP = "SkyArea2"
                    elseif _G.SelectMaterial == "Mystic Droplet" then
                        MMon = "Water Fighter"
                        MPos = CFrame.new(-3331.70459, 239.138336, -10553.3564, -0.29242146, 0, 0.95628953, 0, 1, 0, -0.95628953, 0, -0.29242146)
                        SP = "ForgottenIsland"
                    elseif _G.SelectMaterial == "Vampire Fang" then
                        MMon = "Vampire"
                        MPos = CFrame.new(-6132.39453, 9.00769424, -1466.16919, -0.927179813, 0, -0.374617696, 0, 1, 0, 0.374617696, 0, -0.927179813)
                        SP = "Graveyard"
                    elseif _G.SelectMaterial == "Gunpowder" then
                        MMon = "Pistol Billionaire"
                        MPos = CFrame.new(-185.693283, 84.7088699, 6103.62744, 0.90629667, 0, -0.422642082, 0, 1, 0, 0.422642082, 0, 0.90629667)
                        SP = "Mansion"
                    elseif _G.SelectMaterial ~= "Mini Tusk" then
                        if _G.SelectMaterial == "Conjured Cocoa" then
                            MMon = "Chocolate Bar Battler"
                            MPos = CFrame.new(582.828674, 25.5824986, -12550.7041, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
                            SP = "Chocolate"
                        end
                    else
                        MMon = "Mythological Pirate"
                        MPos = CFrame.new(-13456.0498, 469.433228, -7039.96436, 0, 0, 1, 0, 1, 0, -1, 0, 0)
                        SP = "BigMansion"
                    end
                elseif game.PlaceId == 2753915549 then
                    MMon = "Fishman Warrior"
                    MPos = CFrame.new(60943.9023, 17.9492188, 1744.11133, 0.826706648, 0, -0.562633216, 0, 1, 0, 0.562633216, 0, 0.826706648)
                    SP = "Underwater City"
                    MMon = "Fishman Commando"
                    MPos = CFrame.new(61760.8984, 18.0800781, 1460.11133, -0.632549644, 0, -0.774520278, 0, 1, 0, 0.774520278, 0, -0.632549644)
                    SP = "Underwater City"
                elseif game.PlaceId == 7449423635 then
                    MMon = "Fishman Captain"
                    MPos = CFrame.new(-10828.1064, 331.825989, -9049.14648, -0.0912091732, 0, 0.995831788, 0, 1, 0, -0.995831788, 0, -0.0912091732)
                    SP = "PineappleTown"
                end
            elseif game.PlaceId == 2753915549 then
                MMon = "Military Soldier"
                MPos = CFrame.new(-5565.60156, 9.10001755, 8327.56934, -0.838688731, 0, -0.544611216, 0, 1, 0, 0.544611216, 0, -0.838688731)
                SP = "Magma"
                MMon = "Military Spy"
                MPos = CFrame.new(-5806.70068, 78.5000458, 8904.46973, 0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, 0.707134247)
                SP = "Magma"
            elseif game.PlaceId == 4442272183 then
                MMon = "Lava Pirate"
                MPos = CFrame.new(-5158.77051, 14.4791956, -4654.2627, -0.848060489, 0, -0.529899538, 0, 1, 0, 0.529899538, 0, -0.848060489)
                SP = "CircleIslandFire"
            end
        elseif game.PlaceId == 2753915549 then
            MMon = "Pirate"
            MPos = CFrame.new(-967.433105, 13.5999937, 4034.24707, -0.258864403, 0, -0.965913713, 0, 1, 0, 0.965913713, 0, -0.258864403)
            SP = "Pirate"
            MMon = "Brute"
            MPos = CFrame.new(-1191.41235, 15.5999985, 4235.50928, 0.629286051, 0, -0.777173758, 0, 1, 0, 0.777173758, 0, 0.629286051)
            SP = "Pirate"
        elseif game.PlaceId ~= 4442272183 then
            if game.PlaceId == 7449423635 then
                MMon = "Pirate Millionaire"
                MPos = CFrame.new(-118.809372, 55.4874573, 5649.17041, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
                SP = "Default"
            end
        else
            MMon = "Mercenary"
            MPos = CFrame.new(-986.774475, 72.8755951, 1088.44653, -0.656062722, 0, 0.754706323, 0, 1, 0, -0.754706323, 0, -0.656062722)
            SP = "DressTown"
        end
    else
        MMon = "Factory Staff"
        MPos = CFrame.new(-105.889565, 72.8076935, -670.247986, -0.965929747, 0, -0.258804798, 0, 1, 0, 0.258804798, 0, -0.965929747)
        SP = "Bar"
    end
end

-- [Đoạn mã CheckQuest phân vùng quái Blox Fruits giữ nguyên 100% từ file gốc]
function CheckQuest()
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    if World1 then
        if MyLevel >= 1 and MyLevel <= 9 or SelectMonster == "Bandit" then
            Mon = "Bandit" LevelQuest = 1 NameQuest = "BanditQuest1" NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231)
            CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
        elseif MyLevel >= 60 and MyLevel <= 74 or SelectMonster == "Desert Bandit" then
            Mon = "Desert Bandit" LevelQuest = 1 NameQuest = "DesertQuest" NameMon = "Desert Bandit"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
        elseif MyLevel >= 100 and MyLevel <= 119 or SelectMonster == "Snowman" then
            Mon = "Snowman" LevelQuest = 2 NameQuest = "SnowQuest" NameMon = "Snowman"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
        elseif MyLevel >= 190 and MyLevel <= 209 or SelectMonster == "Prisoner" then
            Mon = "Prisoner" LevelQuest = 1 NameQuest = "PrisonerQuest" NameMon = "Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
            CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
        elseif MyLevel >= 250 and MyLevel <= 274 or SelectMonster == "Toga Warrior" then
            Mon = "Toga Warrior" LevelQuest = 1 NameQuest = "ColosseumQuest" NameMon = "Toga Warrior"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
        elseif MyLevel >= 450 and MyLevel <= 474 or SelectMonster == "God's Guard" then
            Mon = "God's Guard" LevelQuest = 1 NameQuest = "SkyExp1Quest" NameMon = "God's Guard"
            CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643)
            CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688))
            end
        elseif MyLevel >= 475 and MyLevel <= 524 or SelectMonster == "Shanda" then
            Mon = "Shanda" LevelQuest = 2 NameQuest = "SkyExp1Quest" NameMon = "Shanda"
            CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196)
            CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
            if _G.AutoFarm and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
        elseif MyLevel >= 525 and MyLevel <= 549 or SelectMonster == "Royal Squad" then
            Mon = "Royal Squad" LevelQuest = 1 NameQuest = "SkyExp2Quest" NameMon = "Royal Squad"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
        elseif MyLevel >= 625 and MyLevel <= 649 or SelectMonster == "Galley Pirate" then
            Mon = "Galley Pirate" LevelQuest = 1 NameQuest = "FountainQuest" NameMon = "Galley Pirate"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293)
            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
        elseif MyLevel >= 650 or SelectMonster == "Galley Captain" then
            Mon = "Galley Captain" LevelQuest = 2 NameQuest = "FountainQuest" NameMon = "Galley Captain"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293)
            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
        else
            Mon = "Royal Soldier" LevelQuest = 2 NameQuest = "SkyExp2Quest" NameMon = "Royal Soldier"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
        end
    end
end

local function v70(v69) return math.floor(tonumber(v69) + 0.5) end 
Number = math.random(1, 1000000)
local ESPConnections = {}

-- Chams & ESP Logic Hệ thống giữ nguyên hoàn toàn
function UpdatePlayerChams()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Plr then
            pcall(function()
                local char = player.Character if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                if not hrp or not hum then return end
                if not ESPPlayer then
                    if hrp:FindFirstChild("PlayerESP") then hrp.PlayerESP:Destroy() end
                    if ESPConnections[player] then ESPConnections[player]:Disconnect() ESPConnections[player] = nil end
                    return
                end
                if hrp:FindFirstChild("PlayerESP") then return end
                local gui = Instance.new("BillboardGui")
                gui.Name = "PlayerESP" gui.Adornee = hrp gui.Size = UDim2.new(0, 200, 0, 50)
                gui.StudsOffset = Vector3.new(0, 2.5, 0) gui.AlwaysOnTop = true gui.Parent = hrp
                local nameLabel = Instance.new("TextLabel")
                nameLabel.BackgroundTransparency = 1 nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                nameLabel.TextStrokeTransparency = 0 nameLabel.TextScaled = true nameLabel.Font = Enum.Font.SourceSans
                nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255) nameLabel.Text = player.Name nameLabel.Parent = gui
            end)
        end
    end
end

function TPP(v436)
    if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") then
        local v437 = game:service("TweenService")
        local v438 = TweenInfo.new((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v436.Position).Magnitude / 325, Enum.EasingStyle.Linear)
        tween = v437:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, v438, {CFrame = v436})
        tween:Play()
        return {Stop = function(_) tween:Cancel() end}
    else
        tween:Cancel()
        repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
        wait(7)
        return
    end
end

function StopTween(v440)
    if not v440 then 
        _G.StopTween = true wait() 
        topos(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame) wait() 
        if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then 
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy() 
        end 
        _G.StopTween = false _G.Clip = false 
    end
end

function GetNewServer()
    local Servers = {}
    local req = game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
    local data = HttpService:JSONDecode(req)
    for _, server in pairs(data.data) do
        if server.playing < server.maxPlayers and server.id ~= JobId then
            table.insert(Servers, server.id)
        end
    end
    if #Servers > 0 then return Servers[math.random(1, #Servers)] end
end

-- ==========================================
-- VÒNG LẶP HỆ THỐNG FAST ATTACK GỐC
-- ==========================================
spawn(function()
    pcall(function()
        while wait() do
            for _, v442 in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if v442:IsA("Tool") and v442:FindFirstChild("RemoteFunctionShoot") then 
                    _G.SelectWeaponGun = v442.Name 
                end
            end
        end
    end)
end)

game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame) wait(1)
end)

-- Hệ thống Fast Attack Core từ file gốc
local v1 = next
local v2 = { game.ReplicatedStorage.Util, game.ReplicatedStorage.Common, game.ReplicatedStorage.Remotes, game.ReplicatedStorage.Assets, game.ReplicatedStorage.FX, }
local v3 = nil local u4 = nil local u5 = nil
while true do
    local v6 v3, v6 = v1(v2, v3) if v3 == nil then break end
    local v7 = next local v8, v9 = v6:GetChildren()
    while true do
        local v10 v9, v10 = v7(v8, v9) if v9 == nil then break end
        if v10:IsA('RemoteEvent') and v10:GetAttribute('Id') then u5 = v10:GetAttribute('Id') u4 = v10 end
    end
    v6.ChildAdded:Connect(function(p11)
        if p11:IsA('RemoteEvent') and p11:GetAttribute('Id') then u5 = p11:GetAttribute('Id') u4 = p11 end
    end)
end

task.spawn(function()
    while task.wait(0.0001) do
        if _G.AutoAttack then
            local _Character = game.Players.LocalPlayer.Character
            if _Character and _Character:FindFirstChild('HumanoidRootPart') then
                -- Vòng lặp Fast Attack ngầm xử lý tấn công liên tục nguyên bản
                pcall(function()
                    u4:FireServer(u5, "Attack")
                end)
            end
        end
    end
end)

-- ==========================================
-- KHỞI TẠO CỬA SỔ RAYFIELD (IMGUI) - REBRAND MTUAN
-- ==========================================
local Window = Rayfield:CreateWindow({
    Name = "Mtuan Hub",
    LoadingTitle = "Đang tải Chức năng...",
    LoadingSubtitle = "by Mtuan",
    ConfigurationSaving = { Enabled = true, FolderName = "Mtuan Hub", FileName = "Config" }
})

-- ==========================================
-- CHUYỂN ĐỔI GIAO DIỆN TỪ REDZLIB SANG RAYFIELD UI
-- ==========================================

-- TAB MAIN
local MainTab = Window:CreateTab("🏠 Main", 4483362458)
MainTab:CreateSection("Auto Farm Options")

MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        StopTween(_G.AutoFarm)
    end
})

MainTab:CreateToggle({
    Name = "Anti-reset",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoRejoin30m = Value
        if Value and not RejoinRunning then
            RejoinRunning = true
            task.spawn(function()
                while _G.AutoRejoin30m do
                    task.wait(1800) -- 30 phút
                    if not _G.AutoRejoin30m then break end
                    local NewServer = GetNewServer()
                    if NewServer then
                        TeleportService:TeleportToPlaceInstance(PlaceId, NewServer, Plr)
                    else
                        TeleportService:Teleport(PlaceId, Plr)
                    end
                end
                RejoinRunning = false
            end)
        end
    end
})

-- TAB BOSSES
local BossTab = Window:CreateTab("⚔️ Bosses", 4483362458)
BossTab:CreateSection("Farm Boss")

BossTab:CreateToggle({
    Name = "Auto Farm Boss",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoBoss = Value
        StopTween(_G.AutoBoss)
    end
})

-- Vòng lặp Boss chạy ngầm
task.spawn(function()
    while task.wait() do
        if _G.AutoBoss and _G.SelectBoss then
            pcall(function()
                if not game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                    if game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) then
                        topos(game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
                    end
                end
            end)
        end
    end
end)

-- TAB SWORDS
local SwordTab = Window:CreateTab("🗡️ Swords", 4483362458)
SwordTab:CreateSection("Quest Sword")

SwordTab:CreateToggle({
    Name = "Auto Get Saber",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoSaber = Value
        StopTween(_G.AutoSaber)
    end
})

-- TAB RAIDS
local RaidTab = Window:CreateTab("🌋 Raids", 4483362458)
if not World2 then
    RaidTab:CreateSection("Raid Law Only Sea 2 (Bạn chưa ở Sea 2)")
else
    RaidTab:CreateSection("Raid Law Sea 2")
    RaidTab:CreateButton({
        Name = "Auto Buy Chip Law",
        Callback = function()
            local v1069 = {[1] = "BlackbeardReward", [2] = "Microchip", [3] = "2"}
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1069))
        end
    })
    RaidTab:CreateButton({
        Name = "Auto Start Raid Law",
        Callback = function()
            fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
        end
    })
end

-- TAB AIMBOT
local AimbotTab = Window:CreateTab("🎯 Aimbot", 4483362458)
AimbotTab:CreateSection("Skill Aimbot Config")

local AimbotModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/PlockScripts/Aimbot-skill-config/refs/heads/main/Aimbot.lua"))()
local AimbotEnabled = false local AimPlayers = false local AimMobs = false

AimbotTab:CreateToggle({
    Name = "Enable Aimbot Skill",
    CurrentValue = false,
    Callback = function(v)
        AimbotEnabled = v
        if not v then 
            AimbotModule:Pause() AimbotModule:SetPlayerSilentAim(false) AimbotModule:SetNPCSilentAim(false) 
        else 
            if AimPlayers then AimbotModule:SetPlayerSilentAim(true) end 
            if AimMobs then AimbotModule:SetNPCSilentAim(true) end 
            AimbotModule:Restore() 
        end
    end
})

AimbotTab:CreateToggle({
    Name = "Aimbot on Players",
    CurrentValue = false,
    Callback = function(v)
        AimPlayers = v
        if v then AimMobs = false AimbotModule:SetNPCSilentAim(false) end
        if AimbotEnabled then AimbotModule:SetPlayerSilentAim(v) else AimbotModule:SetPlayerSilentAim(false) end
    end
})

-- TAB TELEPORT
local TeleportTab = Window:CreateTab("🌍 Teleport", 4483362458)
TeleportTab:CreateSection("Travel Sea")

TeleportTab:CreateButton({
    Name = "Sea 1",
    Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end
})
TeleportTab:CreateButton({
    Name = "Sea 2",
    Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") end
})
TeleportTab:CreateButton({
    Name = "Sea 3",
    Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end
})

-- TAB MISC (CÀI ĐẶT CHUNG & SHOP)
local MiscTab = Window:CreateTab("⚙️ Misc & Settings", 4483362458)
MiscTab:CreateSection("Shop Items")

MiscTab:CreateButton({
    Name = "Buy Bizarre Rifle 250 Ectoplasm",
    Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1) end
})
MiscTab:CreateButton({
    Name = "Buy Black Cape $50,000",
    Callback = function() 
        local v1158 = {[1] = "BuyItem", [2] = "Black Cape"} 
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v1158)) 
    end
})

MiscTab:CreateSection("Settings & Exploits")

MiscTab:CreateToggle({
    Name = "Fast Attack",
    CurrentValue = true,
    Callback = function(value)
        _G.AutoAttack = value
    end
})

MiscTab:CreateTextBox({
    Name = "Job ID",
    PlaceholderText = "Paste Job ID here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(p215)
        if p215 ~= "" then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, p215) end
    end
})