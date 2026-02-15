class Capture {
    static window := ''
    static x := 0
    static y := 0
    static w := 0
    static h := 0

    static start(ctrl) {
        if WinExist(this.window) {
            WinGetPos(&x, &y, , , ctrl)
            WinMove(x - 800, y, 800, 598, this.window)
            capture_zone := Gui('+AlwaysOnTop -Caption -Border +Resize')
            capture_zone.OnEvent('Resize', (*) => ExitApp())
            capture_zone.Show('w100 h100')
        } else {
            MsgBox('Target window not found')
        }
    }

    static _finish(capture_zone_gui, close_gui) {
        capture_zone_gui.Delete()
        close_gui.Delete()
    }
}