getgenv().AutoChest = false

while task.wait(0.5) do
    if getgenv().AutoChest then
        print("Auto Chest running...")
        -- your chest logic here
    end
end
