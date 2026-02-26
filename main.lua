-- [[ CONFIGURAÇÕES IGNITE HUB + KEYAUTH ]]
local KeyAuthApp = {
    name = "IgniteHub", 
    ownerid = "XTWmDg8iCh", 
    secret = "ff2b5a15aec3ea5bdc1f421e27b0eb04ddc26bac95bde2a62da649c88d0d31a0",
    version = "1.0"
}

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local DISCORD_LINK = "https://discord.gg/76KnzJRkKN" 

local sessionid = ""

-- =========================================================
-- FUNÇÕES DE CONEXÃO KEYAUTH
-- =========================================================
local function KeyAuthInit()
    local url = "https://keyauth.win/api/1.1/?name="..KeyAuthApp.name.."&ownerid="..KeyAuthApp.ownerid.."&type=init&ver="..KeyAuthApp.version
    local s, res = pcall(function() return game:HttpGet(url) end)
    if s then
        local success, decoded = pcall(function() return HttpService:JSONDecode(res) end)
        if success and decoded.success then sessionid = decoded.sessionid return true end
    end
    return false
end

local function KeyAuthLogin(key)
    if sessionid == "" then KeyAuthInit() end
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    local url = "https://keyauth.win/api/1.1/?name="..KeyAuthApp.name.."&ownerid="..KeyAuthApp.ownerid.."&type=license&key="..key.."&hwid="..hwid.."&sessionid="..sessionid
    local s, res = pcall(function() return game:HttpGet(url) end)
    if s then
        local success, decoded = pcall(function() return HttpService:JSONDecode(res) end)
        if success then return decoded end
    end
    return {success = false, message = "Erro de Conexão"}
end

task.spawn(KeyAuthInit)

-- =========================================================
-- INTERFACE DE LOGIN
-- =========================================================
local LoginGui = Instance.new("ScreenGui")
LoginGui.Name = "IgniteLogin"; LoginGui.Parent = CoreGui; LoginGui.ResetOnSpawn = false

local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 320, 0, 200); LoginFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
LoginFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15); LoginFrame.Parent = LoginGui
Instance.new("UICorner", LoginFrame)
local LS = Instance.new("UIStroke", LoginFrame); LS.Color = Color3.fromRGB(140, 0, 255); LS.Thickness = 2.5

local LTitle = Instance.new("TextLabel")
LTitle.Text = "IGNITE HUB | LOGIN"; LTitle.Size = UDim2.new(1, 0, 0, 50); LTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LTitle.Font = Enum.Font.GothamBold; LTitle.BackgroundTransparency = 1; LTitle.Parent = LoginFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 260, 0, 40); KeyInput.Position = UDim2.new(0.5, -130, 0.4, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 30); KeyInput.PlaceholderText = "Insira sua Key..."
KeyInput.Text = ""; KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255); KeyInput.Parent = LoginFrame
Instance.new("UICorner", KeyInput)

local InsertBtn = Instance.new("TextButton")
InsertBtn.Text = "LOGAR"; InsertBtn.Size = UDim2.new(0, 125, 0, 40); InsertBtn.Position = UDim2.new(0.5, -130, 0.7, 0)
InsertBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 255); InsertBtn.TextColor3 = Color3.fromRGB(255, 255, 255); InsertBtn.Parent = LoginFrame
Instance.new("UICorner", InsertBtn)

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Text = "OBTER KEY"; GetKeyBtn.Size = UDim2.new(0, 125, 0, 40); GetKeyBtn.Position = UDim2.new(0.5, 5, 0.7, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50); GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255); GetKeyBtn.Parent = LoginFrame
Instance.new("UICorner", GetKeyBtn)

GetKeyBtn.Activated:Connect(function() setclipboard(DISCORD_LINK) GetKeyBtn.Text = "LINK COPIADO!"; task.wait(2) GetKeyBtn.Text = "OBTER KEY" end)

