discord_webhook_test_send(*) {
    Logging.trace('User press webhook test button', 'Webhook Test')
    Program.send('webhook', 0x5550, 1)
}

discord_webhook_test_received(data) {
    if data is Map and data.Has('message') and data.Has('type') {
        if data['type'] {
            MsgBox(data['message'], 'Success')
        } else {
            MsgBox(data['message'], 'Error')
        }
    }
}