class UI {
    static grid_layout(parent_gui, control_list := [], margin_x := 10, margin_y := 10) {
        if !(parent_gui is Gui) {
            return Type(parent_gui) ' is not a Gui'
        }

        if !(control_list is Array) {
            return Type(control_list) ' is not an array'
        }

        if !control_list.Length {
            return 'control_list must have higher than 0 element'
        }

        if !(margin_x is Number) or (margin_x < 0) {
            return 'Invalid margin_x'
        }

        if !(margin_y is Number) or (margin_y < 0) {
            return 'Invalid margin y'
        }

        rows := control_list.Length

        parent_gui.GetClientPos(, , &parent_width, &parent_height)
        h := (parent_height - (margin_y * (rows + 1))) / rows

        for row in control_list {
            if row is Array and row.Length {
                collumns := row.Length
                w := (parent_width - (margin_x * (collumns + 1))) / collumns
                y := (A_Index * margin_y) + h * (A_Index - 1)

                for control in row {
                    x := (A_Index * margin_x) + w * (A_Index - 1)

                    if control is Gui {
                        this.gui_move(control, x, y, w, h)
                    } else if control is Gui.Control {
                        this.control_move(control, x, y, w, h)
                    }
                }
            }
        }

        return 'Successfully change apply grid out to ' parent_gui.name
    }

    static gui_move(ctrl, x, y, w, h) {
        return ctrl is Gui ? ctrl.show('x' x ' y' y ' w' w ' h' h) : false
    }

    static control_move(ctrl, x, y, w, h) {
        return ctrl is Gui.Control ? ctrl.move('x' x ' y' y ' w' w ' h' h) : false
    }
}