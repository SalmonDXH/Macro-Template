#Requires AutoHotkey v2.0
#Include main\__init__.ahk


Logging.debug('Load ui', 'UI')

show_home_ui()


;!#############################################
;! API
;!#############################################

;- Test


F1:: Reload()
Esc:: ExitApp()