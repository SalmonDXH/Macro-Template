#Include ..\findtext\CustomFindText.ahk
#Include ..\OCR\ocr.ahk


class Image {
    class Entity {
        id := -1
        name := ''
        search := unset
        type := unset
        start := unset
        end := unset


        __New(id, name, image_type, start, end, search) {
            this.id := id
            this.name := name
            this.search := search
            this.type := image_type
            (start is Object and start.HasProp('x') and start.HasProp('y') and start.x is Number and start.y is Number) ? this.start := start : this.start := unset
            (end is Object and ((end.HasProp('x') and end.HasProp('y') and end.x is Number and end.y is Number) or (end.HasProp('w') and end.HasProp('h') and end.w is Number and end.h is Number))) ? this.end := end : this.end := unset
        }

        Check(options := {}) {

            switch this.type {
                case 'FindText':
                    tolerance := (options.HasProp('tolerance')) ? Number(options.tolerance) : 0
                    return FT.check_by_window(this.search, this.start.x, this.start.y, this.end.x, this.end.y, tolerance)
                case 'OCR':
                    result := OCR.check_by_window(this.start.x, this.start.y, this.end.w, this.end.h)
                    return (InStr(result, this.search)) ? true : false

            }
            return false
        }

        Click(options := {}) {

        }
    }

    static Pool := Map()
    static Get(service_id, image_id) => (this.Pool.Has(service_id) and this.Pool[service_id].Has(image_id) and this.Pool[service_id][image_id] is Image.Entity) ? this.Pool[service_id][image_id] : false
    static GetService(service_id) => (this.Pool.Has(service_id)) ? this.Pool[service_id] : false
}