local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Saleh Hub | Developer",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by Saleh",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SalehHub",
      FileName = "Config"
   },
   KeySystem = true,
   KeySettings = {
      Title = "Key System",
      Subtitle = "Key: ASd_123123",
      Note = "Enter the access key",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"ASd_123123"}
   }
})

local Tab = Window:CreateTab("Main", 4483362458)

Tab:CreateButton({
   Name = "Change My Name",
   Callback = function()
       local char = game.Players.LocalPlayer.Character
       if char then 
           for _,v in pairs(char:GetDescendants()) do 
               if v:IsA("TextLabel") and v.Visible then v.Text = "SALEH DEV" end 
           end 
       end
       Rayfield:Notify({
          Title = "Success",
          Content = "Name changed to SALEH DEV",
          Duration = 3,
          Image = 4483362458,
       })
   end,
})

Rayfield:Notify({
   Title = "Executed!",
   Content = "Enjoy the script, Saleh!",
   Duration = 5,
   Image = 4483362458,
})
