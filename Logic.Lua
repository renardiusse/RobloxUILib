local function LoadLibrary()
    -- Configuration: Update this URL to point to your raw GitHub file
    local GithubURL = "https://raw.githubusercontent.com/renardiusse/RenLib/main/RenLib.lua"

    local success, result = pcall(function()
        return game:HttpGet(GithubURL)
    end)
    
    if not success then
        warn("CRITICAL: Failed to fetch library from GitHub.")
        warn("Error:", result)
        warn("URL:", GithubURL)
        return nil
    end

    if type(result) ~= "string" then
        warn("CRITICAL: GitHub response is not a string.")
        warn("Type received:", type(result))
        warn("Value:", tostring(result))
        return nil
    end
    
    if #result < 100 then
        warn("WARNING: Fetched file seems too short (" .. #result .. " bytes). Check the URL.")
        print("First 50 chars:", result:sub(1, 50))
    end

    local chunk, syntaxErr = loadstring(result)
    if not chunk then
        warn("CRITICAL: Syntax Error in Library!")
        warn(syntaxErr)
        return nil
    end
    
    local runSuccess, libOrErr = pcall(chunk)
    if not runSuccess then
        warn("CRITICAL: Library Runtime Error!")
        warn(libOrErr)
        return nil
    end

    return libOrErr
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
