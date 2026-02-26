-- =========================================================
-- CONFIGURAÇÕES DE ACESSO (O SEU PASTEBIN ATUALIZADO)
-- =========================================================
local KEYS_URL = "https://pastebin.com/raw/AaGr9vEK" 
local DISCORD_LINK = "https://discord.gg/76KnzJRkKN" 

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

-- =========================================================
-- INTERFACE DE LOGIN (PREPARANDO O ACESSO)
-- =========================================================
local LoginGui = Instance.new("ScreenGui")
LoginGui.Name = "IgniteLogin"
LoginGui.Parent = CoreGui
LoginGui.ResetOnSpawn = false

local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 320, 0, 200)
LoginFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
LoginFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
LoginFrame.BorderSizePixel = 0
LoginFrame.Parent = LoginGui
Instance.new("UICorner", LoginFrame)
local LStroke = Instance.new("UIStroke", LoginFrame)
LStroke.Color = Color3.fromRGB(140, 0, 255)
LStroke.Thickness = 2.5

local LTitle = Instance.new("TextLabel")
LTitle.Text = "IGNITE HUB | LOGIN"; LTitle.Size = UDim2.new(1, 0, 0, 50)
LTitle.TextColor3 = Color3.fromRGB(255, 255, 255); LTitle.Font = Enum.Font.GothamBold
LTitle.BackgroundTransparency = 1; LTitle.Parent = LoginFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 260, 0, 40); KeyInput.Position = UDim2.new(0.5, -130, 0.4, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 30); KeyInput.PlaceholderText = "Insira sua Key..."
KeyInput.Text = ""; KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255); KeyInput.Parent = LoginFrame
Instance.new("UICorner", KeyInput)

local InsertBtn = Instance.new("TextButton")
InsertBtn.Text = "INSERIR"; InsertBtn.Size = UDim2.new(0, 125, 0, 40); InsertBtn.Position = UDim2.new(0.5, -130, 0.7, 0)
InsertBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 255); InsertBtn.TextColor3 = Color3.fromRGB(255, 255, 255); InsertBtn.Parent = LoginFrame
Instance.new("UICorner", InsertBtn)

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Text = "OBTER KEY"; GetKeyBtn.Size = UDim2.new(0, 125, 0, 40); GetKeyBtn.Position = UDim2.new(0.5, 5, 0.7, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50); GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255); GetKeyBtn.Parent = LoginFrame
Instance.new("UICorner", GetKeyBtn)

-- Draggable Login
local dragging, dragInput, dragStart, startPos
LoginFrame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = input.Position; startPos = LoginFrame.Position end end)
UIS.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then local delta = input.Position - dragStart; LoginFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

GetKeyBtn.Activated:Connect(function() setclipboard(DISCORD_LINK) GetKeyBtn.Text = "LINK COPIADO!" task.wait(2) GetKeyBtn.Text = "OBTER KEY" end)

