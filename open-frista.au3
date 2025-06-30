#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
AutoItSetOption("WinTitleMatchMode", 3)

If $CmdLine[0] < 3 Then
    MsgBox(16, "Error", "Missing arguments. Usage: open-frista.au3 <username> <password> <bpjsno>")
    Exit
EndIf

; Get values from command line
Local $username = $CmdLine[1]
Local $password = $CmdLine[2]
Local $bpjsno      = $CmdLine[3]

; === Config ===
Global Const $LOGIN_TITLE = "[TITLE:Login Frista (Face Recognition BPJS Kesehatan); CLASS:TkTopLevel]"
Global Const $MAIN_TITLE  = "[TITLE:Frista (Face Recognition BPJS Kesehatan); CLASS:TkTopLevel]"
Global Const $FRISTA_PATH = "C:\Program Files (x86)\BPJS Kesehatan\frista.v.3.0.1\frista.exe"


; === Functions ===

Func SafeSend($text)
    $text = StringReplace($text, "{", "{" & "{")
    $text = StringReplace($text, "}", "}" & "}")
    $text = StringReplace($text, "[", "{[}")
    $text = StringReplace($text, "]", "{]}")
    $text = StringReplace($text, "#", "{#}")
    $text = StringReplace($text, "!", "{!}")
    $text = StringReplace($text, "+", "{+}")
    $text = StringReplace($text, "^", "{^}")
    Send($text, 0)
EndFunc

Func PerformLogin()
    Local $aPos = WinGetPos($LOGIN_TITLE) ; [X, Y, Width, Height]
    Local $clickX = $aPos[0] + 400
    Local $clickY = $aPos[1] + 400

    Sleep(1000)
    SafeSend($username) 
    Send("{TAB}")
    SafeSend($password)
    Send("{TAB}")
    MouseClick("left", $clickX, $clickY)
    Sleep(1000)
EndFunc

Func HandleMainWindow()
    Local $hMain = WinWait($MAIN_TITLE, "", 60)
    WinSetState($hMain, "", @SW_SHOW)
    WinSetOnTop($hMain, "", 1)
    WinActivate($hMain)
    WinWaitActive($hMain)

    Send($bpjsno, 0)
EndFunc


; === Decision Logic ===

If WinExists($LOGIN_TITLE) Then
    Local $hLogin = WinWait($LOGIN_TITLE, "", 60)
    WinSetState($hLogin, "", @SW_SHOW)
    WinSetOnTop($hLogin, "", 1)
    WinActivate($hLogin)
    WinWaitActive($hLogin)
    PerformLogin()
    HandleMainWindow()
ElseIf WinExists($MAIN_TITLE) Then
    HandleMainWindow()
Else
    Run($FRISTA_PATH)
    WinActivate($LOGIN_TITLE)
    WinWaitActive($LOGIN_TITLE)
	PerformLogin()
    HandleMainWindow()
EndIf


