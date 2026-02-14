#Requires AutoHotkey v2.0
#Include main\__init__.ahk


Logging.debug('Load ui', 'UI')

show_home_ui()

F1:: SetSize()
F3:: Reload()

Esc:: ExitApp()