local transparency_value = 0.6
local arm_transparency_value = 0.8
local damage_indicator_transparency = 0.9
local critical_hit_transparency = 0.9
local teammate_nametag_transparency = 0.8
local remove_crosshair_dot = true
local make_nametags_invisible = false
local gun_material = "ForceField"  -- if material is set to "None", no material will be set. refer to https://developer.roblox.com/en-us/api-reference/enum/Material for a list of materials.
local arm_material = "None"

-- ignore this. used to separate the arms and cssarms
local blacklist = {
    ["Left Arm"] = true;
    ["Right Arm"] = true;
}

local camera = game.Workspace.CurrentCamera
local player_gui = game.Players.LocalPlayer.PlayerGui
local runservice = game:GetService("RunService")

runservice.Heartbeat:Connect(function(viewmodel_edit)
    local arms = camera:FindFirstChild("Arms")
    if arms then
        for i,v in pairs(arms:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency ~= 1 and not blacklist[v.Name] then
                v.Transparency = transparency_value
            if gun_material ~= "None" then
                v.Material = gun_material
            if v:IsA("Decal") then
                v.Transparency = transparency_value
            end
            end
            end
        end
        for r,e in pairs(arms.CSSArms:GetDescendants()) do
            if e:IsA("BasePart") then
                e.Transparency = arm_transparency_value
            if arm_material ~= "None" then
                e.Material = arm_material
            end
            end
        end
    end
end)

runservice.Heartbeat:Connect(function(damage_indicators)
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

runservice.Heartbeat:Connect(function(invisible_nametags)
    if make_nametags_invisible == true then
        for p,o in pairs(player_gui.Nametags:GetChildren()) do
            o.plrname.TextTransparency = teammate_nametag_transparency
            o.plrname.TextStrokeTransparency = teammate_nametag_transparency
            o.TextLabel.TextTransparency = teammate_nametag_transparency
            o.TextLabel.TextStrokeTransparency = teammate_nametag_transparency
        end
    end
end)

-- patch the humanoidrootpart being visible for some weapons.

runservice.Heartbeat:Connect(function(humanoidrootpart_patch)
    local arms = camera:FindFirstChild("Arms")
    if arms:FindFirstChild("HumanoidRootPart") and arms.HumanoidRootPart.Transparency < 1 then
        arms.HumanoidRootPart.Transparency = 1
    end
end)

if remove_crosshair_dot == true then
    player_gui.GUI.Crosshairs.Crosshair.Dot.Transparency = 1
end