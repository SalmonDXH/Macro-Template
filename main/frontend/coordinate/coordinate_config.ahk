class Coordinate {
    static w := 1280
    static h := 640
    static image_dir := A_ScriptDir '\data\map_image'
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

    class MapDrawing {
        static Coordinate := Map()
        static holder := Gui()
        static current_slot := 'Slot 1'

        static reset() {
            for key, val in this.Coordinate {
                if val is Gui.Control {
                    val.Destroy()
                }
            }
            this.Coordinate := Map()
        }

        static draw(unit, slot, position) {
            if !this.Coordinate.Has(slot) {
                this.Coordinate[slot] := Map()
            }
            if !this.Coordinate[slot].Has(unit) {
                this.Coordinate[slot][unit] := UI.add_text(this.holder, slot ' ' unit)
            }
            this.Coordinate[slot][unit].Move(position.x, position.y)
            if this.current_slot != slot {
                this.Coordinate[slot][unit].Opt := 'c1eaf19'
            } else {
                this.Coordinate[slot][unit].Opt := 'c1270db'
            }
        }

    }
}