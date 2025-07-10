#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
AutoItSetOption("WinTitleMatchMode", 3)

Global Const $LOGIN_TITLE = "[TITLE:Login Frista (Face Recognition BPJS Kesehatan); CLASS:TkTopLevel]"
Global Const $MAIN_TITLE  = "[TITLE:Frista (Face Recognition BPJS Kesehatan); CLASS:TkTopLevel]"

Func CloseWindow($title)
    If WinExists($title) Then
        WinClose($title)
        Sleep(500)
        If WinExists($title) Then
            ; Force close if still open
            ProcessClose("frista.exe")
        EndIf
    EndIf
EndFunc

Func KillHangingAutomation()
    While True
        Local $pid = ProcessExists("open-frista.exe")
        If $pid = 0 Then ExitLoop
        ProcessClose($pid)
        Sleep(200) ;
    WEnd
EndFunc

CloseWindow($LOGIN_TITLE)
CloseWindow($MAIN_TITLE)

KillHangingAutomation()

Exit

