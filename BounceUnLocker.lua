require "lib.moonloader"
local inicfg = require "inicfg"
local mem = require "memory"
local encoding = require "encoding"
local key = require 'vkeys'
local ev = require "lib.samp.events"
local ffi = require "ffi"
local dlstatus = require('moonloader').download_status
local getBonePosition = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)
----------------------------------------------------------------------------------------------------

--[[local ips =
{
    ['Server 1'] = '80.66.82.242:7777'
    --['Server 2'] = 'ip:port'
}
--]]

---------------------------------------------------
encoding.default = 'CP1251'
u8 = encoding.UTF8
script_name('Bounce Script (DevOps)')
script_author('electron.js')
script_version('BounceDev01.16')
update_state = false
---------------------------------------------------


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
	
	while true do wait(0)
		if update_state then
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage("{7044EE}[Bounce Script (DevOps)]: {2DA440}Обновление успешно скачалось, обновляем! {EDEFE0}Последняя версия скрипта: BounceDev01.16", -1)
					thisScript():reload()
				end
			end)
		break
		end
	end
end


function ev.onSendClientJoin(version, mod, nickname, challengeResponse, joinAuthKey, clientVer, challengeResponse2) 
    clientVer = 'BounceDev01.16'
    return {version, mod, nickname, challengeResponse, joinAuthKey, clientVer, challengeResponse2}
end