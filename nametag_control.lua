-- Information
local __author__ = "bardockz"
local __name__ = "Nametag Control"
local __version__ = "1.0"

-- Dependencies
local mem = require "memory"
local ffi = require "ffi"

-- Globals
local originalSettings = {
    distance = nil,
    render = nil,
}

local hideTags = false
local getBonePosition = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)
local renderFont = renderCreateFont("Arial", 10, 0x1 + 0x4)

-- Functions
function getBodyPartCoordinates(id, handle)
    local pedptr = getCharPointer(handle)
    local vec = ffi.new("float[3]")
    getBonePosition(ffi.cast("void*", pedptr), vec, id, true)
    return vec[0], vec[1], vec[2]
end

function drawCustomTags()
    local px, py, pz = getCharCoordinates(PLAYER_PED)
    local _, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local myColor = sampGetPlayerColor(myId)

    for i = 0, sampGetMaxPlayerId() do
        local result, ped = sampGetCharHandleBySampPlayerId(i)

        if result and doesCharExist(ped) then
            local x, y, z = getBodyPartCoordinates(8, ped)
            local dist = getDistanceBetweenCoords3d(px, py, pz, x, y, z)

            -- distance check
            if originalSettings.distance ~= nil and dist > originalSettings.distance then
                goto continue
            end

            -- visibility / wall check
            local camX, camY, camZ = getActiveCameraCoordinates()
            local blocked =
                processLineOfSight(
                    camX, camY, camZ,
                    x, y, z,
                    true,
                    false,
                    false,
                    true,
                    false,
                    false,
                    false,
                    true
                )
            if blocked then
                goto continue
            end

            if isCharOnScreen(ped) then
                local sx, sy = convert3DCoordsToScreen(x, y, z + 0.4 + (dist * 0.05))

                local name = sampGetPlayerNickname(i)
                local text = string.format("%s (%d)", name, i)

                -- Ensure players without target color are skipped
                local color = sampGetPlayerColor(i)
                if color == myColor then
                    goto continue
                end

                -- Name tag
                renderFontDrawText(renderFont, text, sx - renderGetFontDrawTextLength(renderFont, text) / 2, sy, color)

                local armor = sampGetPlayerArmor(i)
                local armorY = sy + renderGetFontDrawHeight(renderFont) + 4
                local hpY = armorY

                -- Armor bar
                if armor > 1 then
                    renderDrawBoxWithBorder(sx - 24, armorY, 50, 6, 0xFF000000, 1, 0xFF000000)
                    armor = math.max(0, math.min(armor, 100))
                    renderDrawBoxWithBorder(sx - 24, armorY, armor / 2, 6, 0xFFFFFFFF, 1, 0x00000000)
                    hpY = armorY + 8
                end

                -- Health bar
                local hp = sampGetPlayerHealth(i)

                renderDrawBoxWithBorder(sx - 24, hpY, 50, 6, 0xFF000000, 1, 0xFF000000)
                hp = math.max(0, math.min(hp, 100))
                renderDrawBoxWithBorder(sx - 24, hpY, hp / 2, 6, 0xFFFF0000, 1, 0x00000000)

            end
        end
        ::continue::
    end
end

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then 
        return 
    end

    while not isSampAvailable() do
         wait(100) 
    end

    local ip, port = sampGetCurrentServerAddress()
    if ip ~= "94.23.145.137" and tonumber(port) ~= 7776 then
        return
    end

	sampAddChatMessage(string.format("[UIF] {D2D2D2}%s v%s by %s loaded.", __name__, __version__, __author__), 0xFFFF9900)

    sampRegisterChatCommand("toggletags", function()
        hideTags = not hideTags
        local pStSet = sampGetServerSettingsPtr()

        if pStSet ~= 0 then
            if hideTags then
                originalSettings.distance = mem.getfloat(pStSet + 39, true)
                originalSettings.render = mem.getfloat(pStSet + 56, true)
                mem.setfloat(pStSet + 39, 0.0, true)
                mem.setfloat(pStSet + 56, 0.0, true)
                sampAddChatMessage("[Nametag Control] {D2D2D2}Team nametags are now hidden.", 0xFFFF9900)
            else
                if originalSettings.distance ~= nil then
                    mem.setfloat(pStSet + 39, originalSettings.distance, true)
                    mem.setfloat(pStSet + 56, originalSettings.render, true)
                end
                sampAddChatMessage("[Nametag Control] {D2D2D2}Team nametags are now visible.", 0xFFFF9900)
            end
        end
    end)

    while true do
        wait(0)
        if hideTags then
            drawCustomTags()
        end
    end
end