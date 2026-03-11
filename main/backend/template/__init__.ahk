class Template {
    class Coordinate {
        class Entity {
            coordinate := Map()
            __New(name, coordinate) {
                this.name := name
                this.coordinate := (coordinate is String) ? JSON.parse(coordinate) : coordinate
                return this
            }

            Get() => this.coordinate
        }

        static Pool := Map()

        static Get(id) => (this.Pool.Has(id)) ? this.Pool[id].Get() : Map()
    }


    class Unit {
        class Ability {
            class Entity {
                name := ''
                action := []
                __New(name, action) {
                    this.name := name
                    this.action := (action is String) ? JSON.parse(action) : (action is Array) ? action : []
                    return this
                }
                Get() => (this.action is Array) ? this.action : []
            }
            static Pool := Map()

            static Get(id) => (this.Pool.Has(id)) ? this.Pool[id] : false
        }
    }
    class Stratergy {
        class Entity {
            name := ''
            stratergy := Map()
            __New(name, stratergy) {
                this.name := name
                this.stratergy := (stratergy is String) ? JSON.parse(stratergy) : (stratergy is Map) ? this.stratergy := stratergy : Map()
                return this
            }

            Get() => (this.stratergy is Map) ? this.stratergy : Map()
        }
        static Pool := Map(
            'Default', this.Entity('Default', Map('Action 1', Map()))
        )

        static Get(id) => (this.Pool.Has(id)) ? this.Pool[id] : (this.Pool.Has('Default')) ? this.Pool['Default'] : false
    }
}


#Include coordinate.ahk