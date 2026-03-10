#Include stratergy_config.ahk

try {
    stratergy_gui := UI.add_to_owner(home_ui)
    stratergy_gui.Title := 'Stratergy'
    stratergy_gui_holder := UI.add_to_parent(stratergy_gui)
    UI.gui_move(stratergy_gui_holder, 0, 0, Stratergy.w, Stratergy.h)

    stratergy_actions_holder := UI.add_to_parent(stratergy_gui_holder)

    UI.gui_move(stratergy_actions_holder, 10, 60, 600, Stratergy.h - 120)

    stratergy_actions_maximum_buttons := (Stratergy.max_action_shown) // 2
    actions_array := [[]]
    actions_gui_array := []
    Loop Stratergy.max_action_shown {
        if actions_array[actions_array.Length].Length >= stratergy_actions_maximum_buttons {
            actions_array.Push([])
        }
        temp_gui := UI.add_to_parent(stratergy_actions_holder)
        actions_array[actions_array.Length].Push(temp_gui)
        actions_gui_array.Push(temp_gui)
        if A_Index = Stratergy.max_action_shown {
            while actions_array[actions_array.Length].Length < stratergy_actions_maximum_buttons {
                actions_array[actions_array.Length].Push('')
            }
        }

    }

    UI.grid_layout(stratergy_actions_holder, actions_array)

    for temp_ui in actions_gui_array {
        temp_code_edit := UI.add_edit(temp_ui, 'A0S1U1D0', , 'Code')
        temp_code_button := UI.add_button(temp_ui, 'Copy')

        temp_action_text := UI.add_text(temp_ui, 'Action:')
        temp_action_ddl := UI.add_ddl(temp_ui, , 'Action')

        temp_slot_text := UI.add_text(temp_ui, 'Slot:')
        temp_slot_ddl := UI.add_ddl(temp_ui, , 'Slot')

        temp_unit_text := UI.add_text(temp_ui, 'Unit:')
        temp_unit_ddl := UI.add_ddl(temp_ui, , 'Unit')

        temp_delay_text := UI.add_text(temp_ui, 'Delay:')
        temp_delay_edit := UI.add_edit(temp_ui, 0, , 'Delay')

        UI.grid_layout(temp_ui, [
            [temp_code_edit, temp_code_button],
            [temp_action_text, temp_action_ddl],
            [temp_slot_text, temp_slot_ddl],
            [temp_unit_text, temp_unit_ddl],
            [temp_delay_text, temp_delay_edit],
            []
        ], , , 10, 25)
        UI.gui_groupbox(temp_ui, 'Action ' A_Index, , 'Action_' A_Index)
    }

} catch Error as e {
    Logging.critical('Fail to create stratergy ui', 'Stratergy UI', e)
}

OpenStratergyGUI(*) {
    Logging.trace('User open Stratergy ui', 'User')
    UI.gui_simple(stratergy_gui, Stratergy.w, Stratergy.h)
    return stratergy_gui
}