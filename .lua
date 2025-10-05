local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local boxColor = Color3.fromRGB(255, 0, 0)
local outlineColor = Color3.fromRGB(255, 0, 0)
local showHitboxes = true
local guiVisible = true
local function highlightHitbox(part)
	if not showHitboxes then return end
	if not part:FindFirstChild("HitboxHighlight") then
		local box = Instance.new("BoxHandleAdornment")
		box.Name = "HitboxHighlight"
		box.Size = part.Size
		box.Adornee = part
		box.AlwaysOnTop = true
		box.ZIndex = 10
		box.Color3 = boxColor
		box.Transparency = 0.85
		box.Parent = part
	else
		part.HitboxHighlight.Color3 = boxColor
	end
	if not part:FindFirstChild("HitboxOutline") then
		local outline = Instance.new("SelectionBox")
		outline.Name = "HitboxOutline"
		outline.Adornee = part
		outline.LineThickness = 0.05
		outline.SurfaceTransparency = 1
		outline.Color3 = outlineColor
		outline.Parent = part
	else
		part.HitboxOutline.Color3 = outlineColor
	end
end
local function removeHitboxes()
	for _, player in pairs(Players:GetPlayers()) do
		if player.Character then
			local hitbox = player.Character:FindFirstChild("HumanoidRootPart")
			if hitbox then
				if hitbox:FindFirstChild("HitboxHighlight") then
					hitbox.HitboxHighlight:Destroy()
				end
				if hitbox:FindFirstChild("HitboxOutline") then
					hitbox.HitboxOutline:Destroy()
				end
			end
		end
	end
end
RunService.RenderStepped:Connect(function()
	if showHitboxes then
		for _, player in pairs(Players:GetPlayers()) do
			if player.Character then
				local hitbox = player.Character:FindFirstChild("HumanoidRootPart")
				if hitbox then
					highlightHitbox(hitbox)
				end
			end
		end
	end
end)
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "HitboxGui"
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundTransparency = 0.3
frame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
frame.Active = true
local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundTransparency = 0.4
topBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
local dragBtn = Instance.new("TextButton", topBar)
dragBtn.Text = "Drag"
dragBtn.Size = UDim2.new(0, 50, 1, 0)
dragBtn.Position = UDim2.new(0, 0, 0, 0)
dragBtn.BackgroundTransparency = 1
dragBtn.TextColor3 = Color3.new(1, 1, 1)
dragBtn.Font = Enum.Font.SourceSansBold
dragBtn.TextSize = 16
dragBtn.AutoButtonColor = false
dragBtn.Active = true
local title = Instance.new("TextLabel", topBar)
title.Text = "Hitbox Viewer"
title.Size = UDim2.new(0, 160, 1, 0)
title.Position = UDim2.new(0.5, -80, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Center
local minimizeBtn = Instance.new("TextButton", topBar)
minimizeBtn.Text = "-"
minimizeBtn.Size = UDim2.new(0, 30, 1, 0)
minimizeBtn.Position = UDim2.new(1, -65, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 18
local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Text = "×"
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
local bottom = Instance.new("Frame", frame)
bottom.Size = UDim2.new(1, 0, 1, -40)
bottom.Position = UDim2.new(0, 0, 0, 40)
bottom.BackgroundTransparency = 0.4
bottom.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
local boxLabel = Instance.new("TextLabel", bottom)
boxLabel.Text = "Colore Hitbox"
boxLabel.Size = UDim2.new(1, -20, 0, 20)
boxLabel.Position = UDim2.new(0, 10, 0, 10)
boxLabel.BackgroundTransparency = 1
boxLabel.TextColor3 = Color3.new(1, 1, 1)
local outlineLabel = Instance.new("TextLabel", bottom)
outlineLabel.Text = "Contorno Hitbox"
outlineLabel.Size = UDim2.new(1, -20, 0, 20)
outlineLabel.Position = UDim2.new(0, 10, 0, 80)
outlineLabel.BackgroundTransparency = 1
outlineLabel.TextColor3 = Color3.new(1, 1, 1)
local palette = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 0, 255),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(0, 0, 0)
}
for i, color in ipairs(palette) do
	local boxBtn = Instance.new("TextButton", bottom)
	boxBtn.Size = UDim2.new(0, 30, 0, 30)
	boxBtn.Position = UDim2.new(0, 10 + (i - 1) * 35, 0, 35)
	boxBtn.BackgroundColor3 = color
	boxBtn.Text = ""
	boxBtn.MouseButton1Click:Connect(function()
		boxColor = color
	end)
	local outlineBtn = Instance.new("TextButton", bottom)
	outlineBtn.Size = UDim2.new(0, 30, 0, 30)
	outlineBtn.Position = UDim2.new(0, 10 + (i - 1) * 35, 0, 105)
	outlineBtn.BackgroundColor3 = color
	outlineBtn.Text = ""
	outlineBtn.MouseButton1Click:Connect(function()
		outlineColor = color
	end)
end
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		frame.Size = UDim2.new(0, 300, 0, 50)
		bottom.Visible = false
	else
		frame.Size = UDim2.new(0, 300, 0, 200)
		bottom.Visible = true
	end
end)
closeBtn.MouseButton1Click:Connect(function()
	showHitboxes = false
	guiVisible = false
	frame.Visible = false
	removeHitboxes()
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.H then
		showHitboxes = true
		guiVisible = true
		frame.Visible = true
	end
end)
local dragging = false
local dragInput, dragStart, startPos
local function update(input)
	if not dragging then return end
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end
dragBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or
	   input.UserInputType == Enum.UserInputType.Touch or
	   input.UserInputType == Enum.UserInputType.Pen then
		dragging = true
		dragInput = input
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
dragBtn.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or
	   input.UserInputType == Enum.UserInputType.Touch or
	   input.UserInputType == Enum.UserInputType.Pen then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