-- =========================================================
-- FUNÇÃO QUE LIBERA O SCRIPT ORIGINAL
-- =========================================================
local function LiberarHub()
    LoginGui:Destroy()
    
    -- [INÍCIO DO SEU SCRIPT ORIGINAL]
    local THEME_COLOR = Color3.fromRGB(140, 0, 255)
    local BG_COLOR = Color3.fromRGB(10, 10, 15)
    local ACCENT_COLOR = Color3.fromRGB(25, 25, 35)

    player:SetAttribute("IsIgniteUser", true)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "IgniteHub_v1"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 420, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
    MainFrame.BackgroundColor3 = BG_COLOR
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    local UIStroke = Instance.new("UIStroke", MainFrame)
    UIStroke.Color = THEME_COLOR
    UIStroke.Thickness = 2.5

    -- RGB Borda
    task.spawn(function()
        local colors = {Color3.fromRGB(140, 0, 255), Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 255)}
        local i = 1
        while true do
            local nextColor = colors[i % #colors + 1]
            local tween = TweenService:Create(UIStroke, TweenInfo.new(4, Enum.EasingStyle.Linear), {Color = nextColor})
            tween:Play(); tween.Completed:Wait(); i = i + 1
        end
    end)

    -- Sistema de Tags (IGT USER)
    local function createIgniteTag(targetPlayer)
        local function applyTag()
            local char = targetPlayer.Character
            if char then
                local head = char:WaitForChild("Head", 5)
                if head and not head:FindFirstChild("IgniteTag") then
                    local tag = Instance.new("BillboardGui")
                    tag.Name = "IgniteTag"; tag.Size = UDim2.new(0, 250, 0, 70); tag.AlwaysOnTop = true
                    tag.ExtentsOffset = Vector3.new(0, 3.5, 0); tag.Parent = head
                    local container = Instance.new("Frame")
                    container.Size = UDim2.new(0.9, 0, 0.6, 0); container.Position = UDim2.new(0.05, 0, 0.2, 0)
                    container.BackgroundColor3 = Color3.fromRGB(15, 0, 30); container.BackgroundTransparency = 0.2
                    container.ClipsDescendants = true; container.Parent = tag
                    Instance.new("UICorner", container); Instance.new("UIStroke", container).Color = THEME_COLOR

                    task.spawn(function()
                        while tag.Parent do
                            local p = Instance.new("TextLabel")
                            p.Text = "✧"; p.TextColor3 = THEME_COLOR; p.BackgroundTransparency = 1
                            p.Size = UDim2.new(0, 10, 0, 10); p.Position = UDim2.new(math.random(), 0, 1, 0); p.Parent = container
                            TweenService:Create(p, TweenInfo.new(math.random(2,4)), {Position = UDim2.new(p.Position.X.Scale, 0, -0.5, 0), TextTransparency = 1}):Play()
                            game:GetService("Debris"):AddItem(p, 4); task.wait(0.6)
                        end
                    end)

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(1, 0, 1, 0); textLabel.BackgroundTransparency = 1
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255); textLabel.Font = Enum.Font.GothamBold; textLabel.TextSize = 18; textLabel.Parent = container

                    task.spawn(function()
                        local fullText = "IGT USER: " .. targetPlayer.DisplayName
                        while tag.Parent do
                            for i = 1, #fullText do textLabel.Text = string.sub(fullText, 1, i) .. "_"; task.wait(0.1) end
                            task.wait(1.5)
                            for i = #fullText, 0, -1 do textLabel.Text = string.sub(fullText, 1, i) .. "_"; task.wait(0.05) end
                            task.wait(0.5)
                        end
                    end)
                end
            end
        end
        applyTag()
        targetPlayer.CharacterAdded:Connect(applyTag)
    end

    -- Monitoramento de Jogadores
    local function checkPlayers()
        for _, p in pairs(Players:GetPlayers()) do if p:GetAttribute("IsIgniteUser") then createIgniteTag(p) end end
    end
    Players.PlayerAdded:Connect(function(p)
        p:GetAttributeChangedSignal("IsIgniteUser"):Connect(function() if p:GetAttribute("IsIgniteUser") then createIgniteTag(p) end end)
    end)
    task.spawn(function() while task.wait(5) do checkPlayers() end end)

    -- Estrelas de Fundo
    local ParticleContainer = Instance.new("Frame")
    ParticleContainer.Size = UDim2.new(1, 0, 1, 0); ParticleContainer.BackgroundTransparency = 1; ParticleContainer.Parent = MainFrame
    local function createStar()
        local icons = {"✦", "✧"}
        local p = Instance.new("TextLabel")
        p.Text = icons[math.random(1, #icons)]; p.TextColor3 = THEME_COLOR; p.BackgroundTransparency = 1
        p.Position = UDim2.new(math.random(), 0, 1.1, 0); p.TextSize = math.random(8, 14); p.Parent = ParticleContainer
        TweenService:Create(p, TweenInfo.new(math.random(3, 6)), {Position = UDim2.new(p.Position.X.Scale, 0, -0.2, 0), Rotation = 360, TextTransparency = 1}):Play()
        game:GetService("Debris"):AddItem(p, 6)
    end
    task.spawn(function() while task.wait(0.4) do createStar() end end)

    -- Sidebar e Tabs
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 100, 1, -60); Sidebar.Position = UDim2.new(0, 0, 0, 60); Sidebar.BackgroundTransparency = 1; Sidebar.Parent = MainFrame
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(1, -110, 1, -70); TabContainer.Position = UDim2.new(0, 105, 0, 65); TabContainer.BackgroundTransparency = 1; TabContainer.Parent = MainFrame

    local PageMenu = Instance.new("Frame"); PageMenu.Size = UDim2.new(1, 0, 1, 0); PageMenu.BackgroundTransparency = 1; PageMenu.Parent = TabContainer
    local PageVoice = Instance.new("Frame"); PageVoice.Size = UDim2.new(1, 0, 1, 0); PageVoice.BackgroundTransparency = 1; PageVoice.Visible = false; PageVoice.Parent = TabContainer
    local PageDestroy = Instance.new("Frame"); PageDestroy.Size = UDim2.new(1, 0, 1, 0); PageDestroy.BackgroundTransparency = 1; PageDestroy.Visible = false; PageDestroy.Parent = TabContainer

    local function createTabBtn(name, pos)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Position = UDim2.new(0.05, 0, 0, pos); btn.BackgroundColor3 = ACCENT_COLOR
        btn.Text = name; btn.Font = Enum.Font.GothamMedium; btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.TextSize = 17; btn.Parent = Sidebar
        Instance.new("UICorner", btn); return btn
    end

    createTabBtn("Menu", 10).Activated:Connect(function() PageVoice.Visible = false; PageDestroy.Visible = false; PageMenu.Visible = true end)
    createTabBtn("Voice", 55).Activated:Connect(function() PageMenu.Visible = false; PageDestroy.Visible = false; PageVoice.Visible = true end)
    createTabBtn("Destroy", 100).Activated:Connect(function() PageMenu.Visible = false; PageVoice.Visible = false; PageDestroy.Visible = true end)

    -- Conteúdo Menu
    local PlayerImg = Instance.new("ImageLabel")
    PlayerImg.Size = UDim2.new(0, 80, 0, 80); PlayerImg.Position = UDim2.new(0, 10, 0, 10)
    PlayerImg.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150); PlayerImg.Parent = PageMenu
    Instance.new("UICorner", PlayerImg).CornerRadius = UDim.new(1, 0)

    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Size = UDim2.new(1, -100, 0, 90); InfoLabel.Position = UDim2.new(0, 100, 0, 5)
    InfoLabel.BackgroundTransparency = 1; InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255); InfoLabel.TextSize = 18; InfoLabel.Font = Enum.Font.GothamMedium; InfoLabel.TextXAlignment = Enum.TextXAlignment.Left; InfoLabel.Parent = PageMenu

    local KeyLabel = Instance.new("TextLabel")
    KeyLabel.Text = "Pressione a tecla [B] para ocultar o Menu Ignite"
    KeyLabel.Size = UDim2.new(1, 0, 0, 60); KeyLabel.Position = UDim2.new(0, 0, 0.65, 0); KeyLabel.TextColor3 = THEME_COLOR; KeyLabel.Font = Enum.Font.GothamBold; KeyLabel.TextSize = 20; KeyLabel.BackgroundTransparency = 1; KeyLabel.TextWrapped = true; KeyLabel.Parent = PageMenu

    task.spawn(function()
        while task.wait(1) do
            local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            InfoLabel.Text = "User: " .. player.DisplayName .. "\nPing: " .. ping .. "ms\nOnline: " .. #Players:GetPlayers()
        end
    end)

    -- Cabeçalho
    local Header = Instance.new("Frame"); Header.Size = UDim2.new(1, 0, 0, 60); Header.BackgroundTransparency = 1; Header.Parent = MainFrame
    Instance.new("TextLabel", Header).Text = "Ignite Hub 1.0"; Header.TextLabel.Size = UDim2.new(1, 0, 0.6, 0); Header.TextLabel.TextColor3 = THEME_COLOR; Header.TextLabel.Font = Enum.Font.SpecialElite; Header.TextLabel.TextSize = 22; Header.TextLabel.BackgroundTransparency = 1
    local Sub = Instance.new("TextLabel", Header); Sub.Text = "created by askovyx/ krazzy / surfista7"; Sub.Position = UDim2.new(0,0,0.5,0); Sub.Size = UDim2.new(1,0,0.4,0); Sub.TextColor3 = Color3.fromRGB(130,130,130); Sub.Font = Enum.Font.Code; Sub.TextSize = 10; Sub.BackgroundTransparency = 1

    -- Botões de Ação
    local AntibanBtn = Instance.new("TextButton", PageVoice); AntibanBtn.Text = "IGT ANTBAN"; AntibanBtn.Size = UDim2.new(0, 200, 0, 60); AntibanBtn.Position = UDim2.new(0.5, -100, 0.4, -30); AntibanBtn.TextColor3 = Color3.fromRGB(255, 255, 255); AntibanBtn.Font = Enum.Font.GothamBold; AntibanBtn.TextSize = 22; AntibanBtn.BackgroundTransparency = 1; Instance.new("UICorner", AntibanBtn); Instance.new("UIStroke", AntibanBtn).Color = THEME_COLOR
    local DestroyerBtn = Instance.new("TextButton", PageDestroy); DestroyerBtn.Text = "DESTROY HUB"; DestroyerBtn.Size = UDim2.new(0, 200, 0, 60); DestroyerBtn.Position = UDim2.new(0.5, -100, 0.4, -30); DestroyerBtn.TextColor3 = Color3.fromRGB(255, 255, 255); DestroyerBtn.Font = Enum.Font.GothamBold; DestroyerBtn.TextSize = 22; DestroyerBtn.BackgroundTransparency = 1; Instance.new("UICorner", DestroyerBtn); Instance.new("UIStroke", DestroyerBtn).Color = Color3.fromRGB(255, 0, 0)
    
    DestroyerBtn.Activated:Connect(function() ScreenGui:Destroy() end)

    -- Arrastar e Toggle [B]
    local d, di, ds, sp
    MainFrame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d=true; ds=i.Position; sp=MainFrame.Position end end)
    UIS.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then local delta = i.Position-ds; MainFrame.Position = UDim2.new(sp.X.Scale, sp.X.Offset+delta.X, sp.Y.Scale, sp.Y.Offset+delta.Y) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d=false end end)
    UIS.InputBegan:Connect(function(i, gp) if not gp and i.KeyCode == Enum.KeyCode.B then MainFrame.Visible = not MainFrame.Visible end end)

    -- Execução Antiban Original
    AntibanBtn.Activated:Connect(function()
        MainFrame.Visible = false
        local LF = Instance.new("Frame", ScreenGui); LF.Size = UDim2.new(0, 250, 0, 4); LF.Position = UDim2.new(0.5, -125, 0.5, 0); LF.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        local FL = Instance.new("Frame", LF); FL.Size = UDim2.new(0, 0, 1, 0); FL.BackgroundColor3 = THEME_COLOR
        local tw = TweenService:Create(FL, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)})
        tw:Play(); tw.Completed:Connect(function()
            LF:Destroy(); task.wait(0.2)
            -- [LÓGICA ANTBAN MANTIDA]
            local VCS = game:GetService("VoiceChatService"); local VCI = game:GetService("VoiceChatInternal")
            local MUTED = "rbxasset://textures/ui/VoiceChat/MicLight/Muted.png"
            local TB = CoreGui:WaitForChild("TopBarApp"):WaitForChild("TopBarApp"):WaitForChild("UnibarLeftFrame"):WaitForChild("UnibarMenu")
            local MC = TB:WaitForChild("2"):WaitForChild("3"); local MP = MC:FindFirstChild("toggle_mic_mute")
            local function get_ic(b) b = b or MP; return b:WaitForChild("IntegrationIconFrame"):WaitForChild("IntegrationIcon")["1"] end
            if not MP then VCS:joinVoice() MP = MC:WaitForChild("toggle_mic_mute") repeat task.wait(0.1) until get_ic().Image == MUTED end
            repeat task.wait(0.1) until get_ic().Image ~= MUTED
            local gid = VCI:GetGroupId(); VCI:JoinByGroupId(gid, true); VCS:leaveVoice(); task.wait()
            for _=1, 4 do VCI:JoinByGroupId(gid, true) end; task.wait(5); VCS:joinVoice(); VCI:JoinByGroupId(gid, true)
            MP.Visible = false; local nm = MP:Clone(); nm.Name = "igt_mic"; nm.Visible = true; nm.Parent = MP.Parent
            local cm = true; local ni = get_ic(nm); local rd = nm:WaitForChild("IntegrationIconFrame"):WaitForChild("IntegrationIcon"):WaitForChild("RedVoiceDot")
            ni.Image = MUTED; VCI:PublishPause(true)
            nm:WaitForChild("IconHitArea_toggle_mic_mute").Activated:Connect(function() cm = not cm; VCI:PublishPause(cm); if cm then ni.Image = MUTED; rd.Visible = false else ni.Image = get_ic(MP).Image; rd.Visible = true end end)
        end)
    end)
end

-- =========================================================
-- LOGICA DE VERIFICAÇÃO DE KEY (BLINDADA)
-- =========================================================
InsertBtn.Activated:Connect(function()
    local input = KeyInput.Text:gsub("%s+", "")
    if input == "" then return end
    InsertBtn.Text = "VERIFICANDO..."
    local s, res = pcall(function() return game:HttpGet(KEYS_URL) end)
    if s then
        local found = false
        for key in res:gsub("\r", ""):gmatch("[^\n]+") do if key:gsub("%s+", "") == input then found = true; break end end
        if found then
            InsertBtn.Text = "ACESSO LIBERADO!"; InsertBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            task.wait(1); LiberarHub()
        else
            InsertBtn.Text = "KEY INVÁLIDA!"; InsertBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
            task.wait(2); InsertBtn.Text = "INSERIR"; InsertBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
        end
    else
        InsertBtn.Text = "ERRO DE CONEXÃO"
    end
end)
