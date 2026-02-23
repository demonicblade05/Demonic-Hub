-- Demonic Hub Loader

local url = "https://raw.githubusercontent.com/demonicblade04/Demonic-Hub/main/main.lua"

local success, response = pcall(function()
    return game:HttpGet(url)
end)

if success then
    loadstring(response)()
else
    warn("Demonic Hub failed to load:", response)
end
