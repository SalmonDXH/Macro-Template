class UI {
    static height := 800
    static width := 1260
    static background_color := '000000'
    static text_color := 'ffffff'
    static title_color := 'ffffff'
    static groupbox_size := 12
    static text_size := 10


    static get_w_h_from_gui(g) {
        if g is Gui {
            g.GetClientPos(, , &w, &h)
            return { w: w, h: h }
        } else {
            return false
        }
    }

    static add_button(ctrl, context?) {
        return ctrl is Gui ? ctrl.AddButton('+Background' this.background_color, IsSet(context) ? context : '') : false
    }

    static add_checkbox(ctrl, context?, color := this.text_color, var_name?) {
        return ctrl is Gui ? ctrl.AddCheckbox('c' color ' ' (IsSet(var_name) ? 'v' var_name : ''), IsSet(context) ? context : '') : false
    }

    static add_text(ctrl, context?, align := '') {
        return ctrl is Gui ? ctrl.AddText('c' this.text_color ' ' align, (IsSet(context)) ? context : '') : false
    }

    static add_edit(ctrl, context?, private := false, var_name?) {
        return ctrl is Gui ? ctrl.AddEdit('c000000 ' (private ? '+Password ' : '') ' ' (IsSet(var_name) ? 'v' var_name : ''), IsSet(context) ? context : '') : false
    }
    static add_ddl(ctrl, ar := [], var_name?) {
        if ctrl is Gui {
            a := ctrl.AddDDL('c000000' ' ' (IsSet(var_name) ? 'v' var_name : ''), ar)
            try a.Choose(1)
            return a
        } else {
            return false
        }
    }

    static add_pic(ctrl, path := '') {
        return ctrl is Gui ? ctrl.AddPicture(, (FileExist(path) ? path : '')) : false
    }

    static grid_layout(parent_gui, control_list := [], margin_x := 10, margin_y := 10, padding_x := 0, padding_y := 0) {
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

        if !(padding_x is Number) or (padding_x < 0) {
            return 'Invalid padding x'
        }

        if !(padding_y is Number) or (padding_y < 0) {
            return 'Invalid padding y'
        }

        rows := control_list.Length

        parent_gui.GetClientPos(, , &parent_width, &parent_height)
        h := (parent_height - padding_y * 2 - (margin_x * (rows - 1))) / rows

        for row in control_list {
            if row is Array and row.Length {
                collumns := row.Length
                if !collumns {
                    continue
                }
                w := (parent_width - padding_x * 2 - (margin_x * (collumns - 1))) / collumns
                y := padding_y + ((A_Index - 1) * margin_y) + h * (A_Index - 1)

                for control in row {
                    x := padding_x + ((A_Index - 1) * margin_x) + w * (A_Index - 1)

                    if control is Gui {
                        this.gui_move(control, x, y, w, h)
                    } else if control is Gui.Control {
                        this.control_move(control, x, y, w, h)
                    }
                }
            }
        }

        return 'Successfully change apply grid out to ' parent_gui.Title
    }

    static gui_move(ctrl, x, y, w, h) {
        return ctrl is Gui ? ctrl.show('x' x ' y' y ' w' w ' h' h) : false
    }

    static gui_simple(ctrl, w, h) {
        return ctrl is Gui ? ctrl.show('w' w ' h' h) : false
    }

    static control_move(ctrl, x, y, w, h) {
        return ctrl is Gui.Control ? ctrl.Move(x, y, w, h) : false
    }

    static add_to_parent(parent_gui) {
        if parent_gui is Gui {
            g := Gui('-Caption -Border +AlwaysOnTop -Resize +Parent' parent_gui.Hwnd)
            g.BackColor := parent_gui.BackColor
            g.SetFont('s' this.text_size)
            return g
        }
        return false
    }

    static add_to_owner(parent_gui) {
        if parent_gui is Gui {
            g := Gui('+AlwaysOnTop -Resize +Owner' parent_gui.Hwnd)
            g.BackColor := parent_gui.BackColor
            return g
        }
        return false
    }

    static gui_groupbox(g, name := '', color := this.title_color) {
        if g is Gui {
            c := IsSet(color) ? color : 'ffffff'
            g.GetClientPos(, , &w, &h)
            gp := g.AddGroupBox('x0 y0 w' w ' h' h ' c' c, name)
            gp.SetFont('bold s' this.groupbox_size)
            return gp
        }
        return false
    }

    static get_image(bit, path) {

    }

    static round_gui(hwnd) {
        ; Window MUST be visible
        WinGetPos(, , &w, &h, "ahk_id " hwnd)
        if (w <= 0 || h <= 0)
            return false

        ; Create ellipse region (perfect vector)
        hRgn := DllCall(
            "CreateEllipticRgn",
            "int", 0,
            "int", 0,
            "int", w,
            "int", h,
            "ptr"
        )

        DllCall("SetWindowRgn", "ptr", hwnd, "ptr", hRgn, "int", true)

        ; Force redraw (important for child GUIs)
        DllCall("RedrawWindow",
            "ptr", hwnd,
            "ptr", 0,
            "ptr", 0,
            "uint", 0x85
        )

        return true
    }


    static drag(hwnd, f?) {
        static WM_NCLBUTTONDOWN := 0xA1
        static HTCAPTION := 2
        PostMessage(WM_NCLBUTTONDOWN, HTCAPTION, , , "ahk_id " hwnd)
        (IsSet(f) and f is Func) ? f.Call() : false
    }
}