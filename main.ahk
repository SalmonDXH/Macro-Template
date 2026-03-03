#Requires AutoHotkey v2.0
#Include main\__init__.ahk


Logging.debug('Load ui', 'UI')

show_home_ui()

F1:: SetSize()
F2:: unset
F3:: Reload()
F4:: SetSize()
Esc:: ExitApp()