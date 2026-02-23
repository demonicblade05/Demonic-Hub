-- Load modules
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/Demonicblade04/Demonic-Hub/main/ui/window.lua"))()
local Tab = loadstring(game:HttpGet("https://raw.githubusercontent.com/Demonicblade04/Demonic-Hub/main/ui/tab.lua"))()
local Button = loadstring(game:HttpGet("https://raw.githubusercontent.com/Demonicblade04/Demonic-Hub/main/ui/button.lua"))()
local Toggle = loadstring(game:HttpGet("https://raw.githubusercontent.com/Demonicblade04/Demonic-Hub/main/ui/toggle.lua"))()
local Slider = loadstring(game:HttpGet("https://raw.githubusercontent.com/Demonicblade04/Demonic-Hub/main/ui/slider.lua"))()
local Dropdown = loadstring(game:HttpGet("https://raw.githubusercontent.com/Demonicblade04/Demonic-Hub/main/ui/dropdown.lua"))()
local Theme = loadstring(game:HttpGet("https://raw.githubusercontent.com/Demonicblade04/YDemonic-Hub/main/ui/theme.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/demonicblade05/Demonic-Hub/main/ui/esp.lua"))()

-- Create window
local win = Window.new("Demonic Hub")

-- Create tabs
local mainTab = Tab.new(win, "Main")
local settingsTab = Tab.new(win, "Settings")

-- Add UI elements to Main tab
Button.new(mainTab, "Test Button", function()
    print("Button clicked!")
end)

Toggle.new(mainTab, "Enable Feature", false, function(state)
    print("Toggle state:", state)
end)

Toggle.new(mainTab, "NPC ESP", false, function(state)
    ESP.Enabled.NPC = state
end)

Toggle.new(mainTab, "Player ESP", false, function(state)
    ESP.Enabled.Player = state
end)

Toggle.new(mainTab, "Boss ESP", false, function(state)
    ESP.Enabled.Boss = state
end)

Toggle.new(mainTab, "Fruit ESP", false, function(state)
    ESP.Enabled.Fruit = state
end)

Toggle.new(mainTab, "Chest ESP", false, function(state)
    ESP.Enabled.Chest = state
end)

Slider.new(mainTab, "Speed", 1, 100, 50, function(value)
    print("Slider value:", value)
end)

Dropdown.new(mainTab, "Mode", {"Easy", "Normal", "Hard"}, function(option)
    print("Selected:", option)
end)

-- Add UI elements to Settings tab
Button.new(settingsTab, "Reset Settings", function()
    print("Settings reset!")
end)
