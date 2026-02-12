#Requires AutoHotkey v2.0

#MaxThreads 255
DetectHiddenWindows(true)


#Include lib\logging\Logging.ahk
#Include lib\program\Program.ahk


try {
    Logging.path := A_Args[1]
}

Logging.debug('Heartbeat launched', 'Start')


Loop {
    if WinExist('main ahk_class AutoHotkey') {

    } else {
        Logging.debug("main program is not running, closing all the background program", 'Closing')
        Program.close_all()
        ExitApp()
    }
    Sleep 2000
}