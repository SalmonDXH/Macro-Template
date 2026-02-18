;!#############################################
;! AHK CONFIGURATION
;!#############################################
#SingleInstance Force
SendMode('Event')
DetectHiddenWindows(true)
#MaxThreads 255


;!#############################################
;! GENERAL CONFIGURATION
;!#############################################


Credit_Config := {
    owner: 'Salmon',
    social: {
        discord: 'https://www.discord.gg/salmon',
        youtube: '',
        website: ''
    }
}

PC_Config := {
    height: A_ScreenHeight,
    width: A_ScreenWidth,
    resolution: A_ScreenWidth / A_ScreenHeight,
}

Macro_Config := {
    name: 'Template',
    version: '1.0.0',
}

Roblox_Config := {
    window: 'ahk_exe RobloxPlayerBeta.exe',
    process: 'RobloxPlayerBeta.exe'
}


Game_Config := {}

;!#############################################
;! OTHER LIBRARY
;!#############################################

#Include ..\lib\security\Scriptguard.ahk
#Include ..\lib\logging\Logging.ahk
#Include ..\lib\ui\func\UI.ahk
#Include ..\lib\file\__init__.ahk
#Include ..\lib\discord\WEBHOOK.ahk
#Include ..\lib\screenshot\Screenshot.ahk
#Include ..\lib\program\Program.ahk
#Include ..\lib\utilities\__init__.ahk
#Include ..\lib\findtext\CustomFindText.ahk


Program.close_all()
Program.run_all(['webhook', 'heartbeat'], Logging.path)

FT.window := Roblox_Config.window
Logging.flag := true

Logging.debug('Load supported library', 'Starting')


;!#############################################
;! MAIN LIBRARY
;!#############################################

#Include backend\__init__.ahk
#Include frontend\__init__.ahk
Logging.debug('Load macro library', 'Starting')

;!#############################################
;! CONNECTION BETWEEN OTHER AHK (API)
;!#############################################

;!#############################################
;! FINAL INITIALIZE
;!#############################################


Logging.debug('Macro Launched', 'Starting')