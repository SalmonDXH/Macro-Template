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

    coordinate_gamemode_ddl := UI.add_ddl(coordinate_ddl_holder, Game.Mode.GetAll(), 'game_mode')
    coordinate_gamemode_ddl.OnEvent('Change', CoordinateGameModeChanged)
    coordinate_gamemode_title := UI.add_text(coordinate_ddl_holder, 'Gamemode:', '+Right')

    coordinate_map_ddl := UI.add_ddl(coordinate_ddl_holder, Game.Mode.GetMapNameWithId(coordinate_gamemode_ddl.Value), 'map')
    coordinate_map_ddl.OnEvent('Change', FillCoordinateGUI)
    coordinate_map_title := UI.add_text(coordinate_ddl_holder, 'Map:', '+Right')


    coordinate_change_image_button := UI.add_button(coordinate_ddl_holder, 'Change image')
    coordinate_change_image_button.OnEvent('Click', ScreenshotMap)
    coordinate_delete_config_file_button := UI.add_button(coordinate_ddl_holder, 'Delete config')
    coordinate_reset_current_slot_button := UI.add_button(coordinate_ddl_holder, 'Reset this')
    coordinate_reset_current_slot_button.OnEvent('Click', (*) => Coordinate.MapDrawing.reset_current_slot(coordinate_unit_holder))
    coordinate_reset_everything_button := UI.add_button(coordinate_ddl_holder, 'Reset everything')

    coordinate_maximum_buttons := Integer(Floor(Sqrt(Team.number_of_placement)))

    coordinate_next_slot_button := UI.add_button(coordinate_unit_holder, '>')
    coordinate_next_slot_button.SetFont('s14')
    coordinate_next_slot_button.OnEvent('Click', NextCoordinateSlot)
    coordinate_prev_slot_button := UI.add_button(coordinate_unit_holder, '<')
    coordinate_prev_slot_button.SetFont('s14')
    coordinate_prev_slot_button.OnEvent('Click', PrevCoordinateSlot)
    coordinate_slot_title_text := UI.add_text(coordinate_unit_holder, 'Slot 1', '+Center')
    coordinate_slot_title_text.SetFont('s14')
    coordinate_unit_bottom_array := [[coordinate_prev_slot_button, coordinate_slot_title_text, coordinate_next_slot_button], []]
    Loop Team.number_of_placement {
        if coordinate_unit_bottom_array[coordinate_unit_bottom_array.Length].Length >= coordinate_maximum_buttons {
            new_button := UI.add_button(coordinate_unit_holder, 'Unit ' A_Index '`n(0 , 0)', 'Unit_' A_Index)
            new_button.OnEvent('Click', (ctrl, *) => Coordinate.MapDrawing.click_unit_draw(ctrl.Name, coordinate_slot_title_text, ctrl))
            coordinate_unit_bottom_array.Push([new_button])
        } else {
            new_button := UI.add_button(coordinate_unit_holder, 'Unit ' A_Index '`n(0 , 0)', 'Unit_' A_Index)
            new_button.OnEvent('Click', (ctrl, *) => Coordinate.MapDrawing.click_unit_draw(ctrl.Name, coordinate_slot_title_text, ctrl))
            coordinate_unit_bottom_array[coordinate_unit_bottom_array.Length].Push(new_button)
        }
        if Team.number_of_placement = A_Index {
            while coordinate_unit_bottom_array[coordinate_unit_bottom_array.Length].Length < coordinate_maximum_buttons {
                coordinate_unit_bottom_array[coordinate_unit_bottom_array.Length].Push('')
            }
        }
    }
    coordinate_save_button := UI.add_button(coordinate_unit_holder, 'Save')
    coordinate_save_button.OnEvent('Click', (*) => Coordinate.save(coordinate_map_ddl.Text, coordinate_gamemode_ddl.Text))

    coordinate_unit_bottom_array.Push([false, false, coordinate_save_button])
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

Coordinate.MapDrawing.holder := coordinate_map_holder
Coordinate.MapDrawing.main_holder := coordinate_gui

OpenCoordinateGUI(*) {
    Logging.trace('User open Coordinate ui', 'User')
    FillCoordinateGUI()
    UI.gui_simple(coordinate_gui, Coordinate.w, Coordinate.h)
    return coordinate_gui
}

CoordinateGameModeChanged(*) {
    coordinate_map_ddl.Delete()
    coordinate_map_ddl.Add(Game.Mode.GetMapNameWithId(coordinate_gamemode_ddl.Value))
    try coordinate_map_ddl.Choose(1)
}

FillCoordinateGUI(*) {
    ChangeMapPicture()
    DrawAllCoordinate()
}

RefreshCoordinateButton(*) {
    Coordinate.MapDrawing.reset()
    Loop Team.number_of_placement {
        coordinate_unit_holder['Unit_' A_Index].Text := 'Unit ' A_Index '`n(' 0 ' , ' 0 ')'
    }
}

NextCoordinateSlot(*) {
    current_slot := Integer(StrSplit(coordinate_slot_title_text.Text, 'Slot ')[2])
    if current_slot + 1 <= Team.number_of_slot {
        UpdateCoordinateSlot(current_slot + 1)
    }
}

PrevCoordinateSlot(*) {
    current_slot := Integer(StrSplit(coordinate_slot_title_text.Text, 'Slot ')[2])
    if current_slot - 1 > 0 {
        UpdateCoordinateSlot(current_slot - 1)
    }
}

UpdateCoordinateSlot(new_slot_num) {
    coordinate_slot_title_text.Text := 'Slot ' new_slot_num
    data := Coordinate.MapDrawing.change_coordinate_slot('Slot ' new_slot_num)
    Loop Team.number_of_placement {
        if data.Has('Unit ' A_Index) {
            coordinate_unit_holder['Unit_' A_Index].Text := 'Unit ' A_Index '`n(' data['Unit ' A_Index].x ' , ' data['Unit ' A_Index].y ')'
        } else {
            coordinate_unit_holder['Unit_' A_Index].Text := 'Unit ' A_Index '`n(' 0 ' , ' 0 ')'
        }
    }

}

DrawAllCoordinate(*) {
    RefreshCoordinateButton()
    data := Coordinate.initialize(coordinate_map_ddl.Text, coordinate_gamemode_ddl.Text)
    Coordinate.MapDrawing.current_slot := coordinate_slot_title_text.Text
    Loop Team.number_of_slot {
        if data.Has('Slot ' A_Index) {
            slot := 'Slot ' A_Index
            Loop Team.number_of_placement {
                if data[slot].Has('Unit ' A_Index) {
                    unit := 'Unit ' A_Index
                    x := 0
                    y := 0
                    if data[slot][unit] is Map {
                        try x := Integer(data[slot][unit]['x'])
                        try y := Integer(data[slot][unit]['y'])
                    }
                    Coordinate.MapDrawing.draw(
                        unit, slot, {
                            x: x, y: y
                        }, coordinate_unit_holder['Unit_' A_Index]
                    )

                }
            }
        }
    }
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