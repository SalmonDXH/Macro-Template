#Include ..\findtext\CustomFindText.ahk
#Include ..\OCR\ocr.ahk


class Image {
    search := unset
    type := unset
    start := unset
    end := unset


    __New(search, image_type, start, end) {
        (search is String) ? this.search := search : this.search := unset
        (image_type is String) ? this.type := image_type : this.type := unset
        (start is Object and start.HasProp('x') and start.HasProp('y') and start.x is Number and start.y is Number) ? this.start := start : this.start := unset
        (end is Object and ((end.HasProp('x') and end.HasProp('y') and end.x is Number and end.y is Number) or (end.HasProp('w') and end.HasProp('h') and end.w is Number and end.h is Number))) ? this.end := end : this.end := unset
    }

    Check(options := {}) {
        if IsSet(this.search) and IsSet(this.type) and IsSet(start) and IsSet(end) {
            switch this.type {
                case 'FindText':
                    tolerance := (options.HasProp('tolerance')) ? Number(options.tolerance) : 0
                    return FT.check_by_window(this.search, this.start.x, this.start.y, this.end.x, this.end.y, tolerance)
                case 'OCR':
                    return OCR.check_by_window(this.start.x, this.start.y, this.end.w, this.end.h)
            }
        } else {
            return false
        }
    }
}