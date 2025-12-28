local function LoadLibrary()
    local GithubURL = "https://raw.githubusercontent.com/renardiusse/RenLib/main/RenLib.lua"
    
    -- Attempt 1: GitHub
    local success, result = pcall(function()
        return game:HttpGet(GithubURL)
    end)
    
    if success and type(result) == "string" and #result > 100 then
        print("Success: Loaded RenLib from GitHub.")
        local chunk, err = loadstring(result)
        if chunk then
            return chunk()
        else
            warn("GitHub Load Error (Syntax):", err)
        end
    else
        warn("GitHub Load Failed. Status:", success)
        warn("Result/Error:", result)
        warn("URL might be wrong. Falling back to local file.")
    end
    
    -- Attempt 2: Local File
    if isfile("RenLib.lua") then
        print("Fallback: Loading local RenLib.lua...")
        return loadfile("RenLib.lua")()
    elseif isfile("RobloxUILib/RenLib.lua") then
        print("Fallback: Loading local RobloxUILib/RenLib.lua...")
        return loadfile("RobloxUILib/RenLib.lua")()
    end
    
    warn("CRITICAL: RenLib not found on GitHub or locally!")
    return nil
end

local Library = LoadLibrary()
if not Library then 
    warn("Library failed to load. Script execution stopped.")
    return 
end

local Window = Library:CreateWindow({
    Name = "RenLib Hub | v2.0"
})

local MainTab = Window:CreateTab({ Name = "Main", Icon = "rbxassetid://4483345998" })
local VisualsTab = Window:CreateTab({ Name = "Visuals", Icon = "rbxassetid://4483345998" })
local SettingsTab = Window:CreateTab({ Name = "Settings", Icon = "rbxassetid://4483345998" })

--// Main Section
local Combat = MainTab:CreateSection({ Name = "Combat" })

Combat:CreateToggle({
    Name = "Silent Aim",
    Default = false,
    Callback = function(state)
        print("Silent Aim:", state)
    end
})

Combat:CreateButton({
    Name = "Kill All",
    Callback = function()
        Library:Notify({
            Title = "Combat",
            Content = "Eliminating enemies...",
            Duration = 2,
            Image = "rbxassetid://4483345998"
        })
    end
})

Combat:CreateSlider({
    Name = "FOV Radius",
    Min = 0, 
    Max = 360, 
    Default = 90,
    Callback = function(val)
        -- print("FOV:", val)
    end
})

Combat:CreateDropdown({
    Name = "Target Part",
    Values = {"Head", "Torso", "HumanoidRootPart"},
    Default = "Head",
    Callback = function(val)
        print("Target:", val)
    end
})

--// Visuals Section
local ESP = VisualsTab:CreateSection({ Name = "ESP Settings" })

ESP:CreateColorPicker({
    Name = "Enemy Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        -- print("Color:", color)
    end
})

ESP:CreateKeybind({
    Name = "Toggle Menu",
    Default = Enum.KeyCode.RightShift,
    Mode = "Toggle",
    Callback = function(state)
        print("Menu Toggled:", state)
    end
})

--// Notification Test
Library:Notify({
    Title = "RenLib",
    Content = "Library Loaded Successfully",
    Duration = 5
})
