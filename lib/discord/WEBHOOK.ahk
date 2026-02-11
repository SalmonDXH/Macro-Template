#Include ..\file\IniFile.ahk
#Include resources\init.ahk

class Discord {
    static f := IniFile(A_ScriptDir '\data\discord.ini')

    static check_webhook(url := this.f.read('WEBHOOK', 'url')) {
        return (url ~= 'i)https?:\/\/discord\.com\/api\/webhooks\/(\d{18,19})\/[\w-]{68}')
    }

    static update_value(val, section, key, t?) {
        s := val
        if IsSet(t) and t is Class and val != '' {
            try {
                s := t(val)
            } catch {
                return
            }
        }
        this.f.write(section, key, s)
    }

    static get_value(t, section, key) {
        val := this.f.read(section, key)
        return (val is t or t = String) ? val : ''
    }

    static update_webhook(val) {
        return (val is String and this.check_webhook(val)) ? this.f.write('WEBHOOK', 'url', val) : false
    }

    static get_webhook() {
        val := this.f.read('WEBHOOK', 'url')
        return (this.check_webhook(val)) ? val : ''
    }

    static send(data := {}) {

    }
}