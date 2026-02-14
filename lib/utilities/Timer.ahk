class Timer {
    static get_next_half_hour() {
        return (30 - Mod(A_Min, 30)) * 60 * 1000 + (60 - A_Sec) * 1000
    }

    static get_today() {
        return FormatTime(A_NowUTC, "dddd")
    }
}