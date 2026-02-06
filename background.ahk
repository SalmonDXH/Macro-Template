#Requires AutoHotkey v2.0
/************************************************************************
 * @description Response for internet connection, background service
 * @author Salmon
 * @date 2025/02/06
 * @version 3.0.0
 ***********************************************************************/

DetectHiddenWindows(true)
SplitPath A_AhkPath, &exeName

exe64 := "AutoHotkey64.exe"
exe32 := "AutoHotkey32.exe"

F1:: {
    MsgBox(WinExist('main ahk_class AutoHotkey'))
}

F2:: ExitApp