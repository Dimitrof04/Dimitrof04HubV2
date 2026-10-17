print("@Dimitrof04 Hub")
print(string.format("Game id : %i", game.GameId))
print(string.format("Player id : %i ", game.Players.LocalPlayer.UserId))
print('loadstring(game:HttpGet("https://github.com/Dimitrof04/Dimitrof04HubV2/main/Hub.lua"))()')
-- [Services]
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- [Gui Class]
local function Guiclass()
	local function CreateUiStroke(parent, size, color)
		local Uistrokebtntab = Instance.new("UIStroke")
		Uistrokebtntab.Color = color or Color3.fromRGB(255, 255, 255)
		Uistrokebtntab.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		Uistrokebtntab.Thickness = size
		Uistrokebtntab.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
		Uistrokebtntab.LineJoinMode = Enum.LineJoinMode.Round
		Uistrokebtntab.Parent = parent

		return Uistrokebtntab
	end

	local function CreateUiFrame(Parent, pos, siz)
		local Frame = Instance.new("Frame")
		Frame.Name = "Frame"
		Frame.Size = siz
		Frame.Position = pos
		Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BackgroundTransparency = 1
		Frame.BorderSizePixel = 0
		Frame.Parent = Parent
		Frame.Visible = true

		return Frame
	end
	
	local function CreateUiScroll(Parent, pos, size, padding)
		local Scroll = Instance.new("ScrollingFrame")
		Scroll.Name = "ScrollingFrame"
		Scroll.Size = size
		Scroll.Position = pos
		Scroll.BackgroundTransparency = 1
		Scroll.BorderSizePixel = 0
		Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
		Scroll.ScrollBarImageColor3 = Color3.fromRGB(255,255,255)
		Scroll.ScrollBarImageTransparency = 1
		Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		Scroll.Parent = Parent
		Scroll.Visible = true
		
		return Scroll
	end

	local function CreateUiList(Parent, VA, HA, Wraps, Sortorder, FD, padding)
		if not padding then
			UDim.new(0, 10)
		end
		local List = Instance.new("UIListLayout", Parent)
		List.FillDirection = FD
		List.SortOrder = Sortorder or Enum.SortOrder.LayoutOrder
		List.Wraps = Wraps
		List.VerticalAlignment = VA
		List.HorizontalAlignment = HA
		List.Name = "List"
		List.Padding = padding or UDim.new(0, 10)

		return List
	end

	local function CreateUiText(TextLabel, Parent, pos, siz)
		local Text = Instance.new("TextLabel")
		Text.Size = siz
		Text.Position = pos
		Text.BackgroundTransparency = 1
		Text.Text = TextLabel
		Text.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text.TextXAlignment = Enum.TextXAlignment.Center
		Text.Font = Enum.Font.SourceSans
		Text.TextSize = 14
		Text.TextScaled = true
		Text.Parent = Parent
		Text.Name = "TextLabel"
		Text.Visible = true

		return Text
	end

	local function CreateUiTextButton(Text, Parent, pos, siz)
		local TextButton = Instance.new("TextButton")
		TextButton.Size = siz
		TextButton.Position = pos

		TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.BackgroundTransparency = 0.99 

		TextButton.Text = Text
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.Parent = Parent
		TextButton.Font = Enum.Font.SourceSans
		TextButton.TextScaled = true
		TextButton.Name = "TextButton"
		TextButton.Visible = true

		TextButton.Active = true 

		TextButton.ZIndex = 10 

		return TextButton
	end
	
	local function CreateUiBorder(Parent, radius)
		local Border = Instance.new("UICorner")
		Border.CornerRadius = radius or UDim.new(0.1, 0)
		Border.Parent = Parent
		
		return Border
	end
	
	return {
		CreateUiStroke = CreateUiStroke,
		CreateUiFrame = CreateUiFrame,
		CreateUiScroll = CreateUiScroll,
		CreateList = CreateUiList,
		CreateUiText = CreateUiText,
		CreateUiTextButton = CreateUiTextButton,
		CreateUiBorder = CreateUiBorder,
	}
