class Coordinate {
    static w := 1280
    static h := 640
    static data := {
        map_name: 'None',
        game_mode: 'None',
        config: Map()
    }

    static get(map_name, game_mode := 'default') {
        file_name := StrReplace(game_mode '\' map_name, ' ', '_')
        this.data.team := map_name
        this.data.game_mode := game_mode
        this.data.config := JsonFile(A_ScriptDir '\data\coordinate\' file_name '.json').read()
        return this.data.config
    }

    static save(map_name, game_mode := 'default', data := Map()) {
        file_name := StrReplace(game_mode '\' map_name, ' ', '_')
        JsonFile(A_ScriptDir '\data\coordinate\' file_name '.json').save(data)
    }
}