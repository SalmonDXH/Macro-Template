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

    static send(data := {}, mention := false) {
        if !this.check_webhook() {
            return false
        }
        webhook := WebHookBuilder(this.get_webhook())
        title := (data.HasProp('title')) ? data.title : ''
        description := (data.HasProp('description')) ? data.description : ''
        footer_description := (data.HasProp('footer')) ? data.footer : A_Hour ':' A_Min ':' A_Sec
        image_path := (data.HasProp('image')) and data.image is String and FileExist(data.image) ? data.image : false
        attachment := image_path ? AttachmentBuilder(image_path) : false

        embed := EmbedBuilder()
        embed.setTitle(title)
        embed.setDescription(description)
        embed.setFooter({ text: footer_description })
        (data.HasProp('color')) ? embed.setColor(data.color) : false
        (attachment) ? embed.setImage(attachment) : false
        content := (mention and this.get_value(Integer, 'WEBHOOK', 'user_id') != '') ? '<@' this.get_value(Integer, 'WEBHOOK', 'user_id') '>' : ''
        data_send := attachment ? { content: content, embeds: [embed], files: [attachment] } : { embeds: [embed] }
        try {
            return webhook.send(data_send)
        } catch Error as e {
            return e
        }


    }
}