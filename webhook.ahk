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

F2:: ExitApp()