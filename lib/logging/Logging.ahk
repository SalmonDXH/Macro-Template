class Logging {
    static path := A_ScriptDir '\data\debug_' A_Year '_' A_Mon '_' A_DD '_' A_Hour '_' A_Min '.log'
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
        return this._write(context, 'INFO', service)
    }

    static error(context, service) {
        return this._write(context, 'INFO', service)
    }

    static critical(context, service) {
        return this._write(context, 'INFO', service)
    }

    static _write(context, level, service) {
        try {
            if this._ensure_dir() {
                tc := (A_TickCount - this.runtime)
                h := tc // (3600000)
                m := Mod(tc // 60000, 60000)
                s := Mod(tc // 1000, 1000)
                time := ("["
                    . (h > 9 ? h : "0" h) ":"
                    . (m > 9 ? m : "0" m) ":"
                    . (s > 9 ? s : "0" s)
                    . "]")
                pad := Max(0, 8 - StrLen(level))
                l_text := "[" . level "]"
                return FileAppend(time ' ' l_text ' [' service '] ' context '`n', this.path)
            } else {
                MsgBox('Error creating path:`n' this.path, 'Logs Error')
                return false
            }
        } catch Error as e {
            MsgBox(e.Message '`n' e.What '`n' e.File, 'Logs Error')
            return false
        }

    }

    static _ensure_dir() {
        try {
            SplitPath(this.path, , &dir)
            return DirExist(dir) ? true : DirCreate(dir)
        } catch Error as e {
            MsgBox(e.Message '`n' e.What '`n' e.File, 'Logs Error')
            return false
        }
    }
}