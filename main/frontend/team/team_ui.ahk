#Include team_config.ahk


try {
    team_gui := UI.add_to_owner(home_ui)
    team_gui.Title := 'Team'
    team_gui_holder := UI.add_to_parent(team_gui)
    UI.gui_move(team_gui_holder, 0, 0, Team.w, Team.h)
    team_ddl := UI.add_ddl(team_gui_holder, Utils.loop_array('Team', Team.number_of_team))
    UI.control_move(team_ddl, 20, 10, 120, 20)
    team_ui_array := []
    Loop Team.number_of_slot {
        slot_ui := UI.add_to_parent(team_gui_holder)
        team_ui_array.Push(slot_ui)
    }
    UI.grid_layout(team_gui_holder, [team_ui_array], , , 20, 50)
    for holder in team_ui_array {
        if holder is Gui {
            UI.gui_groupbox(holder, 'Slot ' A_Index)
            name_title := UI.add_text(holder, 'Name:')
            name_edit := UI.add_edit(holder, , , 'name')
            placement_title := UI.add_text(holder, 'Placement:')
            placement_ddl := UI.add_ddl(holder, Utils.array_range(0, Team.number_of_placement))
            UI.grid_layout(holder, [
                [name_title],
                [name_edit],
                [placement_title],
                [placement_ddl],
                false,
                false,
                false,
                false
            ], , , 10, 25)
        }
    }
} catch Error as e {
    Logging.critical('Fail to create team ui', 'Team', e)
}

OpenTeamGUI(*) {
    Logging.trace('User open team ui', 'Team')
    UI.gui_simple(team_gui, Team.w, Team.h)
    return team_gui
}