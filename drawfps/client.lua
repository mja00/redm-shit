frameCount = 0
lastFps = 0
showFPS = false

RegisterCommand("cl_drawfps", function(source, args, raw)
    function showUsage()
        print("Usage: cl_drawfps [value]")
        print("Possible values: 1(true)/0(false)")
    end

    if #args < 1 or #args > 1 then
        showUsage()
        return
    end

    local lower = args[1]

    if lower == "1" or lower == "true" then
        print("FPS Enabled")
        frameCount = 0
        lastFps = 0
        showFPS = true
        return
    end
    if lower == "0" or lower == "false" then
        showFPS = false
        return
    end
end)

function FpsTick()
    ScreenText("FPS: "..lastFps,0.0,0.975,0.3)
end

function calcFps()
    lastFps = frameCount
    frameCount = 0
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if showFPS then
            frameCount = frameCount + 1
            FpsTick()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        calcFps()
    end
end)

function ScreenText(text,x,y,scale)
    local str = CreateVarString(10, "LITERAL_STRING", text)
    SetTextScale(scale, scale)
    Citizen.InvokeNative(0x50A41AD966910F03, 200,200,200,255)
    Citizen.InvokeNative(0x1BE39DBAA7263CA5, 0.1, 20,20,20,255)
    DrawText(str,x,y)
end