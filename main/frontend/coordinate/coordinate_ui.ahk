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

    coordinate_map_ddl := UI.add_ddl(coordinate_ddl_holder, , 'map')
    coordinate_map_title := UI.add_text(coordinate_ddl_holder, 'Map:', '+Right')
    coordinate_gamemode_ddl := UI.add_ddl(coordinate_ddl_holder, , 'game_mode')
    coordinate_gamemode_title := UI.add_text(coordinate_ddl_holder, 'Gamemode:', '+Right')


    coordinate_change_image_button := UI.add_button(coordinate_ddl_holder, 'Change image')
    coordinate_delete_config_file_button := UI.add_button(coordinate_ddl_holder, 'Delete config')
    coordinate_reset_current_slot_button := UI.add_button(coordinate_ddl_holder, 'Reset this')
    coordinate_reset_everything_button := UI.add_button(coordinate_ddl_holder, 'Reset everything')

    coordinate_maximum_buttons := Integer(Floor(Sqrt(Team.number_of_placement)))
    coordinate_unit_bottom_array := [[UI.add_text(coordinate_unit_holder, 'Unit Coordinate', '+Center')], []]
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
    UI.gui_simple(coordinate_gui, Coordinate.w, Coordinate.h)
    return coordinate_gui
}