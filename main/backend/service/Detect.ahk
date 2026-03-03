#Include ..\config\image.ahk

class Detect {
    static Check(service_id) {
        image_service_pool := Image.GetService(service_id)
        if image_service_pool is Map {
            for id, i in image_service_pool {
                if i is Image.Entity and i.Check() {
                    return i
                }
            }
        }
        return false
    }

    static Click(service_id, id) {
        entity := Image.Get(service_id, id)
        if entity {
            entity.Click()
        }
    }
}