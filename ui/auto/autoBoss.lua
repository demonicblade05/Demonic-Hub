getgenv().AutoBoss = false

while task.wait(0.5) do
    if getgenv().AutoBoss then
        print("Auto Boss running...")
        -- your boss logic here
    end
end