end

local Gui = Guiclass()
-- [ Script ]

local Global = {
	bools = {
		Speed = false,
		InfJump = false,
		NoClip = false,
		Fly = false,
		TweenTP = false,
		Esp = false,
		Aimbot = false,
		AutoSpin = false,
		ExpansiveHitbox = false,
		Espectre = false
	},
	values = {
		Speed = 16,
		FlySpeed = 50,
		TweenSpeed = 300,
		AutoSpinSpeed = 50,
		BackTransparancy = 0.5,
		Fov = 90,
		AimSmoothness = 0.2,
		HitboxSize = 10
	},
	DragData = {
		dragStartMini = nil,
		startPosMini = nil
	}
}

local FileName = "Dimitrof04Config.json"

-- Função para Salvar
local function SaveConfig()
	local success, encoded = pcall(function()
		return HttpService:JSONEncode(Global)
	end)

	if success then
		writefile(FileName, encoded)
		print("Configurações salvas com sucesso!")
	else
		warn("Erro ao codificar o arquivo JSON para salvar.")
	end
end

-- Função para Carregar
local function LoadConfig()
	if isfile and isfile(FileName) then
		local success, decoded = pcall(function()
			local content = readfile(FileName)
			return HttpService:JSONDecode(content)
		end)

		if success and type(decoded) == "table" then
			-- Atualiza os valores do Global mantendo as estruturas seguras
			if decoded.bools then
				for k, v in pairs(decoded.bools) do
					if Global.bools[k] ~= nil then
						Global.bools[k] = v
					end
				end
			end
			if decoded.values then
				for k, v in pairs(decoded.values) do
					if Global.values[k] ~= nil then
						Global.values[k] = v
					end
				end
			end
			print("Configurações carregadas com sucesso!")
		else
			warn("Arquivo de configuração corrompido, usando padrões.")
		end
	end
end

-- Carrega assim que o script iniciar
LoadConfig()

