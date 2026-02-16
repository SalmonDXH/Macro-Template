#Include ..\discord\resources\JSON.ahk
#Include File.ahk

Class JsonFile extends FileCustom {
    read() {
        try {
            return this.check() ? JSON.parse(FileRead(this.path)) : Map()
        }
        return Map()
    }

    save(data) {
        s := ''
        if data is Map {
            s := JSON.stringify(data)
        } else if data is String {
            s := data
        }
        super.write(s)
    }
}