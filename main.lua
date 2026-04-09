getgenv().SilentAim = true
getgenv().ShowTracers = true

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Architect Suite | V42 Pure",
   LoadingTitle = "Numbers Only Edition",
   ConfigurationSaving = {Enabled = false}
})

local Main = Window:CreateTab("Control Center")
local Combat = Window:CreateTab("Combat Pro")

-- // وظيفة الفرز لضمان وضع الرقم فوق والاسم تحت
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

-- // --- [ إحصائياتك أنت ] ---
Main:CreateSection("My Profile")

Main:CreateInput({
   Name = "Set My Name",
   PlaceholderText = "Type Name...",
   Callback = function(t)
       local labels = GetSortedLabels(game.Players.LocalPlayer.Character)
       if #labels >= 2 then labels[2].Text = t elseif #labels == 1 then labels[1].Text = t end
   end,
})

Main:CreateInput({
   Name = "Set My Level (Numbers Only)",
   PlaceholderText = "e.g. 66",
   Callback = function(l)
       local labels = GetSortedLabels(game.Players.LocalPlayer.Character)
       -- استخراج الأرقام فقط وحذف أي حرف (مثل Lv)
       local numOnly = l:gsub("%D", "") 
       if #labels >= 1 then labels[1].Text = numOnly end
   end,
})

-- // --- [ إحصائيات الضحية - بدون حروف ] ---
Main:CreateSection("Target Player (Troll)")

local TargetOther = ""
Main:CreateInput({
   Name = "1. Who is the target?",
   PlaceholderText = "Search player...",
   Callback = function(t) TargetOther = t:lower() end,
})

Main:CreateInput({
   Name = "2. Change HIS Name",
   PlaceholderText = "New fake name...",
   Callback = function(n)
       for _, p in pairs(game.Players:GetPlayers()) do
           if p.Name:lower():find(TargetOther) and p.Character then
               local labels = GetSortedLabels(p.Character)
               if #labels >= 2 then labels[2].Text = n end
           end
       end
   end,
})

Main:CreateInput({
   Name = "3. Change HIS Level (Numbers Only)",
   PlaceholderText = "e.g. 1",
   Callback = function(l)
       local numOnly = l:gsub("%D", "")
       for _, p in pairs(game.Players:GetPlayers()) do
           if p.Name:lower():find(TargetOther) and p.Character then
               local labels = GetSortedLabels(p.Character)
               if #labels >= 1 then labels[1].Text = numOnly end
           end
       end
   end,
})

-- // --- [ Combat ] ---
Combat:CreateToggle({
   Name = "Silent Aim",
   CurrentValue = true,
   Callback = function(v) getgenv().SilentAim = v end,
})

Combat:CreateToggle({
   Name = "Red Tracers",
   CurrentValue = true,
   Callback = function(v) getgenv().ShowTracers = v end,
})
