class Game {
    class Map {
        class Entity {
            __New(id, name) {
                this.id := id
                this.name := name
                return this
            }
        }
        static Pool := Map(
            1, Game.Map.Entity(1, 'Example 1'),
            2, Game.Map.Entity(2, 'Example 2'),
            3, Game.Map.Entity(3, 'Example 3'),
            4, Game.Map.Entity(4, 'Example 4'),
        )

        static Get(id) => (this.Pool.Has(id)) ? this.Pool[id] : false

        static GetMaps(ids) {
            maps := Map()
            for id in ids {
                (this.Pool.Has(id)) ? maps[id] := this.Pool[id] : false
            }
            return maps
        }
    }

    class Mode {
        class Entity {
            __New(id, name, maps) {
                this.id := id
                this.name := name
                this.maps := Game.Map.GetMaps(maps)
                return this
            }

            GetMapNames() {
                maps_name := []
                for id, m in this.maps {
                    (m is Game.Map.Entity) ? maps_name.Push(m.name) : false
                }
                return maps_name
            }
        }
        static Pool := Map(
            1, Game.Mode.Entity(1, 'Story', [1, 2]),
            2, Game.Mode.Entity(2, 'Legend Stage', [1, 3, 4]),
        )

        static GetMapNameWithId(id) => (this.Pool.Has(id)) ? this.Pool[id].GetMapNames() : []

        static GetAll() {
            modes := []
            for id, mode in this.Pool {
                (mode is Game.Mode.Entity) ? modes.Push(mode.name) : false
            }
            return modes
        }

    }
    class Playing {
        movement := 0
        team_state := Map() 0

        __New(game_mode, map_name, team_number) {
            ; Coordinate
            Coordinate.initialize(map_name, game_mode)
            ; Stratergy
            Stratergy.initialize(map_name, game_mode)
            ; Team
            Team.initialize(team_number)
        }

        _reset_team_state() {
            ; config here
            state := Map()
            Loop (Team.number_of_slot) {
                slot_name := 'slot ' A_Index
                state[slot_name] := Map()
                Loop (Team.number_of_placement) {
                    state[slot_name] := Map(
                        'current_level', 0,
                        'is_placed', false
                    )
                }
            }
            this.team_state := state
        }

        play() {
            ; Get the current action
            stratergy_data := Stratergy.Get(this.movement)
            if (stratergy_data) {

            }
            this.movement += 1
        }

        reset() {
            this.movement := 0
            this._reset_team_state()
        }
    }
}