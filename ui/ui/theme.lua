local Theme = {}

Theme.Colors = {
    Background = Color3.fromRGB(25, 25, 25),
    Secondary = Color3.fromRGB(35, 35, 35),
    Accent = Color3.fromRGB(0, 170, 255),
    Text = Color3.fromRGB(255, 255, 255),
    Button = Color3.fromRGB(40, 40, 40),
    ButtonHover = Color3.fromRGB(60, 60, 60)
}

function Theme.Apply(object, property, colorName)
    if Theme.Colors[colorName] then
        object[property] = Theme.Colors[colorName]
    end
end

return Theme
