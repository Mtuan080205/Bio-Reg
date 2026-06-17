-- =============================================
-- MENU TÊN BẠN - BLOX FRUITS (Rayfield UI)
-- =============================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Mtuan Hub",
    LoadingTitle = "Đang tải menu...",
    LoadingSubtitle = "by Mtuan",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Mtuan Hub",
        FileName = "Config"
    }
})

-- ================== TAB MAIN ==================
local MainTab = Window:CreateTab("🏠 Main", 4483362458)

MainTab:CreateSection("Auto Farm")

local AutoFarmToggle = MainTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Farm Level:", Value)
        -- Code farm level sẽ thêm sau nếu bạn cần
    end,
})

MainTab:CreateToggle({
    Name = "Auto Farm Mastery",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Farm Mastery:", Value)
    end,
})

MainTab:CreateToggle({
    Name = "Auto Kill Aura",
    CurrentValue = false,
    Callback = function(Value)
        print("Kill Aura:", Value)
    end,
})

MainTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end,
})

-- ================== TAB FRUIT ==================
local FruitTab = Window:CreateTab("🍎 Fruit", 6023426915)

FruitTab:CreateToggle({
    Name = "Auto Eat Fruit",
    CurrentValue = false,
    Callback = function(Value) end,
})

FruitTab:CreateToggle({
    Name = "Fruit Sniper (Teleport)",
    CurrentValue = false,
    Callback = function(Value) end,
})

FruitTab:CreateButton({
    Name = "Store All Fruit",
    Callback = function()
        print("Đã cất fruit!")
    end,
})

-- ================== TAB RAID & EVENT ==================
local RaidTab = Window:CreateTab("⚔️ Raid & Event", 6031094678)

RaidTab:CreateToggle({
    Name = "Auto Raid",
    CurrentValue = false,
    Callback = function(Value) end,
})

RaidTab:CreateToggle({
    Name = "Auto Sea Event",
    CurrentValue = false,
    Callback = function(Value) end,
})

RaidTab:CreateToggle({
    Name = "Auto Trial (V4)",
    CurrentValue = false,
    Callback = function(Value) end,
})

-- ================== TAB MISC ==================
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

MiscTab:CreateToggle({
    Name = "FPS Boost",
    CurrentValue = false,
    Callback = function(Value)
        setfpscap(Value and 60 or 999)
    end,
})

MiscTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = true,
    Callback = function(Value)
        print("Anti AFK:", Value)
    end,
})

MiscTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end,
})

-- Thông báo khi load xong
Rayfield:Notify({
    Title = "✅ Menu Loaded Thành Công!",
    Content = "Chúc bạn farm vui vẻ! Menu tên: TÊN BẠN Hub",
    Duration = 6,
    Image = 4483362458,
})

print("Menu TÊN BẠN Hub đã load!")