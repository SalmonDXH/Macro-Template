class Capture {
    static window := ''
    static x := 0
    static y := 0
    static w := 0
    static h := 0

    static start(ctrl) {
        if WinExist(this.window) {
            if !WinExist('Capture Zone') {
                static drag(hwnd) {
                    static WM_NCLBUTTONDOWN := 0xA1
                    static HTCAPTION := 2
                    PostMessage(WM_NCLBUTTONDOWN, HTCAPTION, , , "ahk_id " hwnd.hwnd)

                    KeyWait("LButton")

                    if WinExist(Capture.window) {
                        WinGetPos(&x_win, &y_win, , , Capture.window)
                        WinGetPos(&x, &y, &w, &h, hwnd.hwnd)

                        Capture.x := x - x_win
                        Capture.y := y - y_win
                        Capture.w := w
                        Capture.h := h

                        hwnd["drag"].Text := "x: " Capture.x " y: " Capture.y " w: " Capture.w " h: " Capture.h
                    }
                }

                static resize_control(hwnd, ctrl) {
                    WinGetPos(, , &w, &h, hwnd.hwnd)
                    ctrl.Move(0, 0, w, h)
                    if (WinExist(Capture.window)) {
                        WinGetPos(&x_win, &y_win, , , Capture.window)
                        WinGetPos(&x, &y, &w, &h, hwnd.hwnd)
                        Capture.x := x - x_win
                        Capture.y := y - y_win
                        Capture.w := w
                        Capture.h := h
                        hwnd['drag'].Text := 'x: ' Capture.x ' y:' Capture.y ' w:' Capture.w ' h:' Capture.h
                    }
                }

                static FT_clipboard(hwnd) {
                    A_Clipboard := (Capture.x ', ' Capture.y ', ' Capture.x + Capture.w ', ' Capture.y + Capture.h)
                }
                WinGetPos(&x, &y, , , ctrl)
                WinActivate(this.window)
                WinMove(x - 850, y, 800, 598, this.window)
                capture_zone := Gui('+AlwaysOnTop -Caption -Border +Resize', 'Capture Zone')
                capture_zone.BackColor := 'c5dced6'

                capture_zone.SetFont('bold s16')
                capture_zone.AddButton('x10 y10 w100 h30', '✅').OnEvent('Click', (*) => capture_zone.Destroy())
                capture_zone.AddButton('x10 y50 w100 h30', 'FindText').OnEvent('Click', (*) => FT_clipboard(capture_zone))
                WinGetPos(&x, &y, &w, &h, this.window)
                start_w := this.w ? this.w : w
                start_h := this.h ? this.h : h

                capture_zone.AddText('vdrag +Center +BackgroundTrans x0 y0 w' start_w ' h' start_h).OnEvent('Click', (*) => drag(capture_zone))

                capture_zone.OnEvent('Size', (ctrl, *) => resize_control(ctrl, ctrl['drag']))
                capture_zone.Show('x' x + this.x ' y' y + this.y ' w' start_w ' h' start_h)
                WinSetTransparent(200, 'ahk_id ' capture_zone.Hwnd)

            }

        } else {
            MsgBox('Target window not found')
        }
    }

    static capture_pos(ctrl, &x?, &y?) {
        if WinExist(this.window) {
            WinGetPos(&x, &y, , , ctrl)
            WinActivate(this.window)
            WinMove(x - 800, y, 800, 598, this.window)
            static get_current_pos(&x, &y) {
                MouseGetPos(&x, &y)
                return x ', ' y
            }

            static update_tool_tip() {
                ToolTip('Click to capture:`n' get_current_pos(&x, &y), x + 10, y + 10)
            }
            SetTimer(update_tool_tip, 1)
            WinActivate(this.window)
            KeyWait('LButton', 'D')
            KeyWait('LButton')
            SetTimer(update_tool_tip, 0)
            get_current_pos(&x, &y)
            ToolTip('')
            return true
        }
    }
}