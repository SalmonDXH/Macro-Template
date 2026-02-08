class FileCustom {
    path => String
    __New(p) {
        this.path := p
    }

    check() {
        return FileExist(this.path)
    }

    ensure_dir() {
        SplitPath(this.path, , &dir)
        if (dir != "" and !DirExist(dir)) {
            DirCreate(dir)
        }
    }

    write(content := '') {
        if this.check() {
            FileDelete(this.path)
        } else {
            this.ensure_dir()
        }
        return FileAppend(content, this.path)
    }

    read() {
        return this.check() ? FileRead(this.path) : false
    }

    append(content := '') {
        if !this.check() {
            this.ensure_dir()
        }
        FileAppend(content, this.path)
    }

    delete() {
        if this.check() {
            FileDelete(this.path)
        }
    }

}