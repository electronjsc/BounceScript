require "lib.moonloader"
local mem = require "memory"
local encoding = require "encoding"
local key = require 'vkeys'
local ev = require "lib.samp.events"
local inicfg = require 'inicfg'
local imgui = require 'mimgui'
local ffi = require "ffi"
local dlstatus = require('moonloader').download_status
local getBonePosition = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)
---------------------------------------------------

---------------------------------------------------
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
script_name('Bounce Script (DevOps)')
script_author('electron.js')
script_version('BounceDev01.16')
update_state = false
---------------------------------------------------

local sw, sh = getScreenResolution()

ffi.cdef
[[
    void *malloc(size_t size);
    void free(void *ptr);
]]

local cfg = inicfg.load({
    config = { 
        POSX = 40.0,
        POSY = 104.0,
        WIDTH = 94.0,
        HEIGHT = 76.0,
        RADARRECT = false,
    }
}, "[Bounce Script (DevOps)].ini")


local new = imgui.new
local newFrame = new.bool(false)

local Width = imgui.new.float(cfg.config.WIDTH)
local Height = imgui.new.float(cfg.config.HEIGHT)
local X = imgui.new.float(cfg.config.POSX)
local Y = imgui.new.float(cfg.config.POSY)

----------------------------------------------------


function main()
	
	repeat wait(0) until isSampAvailable()
	--repeat wait(0) until checkip()
	sampAddChatMessage("{7044EE}[Bounce Script (DevOps)]: {2DA440}Скрипт успешно загружен! {EDEFE0}Ожидаем подключения на сервер...", -1)
	repeat wait(0) until sampGetGamestate() == 3
	sampAddChatMessage("{7044EE}[Bounce Script (DevOps)]: {2DA440}Подключены. {C1973F}Авторы: electron.js. {EDEFE0}Активация автоматическая.", -1)
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				update_state = true
			end
			os.remove(update_path)
		end
	end)
    
    ffi.cdef([[
        typedef struct {
            const char* state;
            const char* details;
            int64_t startTimestamp;
            int64_t endTimestamp;
            const char* largeImageKey;
            const char* largeImageText;
            const char* smallImageKey;
            const char* smallImageText;
            const char* partyId;
            const char* button1_label; 
            const char* button1_url;
            const char* button2_label;
            const char* button2_url;
            int partySize;
            int partyMax;
            const char* matchSecret;
            const char* joinSecret;
            const char* spectateSecret;
            int8_t instance;
        } DiscordRichPresence;
    
        void Discord_Initialize(const char* applicationId,
            int handlers,
            int autoRegister,
            const char* optionalSteamId);
    
        void Discord_UpdatePresence(const DiscordRichPresence* presence);
    
        typedef struct {
            int type;
            int state;
            int ammoInClip;
            int totalAmmo;
            char field_10[0x0C];
        } CWeapon;
    
        typedef struct {
            char field_0[0x544];
            float maxHealth;
            char field_548[0x58];
            CWeapon weapons[13];
        } CPed;
    ]])
    
    sampRegisterChatCommand("bouncedev", function()
        newFrame[0] = not newFrame[0]
    end)

    local RadarX = ffi.new('float[1]')
    local RadarY = ffi.new('float[1]')
    local RadarH = ffi.new('float[1]')
    local RadarW = ffi.new('float[1]')

    local drpc = ffi.load("moonloader/lib/discord-rpc.dll")
    local rpc = ffi.new("DiscordRichPresence")

    drpc.Discord_Initialize("1085603430103519292", 0, 0, "")
	
	repeat
		wait(0)
	until isPlayerPlaying(playerHandle)
	
	rpc.startTimestamp = os.time()
	
	local stat = getIntStat(121)
	local time = os.time()
	local flag = false
	local samp = 0
	
	if isSampLoaded() then
		if isSampfuncsLoaded() then
			samp = 2
		else
			print("SAMPFUNC требуется для работы в SAMP")
			samp = 1
		end
	end
	
	local cped = ffi.cast("CPed*", getCharPointer(playerPed))

	while true do

        RadarW[0] = cfg.config.WIDTH
        RadarH[0] = cfg.config.HEIGHT
        RadarX[0] = cfg.config.POSX
        RadarY[0] = cfg.config.POSY

        ffi.cast('float**', 0x58A79B)[0] = RadarX
        ffi.cast('float**', 0x5834D4)[0] = RadarX
        ffi.cast('float**', 0x58A836)[0] = RadarX
        ffi.cast('float**', 0x58A8E9)[0] = RadarX
        ffi.cast('float**', 0x58A98A)[0] = RadarX
        ffi.cast('float**', 0x58A469)[0] = RadarX
        ffi.cast('float**', 0x58A5E2)[0] = RadarX
        ffi.cast('float**', 0x58A6E6)[0] = RadarX
        ---
        ffi.cast('float**', 0x58A7C7)[0] = RadarY
        ffi.cast('float**', 0x58A868)[0] = RadarY
        ffi.cast('float**', 0x58A913)[0] = RadarY
        ffi.cast('float**', 0x58A9C7)[0] = RadarY
        ffi.cast('float**', 0x583500)[0] = RadarY
        ffi.cast('float**', 0x58A499)[0] = RadarY
        ffi.cast('float**', 0x58A60E)[0] = RadarY
        ffi.cast('float**', 0x58A71E)[0] = RadarY

        ffi.cast('float**', 0x58A47D)[0] = RadarH
        ffi.cast('float**', 0x58A632)[0] = RadarH 
        ffi.cast('float**', 0x58A6AB)[0] = RadarH 
        ffi.cast('float**', 0x58A70E)[0] = RadarH 
        ffi.cast('float**', 0x58A801)[0] = RadarH 
        ffi.cast('float**', 0x58A8AB)[0] = RadarH 
        ffi.cast('float**', 0x58A921)[0] = RadarH 
        ffi.cast('float**', 0x58A9D5)[0] = RadarH 
        ffi.cast('float**', 0x5834F6)[0] = RadarH 

        ffi.cast('float**', 0x5834C2)[0] = RadarW
        ffi.cast('float**', 0x58A449)[0] = RadarW 
        ffi.cast('float**', 0x58A7E9)[0] = RadarW 
        ffi.cast('float**', 0x58A840)[0] = RadarW 
        ffi.cast('float**', 0x58A943)[0] = RadarW 
        ffi.cast('float**', 0x58A99D)[0] = RadarW 

		rpc.largeImageKey = "bouncedev"

		if flag then
			if samp == 2 then
				local gameState = {
					"u8Не имеет состояния",
					"u8Ожидание подключения",
				    "u8Ожидание спавна",
				    "u8Подключение на сервер",
				    "u8Переподключение",
					"u8Отсоеденение"
				}

				local state = sampGetGamestate()
				
				if state == 3 or state == 4 then
					local ip, port = sampGetCurrentServerAddress()
					rpc.state = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) .. "[" .. select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) .. "]"
				else
					rpc.state = gameState[sampGetGamestate()]
				end
				
				rpc.details = sampGetCurrentServerName()
			end
			
			if os.time() > time + 5 then
				flag = false
				time = os.time()
			end
		else
			local show = false
			
			if samp == 2 then
				local state = sampGetGamestate()
				
				if state == 3 or state == 4 then
					show = true
				end
			else 
				show = true
			end
            
            if show then 
                if sampIsPlayerPaused(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) == true) then                    
                    rpc.state = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) .. "[" .. select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) .. "] | Находится в AFK"
                end
            end
			
			if os.time() > time + 5 then
				flag = true
				time = os.time()
			end
		end

		rpc.largeImageText = string.format("Bounce Project")

        rpc.button1_label = "Bounce Media - VK"
        rpc.button1_url = "https://vk.com/rp_bounce"

        rpc.button2_label = "Bounce Media - Discord"
        rpc.button2_url = "https://discord.gg/5bHmGrdJ2F"

		drpc.Discord_UpdatePresence(rpc)
		wait(150)
	end
