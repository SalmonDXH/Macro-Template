class Move {
    static speed_multiplier := 1
    static _move(keybind, delay) {
        SendMode('Input')
        SendInput('{' keybind ' Down}')
        Sleep delay / ((this.speed_multiplier) ? this.speed_multiplier : 1)
        SendInput(' {' keybind ' Up}')
    }
}