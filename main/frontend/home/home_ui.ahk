;!#############################################
;! HOME UI
;!#############################################


;?#############################################
;? CONFIGURATION
;?#############################################
try {
    home_ui := Gui('-Resize +AlwaysOnTop -Caption')
    home_ui.OnEvent('Close', (*) => ExitApp())
    home_ui.BackColor := UI.background_color
    Logging.debug('Create home ui', 'Home UI')
} catch Error as e {
    Logging.critical('Fail to create home ui', 'Home UI', e)
}

show_home_ui() {
    UI.gui_simple(home_ui, UI.width, UI.height)
}


;?#############################################
;? UTILITIES BUTTON
;?#############################################
try {
    home_ui_close_button := UI.add_to_parent(home_ui)
    home_ui_close_button.BackColor := 0xff0000
    home_ui_close_button.AddText('x0 y0 w20 h20').OnEvent('Click', (*) => ExitApp())
    UI.gui_move(home_ui_close_button, UI.width - 30, 10, 20, 20)
    UI.round_gui(home_ui_close_button.Hwnd)
    Logging.debug('Create close button for home ui', 'Home UI')
} catch Error as e {
    Logging.critical('Fail to create close button', 'Home UI', e)
}


try {
    home_ui_minimize_button := UI.add_to_parent(home_ui)
    home_ui_minimize_button.BackColor := 0xfbff00
    home_ui_minimize_button.AddText('x0 y0 w20 h20').OnEvent('Click', (*) => WinMinimize(home_ui.Hwnd))
    UI.gui_move(home_ui_minimize_button, UI.width - 30 - 30, 10, 20, 20)
    UI.round_gui(home_ui_minimize_button.Hwnd)
    Logging.debug('Create minimize button for home ui', 'Home UI')
} catch Error as e {
    Logging.critical('Fail to create minimize button', 'Home UI', e)
}


try {
    home_ui_drag_bar := UI.add_to_parent(home_ui)
    home_ui_drag_bar_text := home_ui_drag_bar.AddText('x0 y0 w800 h20 c' UI.title_color, Macro_Config.name ' v' Macro_Config.version ' by ' Credit_Config.owner)
    home_ui_drag_bar_text.SetFont('bold s10')
    home_ui_drag_bar_text.OnEvent('Click', (*) => UI.drag(home_ui.Hwnd, set_size))
    UI.gui_move(home_ui_drag_bar, 30, 5, 800, 20)
    Logging.debug('Create drag bar for home ui', 'Home UI')
} catch Error as e {
    Logging.critical('Fail to create  drag bar', 'Home UI', e)
}

set_size() {
    if WinExist(home_ui.Hwnd) {
        WinActivate(home_ui.Hwnd)
        if WinExist(Roblox_Config.window) {
            WinActivate(Roblox_Config.window)
            WinGetPos(, , &w, &h, Roblox_Config.window)
            if w = A_ScreenWidth and h = A_ScreenHeight {
                SendInput('{F11}')
            }
            WinGetPos(&x, &y, , , roblox_holder.Hwnd)
            WinMove(x - 8, y - 30, 800, 598, Roblox_Config.window)
        }
    }
}

;?#############################################
;? ROBLOX HOLDER
;?#############################################
try {
    roblox_holder := home_ui.AddText('c0x7e4141 Background0x7e4141')
    UI.control_move(roblox_holder, 30, 30, 800, 600)
    WinSetTransColor("0x7e4141 255", home_ui)
    Logging.debug('Create Roblox holder', 'Home UI')
} catch Error as e {
    Logging.critical('Fail to create roblox holder', 'Home UI', e)
}


;?#############################################
;? DASHBOARD HOLDER
;?#############################################
try {
    dashboard_holder := UI.add_to_parent(home_ui)
    UI.gui_move(dashboard_holder, 30 + 800 + 20, 30, UI.width - 850 - 30, 600)
    UI.gui_groupbox(dashboard_holder, 'Dashboard')
    Logging.debug('Create Dashboard holder ui', 'Home UI')
} catch Error as e {
    Logging.critical('Fail to create dashboard holder ui', 'Home UI', e)
}

