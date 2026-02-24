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

    static save(map_name, game_mode := 'default') {
        coordinates := Coordinate.MapDrawing.Coordinate
        data := Map()
        for slot, items in coordinates {
            data[slot] := Map()
            for unit, ctrl in items {
                ctrl.GetPos(&x, &y)
                data[slot][unit] := Map('x', x, 'y', y)
            }
        }
        file_name := StrReplace(game_mode '\' map_name, ' ', '_')
        JsonFile(A_ScriptDir '\data\coordinate\' file_name '.json').save(data)
    }

    class MapDrawing {
        ; COORDINATE := Map( 'Slot 1', Map('Unit 1' , Gui.Control : Text) )
        static Coordinate := Map()
        static holder := Gui()
        static main_holder := Gui()
        static current_slot := 'Slot 1'

        static reset() {
            for slot, items in this.Coordinate {
                if items is Map {
                    for u, unit_text in items {
                        if unit_text is Gui.Control {
                            unit_text.Value := ''
                        }

                    }
                }
            }
        }


        static draw(unit, slot, position, ctrl?) {
            if position.x and position.y and position.x > 0 and position.x < 800 and position.y < 600 {
                u := StrReplace(unit, '_', ' ')
                s := StrReplace(slot, '_', ' ')
                if !this.Coordinate.Has(s) {
                    this.Coordinate[s] := Map()
                }
                if !this.Coordinate[s].Has(u) {
                    this.Coordinate[s][u] := UI.add_text(this.holder, s ' ' u, '+BackgroundTrans')
                }
                ctrlObj := this.Coordinate[s][u]

                ctrlObj.Text := s ' ' u

                ; Force resize
                ctrlObj.GetPos(, , &w, &h)
                ctrlObj.Move(position.x, position.y, w, h)


                if this.current_slot = s {
                    this.Coordinate[s][u].SetFont('c1eaf19')
                } else {
                    this.Coordinate[s][u].SetFont('c1270db')
                }
                if (IsSet(ctrl) and ctrl is Gui.Control) {
                    ctrl.Text := u '`n(' position.x ' , ' position.y ')'
                }
            }
        }

        static click_unit_draw(unit, ctrl_slot, ctrl) {
            this.main_holder.Show()
            static ToolTipClick(*) {
                MouseGetPos(&mouse_x, &mouse_y,)
                Coordinate.MapDrawing.holder.GetPos(&map_x, &map_y)

                x := mouse_x - map_x
                y := mouse_y - map_y
                ToolTip(x ', ' y, mouse_x + 10, mouse_y + 10)
                return { x: x, y: y }
            }

            SetTimer(ToolTipClick, 1)
            KeyWait("LButton", "D")
            a := ToolTipClick()
            SetTimer(ToolTipClick, 0)
            ToolTip('')
            Coordinate.MapDrawing.draw(unit, ctrl_slot.Text, a, ctrl)
        }

        static change_coordinate_slot(slot) {
            if this.Coordinate.Has(this.current_slot) {
                for unit, text in this.Coordinate[this.current_slot] {
                    text.SetFont('c1270db')
                }
            }
            this.current_slot := slot
            if this.Coordinate.Has(slot) {
                ctrls := Map()
                for unit, text in this.Coordinate[slot] {
                    text.SetFont('c1eaf19')
                    text.GetPos(&x, &y)
                    ctrls[unit] := { x: x, y: y }
                }
                return ctrls
            } else {
                return Map()
            }


        }
    }
}