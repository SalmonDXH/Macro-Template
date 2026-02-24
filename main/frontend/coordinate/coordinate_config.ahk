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
        ; COORDINATE := Map( 'Slot 1', Map('Unit 1' , Gui.Control : Text) )
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
            if position.x and position.y {
                u := StrReplace(unit, '_', ' ')
                s := StrReplace(slot, '_', ' ')
                if !this.Coordinate.Has(s) {
                    this.Coordinate[s] := Map()
                }
                if !this.Coordinate[s].Has(u) {
                    this.Coordinate[s][u] := UI.add_text(this.holder, s ' ' u)
                }
                this.Coordinate[s][u].Move(position.x, position.y)
                if this.current_slot = s {
                    this.Coordinate[s][u].SetFont('c1eaf19')
                } else {
                    this.Coordinate[s][u].SetFont('c1270db')
                }
            }
        }

        static change_coordinate_slot(slot) {
            if this.Coordinate.Has(this.current_slot) {
                for unit, text in this.Coordinate[this.current_slot] {
                    text.SetFont('c1270db')
                }
            }
            if this.Coordinate.Has(slot) {
                for unit, text in this.Coordinate[slot] {
                    text.SetFont('c1eaf19')
                }
            }
            this.current_slot := slot
        }
    }
}