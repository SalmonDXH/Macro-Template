class Utils {
    static loop_array(front?, nums := 0, back?) {
        a := []
        loop nums {
            a.Push((IsSet(front) ? front ' ' : '') A_Index (IsSet(back) ? ' ' back : ''))
        }
        return a
    }

    static array_range(from := 0, to := 0) {
        i := from
        a := []
        while i <= to {
            a.Push(i)
            i++
        }
        return a
    }
}