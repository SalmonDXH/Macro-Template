#Include File.ahk

class IniFile extends FileCustom {
    read(section, key) {
        if this.check() {
            try {
                return IniRead(this.path, section, key)
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