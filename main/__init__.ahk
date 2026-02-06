;!#############################################
;! AHK CONFIGURATION
;!#############################################
#SingleInstance Force
SendMode('Event')
DetectHiddenWindows(true)


;!#############################################
;! OTHER LIBRARY
;!#############################################

#Include ..\lib\security\Scriptguard.ahk
#Include ..\lib\logging\Logging.ahk
#Include ..\lib\ui\func\UI.ahk
#Include ..\lib\file\__init__.ahk
#Include ..\lib\screenshot\Screenshot.ahk
Logging.debug('Load supported library', 'Starting Macro')

;!#############################################
;! GENERAL CONFIGURATION
;!#############################################


Default_Config := {
    height: 1920,
    width: 1080,
    resolution: 16 / 9
}

Credit_Config := {
    owner: 'Salmon',
    social: {
        discord: 'discord.gg/salmon'
    }
}

PC_Config := {
    height: A_ScreenHeight,
    width: A_ScreenWidth,
    resolution: A_ScreenWidth / A_ScreenHeight,
    h_ratio: A_ScreenHeight / Default_Config.height,
    w_ratio: A_ScreenWidth / Default_Config.width
}

Macro_Config := {
    name: '',
    version: '',
    UI: {
        height: PC_Config.height * (1 / 2.5),
        width: PC_Config.width * (1 / 4),
        background_color: 0x000000
    }
}

Game_Config := {}

Logging.debug('Load Config', 'Starting Macro')


;!#############################################
;! MAIN LIBRARY
;!#############################################

#Include backend\__init__.ahk
#Include frontend\__init__.ahk
Logging.debug('Load macro library', 'Starting Macro')

;!#############################################
;! CONNECTION BETWEEN OTHER AHK
;!#############################################

;!#############################################
;! FINAL INITIALIZE
;!#############################################


Logging.debug('Macro Launched', 'Starting Macro')


ESC:: ExitApp()