local function CreateScrengui()	
	local Screngui = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
	Screngui.IgnoreGuiInset = true
	Screngui.ResetOnSpawn = false
	Screngui.Name = "Dimitrof04ScriptRenew"
	Screngui.DisplayOrder = 99
	
	local mainbtn = Instance.new("ImageButton",Screngui)
	mainbtn.Name = "MainButton"
	mainbtn.Size = UDim2.fromScale(0.061,0.109)
	mainbtn.Position = UDim2.fromOffset(100,100)
	mainbtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	mainbtn.BackgroundTransparency = 1
	mainbtn.Image = "rbxassetid://96272608935524"
	mainbtn.ZIndex = 10
	Gui.CreateUiBorder(mainbtn, UDim.new(1,0))
	Gui.CreateUiStroke(mainbtn, 0.06)
	
	local Window = Gui.CreateUiFrame(Screngui, UDim2.fromScale(0.5,0.5), UDim2.fromScale(0.350, 0.450))
	Window.AnchorPoint = Vector2.new(0.5,0.5)
	Window.BackgroundTransparency = 0.5
	Window.ZIndex = -1
	Gui.CreateUiBorder(Window,UDim.new(0.05,0))
	Gui.CreateUiStroke(Window, 0.01)
	
	local TopBar = Gui.CreateUiFrame(Window, UDim2.fromScale(0.02, 0), UDim2.fromScale(0.96, 0.09))
	
	local Title = Gui.CreateUiText("Dimitrof04 v2", TopBar, UDim2.fromScale(0, 0), UDim2.fromScale(1,1))
	
	local PageParent = Gui.CreateUiFrame(Window, UDim2.fromScale(0.318, 0.1), UDim2.fromScale(0.662, 0.88))
	
	local PagesList = Gui.CreateUiScroll(Window, UDim2.fromScale(0.018, 0.1), UDim2.fromScale(0.3,0.855))
	Gui.CreateList(PagesList, Enum.VerticalAlignment.Top, Enum.HorizontalAlignment.Left, false, Enum.SortOrder.LayoutOrder, Enum.FillDirection.Vertical, UDim.new(0,5))
	
	local function OpenPage(name)
		if not name then return end
		for i,v in pairs(PageParent:GetChildren()) do
			if v.Name ~= name then
				v.Visible = false
			else
				v.Visible = true
			end
		end
	end
	
	local function CreatePage(pagename)
		local Page = Gui.CreateUiScroll(PageParent, UDim2.fromScale(0,0), UDim2.fromScale(1,1), UDim.new(0, 5))
		Gui.CreateList(Page, Enum.VerticalAlignment.Top, Enum.HorizontalAlignment.Center, false, Enum.SortOrder.LayoutOrder, Enum.FillDirection.Vertical, UDim.new(0,5))
		Page.Name = pagename
		
		local Pagebtn = Gui.CreateUiTextButton(pagename, PagesList, UDim2.fromOffset(0,0), UDim2.new(1,0,0,45)) 
		
		if Pagebtn and Pagebtn.Activated then
			Pagebtn.Activated:Connect(function()
				OpenPage(pagename)
			end)
		end
		
		PagesList.CanvasSize += UDim2.new(0,0,0,50)
		
		local function CreateDescription(text)
			Page.CanvasSize += UDim2.new(0,0,0,45)
			return Gui.CreateUiText(text, Page, UDim2.fromOffset(0,0), UDim2.new(0.8,0,0,35))
		end

		local function CreateButtonInput(text, stateKey)
			local btn = Gui.CreateUiTextButton(text .. " : ", Page, UDim2.new(0,0,0,0), UDim2.new(0.8, 0,0, 45))
			btn.Font = Enum.Font.GothamMedium

			local corner = Gui.CreateUiBorder(btn, UDim.new(0.1, 0))

			local stroke = Gui.CreateUiStroke(btn, 0.1)
			
			local function Update()
				if Global.bools[stateKey] then
					btn.Text = text .. " : On"
				else
					btn.Text = text .. " : Off"
				end
			end

			if btn and btn.Activated then
				btn.Activated:Connect(function()
					Global.bools[stateKey] = not Global.bools[stateKey]
					Update() -- Atualiza o texto na hora do clique
				end)
			end
			
			Page.CanvasSize += UDim2.new(0,0,0,50)
			
			Update()

			return btn
		end

		local function CreateOneButton(text)
			local btn = Gui.CreateUiTextButton(text, Page, UDim2.new(0,0,0,0), UDim2.new(0.8, 0,0, 45))
			btn.Font = Enum.Font.GothamMedium

			local corner = Gui.CreateUiBorder(btn, UDim.new(0.1, 0))

			Gui.CreateUiStroke(btn, 0.1)
			
			Page.CanvasSize += UDim2.new(0,0,0,50)
			
			return btn
		end

		local function CreateInput(Default)
			local box = Instance.new("TextBox")
			box.Size = UDim2.new(1, 0, 0, 30)
			box.Position = UDim2.new(0, 0, 0, 0)
			box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			box.PlaceholderText = Default
			box.Text = Default
			box.TextColor3 = Color3.fromRGB(255, 255, 255)
			box.Parent = Page

			Gui.CreateUiBorder(box)
			
			Page.CanvasSize += UDim2.new(0,0,0,35)

			return box
		end

		local function CreateSlider(labelText, min, max, default, stateKey)
			Global.values[stateKey] = default

			local frame = Gui.CreateUiFrame(Page, UDim2.new(0,0,0,0), UDim2.new(0.95, 0,0, 50))

			local label = Gui.CreateUiText(labelText .. ": " .. default, frame, UDim2.new(0,0,0,0), UDim2.new(1,0,0.5,0))
			label.Font = Enum.Font.Gotham
			label.TextScaled = true

			local bar = Gui.CreateUiFrame(frame, UDim2.new(0, 0, 0, 25), UDim2.new(1, 0, 0, 10))
			bar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			bar.BackgroundTransparency = 0

			local barCorner = Gui.CreateUiBorder(bar)

			local fill = Gui.CreateUiFrame(bar, UDim2.new(0, 0, 0, 0), UDim2.new((default-min)/(max-min), 0, 1, 0))
			fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			fill.BackgroundTransparency = 0

			local fillCorner = Gui.CreateUiBorder(fill)

			local dragging = false

			local function updateSlider(input)
				local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
				fill.Size = UDim2.new(pos, 0, 1, 0)

				local val = math.floor(min + ((max - min) * pos))
				Global.values[stateKey] = val
				label.Text = labelText .. ": " .. val
			end

			bar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					updateSlider(input)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					updateSlider(input)
				end
			end)

			Page.CanvasSize += UDim2.new(0,0,0,55)
		end

		-- Retorna a página e os construtores caso queira utilizá-los fora
		return {
			Create_Description = CreateDescription,
			Create_ButtonInput = CreateButtonInput,
			Create_OneShotbtn = CreateOneButton,
			Create_InputText = CreateInput,
			Create_Slider = CreateSlider
		}
	end
	
	local function UpdateBackgroud(r, g ,b)
		Window.BackgroundColor3 = Color3.new(r,g,b)
	end

	local function UpdateWindowtransparancy(value)
		if value < 0 then value = 0 end
		if value > 1 then value = 1 end
		Window.BackgroundTransparency = value
	end

	local function UpdateVisible(value)
		if not value then
			Window.Visible = not Window.Visible
			return
		end
		Window.Visible = value
	end
	
	if mainbtn and mainbtn.Activated then
		mainbtn.Activated:Connect(function()
			Window.Visible = not Window.Visible
		end)
	end
	
	return {
		Objs = {
			Screngui = Screngui,
			Window = Window,
			TopBar = TopBar,
			Minibutton = mainbtn,
		},
		Actions = {
			update_background = UpdateBackgroud,
			update_windowtransparancy = UpdateWindowtransparancy,
			update_visible = UpdateVisible,
			page = CreatePage, 
			OpenPage = OpenPage,
		}
	}
