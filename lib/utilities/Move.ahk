class Move {
    static _move(keybind, delay) {
        SendMode('Input')
        SendInput('{' keybind ' Down}')
        Sleep delay
        SendInput(' {' keybind ' Up}')
    }
}