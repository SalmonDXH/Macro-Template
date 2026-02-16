class Team {
    static number_of_team := 8
    static number_of_slot := 6
    static number_of_placement := 5
    static w := 1200
    static h := 400
    static data := {
        team: 'Team 0',
        config: Map()
    }

    static get(team) {
        file_name := (team is Integer) ? 'Team_' team : StrReplace(team, ' ', '_')
        this.data.team := (team is Integer) ? 'Team ' team : team
        this.data.config := JsonFile(A_ScriptDir '\data\Team\' file_name '.json').read()
        return this.data.config
    }

    static save(team, data) {
        file_name := (team is Integer) ? 'Team_' team : StrReplace(team, ' ', '_')
        JsonFile(A_ScriptDir '\data\Team\' file_name '.json').save(data)
    }
}