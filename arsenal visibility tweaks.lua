local transparency_value = 0.6
local arm_transparency_value = 0.8
local damage_indicator_transparency = 0.9
local critical_hit_transparency = 0.9
local teammate_nametag_transparency = 0.8
local remove_crosshair_dot = true
local make_nametags_invisible = false
local gun_material = "ForceField"  -- if material is set to "None", no material will be set. refer to https://developer.roblox.com/en-us/api-reference/enum/Material for a list of materials.
local arm_material = "None"

local camera = game.Workspace.CurrentCamera
local player_gui = game.Players.LocalPlayer.PlayerGui
local runservice = game:GetService("RunService")


runservice.Heartbeat:Connect(function(dothings)
    local a = camera:FindFirstChild("Arms")
    local b = player_gui
    if a then
        for z,v in pairs(a:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency ~= 1 then
                v.Transparency = transparency_value
            if gun_material ~= "None" then
                v.Material = gun_material
            end
            end
            if v:IsA("Decal") then
                v.Transparency = transparency_value
            end
        end
        if a:FindFirstChild("HumanoidRootPart") and a.HumanoidRootPart.Transparency < 1 then
            a.HumanoidRootPart.Transparency = 1
        end
        for i,x in pairs(game.Workspace.Camera.Arms.CSSArms:GetDescendants()) do
            if x:IsA("BasePart") then
                x.Transparency = arm_transparency_value
            if arm_material ~= "None" then
                x.Material = arm_material
            end
            end
        end
    end
    for l,k in pairs(player_gui:GetChildren()) do
        if k:IsA("BillboardGui") then
            k.TextButton.TextTransparency = damage_indicator_transparency
            k.TextButton.TextStrokeTransparency = damage_indicator_transparency
            k.Crit.TextTransparency = critical_hit_transparency
            k.Crit.TextStrokeTransparency = critical_hit_transparency
		    --and for good measure, include mini crits. i don't know if they even exist in arsenal, but i'm counting them as criticals.
		    k.MCrit.TextTransparency = critical_hit_transparency
		    k.MCrit.TextStrokeTransparency = critical_hit_transparency
        end
    end
end)

runservice.RenderStepped:Connect(function(dootherthings)
    if make_nametags_invisible == true then
        for p,o in pairs(player_gui.Nametags:GetChildren()) do
            o.plrname.TextTransparency = teammate_nametag_transparency
            o.plrname.TextStrokeTransparency = teammate_nametag_transparency
            o.TextLabel.TextTransparency = teammate_nametag_transparency
            o.TextLabel.TextStrokeTransparency = teammate_nametag_transparency
        end
    end
end)
    
if remove_crosshair_dot == true then
    player_gui.GUI.Crosshairs.Crosshair.Dot.Transparency = 1
end