end

local function Actionsclass()
	local function GetChar(playername)
		local playerObj = playername and Players:FindFirstChild(playername) or Players.LocalPlayer
		if not playerObj then return false end

		-- O Character é uma propriedade do Player, não um filho direto via WaitForChild
		local char = playerObj.Character or playerObj.CharacterAdded:Wait(5)

		if not char then
			return false
		end

		local Humanoid = char:WaitForChild("Humanoid", 5)
		local RootPart = char:WaitForChild("HumanoidRootPart", 5)

		if not Humanoid or not RootPart then
			return false
		end

		return char, Humanoid, RootPart
	end
	
	local function GetClosestPlayer()
		local closestPlayer = nil
		local shortestDistance = math.huge
		local mouseLocation = UserInputService:GetMouseLocation()

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid.Health > 0 then
					local head = player.Character.Head
					local screenPoint, onScreen = Camera:WorldToViewportPoint(head.Position)

					if onScreen then
						local screenPos = Vector2.new(screenPoint.X, screenPoint.Y)
						local distance = (screenPos - mouseLocation).Magnitude

						-- O raio máximo é o valor do Fov definido na tabela Global
						local maxFov = Global.values.Fov or 100

						if distance < shortestDistance and distance <= maxFov then
							shortestDistance = distance
							closestPlayer = player
						end
					end
				end
			end
		end

		return closestPlayer
	end
	
	local function GetPlayerThumbnail(userId, thumbnailType, thumbnailSize)
		local type = thumbnailType or Enum.ThumbnailType.HeadShot
		local size = thumbnailSize or Enum.ThumbnailSize.Size420x420

		local success, content = pcall(function()
			return Players:GetUserThumbnailAsync(userId, type, size)
		end)

		if success then
			return content -- Retorna a URL (string) da imagem
		else
			warn("Erro ao buscar a imagem do player:", content)
			return false
		end
	end
	
	local function SpectatePlayer(targetChar)
		if targetChar then
			local humanoid = targetChar:FindFirstChildOfClass("Humanoid")
			if humanoid then
				Camera.CameraSubject = humanoid -- O Humanoid garante que a câmera siga perfeitamente
			end
		end
	end

	local function UnSpectate()
		local _, localHumanoid = GetChar()
		if localHumanoid then
			Camera.CameraSubject = localHumanoid
		end
	end
	
	return {
		GetChar = GetChar,
		GetClosestPlayer = GetClosestPlayer,
		GetPlayerThumbnail = GetPlayerThumbnail,
		SpectatePlayer = SpectatePlayer,
		UnSpectate = UnSpectate,
	}