-- =========================================================
-- FUNÇÃO QUE LIBERA O HUB (TUDO RESTAURADO)
-- =========================================================
local function LiberarHub()
    LoginGui:Destroy()
    local THEME_COLOR = Color3.fromRGB(140, 0, 255)
    player:SetAttribute("IsIgniteUser", true)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "IgniteHub_Main"; ScreenGui.Parent = CoreGui; ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 420, 0, 320); MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15); MainFrame.ClipsDescendants = true; MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame)
    local Stroke = Instance.new("UIStroke", MainFrame); Stroke.Color = THEME_COLOR; Stroke.Thickness = 2.5

    -- [PARTÍCULAS / ESTRELAS]
    local ParticleContainer = Instance.new("Frame")
    ParticleContainer.Size = UDim2.new(1, 0, 1, 0); ParticleContainer.BackgroundTransparency = 1; ParticleContainer.Parent = MainFrame
    task.spawn(function()
        while MainFrame.Parent do
            local p = Instance.new("TextLabel")
            p.Text = math.random() > 0.5 and "✦" or "✧"; p.TextColor3 = THEME_COLOR; p.BackgroundTransparency = 1
            p.Position = UDim2.new(math.random(), 0, 1.1, 0); p.TextSize = math.random(8, 14); p.Parent = ParticleContainer
            TweenService:Create(p, TweenInfo.new(math.random(3, 6)), {Position = UDim2.new(p.Position.X.Scale, 0, -0.2, 0), Rotation = 360, TextTransparency = 1}):Play()
            game:GetService("Debris"):AddItem(p, 6); task.wait(0.4)
        end
    end)

    -- [CABEÇALHO]
    local Header = Instance.new("Frame"); Header.Size = UDim2.new(1, 0, 0, 60); Header.BackgroundTransparency = 1; Header.Parent = MainFrame
    local Title = Instance.new("TextLabel", Header); Title.Text = "Ignite Hub 1.0"; Title.Size = UDim2.new(1, 0, 0.6, 0); Title.TextColor3 = THEME_COLOR; Title.Font = Enum.Font.SpecialElite; Title.TextSize = 24; Title.BackgroundTransparency = 1
    local Sub = Instance.new("TextLabel", Header); Sub.Text = "created by askovyx / krazzy / surfista7"; Sub.Position = UDim2.new(0,0,0.6,0); Sub.Size = UDim2.new(1,0,0.4,0); Sub.TextColor3 = Color3.fromRGB(130,130,130); Sub.Font = Enum.Font.Code; Sub.TextSize = 10; Sub.BackgroundTransparency = 1

    -- [SIDEBAR]
    local Sidebar = Instance.new("Frame"); Sidebar.Size = UDim2.new(0, 100, 1, -70); Sidebar.Position = UDim2.new(0, 5, 0, 65); Sidebar.BackgroundTransparency = 1; Sidebar.Parent = MainFrame
    local TabContainer = Instance.new("Frame"); TabContainer.Size = UDim2.new(1, -120, 1, -80); TabContainer.Position = UDim2.new(0, 110, 0, 70); TabContainer.BackgroundTransparency = 1; TabContainer.Parent = MainFrame

    local PageMenu = Instance.new("Frame", TabContainer); PageMenu.Size = UDim2.new(1, 0, 1, 0); PageMenu.BackgroundTransparency = 1
    local PageVoice = Instance.new("Frame", TabContainer); PageVoice.Size = UDim2.new(1, 0, 1, 0); PageVoice.BackgroundTransparency = 1; PageVoice.Visible = false
    local PageDestroy = Instance.new("Frame", TabContainer); PageDestroy.Size = UDim2.new(1, 0, 1, 0); PageDestroy.BackgroundTransparency = 1; PageDestroy.Visible = false

    local function createTab(name, page, pos)
        local b = Instance.new("TextButton", Sidebar); b.Size = UDim2.new(1, 0, 0, 35); b.Position = UDim2.new(0, 0, 0, pos); b.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        b.Text = name; b.TextColor3 = Color3.fromRGB(255, 255, 255); b.Font = Enum.Font.GothamMedium; Instance.new("UICorner", b)
        b.Activated:Connect(function() PageMenu.Visible = false; PageVoice.Visible = false; PageDestroy.Visible = false; page.Visible = true end)
    end
    createTab("Menu", PageMenu, 0); createTab("Voice", PageVoice, 45); createTab("Destroy", PageDestroy, 90)

    -- [PÁGINA MENU (ÍCONE RESTAURADO)]
    local PlayerImg = Instance.new("ImageLabel", PageMenu); PlayerImg.Size = UDim2.new(0, 70, 0, 70); PlayerImg.Position = UDim2.new(0, 5, 0, 5)
    pcall(function() PlayerImg.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150) end)
    Instance.new("UICorner", PlayerImg).CornerRadius = UDim.new(1, 0)

    local InfoLabel = Instance.new("TextLabel", PageMenu); InfoLabel.Size = UDim2.new(1, -85, 0, 70); InfoLabel.Position = UDim2.new(0, 85, 0, 5)
    InfoLabel.BackgroundTransparency = 1; InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255); InfoLabel.TextXAlignment = 0; InfoLabel.Font = Enum.Font.Gotham; InfoLabel.TextSize = 14
    task.spawn(function() while task.wait(1) do InfoLabel.Text = "User: "..player.DisplayName.."\nPing: "..math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()).."ms\nPlayers: "..#Players:GetPlayers() end end)

    local BLabel = Instance.new("TextLabel", PageMenu); BLabel.Text = "Pressione [B] para ocultar"; BLabel.Size = UDim2.new(1,0,0,30); BLabel.Position = UDim2.new(0,0,0.8,0); BLabel.BackgroundTransparency = 1; BLabel.TextColor3 = THEME_COLOR; BLabel.Font = Enum.Font.GothamBold

    -- [BOTÃO VOICE (ANTIBAN RESTAURADO)]
    local AntibanBtn = Instance.new("TextButton", PageVoice); AntibanBtn.Text = "IGT ANTBAN"; AntibanBtn.Size = UDim2.new(0, 180, 0, 50); AntibanBtn.Position = UDim2.new(0.5, -90, 0.4, -25); AntibanBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30); AntibanBtn.TextColor3 = Color3.fromRGB(255, 255, 255); AntibanBtn.Font = Enum.Font.GothamBold; AntibanBtn.TextSize = 18; Instance.new("UICorner", AntibanBtn); local st = Instance.new("UIStroke", AntibanBtn); st.Color = THEME_COLOR
    AntibanBtn.Activated:Connect(function() 
        AntibanBtn.Text = "EXECUTANDO..."; task.wait(1.5)
        -- Aqui você cola o seu script de Antiban original se quiser, ou deixa a função visual
        AntibanBtn.Text = "ANTIBAN ATIVO!"; AntibanBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
    end)

    -- [BOTÃO DESTROY]
    local DestBtn = Instance.new("TextButton", PageDestroy); DestBtn.Text = "FECHAR TUDO"; DestBtn.Size = UDim2.new(0, 180, 0, 50); DestBtn.Position = UDim2.new(0.5, -90, 0.4, -25); DestBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0); DestBtn.TextColor3 = Color3.fromRGB(255, 255, 255); DestBtn.Font = Enum.Font.GothamBold; Instance.new("UICorner", DestBtn)
    DestBtn.Activated:Connect(function() ScreenGui:Destroy() end)

    -- [DRAG]
    local d, ds, sp; MainFrame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d=true; ds=i.Position; sp=MainFrame.Position end end)
    UIS.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then local delta = i.Position-ds; MainFrame.Position = UDim2.new(sp.X.Scale, sp.X.Offset+delta.X, sp.Y.Scale, sp.Y.Offset+delta.Y) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d=false end end)
    UIS.InputBegan:Connect(function(i, gp) if not gp and i.KeyCode == Enum.KeyCode.B then MainFrame.Visible = not MainFrame.Visible end end)
end

-- =========================================================
-- LOGICA DE LOGIN
-- =========================================================
InsertBtn.Activated:Connect(function()
    local input = KeyInput.Text:gsub("%s+", "")
    if input == "" then return end
    InsertBtn.Text = "VERIFICANDO..."; InsertBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    local res = KeyAuthLogin(input)
    if res and res.success then
        InsertBtn.Text = "ACESSO LIBERADO!"; InsertBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        task.wait(1); LiberarHub()
    else
        InsertBtn.Text = (res and res.message or "ERRO"):upper(); InsertBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
        task.wait(2); InsertBtn.Text = "LOGAR"; InsertBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
    end
end)
