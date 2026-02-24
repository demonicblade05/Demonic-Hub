getgenv().AutoNPC = false

while task.wait(0.5) do
    if getgenv().AutoNPC then
        print("Auto NPC running...")
        -- your NPC logic here
    end
end
