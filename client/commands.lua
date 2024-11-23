lib.locale()
-- Toggle all UI ON/OFF
RegisterCommand('hideui', function()
    TriggerEvent('HideAllUI')
end)

CreateThread(function ()
    Wait(1000)
    TriggerEvent('chat:addSuggestion','/hideui', locale('cl_hideui'), {})
end)