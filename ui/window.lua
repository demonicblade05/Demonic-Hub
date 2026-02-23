local Window = {}
Window.__index = Window

function Window.new(title)
    local self = setmetatable({}, Window)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = title
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

    self.Gui = ScreenGui
    self.Main = Main
    self.Tabs = {}

    return self
end

return Window