;?#############################################
;? MISC HOLDER
;?#############################################
try {
    misc_holder := UI.add_to_parent(home_ui)
    UI.gui_move(misc_holder, 30, 600 + 30 + 10, UI.width - 30 * 2, UI.height - 640 - 30)
    Logging.debug('Create Misc holder ui', 'Home UI')
    discord_misc_holder := UI.add_to_parent(misc_holder)
    roblox_misc_holder := UI.add_to_parent(misc_holder)
    keybind_misc_holder := UI.add_to_parent(misc_holder)
    support_misc_holder := UI.add_to_parent(misc_holder)
    UI.grid_layout(misc_holder, [[discord_misc_holder, roblox_misc_holder, keybind_misc_holder, support_misc_holder]], 10, 10)

    UI.gui_groupbox(discord_misc_holder, 'Discord')
    UI.gui_groupbox(roblox_misc_holder, 'Roblox')
    UI.gui_groupbox(keybind_misc_holder, 'Keybind')
    UI.gui_groupbox(support_misc_holder, 'Support')


    ;! Discord
    discord_user_id_text := UI.add_text(discord_misc_holder, 'User id:', '+Center')
    discord_user_id_edit := UI.add_edit(discord_misc_holder)
    discord_config_button := UI.add_button(discord_misc_holder, 'Config')

    discord_webhook_test_button := UI.add_button(discord_misc_holder, 'Test')
    discord_webhook_edit := UI.add_edit(discord_misc_holder, , true)
    discord_webhook_text := UI.add_text(discord_misc_holder, 'Webhook URL:', '+Center')

    discord_bot_text := UI.add_text(discord_misc_holder, 'Bot Token:', '+Center')
    discord_bot_edit := UI.add_edit(discord_misc_holder, , true)
    discord_bot_run_button := UI.add_button(discord_misc_holder, 'Run')

    UI.grid_layout(discord_misc_holder,
        [
            [discord_user_id_text, discord_user_id_edit, discord_config_button],
            [discord_webhook_text, discord_webhook_edit, discord_webhook_test_button],
            [discord_bot_text, discord_bot_edit, discord_bot_run_button],
        ], , , 10, 25)
    Logging.debug('Create all element needed for discord holder UI', 'Discord Holder')

    ;! Roblox
    roblox_private_server_text := UI.add_text(roblox_misc_holder, 'PS URL:', '+Center')
    roblox_private_server_edit := UI.add_edit(roblox_misc_holder)
    roblox_private_server_test_button := UI.add_button(roblox_misc_holder, 'Test')

    roblox_reconnect_every_text := UI.add_text(roblox_misc_holder, 'Reconnect every (h):', '+Center')
    roblox_reconnect_every_edit := UI.add_edit(roblox_misc_holder, 1)
    UI.grid_layout(roblox_misc_holder, [
        [roblox_private_server_text, roblox_private_server_edit, roblox_private_server_test_button],
        [roblox_reconnect_every_text, roblox_reconnect_every_edit],
        []
    ], , , 10, 25)
    Logging.debug('Create all element needed for Roblox holder UI', 'Roblox Holder')
    ;! Keybind
    F1_keybind_button := UI.add_button(keybind_misc_holder, 'Align (F1)')
    F2_keybind_button := UI.add_button(keybind_misc_holder, 'Start (F2)')
    F3_keybind_button := UI.add_button(keybind_misc_holder, 'Reload (F3)')
    F4_keybind_button := UI.add_button(keybind_misc_holder, 'Pause (F4)')
    F5_keybind_button := UI.add_button(keybind_misc_holder, 'PS (F5)')
    F6_keybind_button := UI.add_button(keybind_misc_holder, 'Discord Bot (F6)')
    F7_keybind_button := UI.add_button(keybind_misc_holder, 'Custom (F7)')

    UI.grid_layout(keybind_misc_holder, [
        [F1_keybind_button, F2_keybind_button, F3_keybind_button],
        [F4_keybind_button, F5_keybind_button, F6_keybind_button],
        [F7_keybind_button, '', '']
    ], , , 10, 25)
    Logging.debug('Create all element needed for Keybind holder UI', 'Keybind Holder')

    ;! Support
    tutorial_support_button := UI.add_button(support_misc_holder, 'Tutorial')
    youtube_support_button := UI.add_button(support_misc_holder, 'Youtube')
    discord_support_button := UI.add_button(support_misc_holder, 'Discord')
    website_support_button := UI.add_button(support_misc_holder, 'Our website')
    UI.grid_layout(support_misc_holder, [
        [tutorial_support_button, youtube_support_button],
        [discord_support_button, website_support_button],
    ], , , 10, 25)
    Logging.debug('Create all element needed for Support holder UI', 'Support Holder')
} catch Error as e {
    Logging.critical('Fail to create misc holder ui', 'Home UI', e)
}