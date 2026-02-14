;!#############################################
;! DISCORD UI
;!#############################################
discord_width := 400
discord_height := 240

try {
    discord_gui := UI.add_to_owner(home_ui)
    discord_gui.Title := 'Discord'
    discord_bot_holder := UI.add_to_parent(discord_gui)
    UI.gui_move(discord_bot_holder, 0, 0, discord_width, 95)
    UI.gui_groupbox(discord_bot_holder, 'Bot')

    discord_bot_auto_checkbox := UI.add_checkbox(discord_bot_holder, 'Auto run discord bot')
    discord_bot_auto_checkbox.Value := Discord.get_value(Integer, 'BOT', 'token')
    discord_bot_auto_checkbox.OnEvent('Click', (ctrl, *) => Discord.update_value(ctrl.Value, 'BOT', 'token'))
    UI.grid_layout(discord_bot_holder, [[discord_bot_auto_checkbox]], , , 10, 25)

    discord_mention_holder := UI.add_to_parent(discord_gui)
    UI.gui_move(discord_mention_holder, 0, 105, discord_width, discord_height - 95 - 10)
    UI.gui_groupbox(discord_mention_holder, 'Webhook')
    discord_activity_logs_checkbox := UI.add_checkbox(discord_mention_holder, 'Activity logs')
    discord_activity_logs_checkbox.Value := Discord.get_value(Integer, 'WEBHOOK', 'activity')
    discord_activity_logs_checkbox.OnEvent('Click', (ctrl, *) => Discord.update_value(ctrl.Value, 'WEBHOOK', 'activity'))

    discord_mention_won_checkbox := UI.add_checkbox(discord_mention_holder, 'Won')
    discord_mention_lost_checkbox := UI.add_checkbox(discord_mention_holder, 'Lost')
    discord_mention_restart_checkbox := UI.add_checkbox(discord_mention_holder, 'Restart')
    discord_mention_disconnect_checkbox := UI.add_checkbox(discord_mention_holder, 'Disconnect')
    UI.grid_layout(discord_mention_holder, [
        [discord_activity_logs_checkbox],
        [discord_mention_won_checkbox, discord_mention_lost_checkbox],
        [discord_mention_restart_checkbox, discord_mention_disconnect_checkbox],
    ], , , 10, 25)
} catch Error as e {
    Logging.critical('Fail to create discord ui', 'Discord UI', e)
}


OpenDiscordGUI(*) {
    Logging.trace('User open Discord Config ui', 'User')
    UI.gui_simple(discord_gui, discord_width, discord_height)
}