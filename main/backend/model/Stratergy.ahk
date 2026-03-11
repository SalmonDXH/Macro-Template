class Stratergy {
    class Entity {
        action := 'None'
        slot := 'None'
        unit := 'None'
        level := 0
        delay := 0

        __New(data := Map()) {
            this.action := (data.Has('action')) ? data['action'] : 'None'
            this.slot := (data.Has('slot')) ? data['slot'] : 'None'
            this.unit := (data.Has('unit')) ? data['unit'] : 'None'
            this.level := (data.Has('level')) ? data['level'] : 'None'
            try this.delay := (data.Has('delay')) ? Integer(data['delay']) : 0
        }

        ToMap() => Map(
            'action', this.action,
            'slot', this.slot,
            'unit', this.unit,
            'level', this.level,
            'delay', this.delay
        )
    }

    static max_action_shown := 8
    static w := 1000
    static h := 600

    static Pool := Map()


    static Parse(data) {
        result := Map()
        for action, entity in data {
            result[action] := this.Entity(entity)
        }
        return result
    }
    static initialize(map_name, game_mode := 'default') {
        game_mode_path := StrReplace(Trim(game_mode), ' ', '_')
        map_name_path := StrReplace(Trim(map_name), ' ', '_')
        f_path := A_ScriptDir '\data\game\' game_mode_path '\' map_name_path '\stratergy.json'
        f := JsonFile(f_path)
        data := (f.check()) ? f.read : Template.Stratergy.Get(map_name)
        this.Pool := this.Parse(data)
        return data
    }

    static save(game_mode, map_name) {
        data := Map()
        for action, entity in this.Pool {
            if (entity is this.Entity) {
                data[action] := entity.ToMap()
            }
        }

        game_mode_path := StrReplace(Trim(game_mode), ' ', '_')
        map_name_path := StrReplace(Trim(map_name), ' ', '_')
        f_path := A_ScriptDir '\data\game\' game_mode_path '\' map_name_path '\stratergy.json'
        f := JsonFile(f_path)

        f.save(data)
    }
}