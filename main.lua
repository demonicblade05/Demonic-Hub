-- Demonic Hub Main Loader

local ui = {}

-- Load modules
ui.Window   = loadstring(game:HttpGet("https://raw.githubusercontent.com/demonicblade05/Demonic-Hub/main/ui/window.lua"))()
ui.Button   = loadstring(game:HttpGet("https://raw.githubusercontent.com/demonicblade05/Demonic-Hub/main/ui/button.lua"))()
ui.Toggle   = loadstring(game:HttpGet("https://raw.githubusercontent.com/demonicblade05/Demonic-Hub/main/ui/toggle.lua"))()
ui.Slider   = loadstring(game:HttpGet("https://raw.githubusercontent.com/demonicblade05/Demonic-Hub/main/ui/slider.lua"))()
ui.Dropdown = loadstring(game:HttpGet("https://raw.githubusercontent.com/demonicblade05/Demonic-Hub/main/ui/dropdown.lua"))()
ui.Loader   = loadstring(game:HttpGet("https://raw.githubusercontent.com/demonicblade05/Demonic-Hub/main/ui/loader.lua"))()

-- Create window
local window = ui.Loader:CreateWindow("Demonic Hub")

-- Example UI elements (you can remove or edit these)
ui.Button.new(window, "Test Button", function()
    print("Button clicked")
end)

ui.Toggle.new(window, "Auto Attack", false, function(state)
    getgenv().AutoAttack = state
end)

ui.Toggle.new(window, "Test Toggle", false, function(state)
    print("Toggle:", state)
end)

ui.Slider.new(window, "Test Slider", 0, 100, 50, function(value)
    print("Slider:", value)
end)

ui.Dropdown.new(window, "Test Dropdown", {"A", "B", "C"}, function(choice)
    print("Dropdown:", choice)
end)

return ui
