-- ==============================================================================
-- PROJECT JAINA: CARBONITE P2P CHANNEL SILENCER (ANTI-LEAK MODULE)
-- ==============================================================================
-- Suprime el volcado de paquetes hexadecimales (S# ...) y los avisos de entrada/
-- salida de canales Crb* en ChatFrame1..ChatFrame7 sin afectar la telemetría interna.
--
-- Autor: Project Jaina Staff (Mythos 5)
-- Ecosistema: World of Warcraft 3.3.5a (Build 12340)
-- ==============================================================================

local function IsCarbonitePayload(msg, channelName)
    if channelName and (channelName:find("^[Cc]rb") or channelName:find("^crbb")) then
        return true
    end
    if msg and (msg:find("^S# %x+") or msg:find("^V# ") or msg:find("^N# ")) then
        return true
    end
    return false
end

-- 1. Filtro de mensajes de texto en canales (Elimina [6. CrbZ...] [Jugador]: S# ...)
local function CarboniteChannelMessageFilter(self, event, msg, author, lang, channelString, target, flags, zoneId, channelNumber, channelName, ...)
    if IsCarbonitePayload(msg, channelName or channelString) then
        return true -- Descarte total: no se imprime en el chat
    end
    return false, msg, author, lang, channelString, target, flags, zoneId, channelNumber, channelName, ...
end

-- 2. Filtro de avisos de sistema (Elimina "Te has unido al canal" / "Abandonas el canal")
local function CarboniteNoticeFilter(self, event, noticeType, _, _, _, _, _, _, _, channelName, ...)
    if channelName and (channelName:find("^[Cc]rb") or channelName:find("^crbb")) then
        return true -- Descarte silencioso de notificaciones
    end
    return false, noticeType, _, _, _, _, _, _, _, _, channelName, ...
end

-- Registrar filtros de eventos en la UI de Blizzard
if ChatFrame_AddMessageEventFilter then
    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", CarboniteChannelMessageFilter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_JOIN", CarboniteNoticeFilter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_LEAVE", CarboniteNoticeFilter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", CarboniteNoticeFilter)
    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE_USER", CarboniteNoticeFilter)
end

-- 3. Vigilante en tiempo real: expulsa los canales Crb* del renderizado de ChatFrame1..7
local cleanerFrame = CreateFrame("Frame")
cleanerFrame:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
cleanerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

cleanerFrame:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    local targetChannel = arg9 or arg2
    if targetChannel and (tostring(targetChannel):find("^[Cc]rb") or tostring(targetChannel):find("^crbb")) then
        for i = 1, (NUM_CHAT_WINDOWS or 7) do
            local cf = _G["ChatFrame" .. i]
            if cf and cf.channelList then
                for idx, cName in ipairs(cf.channelList) do
                    if cName and (cName:find("^[Cc]rb") or cName:find("^crbb")) then
                        ChatFrame_RemoveChannel(cf, cName)
                    end
                end
            end
        end
    end
end)
