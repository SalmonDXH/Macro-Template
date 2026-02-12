#Include webhook\__init__.ahk

wn_reciever(wparam, lparam, *) {
    data := Program.receive(wparam, lparam)
    if data and data.HasProp('type') and data.HasProp('data') and data.type {
        switch data.type {
            case 1: ; Test Webhook
                SetTimer(() => discord_webhook_test_received(data.data), -1)
        }
    }
    return 1
}

OnMessage(0x004A, wn_reciever)