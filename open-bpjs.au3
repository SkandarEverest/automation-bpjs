#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

Run("C:\Program Files (x86)\BPJS Kesehatan\Aplikasi Sidik Jari BPJS Kesehatan\After.exe")
WinSetState("[CLASS:Chrome_WidgetWin_1]", "", @SW_MINIMIZE)
WinWaitActive("[REGEXPCLASS:HwndWrapper.*]")

Sleep(1000)
Send("test", 0) 
Send("{TAB}")
Send("test", 0)
Send("{TAB}")
Send("{ENTER}")