end

local Actions = Actionsclass()

local function TpPlayersListPage(Hub, Textbox)
	local Gui = Guiclass()

	local Frame = Gui.CreateUiFrame(Hub.Objs.Screngui,UDim2.fromOffset(0, 0,0, 0), UDim2.fromScale(1, 1))
	Frame.ZIndex = 5
	Frame.BackgroundTransparency = 0.65
	Frame.Visible = false
	Gui.CreateList(Frame, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Center, true, Enum.SortOrder.Name, Enum.FillDirection.Vertical, UDim.new(0.1,0))

	-- Função interna para realizar o teletransporte
	local function TeleportToPlayer(targetPlayer)
		local localChar, _, localRoot = Actions.GetChar()
		local targetChar, _, targetRoot = Actions.GetChar(targetPlayer.Name)

		if localRoot and targetRoot then
			if Global.bools.TweenTP then
				-- Teletransporte suave usando Tween (TweenTP ativado)
				local distance = (localRoot.Position - targetRoot.Position).Magnitude
				local speed = Global.values.TweenSpeed
				local timeTaken = distance / speed

				local tweenInfo = TweenInfo.new(timeTaken, Enum.EasingStyle.Linear)
				local tween = TweenService:Create(localRoot, tweenInfo, {CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)})
				tween:Play()
			else
				-- Teletransporte instantâneo (TweenTP desativado)
				localRoot.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
			end
		end
	end

	local function CreatePlayer(player)
		if not player or not player.UserId then return end

		local success, Img = pcall(function()
			return Actions.GetPlayerThumbnail(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		end)

		if not success or not Img then
			return 
		end

		local btn = Instance.new("ImageButton")
		btn.Size = UDim2.new(0.063, 0,0.111, 0)
		btn.Position = UDim2.fromOffset(0,0)
		btn.Image = Img
		btn.Name = player.DisplayName
		btn.BackgroundTransparency = 1
		btn.ZIndex = 6
		btn.Parent = Frame
		
		Gui.CreateUiBorder(btn, UDim.new(1,0))
		Gui.CreateUiStroke(btn, 0.05)

		-- Evento de clique no botão do player
		if btn and btn.Activated then
			btn.Activated:Connect(function()
				Textbox.Text = player.DisplayName
			end)
		end

		return btn, player.DisplayName
	end

	local function RemovePlayer(player)
		local btn = Frame:FindFirstChild(player.DisplayName)
		if btn then
			btn.Destroy()
		end	
	end

	return {
		Frame = Frame,
		Create_Player = CreatePlayer,
		Remove_Player = RemovePlayer,
		TeleportToPlayer = TeleportToPlayer
	}
end

local function main()	
	local Hub = CreateScrengui()
	
	local localPlayerPage = Hub.Actions.page("Local")
	local PlayerPage = Hub.Actions.page("Player")
	local FpsPage = Hub.Actions.page("FPS Cheat")
	local MiscPage = Hub.Actions.page("Misc")
	
	Hub.Actions.OpenPage("Local")
	
	localPlayerPage.Create_Description("Speed")
	localPlayerPage.Create_ButtonInput("Speed", "Speed")
	localPlayerPage.Create_Slider("Speed", 0, 300, 16, "Speed")
	localPlayerPage.Create_ButtonInput("Pulo Infinito", "InfJump")
	localPlayerPage.Create_ButtonInput("NoClip", "NoClip")
	localPlayerPage.Create_Description("Fly")
	localPlayerPage.Create_ButtonInput("Fly", "Fly")
	localPlayerPage.Create_Slider("Fly Speed", 0, 500, 50, "FlySpeed")
	
	local Player_name = PlayerPage.Create_InputText("Player Name")
	local TPListOpen = PlayerPage.Create_OneShotbtn("Open Player List")
	PlayerPage.Create_Description("Teleport")
	local Tpbtn = PlayerPage.Create_OneShotbtn("Teleport")
	PlayerPage.Create_Slider("TweenSpeed", 100, 1000, 300, "TweenSpeed")
	PlayerPage.Create_ButtonInput("TweenTp", "TweenTP")
	local EspectrebtnPlayerPage = PlayerPage.Create_ButtonInput("Espectador", "Espectre")
	
	FpsPage.Create_Description("Aimbot")
	FpsPage.Create_ButtonInput("Aimbot", "Aimbot")
	FpsPage.Create_Slider("Fov", 30, 500, 70, "Fov")
	FpsPage.Create_Slider("Smoothness", 10, 70, 20, "AimSmoothness")
	FpsPage.Create_ButtonInput("Esp", "Esp")
	FpsPage.Create_ButtonInput("Expansive Hitbox", "ExpansiveHitbox")
	FpsPage.Create_Slider("Hitbox Size", 5, 150, 50, "HitboxSize")
	FpsPage.Create_Description("Esp and Box Color")
	local enemycharcolor = FpsPage.Create_InputText("255,0,0")
	FpsPage.Create_ButtonInput("Auto Spin", "AutoSpin")
	FpsPage.Create_Slider("Auto Spin Speed", 1, 500, 50, "AutoSpinSpeed")
	
	MiscPage.Create_Description("BackgroudColor")
	local BgColorInput = MiscPage.Create_InputText("15,15,15")
	MiscPage.Create_Slider("Backgroud Transparency", 20, 70, 50, "BackTransparancy")
	local SaveDatabtn = MiscPage.Create_OneShotbtn("Save Data")
	
	local PlayersListPage = TpPlayersListPage(Hub, Player_name)
	
	local FovFrame = Gui.CreateUiFrame(Hub.Objs.Screngui, UDim2.fromScale(0.5,0.5), UDim2.new(0,0))
	FovFrame.AnchorPoint = Vector2.new(0.5,0.5)
	FovFrame.ZIndex = -2
	
	Gui.CreateUiStroke(FovFrame, 0.05)
	Gui.CreateUiBorder(FovFrame, UDim.new(1,0))

	-- Loop 1: RenderStepped (Para físicas e updates por frame: Speed, NoClip, Fly)
	RunService.RenderStepped:Connect(function(dt)
		local trys = 0

		-- Leitura dinâmica da cor inserida no InputText (ex: "255,0,0")
		local customColor = Color3.new(1, 0, 0)
		if enemycharcolor and enemycharcolor.Text then
			local r, g, b = enemycharcolor.Text:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
			if r and g and b then
				customColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
			end
		end

		if Global.bools.Aimbot then
			local target = Actions.GetClosestPlayer()
			if target and target.Character and target.Character:FindFirstChild("Head") then
				local targetPos = target.Character.Head.Position
				local current = Camera.CFrame.Position

				local newCF = CFrame.new(current, targetPos)
				Camera.CFrame = Camera.CFrame:Lerp(newCF, Global.values.AimSmoothness / 100)
			end
		end

		if FovFrame and Global.bools.Aimbot then
			local fovSize = (Global.values.Fov or 70) * 2
			FovFrame.Size = UDim2.fromOffset(fovSize, fovSize)
			FovFrame.Visible = true
		else
			FovFrame.Visible = false
		end

		-- NOCLIP
		if Global.bools.NoClip and LocalPlayer.Character then
			for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end

		local Character, Humanoid, RootPart = Actions.GetChar()

		if Character and Humanoid then
			Humanoid.UseJumpPower = true

			if Global.bools.Speed then
				Humanoid.WalkSpeed = Global.values.Speed or 16
			else
				Humanoid.WalkSpeed = 16
			end

			if Global.bools.InfJump then
				Humanoid.JumpPower = Global.values.JumpPower or 50
			else
				Humanoid.JumpPower = 50
			end
		end

		-- Spin
		if Global.bools.AutoSpin and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			RootPart.CFrame *= CFrame.Angles(0, math.rad(Global.values.AutoSpinSpeed), 0)
		end

		-- EXPANSIVE HITBOX & ESP
		for _, p in pairs(Players:GetPlayers()) do
			local pchar, phumanoid, prootpath = Actions.GetChar(p.Name)

			if not pchar then
				trys += 1
				if trys >= 3 then
					break
				end
				continue 
			end

			if p ~= LocalPlayer and pchar and prootpath then
				-- 1. Expansive Hitbox (Aumenta o tamanho da hitbox dos inimigos)
				if Global.bools.ExpansiveHitbox then
					prootpath.Size = Vector3.new(Global.values.HitboxSize or 20, Global.values.HitboxSize or 20, Global.values.HitboxSize or 20)
					prootpath.Transparency = 0.75 -- Deixa semi-transparente para ver a hitbox
					prootpath.CanCollide = false
				else
					prootpath.Size = Vector3.new(2, 2, 1) -- Tamanho padrão do Roblox
					prootpath.Transparency = 1
				end

				-- 2. ESP com atualização de cor dinâmica baseada no InputText
				local esp1, esp2
				if pchar.Head:FindFirstChild("ESP") or prootpath:FindFirstChild("ESP") then
					esp1 = pchar.Head:FindFirstChild("ESP")
					esp2 = prootpath:FindFirstChild("ESP")
				end

				if Global.bools.Esp then
					if not pchar.Head:FindFirstChild("ESP") and not prootpath:FindFirstChild("ESP") then
						local bill = Instance.new("BillboardGui", p.Character.Head)
						bill.Name = "ESP"
						bill.Size = UDim2.new(8,0,1,0)
						bill.AlwaysOnTop = true

						local txt = Instance.new("TextLabel", bill)
						txt.Size = UDim2.new(1,0,1,0)
						txt.Text = p.Name
						txt.TextColor3 = customColor
						txt.BackgroundTransparency = 1

						local bill2 = Instance.new("BillboardGui", p.Character.HumanoidRootPart)
						bill2.Name = "ESP"
						bill2.Size = UDim2.new(3,0,4,0)
						bill2.AlwaysOnTop = true

						local FrameESP = Instance.new("Frame", bill2)
						FrameESP.Size = UDim2.new(1,0,1,0)
						FrameESP.BackgroundTransparency = 0.75
						FrameESP.BackgroundColor3 = customColor
						FrameESP.Name = "ESP"
					else
						if esp1 then 
							esp1.Enabled = true 
							local txt = esp1:FindFirstChildOfClass("TextLabel")
							if txt then txt.TextColor3 = customColor end
						end
						if esp2 then 
							esp2.Enabled = true 
							local frameComp = esp2:FindFirstChildOfClass("Frame")
							if frameComp then frameComp.BackgroundColor3 = customColor end
						end
					end
				else
					if esp1 then esp1.Enabled = false end
					if esp2 then esp2.Enabled = false end
				end
			end
		end
		
		local CustomColorBackgroud = Color3.new(15,15,15)
		if BgColorInput and BgColorInput.Text then
			local r, g, b = BgColorInput.Text:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
			if r and g and b then
				CustomColorBackgroud = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
			end
		end

		Hub.Objs.Window.BackgroundColor3 = CustomColorBackgroud
		Hub.Objs.Window.BackgroundTransparency = Global.values.BackTransparancy / 100
	end)
	
	-- Loop 2: Heartbeat (Para lógica de tempo: Esp, Aimbot, Auto Spin)
	RunService.Heartbeat:Connect(function()
		local char, Humanoid, RootPart = Actions.GetChar()
		
		if Global.bools.Fly then
			if char and RootPart then

				if not RootPart:FindFirstChild("FlyVelocity") then
					local bv = Instance.new("BodyVelocity", RootPart)
					bv.Name = "FlyVelocity"
					bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

					local bg = Instance.new("BodyGyro", RootPart)
					bg.Name = "FlyGyro"
					bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				end

				local bv = RootPart:FindFirstChild("FlyVelocity")
				local bg = RootPart:FindFirstChild("FlyGyro")

				if bv and bg then
					local moveDir = Humanoid.MoveDirection
					local flyVel = moveDir * Global.values.FlySpeed

					if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
						flyVel += Vector3.new(0, Global.values.FlySpeed, 0)
					elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
						flyVel += Vector3.new(0, -Global.values.FlySpeed, 0)
					end

					bv.Velocity = flyVel
					bg.CFrame = Camera.CFrame
				end
			end
		else
			if char and RootPart then
				local bv = RootPart:FindFirstChild("FlyVelocity")
				local bg = RootPart:FindFirstChild("FlyGyro")

				if bv then bv:Destroy() end
				if bg then bg:Destroy() end
			end
		end
	end)

	-- Loop 3: Evento separado para entradas de ações pontuais (Ex: Pulo Infinito)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if input.KeyCode == Enum.KeyCode.J then
			Hub.Actions.update_visible()
		end
		
		if input.KeyCode == Enum.KeyCode.K then
			PlayersListPage.Frame.Visible = not PlayersListPage.Frame.Visible
		end
	end)
	
	UserInputService.JumpRequest:Connect(function()
		local char, Humanoid = Actions.GetChar()
		if Global.bools.InfJump and char and Humanoid then
			Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
	
	local dragging, dragStart, startPos

	Hub.Objs.TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = Hub.Objs.Window.Position
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			Hub.Objs.Window.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	Hub.Objs.Minibutton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Global.DragData.draggingMini = true
			Global.DragData.dragStartMini = UserInputService:GetMouseLocation()
			Global.DragData.startPosMini = Hub.Objs.Minibutton.Position
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Global.DragData.draggingMini = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if Global.DragData.draggingMini and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local mousePos = UserInputService:GetMouseLocation()
			local delta = mousePos - Global.DragData.dragStartMini

			Hub.Objs.Minibutton.Position = UDim2.new(
				0,
				Global.DragData.startPosMini.X.Offset + delta.X,
				0,
				Global.DragData.startPosMini.Y.Offset + delta.Y
			)
		end
	end)
	
	Players.PlayerAdded:Connect(function(player)
		PlayersListPage.Create_Player(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		PlayersListPage.Remove_Player(player)
	end)

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= game.Players.LocalPlayer then
			PlayersListPage.Create_Player(player)
		end
	end
	
	if TPListOpen.Activated then
		TPListOpen.Activated:Connect(function()
			PlayersListPage.Frame.Visible = true
		end)
	end

	if Tpbtn.Activated then
		Tpbtn.Activated:Connect(function()
			if Tpbtn and Tpbtn.Activated then
				Tpbtn.Activated:Connect(function()
					local targetName = Player_name.Text
					local targetPlayer = Players:FindFirstChild(targetName)

					if targetPlayer then
						PlayersListPage.TeleportToPlayer(targetPlayer)
					else
						warn("Jogador não encontrado: " .. tostring(targetName))
					end
				end)
			end
		end)
	end
	
	if EspectrebtnPlayerPage and EspectrebtnPlayerPage.Activated then
		EspectrebtnPlayerPage.Activated:Connect(function()
			task.wait(0.1)
			if Global.bools.Espectre then
				-- Pega apenas o primeiro retorno do GetChar (o Character)
				local targetChar, _, _ = Actions.GetChar(Player_name.Text)
				if targetChar then
					Actions.SpectatePlayer(targetChar)
				else
					warn("Não foi possível encontrar o personagem para assistir.")
				end
			else
				Actions.UnSpectate()
			end
		end)
	end
	
	if SaveDatabtn and SaveDatabtn.Activated then
		SaveDatabtn.Activated:Connect(function()
			SaveConfig()
		end)
	end
	
	task.spawn(function()
		while true do
			SaveConfig()
			task.wait(90)
		end
	end)
end

if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("Dimitrof04ScriptRenew") then
	main()
end
