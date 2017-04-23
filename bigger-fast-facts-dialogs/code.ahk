#include OnWin.ahk


SayTheTime_ActiveEvent()


SayTheTime_ActiveEvent(this:="") {
    if (!this) {
      OnWin("Active", "Fast Facts ahk_exe SayTimeMain.exe", Func(A_ThisFunc))
    } else if ("Active" == this.Event ) {
      OnWin("NotActive", this.WinTitle, this.Callback)
      GoSub Say_the_time_Resize
    } else if ("NotActive" == this.Event ) {
      OnWin("Active", this.WinTitle, this.Callback)
      WinClose Fast Facts ahk_exe SayTimeMain.exe
    }
  }

  Say_the_time_Resize:
    SysGet, MonitorWorkArea, MonitorWorkArea, 0
    AvalHeight := MonitorWorkAreaBottom
    WinHeight := 700 ;   650

    WinWait Fast Facts ahk_exe SayTimeMain.exe

    ControlMove PSMonthCalendar1,,WinHeight - 250,,, Fast Facts ahk_exe SayTimeMain.exe
    ControlMove ListBox1,,,,WinHeight - 325, Fast Facts ahk_exe SayTimeMain.exe
    ControlFocus PSMonthCalendar1, Fast Facts ahk_exe SayTimeMain.exe

    WinMove Fast Facts ahk_exe SayTimeMain.exe,,,AvalHeight - WinHeight ,,WinHeight

    Send {Home}{Tab}{Down 3}
  Return
