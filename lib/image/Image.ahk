#Include ..\findtext\CustomFindText.ahk
#Include ..\OCR\ocr.ahk
#Include ..\file\JsonFile.ahk


class Image {
    class Entity {
        id := -1
        name := ''
        keyword := unset
        type := unset
        coordinate := {}


        __New(id, name, image_type, coordinate, keyword) {
            this.id := id
            this.name := name
            this.keyword := keyword
            this.type := image_type
            this.coordinate := coordinate
        }

        Check() {

            switch this.type {
                case 'FindText':
                    tolerance := (this.coordinate.HasProp('tolerance')) ? Number(this.coordinate.tolerance) : 0
                    return FT.check_by_window(this.keyword, this.coordinate.sx, this.coordinate.sy, this.coordinate.ex, this.coordinate.ey, tolerance)
                case 'OCR':
                    result := OCR.check_by_window(this.coordinate.sx, this.coordinate.sy, this.coordinate.w, this.coordinate.h)
                    return (InStr(result, this.keyword)) ? true : false

            }
            return false
        }

        Click(options := {}) {

        }

        ToMap() => Map(
            'id', this.id,
            'name', this.name,
            'keyword', this.keyword,
            'type', this.type,
            'coordinate', this.coordinate,
        )
    }

    static Pool := Map()

    static Type := ['FindText', 'OCR']

    static Get(service_id, image_id) => (this.Pool.Has(service_id) and this.Pool[service_id].Has(image_id) and this.Pool[service_id][image_id] is Image.Entity) ? this.Pool[service_id][image_id] : false
    static GetService(service_id) => (this.Pool.Has(service_id)) ? this.Pool[service_id] : false

    static Initialize() {
        f := JsonFile(A_ScriptDir '\data\config\image.json')
        data := f.read()
        for category, pool in data {
            if pool is Map {
                if !this.Pool.Has(category) {
                    this.Pool[category] := Map()
                }
                for image_name, image in pool {
                    if this.Pool[category].Has(image_name) {
                        id := this.Pool[category][image_name].id
                    } else {
                        id := 1 + this.Pool[category].Count
                    }
                    name := (image.Has('name')) ? image['name'] : ''
                    keyword := (image.Has('keyword')) ? image['keyword'] : ''
                    t := (image.Has('type')) ? image['type'] : ''
                    c := { sx: 0, sy: 0, es: 0, ey: 0, w: 0, h: 0 }
                    if image.Has('coordinate') {
                        coor := image['coordinate']
                        try c.sx := Integer(coor['sx'])
                        try c.sy := Integer(coor['sy'])

                        try c.ex := Integer(coor['ex'])
                        try c.ey := Integer(coor['ey'])

                        try c.w := Integer(coor['w'])
                        try c.h := Integer(coor['h'])
                    }

                    this.Pool[category][image_name] := this.Entity(id, name, t, c, keyword)
                }
            }

        }
    }

    static Save() {
        f := JsonFile(A_ScriptDir '\data\config\image.json')
        dict := Map()
        for service, pool in this.Pool {
            dict[service] := Map()
            for image_name, image in pool {
                (image is this.Entity) ? dict[service][image_name] := image.ToMap() : false
            }
        }

        f.save(dict)
    }

    static test() {
        dict := Map()
        for service, pool in this.Pool {
            dict[service] := Map()
            for image_name, image in pool {
                (image is this.Entity) ? dict[service][image_name] := image.ToMap() : false
            }
        }

    }
}