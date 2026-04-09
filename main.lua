getgenv().SilentAim = true
getgenv().ShowTracers = true

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Architect Suite | V45 Cash",
   LoadingTitle = "Custom Money Edition",
   ConfigurationSaving = {Enabled = false}
})

local Main = Window:CreateTab("Control Center")
local Combat = Window:CreateTab("Combat Pro")

-- // وظيفة ترتيب النصوص فوق الرأس
local function GetSortedLabels(char)
    local labels = {}
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("TextLabel") and v.Visible then table.insert(labels, v) end
        end
        table.sort(labels, function(a, b) return a.AbsolutePosition.Y < b.AbsolutePosition.Y end)
    end
    return labels
end

-- // --- [ القسم الجديد: التحكم بالفلوس ] ---
Main:CreateSection("Custom Fake Cash")

Main:CreateInput({
   Name = "Enter Custom Cash Amount",
   PlaceholderText = "Type any number (e.g. 500000)",
   Callback = function(val)
       -- السكربت يمر على كل واجهات المستخدم ويغير أي نص فيه علامة $
       local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
       for _, v in pairs(playerGui:GetDescendants()) do
           if v:IsA("TextLabel") then
               -- يبحث عن النصوص اللي فيها علامة $ أو مرتبطة بالفلوس
               if v.Text:find("%$") or v.Name:lower():find("money") or v.Name:lower():find("cash") then
                   v.Text = "$" .. val
               end
           end
       end
   end,
})

-- // --- [ إحصائياتك الشخصية ] ---
Main:CreateSection("My Profile Settings")

Main:CreateInput({
   Name = "My Fake Name",
   PlaceholderText = "New Name...",
   Callback = function(t)
       local labels = GetSortedLabels(game.Players.LocalPlayer.Character)
       if #labels >= 2 then labels[2].Text = t elseif #labels == 1 then labels[1].Text = t end
   end,
})

Main:CreateInput({
   Name = "My Fake Level",
   PlaceholderText = "New Level...",
   Callback = function(l)
       local labels = GetSortedLabels(game.Players.LocalPlayer.Character)
       local numOnly = l:gsub("%D", "")
       if #labels >= 1 then labels[1].Text = numOnly end
   end,
})

-- // --- [ التحكم بالآخرين ] ---
Main:CreateSection("Target Player (Troll)")

local TargetOther = ""
Main:CreateInput({
   Name = "Target Player Name",
   PlaceholderText = "Search...",
   Callback = function(t) TargetOther = t:lower() end,
})

Main:CreateInput({
   Name = "Change HIS Name",
   Callback = function(n)
       for _, p in pairs(game.Players:GetPlayers()) do
           if p.Name:lower():find(TargetOther) and p.Character then
               local labels = GetSortedLabels(p.Character)
               if #labels >= 2 then labels[2].Text = n end
           end
       end
   end,
})

-- // --- [ Combat ] ---
Combat:CreateToggle({Name = "Silent Aim", CurrentValue = true, Callback = function(v) getgenv().SilentAim = v end})
Combat:CreateToggle({Name = "Red Tracers", CurrentValue = true, Callback = function(v) getgenv().ShowTracers = v end})
