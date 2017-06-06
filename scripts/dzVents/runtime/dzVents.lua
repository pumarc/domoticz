local currentPath = globalvariables['script_path']
local triggerReason = globalvariables['script_reason']

_G.scriptsFolderPath = currentPath .. 'scripts' -- global
_G.generatedScriptsFolderPath = currentPath .. 'generated_scripts' -- global
_G.dataFolderPath = currentPath .. 'data' -- global

package.path = package.path .. ';' .. currentPath .. '?.lua'
package.path = package.path .. ';' .. currentPath .. 'runtime/?.lua'
package.path = package.path .. ';' .. currentPath .. 'runtime/device-adapters/?.lua'
package.path = package.path .. ';' .. currentPath .. 'dzVents/?.lua'
package.path = package.path .. ';' .. currentPath .. 'scripts/?.lua'
package.path = package.path .. ';' .. currentPath .. 'generated_scripts/?.lua'
package.path = package.path .. ';' .. currentPath .. 'data/?.lua'

local EventHelpers = require('EventHelpers')
local helpers = EventHelpers()

--local persistence = require('persistence')
--if (_G.TESTMODE == nil) then
--	persistence.store(currentPath .. '/domoticzData.lua', domoticzData)
--end

commandArray = {}

if triggerReason == "time" then
	commandArray = helpers.dispatchTimerEventsToScripts()
elseif triggerReason == "device" then
	commandArray = helpers.dispatchDeviceEventsToScripts()
elseif triggerReason == "uservariable" then
	commandArray = helpers.dispatchVariableEventsToScripts()
elseif triggerReason == 'security' then
	commandArray = helpers.dispatchSecurityEventsToScripts()
else
	print ("Unknown trigger: ", triggerReason)
end

return commandArray
