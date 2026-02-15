SendMode('Event')

class Mouse {
    static click(x, y) {
        MouseMove(x, y)
        MouseClick("Left", 0, 0, , , , "R")
        Sleep 10
        return
    }

    static scroll_up(delay := 10) {
        SendInput("{WheelDown Down}")
        sleep delay
    }

    static scroll_down(delay := 10) {
        SendInput("{WheelUp Down}")
        sleep delay
    }

    static FT_click(data) {
        if data and data.HasProp('x') and data.HasProp('y') {
            this.click(data.x, data.y)
        }
    }
}