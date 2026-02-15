#Include FindText.ahk
class FT {
    static window := ''

    static check_by_window(image, x_begin := 0, y_begin := 0, x_end := 0, y_end := 0, tolerance := 0) {
        DetectHiddenWindows(true)
        try {
            if WinExist(this.window) and image is String {
                WinGetPos(&x, &y, , , this.window)
                return FindText(, , x + x_begin, y + x_begin, x + x_end, y + y_end, tolerance, tolerance, image)
            } else {
                return false
            }
        } catch {
            return false
        }
    }

    static click_by_window(image, x_begin := 0, y_begin := 0, x_end := 0, y_end := 0, tolerance := 0) {
        DetectHiddenWindows(true)
        try {
            if WinExist(this.window) and image is String {
                WinGetPos(&x, &y, , , this.window)
                if FindText(&x_found, &y_found, x + x_begin, y + x_begin, x + x_end, y + y_end, tolerance, tolerance, image) {
                    return { x: x_found - x, y: y_found }
                } else {
                    return false
                }
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}