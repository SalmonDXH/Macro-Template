class Mouse {
    static click(x, y) {
        SendMode('Event')
        MouseMove(x, y)
        MouseMove(0, 0, , "R")
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

    static multi_scroll(scroll_type, scroll_time := 1, delay := 10) {
        switch scroll_type {
            case 'up':
                Loop scroll_time {
                    this.scroll_up(delay)
                }
            case 'down':
                Loop scroll_time {
                    this.scroll_down(delay)
                }

        }
    }

    static FT_click(data) {
        if data and data.HasProp('x') and data.HasProp('y') {
            this.click(data.x, data.y)
        }
    }
}