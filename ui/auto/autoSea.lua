getgenv().AutoSea = false

while task.wait(0.5) do
    if getgenv().AutoSea then
        print("Auto Sea running...")
        -- your sea logic here
    end
end
