#Include lib\screenshot\Screenshot.ahk
#Include lib\discord\WEBHOOK.ahk
#Include lib\logging\Logging.ahk
#Include lib\program\Program.ahk


#SingleInstance Force
#MaxThreads 255


try {
    Logging.path := A_Args[1]
}


OnMessage(0x5550, Example)

roblox_window := 'ahk_exe RobloxPlayerBeta.exe'

Example(*) {
    t := A_TickCount
    p := Screenshot.screenshot(10, 10, 200, 200)
    SetTimer(() => Discord.send({ image: p }), -100)
    return A_TickCount - t
}

F2:: ExitApp()