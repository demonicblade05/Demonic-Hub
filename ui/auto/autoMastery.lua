getgenv().AutoMastery = false

while task.wait(0.5) do
    if getgenv().AutoMastery then
        print("Auto Mastery running...")
        -- your mastery logic here
    end
end
