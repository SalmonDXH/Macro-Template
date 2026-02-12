class Program {
    static exe_path32 := A_AhkPath
    static exe_path64 := (A_Is64bitOS && FileExist("\AutoHotkey64.exe")) ? (A_WorkingDir "\AutoHotkey64.exe") : A_AhkPath
    static send(target, onmessage_type, message := '', wparam := 0) {
        t := target ' ahk_class AutoHotkey'
        copy_data_struct := Buffer(3 * A_PtrSize)
        size_in_bytes := (StrLen(message) + 1) * 2
        NumPut("Ptr", size_in_bytes
            , "Ptr", StrPtr(message)
            , copy_data_struct, A_PtrSize)
        try {
            return SendMessage(onmessage_type, wparam, copy_data_struct, , t)
        } catch {
            return 0
        }
    }

    static recieve(wparam, lparam, *) {
        string_address := NumGet(lparam + 2 * A_PtrSize, 'Ptr')
        string_text := StrGet(string_address)
        return { type: wparam, message: lparam }
    }

    static run(target, param := '') {
        DetectHiddenWindows(true)
        if !WinExist(target ' ahk_class AutoHotkey') {
            return run(target (A_IsCompiled ? '.exe' : '.ahk') ' ' param)
        } else {
            return 0
        }

    }

    static stop(target) {
        DetectHiddenWindows(true)
        return WinExist(target ' ahk_class AutoHotkey') ? WinClose(target ' ahk_class AutoHotkey') : true
    }

    static close_all() {
        list := WinGetList('ahk_class AutoHotkey ahk_exe ' this.exe_path32)
        if (this.exe_path32 != this.exe_path64)
            list.Push(WinGetList("ahk_class AutoHotkey ahk_exe " this.exe_path64)*)
        for hwnd in list {
            (A_ScriptHwnd != hwnd) ? WinClose('ahk_id ' hwnd) : false
        }
        return true
    }
}