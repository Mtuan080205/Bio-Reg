local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Mtuan Hub",
    LoadingTitle = "Đang tải...",
    LoadingSubtitle = "by Mtuan",
    ConfigurationSaving = { Enabled = true, FolderName = "Mtuan Hub", FileName = "Config" }
})

local MainTab = Window:CreateTab("🏠 Main", 4483362458)

MainTab:CreateSection("Auto Farm")

MainTab:CreateToggle({
    Name = "Auto Farm Level (Basic)",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoFarm = Value
        if Value then
            task.spawn(function()
                while getgenv().AutoFarm do
                    task.wait(0.5)
                    -- Logic farm cơ bản (có thể không hoàn hảo 100%)
                    local mobs = workspace.Enemies:GetChildren()
                    for _, mob in pairs(mobs) do
                        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                            local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if root then
                                root.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                                -- Attack (cách đơn giản)
                                local args = { [1] = mob }
                                -- Thay bằng remote thật nếu bạn biết
                            end
                            break
                        end
                    end
                end
            end)
        end
    end,
})

MainTab:CreateToggle({
    Name = "Auto Kill Aura",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().KillAura = Value
        print("Kill Aura:", Value and "BẬT" or "TẮT")
        -- Kill Aura thường cần remote phức tạp hơn
    end,
})

MainTab:CreateButton({
    Name = "Server Hop (Hoạt động)",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end,
})

-- Fruit Tab
local FruitTab = Window:CreateTab("🍎 Fruit", 6023426915)
FruitTab:CreateToggle({
    Name = "Auto Eat Fruit (Basic)",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Eat Fruit:", Value)
        -- Code ăn fruit cần kiểm tra backpack
    end,
})

-- Misc Tab
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)

MiscTab:CreateToggle({
    Name = "FPS Boost",
    CurrentValue = false,
    Callback = function(Value)
        setfpscap(Value and 60 or 999)
        print("FPS Boost:", Value and "60 FPS" or "Unlimited")
    end,
})

MiscTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = true,
    Callback = function(Value)
        if Value then
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end
    end,
})

Rayfield:Notify({Title = "✅ Menu Loaded!", Content = "Một số chức năng cơ bản đã hoạt động. Farm Level và Kill Aura chỉ là bản basic.", Duration = 8})