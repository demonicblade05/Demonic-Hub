getgenv().AutoFruit = false

while task.wait(0.5) do
    if getgenv().AutoFruit then
        print("Auto Fruit running...")
        -- your fruit logic here
    end
end
