getgenv().AutoQuest = false

while task.wait(0.5) do
    if getgenv().AutoQuest then
        print("Auto Quest running...")
        -- your quest logic here
    end
end
