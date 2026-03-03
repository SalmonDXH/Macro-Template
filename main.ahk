#Requires AutoHotkey v2.0
#Include main\__init__.ahk


Logging.debug('Load ui', 'UI')

show_home_ui()

F1:: SetSize()
F2:: unset
F3:: Reload()

F4:: {
    SetSize()
    for id, i in Image.GetService(1) {
        MsgBox id ' ' i.name
        if i.Check() {
            MsgBox id
            break
        }
    }
}
Esc:: ExitApp()