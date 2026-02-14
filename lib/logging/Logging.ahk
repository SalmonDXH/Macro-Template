class Logging {
    static flag := true
    static path := A_ScriptDir '\data\debug\debug_' A_Year '_' A_Mon '_' A_DD '_' A_Hour '_' A_Min '_' A_Sec '.log'
    static runtime := A_TickCount

    static trace(context, service) {
        return this._write(context, 'TRACE', service)
    }

    static debug(context, service) {
        return this._write(context, 'DEBUG', service)
    }

    static info(context, service) {
        return this._write(context, 'INFO', service)
    }

    static warning(context, service) {
        return this._write(context, 'WARNING', service)
    }

    static error(context, service, e?) {
        s := context
        if IsSet(e) and e is Error {
            s .= '`nReason: ' e.Message
            s .= '`nWhat: ' e.What
            s .= '`nExtra: ' e.Extra
            s .= '`nLocation: ' e.Stack
        }
        return this._write(s, 'ERROR', service)
    }

    static critical(context, service, e?) {
        s := context
        if IsSet(e) and e is Error {
            s .= '`nReason: ' e.Message
            s .= '`nWhat: ' e.What
            s .= '`nExtra: ' e.Extra
            s .= '`nLocation: `n' e.Stack
        }
        this._write(s, 'CRITICAL', service)
        MsgBox(s)
        return ExitApp()
    }

    static _write(context, level, service) {
        if this.flag {
            try {
                if this._ensure_dir() {
                    time := '[' A_Hour ':' A_Min ':' A_Sec ']'
                    l_text := "[" . level "]"
                    return FileAppend(time ' ' l_text ' [' A_ScriptName ']' ' [' service '] ' context '`n', this.path)
                } else {
                    MsgBox('Error creating path:`n' this.path, 'Logs Error')
                    return false
                }
            } catch Error as e {
                MsgBox(e.Message '`n' e.What '`n' e.File, 'Logs Error')
                return false
            }
        } else {
            return true
        }


    }

    static _ensure_dir() {
        try {
            SplitPath(this.path, , &dir)
            (DirExist(dir)) ? true : DirCreate(dir)
            return true
        } catch Error as e {
            MsgBox(e.Message '`n' e.What '`n' e.File, 'Logs Error')
            return false
        }
    }
}