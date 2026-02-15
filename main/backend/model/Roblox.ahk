class Roblox {
    static f := IniFile(A_ScriptDir '\data\roblox.ini')
    static experience_id := 0
    static reconnect := 0
    static check_ps_url(url := this.get_value(String, 'RECONNECTION', 'url')) {
        if RegExMatch(url, "^https://www\.roblox\.com/games/\d+.*") {
            return true
        } else {
            return false
        }
    }

    static start_ps() {
        if this.check_ps_url() {
            Run(this.get_ps_url())
        } else {
            Run('roblox://placeID=' this.experience_id)
        }
        this.reconnect++
    }

    static get_ps_url() {
        url := this.get_value(String, 'RECONNECTION', 'url')
        if (RegExMatch(url, "privateServerLinkCode=(\d+)", &match)) {
            linkCode := match[1]
        }

        if (RegExMatch(url, "games/(\d+)", &placeMatch)) {
            placeID := placeMatch[1]
        }

        return "roblox://placeID=" placeID "&linkCode=" linkCode
    }

    static get_value(t, section, key, d := '') {
        val := this.f.read(section, key)
        if t = String {
            return val ? val : d
        }
        return val is t and val ? val : d
    }

    static update_ps_url(url) {
        if this.check_ps_url(url) or url = '' {
            this.update_value(url, 'RECONNECTION', 'url')
        }
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

}