;!#############################################
;! AHK CONFIGURATION
;!#############################################
#SingleInstance Force
SendMode('Event')
DetectHiddenWindows(true)
#MaxThreads 255


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

Program.close_all()
Program.run_all(['webhook', 'heartbeat'], Logging.path)

Logging.flag := true

Logging.debug('Load supported library', 'Starting')

;!#############################################
;! GENERAL CONFIGURATION
;!#############################################


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

Logging.debug('Load Config', 'Starting')


;!#############################################
;! MAIN LIBRARY
;!#############################################

#Include backend\__init__.ahk
#Include frontend\__init__.ahk
Logging.debug('Load macro library', 'Starting')

;!#############################################
;! CONNECTION BETWEEN OTHER AHK
;!#############################################

;!#############################################
;! FINAL INITIALIZE
;!#############################################


Logging.debug('Macro Launched', 'Starting')