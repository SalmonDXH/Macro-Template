#Include lib\RapidOcr.ahk
#Include ..\screenshot\Screenshot.ahk

class OCR {
    static window := ''
    static title_bar_height := 30

    static check_by_window(x, y, w, h) {
        DetectHiddenWindows(true)
        try {
            image_path := Screenshot.screeshot_from_app(this.window, x, y, w, h)
            o := RapidOcr().ocr_from_file(image_path)
            try FileDelete(image_path)
            return o
        } catch Error as e {
            return false
        }
    }
}