end

local newFrame = imgui.OnFrame( 
    function() return newFrame[0] end, 
    function(player)        
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(500, 305), imgui.Cond.FirstUseEver)
        imgui.Begin("[Bounce Script (DevOps)]", newFrame, imgui.WindowFlags.NoResize)
            imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Ширина радара")).x)/2)
            imgui.Text(u8"Ширина радара")
            imgui.PushItemWidth(480)
            if imgui.SliderFloat("##1", Width, 0.0, 300.0) then 
                cfg.config.WIDTH = Width[0] 
                inicfg.save(cfg, '[Bounce Script (DevOps)].ini') 
            end
            imgui.Separator()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Высота радара")).x)/2)
            imgui.Text(u8"Высота радара")
            imgui.PushItemWidth(480)
            if imgui.SliderFloat("##2", Height, 0.0, 300.0) then 
                cfg.config.HEIGHT = Height[0] 
                inicfg.save(cfg, '[Bounce Script (DevOps)].ini') 
            end
            imgui.Separator()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Координаты X")).x)/2)
            imgui.Text(u8"Координаты X")
            imgui.PushItemWidth(480)
            if imgui.SliderFloat("##3", X, 0.0, sw/3) then 
                cfg.config.POSX = X[0] 
                inicfg.save(cfg, '[Bounce Script (DevOps)].ini') 
            end
            imgui.Separator()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Координаты Y")).x)/2)
            imgui.Text(u8"Координаты Y")
            imgui.PushItemWidth(480)
            if imgui.SliderFloat("##4", Y, 0.0, sh/2) then 
                cfg.config.POSY = Y[0]
                inicfg.save(cfg, '[Bounce Script (DevOps)].ini') 
            end
            imgui.Separator()
            imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Остальное")).x)/2)
            imgui.Text(u8"Остальное")
            if imgui.Button(u8"Сбросить настройки!", imgui.ImVec2(480, 20)) then
                sampAddChatMessage("[Bounce Script (DevOps)]: {FFFFFF}Настройки сброшены!", 0x9562DE)
                cfg.config.POSX = 40.0
                cfg.config.POSY = 104.0
                cfg.config.WIDTH = 94.0
                cfg.config.HEIGHT = 76.0
                inicfg.save(cfg, "[Bounce Script (DevOps)].ini")
                local Width = imgui.new.float(94.0)
                local Height = imgui.new.float(76.0)
                local X = imgui.new.float(40.0)
                local Y = imgui.new.float(76.0)
            end
        imgui.End()                
    end
)

function ev.onSendClientJoin(version, mod, nickname, challengeResponse, joinAuthKey, clientVer, challengeResponse2) 
    clientVer = 'BounceDev01.16'
    return {version, mod, nickname, challengeResponse, joinAuthKey, clientVer, challengeResponse2}
end