#Include coordinate_config.ahk


try {
    coordinate_gui := UI.add_to_owner(home_ui)
    coordinate_gui.Title := 'Coordinate'
    coordinate_gui_holder := UI.add_to_parent(coordinate_gui)
    UI.gui_move(coordinate_gui_holder, 0, 0, Coordinate.w, Coordinate.h)

    coordinate_map_holder := UI.add_to_parent(coordinate_gui_holder)
    coordinate_map_pic := UI.add_pic(coordinate_map_holder)
    UI.control_move(coordinate_map_pic, 0, 0, 800, 600)
    UI.gui_move(coordinate_map_holder, 20, 20, 800, 600)

    coordinate_dashboard_holder := UI.add_to_parent(coordinate_gui_holder)
    UI.gui_move(coordinate_dashboard_holder, 840, 20, Coordinate.w - 860, 600)
    coordinate_ddl_holder := UI.add_to_parent(coordinate_dashboard_holder)
    coordinate_unit_holder := UI.add_to_parent(coordinate_dashboard_holder)

    UI.gui_move(coordinate_ddl_holder, 0, 0, Coordinate.w - 860, 260)
    UI.gui_move(coordinate_unit_holder, 0, 300, Coordinate.w - 860, 600 - 300)

    coordinate_map_ddl := UI.add_ddl(coordinate_ddl_holder, ['Test'], 'map')
    coordinate_map_title := UI.add_text(coordinate_ddl_holder, 'Map:', '+Right')
    coordinate_gamemode_ddl := UI.add_ddl(coordinate_ddl_holder, , 'game_mode')
    coordinate_gamemode_title := UI.add_text(coordinate_ddl_holder, 'Gamemode:', '+Right')


    coordinate_change_image_button := UI.add_button(coordinate_ddl_holder, 'Change image')
    coordinate_change_image_button.OnEvent('Click', ScreenshotMap)
    coordinate_delete_config_file_button := UI.add_button(coordinate_ddl_holder, 'Delete config')
    coordinate_reset_current_slot_button := UI.add_button(coordinate_ddl_holder, 'Reset this')
    coordinate_reset_everything_button := UI.add_button(coordinate_ddl_holder, 'Reset everything')

    coordinate_maximum_buttons := Integer(Floor(Sqrt(Team.number_of_placement)))
    coordinate_next_slot_button := UI.add_text(coordinate_unit_holder, '>')
    coordinate_next_slot_button.SetFont('s14')
    coordinate_prev_slot_button := UI.add_text(coordinate_unit_holder, '<', '+Right')
    coordinate_prev_slot_button.SetFont('s14')
    coordinate_slot_title_text := UI.add_text(coordinate_unit_holder, 'Slot 1', '+Center')
    coordinate_slot_title_text.SetFont('s14')
    coordinate_unit_bottom_array := [[coordinate_prev_slot_button, coordinate_slot_title_text, coordinate_next_slot_button], []]
    Loop Team.number_of_placement {
        if coordinate_unit_bottom_array[coordinate_unit_bottom_array.Length].Length >= coordinate_maximum_buttons {
            coordinate_unit_bottom_array.Push([UI.add_button(coordinate_unit_holder, 'Unit ' A_Index '`n(0 , 0)')])
        } else {
            coordinate_unit_bottom_array[coordinate_unit_bottom_array.Length].Push(UI.add_button(coordinate_unit_holder, 'Unit ' A_Index '`n(0 , 0)'))
        }
        if Team.number_of_placement = A_Index {
            while coordinate_unit_bottom_array[coordinate_unit_bottom_array.Length].Length < coordinate_maximum_buttons {
                coordinate_unit_bottom_array[coordinate_unit_bottom_array.Length].Push('')
            }
        }
    }
    UI.grid_layout(coordinate_ddl_holder, [
        [coordinate_gamemode_title, coordinate_gamemode_ddl],
        [coordinate_map_title, coordinate_map_ddl],
        [coordinate_change_image_button, coordinate_delete_config_file_button],
        [coordinate_reset_current_slot_button, coordinate_reset_everything_button]
    ])

    UI.grid_layout(coordinate_unit_holder, coordinate_unit_bottom_array)
} catch Error as e {
    Logging.critical('Fail to create coordinate ui', 'Coordinate UI', e)
}


OpenCoordinateGUI(*) {
    Logging.trace('User open Coordinate ui', 'User')
    FillCoordinateGUI()
    UI.gui_simple(coordinate_gui, Coordinate.w, Coordinate.h)
    return coordinate_gui
}

FillCoordinateGUI(*) {
    ChangeMapPicture()
}

ChangeMapPicture(*) {
    image_path := Coordinate.image_dir '\' StrReplace(coordinate_map_ddl.Text, ' ', '_') '.png'
    coordinate_map_pic.Value := (FileExist(image_path)) ? image_path : ''
}

ScreenshotMap(*) {
    if WinExist(Roblox_Config.window) {
        coordinate_map_pic.Value := ''
        coordinate_gui.Hide()
        SetSize()
        Sleep 1000
        Screenshot.screeshot_from_app(Roblox_Config.window, 0, 31, , 600, coordinate_map_ddl.Text, Coordinate.image_dir)
        ChangeMapPicture()
        coordinate_gui.Show()
    } else {
        MessageBox.warn('Couldnt find roblox instance, please open it or use roblox website instead of roblox Microsoft', 'Error')
    }


}