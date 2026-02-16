#Include lib\screenshot\Screenshot.ahk
#Include lib\discord\WEBHOOK.ahk
#Include lib\logging\Logging.ahk
#Include lib\program\Program.ahk


#SingleInstance Force
#MaxThreads 255


try {
    Logging.path := A_Args[1]
}
Logging.debug('Webhook launched', 'Start')

OnMessage(0x5550, webhook_received)
OnMessage(0x004A, webhook_data)

roblox_window := 'ahk_exe RobloxPlayerBeta.exe'
webhook_received(lparam, *) {
    switch lparam {
        case 1:
            SetTimer(() => webhook_test(), -1)
    }
    return 1
}

webhook_test() {
    p := Screenshot.screenshot(0, 0, A_ScreenWidth, A_ScreenHeight)
    Logging.debug('Get a full screenshot', 'Test')

    data := {
        message: '',
        type: false
    }
    try {
        Logging.debug('Sending webhook', 'Test')
        result := Discord.send({ image: p }, true)
        if result is Error {
            Logging.error('Fail to send webhook', 'Test', result)
            data.message := 'Fail to send webhook:`n' result.Message
        } else if result is Object {
            if result.HasProp('status') {
                if result.status = 200 {
                    data.type := true
                    data.message := '[' result.status '] Send webhook successfully'
                    Logging.debug('Send webhook successfully', 'Test')
                } else {
                    data.message := '[Error ' result.status '] Fail to send webhook'
                    Logging.error('Error ' result.status ' - Fail to send webhook', 'Test')

                }
            } else {
                Logging.debug('Fail to send webhook - invalid webhook url', 'Test')
                data.message := 'Invalid webhook url'
            }
        }

    } catch Error as e {
        Logging.error('Fail to sendwebhook', 'Test', e)
        data.message := 'Fail to send webhook: ' e.Message
    }

    Logging.debug('Sending data to main program', 'Test')
    try FileDelete(p)
    Program.send_wm('main', data, 1)

}

webhook_data(wparam, lparam, *) {
    data := Program.receive(wparam, lparam)
    if data and data.HasProp('type') and data.HasProp('data') {
        switch data.type {
            case 1:
                if data.data.Has('message') {
                    SetTimer(() => webhook_logs(data.data['message']), -1)
                }
            case 2:
                SetTimer(() => webhook_match_ended(data), -1)
        }
    }
    return 1
}


webhook_logs(message) {
    try {
        result := Discord.send({ description: message })
        if result is Error {
            Logging.error('Fail to send logs webhook', 'Logs', result)
        } else if result {
            if result.HasProp('status') {
                if result.status = 200 {
                    Logging.debug('Send webhook logs: ' message, 'Logs')
                } else {
                    Logging.error('Fail to send logs webhook: ' result.status, 'Logs')
                }
            }
        } else {
            Logging.error('Invalid webhook', 'Logs')
        }

    } catch Error as e {
        Logging.error('Fail to send logs webhook', 'Logs', e)
    }
}

webhook_match_ended(data) {
    p := Screenshot.screeshot_from_app(roblox_window, , , , , 'result')
    if p {
        try {
            d := {
                title: ((data.HasProp('game_mode')) ? data.game_mode : 'Match') ' Finished',
                image: (p) ? p : '',
                color: ((data.HasProp('color')) ? data.color : 0x90EE90)
            }
            Discord.send(d, (data.HasProp('mention')) ? data.mention : false)

        } catch Error as e {
            Logging.error('Fail to send result webhook', 'Match ended', e)
        }

        try FileDelete(p)

    } else {
        Logging.error('Fail to capture roblox because there is no roblox instance', 'Screenshot')
    }

}

Loop {
    Sleep 1000
}