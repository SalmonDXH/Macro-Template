#SingleInstance Force


#Include lib\screenshot\Screenshot.ahk
#Include lib\ui\func\UI.ahk
#Include lib\capture\Capture.ahk

UI.background_color := 'ffffff'
UI.text_color := '000000'

main_ui := Gui('+AlwaysOnTop', 'Developer Dashboard')
main_ui.OnEvent('Close', (*) => ExitApp())
main_ui.Show('w400 h200')


roblox_window := 'ahk_exe RobloxPlayerBeta.exe'

Capture.window := roblox_window

capture_area_button := UI.add_button(main_ui, 'Capture Area')
capture_area_button.OnEvent('Click', (*) => Capture.start(main_ui.Hwnd))

capture_pos_button := UI.add_button(main_ui, 'Capture Pos')
capture_pos_button.OnEvent('Click', (*) => capturing_pos_func())

capturing_pos_func() {
    Capture.capture_pos(main_ui.Hwnd, &x, &y)
    A_Clipboard := x ', ' y
}

UI.grid_layout(main_ui, [
    [capture_area_button, capture_pos_button]
], , , 10, 10)