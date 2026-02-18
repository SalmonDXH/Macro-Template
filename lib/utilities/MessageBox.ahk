Class MessageBox {
    static warn(context := '', title := '') {
        return this._start(context, title, 0x30)

    }
    static _start(context := '', title := '', option := 0x000000) {
        return MsgBox(context, title, option + 0x40000)
    }
}