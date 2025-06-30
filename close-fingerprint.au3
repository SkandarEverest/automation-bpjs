#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
AutoItSetOption("WinTitleMatchMode", 3)

Global Const $FINGERPRINT_TITLE = "[REGEXPCLASS:HwndWrapper\[After\.exe;;.*\]]"

Func CloseWindow($title)
    If WinExists($title) Then
        WinClose($title)
        Sleep(500)
        If WinExists($title) Then
            ; Force close if still open
            ProcessClose("after.exe")
        EndIf
    EndIf
EndFunc

Func KillHangingAutomation()
    If ProcessExists("open-fingerprint.exe") Then
        ProcessClose("open-fingerprint.exe")
    EndIf
EndFunc

CloseWindow($FINGERPRINT_TITLE)
KillHangingAutomation()

Exit
