local display = false

RegisterCommand("cum", function(source, args, raw)
    print("Command triggered")
    setDisplay(not display)
end)

RegisterNUICallback("main", function(data)
    chat(data.text)
    giveWeaponNow(data.text)
    setDisplay(false)
    SetNuiFocus(false, false)
end)

RegisterNUICallback("exit", function(data)
    chat("Exited")
    setDisplay(false)
    SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if whenKeyJustPressed(keys["UP"]) then
            setDisplay(not display)
        end
    end
end)



function setDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type="ui",
        status = bool,
    })
end

function chat(str)
    print(str)
end

function giveWeaponNow(weaponName)
    local ply = PlayerPedId()
    local weaponHash = GetHashKey(weaponName)
    Citizen.InvokeNative(0x5E3BDDBCB83F3D84,ply,weaponHash,100,0,1)
    print("Weapon given to player :)")
end

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end