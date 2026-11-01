-- toggle all UI on/off (e.g. for screenshots)
RegisterCommand('hideui', function()
    TriggerEvent('HideAllUI')
end, false)

CreateThread(function()
    Wait(1000)
    TriggerEvent('chat:addSuggestion', '/hideui', locale('cl_hideui'), {})
end)
