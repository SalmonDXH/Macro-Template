#Include File.ahk

class IniFile extends FileCustom {
    read(section, key) {
        if this.check() {
            try {
                val := IniRead(this.path, section, key)
                try {
                    return Number(val)
                } catch {
                    return val
                }
            } catch {
                return false
            }
        } else {
            return false
        }
    }

    write(section, key, val) {
        if !this.check() {
            this.ensure_dir()
        }
        return IniWrite(val, this.path, section, key)
    }
}