  IsClickOnClock() {
    MouseGetPos, , , WhichWindow, WhichControl
    ControlGetPos, x, y, w, h, %WhichControl%, ahk_id %WhichWindow%
    if ("TrayClockWClass1" == WhichControl) {
      return true
    }
    return false
  }


	#if IsClickOnClock()
		MButton::Send {LButton}
		LButton::
			ControlGet, hClock, Hwnd,, TrayClockWClass1, ahk_class Shell_TrayWnd ; https://autohotkey.com/board/topic/70770-win7-taskbar-clock-toggle/
			if (hClock) {
				VarSetCapacity(IID_IAccessible, 16), DllCall("ole32\CLSIDFromString", "WStr", "{618736e0-3c3d-11cf-810c-00aa00389b71}", "Ptr", &IID_IAccessible)
				if (DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hClock, "UInt", OBJID_CLIENT := 0xFFFFFFFC, "Ptr", &IID_IAccessible, "Ptr*", accTrayClock))
					return
				VarSetCapacity(variant, A_PtrSize == 8 ? 24 : 16, 0), NumPut(VT_I4 := 3, variant,, "UShort")
				DllCall(NumGet(NumGet(accTrayClock+0)+25*A_PtrSize), "Ptr", accTrayClock, "Ptr", &variant) ; IAccessible::DoDefaultAction
				ObjRelease(accTrayClock)
			}
		Return
	#if
