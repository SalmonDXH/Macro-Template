#Include ..\discord\resources\JSON.ahk


class Program {
    static exe_path32 := A_AhkPath
    static exe_path64 := (A_Is64bitOS && FileExist("\AutoHotkey64.exe")) ? (A_WorkingDir "\AutoHotkey64.exe") : A_AhkPath
    static send_wm(target, data := {}, wparam := 0) {
        DetectHiddenWindows(true)
        t := target ' ahk_class AutoHotkey'
        if !WinExist(t) {
            return false
        }
        copy_data_struct := Buffer(3 * A_PtrSize)
        message := JSON.stringify(data)
        size_in_bytes := (StrLen(message) + 1) * 2
        NumPut("Ptr", size_in_bytes
            , "Ptr", StrPtr(message)
            , copy_data_struct, A_PtrSize)
        return SendMessage(0x004A, wparam, copy_data_struct, , t)
    }

    static send(target, onmessage_type, lparam := 0) {
        DetectHiddenWindows(true)
        t := target ' ahk_class AutoHotkey'
        if !WinExist(t) {
            return false
        }
        return SendMessage(onmessage_type, lparam, , , t)
    }

    static api_receive(func, params*) {
        SetTimer(() => func(params*), -1)
        return 1
    }

    static receive(wparam, lparam, *) {
        string_address := NumGet(lparam + 2 * A_PtrSize, 'Ptr')
        string_text := StrGet(string_address)
        return { type: wparam, data: JSON.parse(string_text) }
    }

    static run(target, param := '') {
        DetectHiddenWindows(true)
        if !WinExist(target ' ahk_class AutoHotkey') {
            return run(target (A_IsCompiled ? '.exe' : '.ahk') ' ' param)
        } else {
            return 0
        }

    }

    static run_all(targets, param := '') {
        if targets is Array {
            for target in targets {
                (target is String) ? this.run(target, param) : false
            }
        }
        return 1
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