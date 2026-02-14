#Include Gdip\Gdip_All.ahk

class Screenshot {
    static path := A_ScriptDir '\data\screenshot'

    static screeshot_from_app(app, x_custom := 0, y_custom := 0, w_custom := 0, h_custom := 0, name?) {
        if app is String and WinExist(app) {
            WinGetPos(&x, &y, &w, &h, app)
            return this.screenshot(x + x_custom, y + y_custom, (w_custom) ? w_custom : w, (h_custom) ? h_custom : h, name)
        } else {
            return false
        }
    }

    static screenshot(x, y, w, h, name?) {
        DetectHiddenWindows(true)
        pToken := Gdip_Startup()
        if !pToken {
            return
        }

        pBitmap := Gdip_BitmapFromScreen("0|0|" A_ScreenWidth "|" A_ScreenHeight)
        if !pBitmap {
            Gdip_Shutdown(pToken)
            return
        }

        pCroppedBitmap := this._crop_image(pBitmap, x, y, w, h)

        if !pCroppedBitmap {
            Gdip_DisposeImage(pBitmap)
            Gdip_Shutdown(pToken)
            return
        }

        ; Save to temp file
        tempPath := this.path "\cropped_" A_TickCount (IsSet(name) ? '_' name : '') ".png"
        SplitPath(tempPath, , &dir)
        DirExist(dir) ? true : DirCreate(dir)
        Gdip_SaveBitmapToFile(pCroppedBitmap, tempPath)

        ; Create Attachment
        Gdip_DisposeImage(pBitmap)
        Gdip_DisposeImage(pCroppedBitmap)
        Gdip_Shutdown(pToken)

        return tempPath
    }

    static _crop_image(pBitmap, x, y, width, height) {
        ; Initialize GDI+ Graphics from the source bitmap
        pGraphics := Gdip_GraphicsFromImage(pBitmap)
        if !pGraphics {
            MsgBox("Failed to initialize graphics object")
            return
        }
        ; Create a new bitmap for the cropped image
        pCroppedBitmap := Gdip_CreateBitmap(width, height)
        if !pCroppedBitmap {
            MsgBox("Failed to create cropped bitmap")
            Gdip_DeleteGraphics(pGraphics)
            return
        }
        ; Initialize GDI+ Graphics for the new cropped bitmap
        pTargetGraphics := Gdip_GraphicsFromImage(pCroppedBitmap)
        if !pTargetGraphics {
            MsgBox("Failed to initialize graphics for cropped bitmap")
            Gdip_DisposeImage(pCroppedBitmap)
            Gdip_DeleteGraphics(pGraphics)
            return
        }
        ; Copy the selected area from the source bitmap to the new cropped bitmap
        Gdip_DrawImage(pTargetGraphics, pBitmap, 0, 0, width, height, x, y, width, height)
        ; Cleanup
        Gdip_DeleteGraphics(pGraphics)
        Gdip_DeleteGraphics(pTargetGraphics)
        ; Return the cropped bitmap
        return pCroppedBitmap
    }
}