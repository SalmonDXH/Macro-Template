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
}