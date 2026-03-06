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
    Loop Stratergy.max_action_shown {
        if actions_array[actions_array.Length].Length >= stratergy_actions_maximum_buttons {
            actions_array.Push([])
        }
        temp_gui := UI.add_to_parent(stratergy_actions_holder)
        temp_gui.BackColor := 'cffffff'
        actions_array[actions_array.Length].Push(temp_gui)
        if A_Index = Stratergy.max_action_shown {
            while actions_array[actions_array.Length].Length < stratergy_actions_maximum_buttons {
                actions_array[actions_array.Length].Push('')
            }
        }

    }

    UI.grid_layout(stratergy_actions_holder, actions_array)

} catch Error as e {
    Logging.critical('Fail to create stratergy ui', 'Stratergy UI', e)
}

OpenStratergyGUI(*) {
    Logging.trace('User open Stratergy ui', 'User')
    UI.gui_simple(stratergy_gui, Stratergy.w, Stratergy.h)
    return stratergy_gui
}