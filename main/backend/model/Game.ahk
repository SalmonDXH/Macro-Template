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
}