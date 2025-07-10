#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Automates login and BPJS number input to Frista.

#ce ----------------------------------------------------------------------------

AutoItSetOption("WinTitleMatchMode", 3)

; === Validate arguments ===
If $CmdLine[0] < 3 Then
    MsgBox(16, "Error", "Missing arguments. Usage: open-frista.au3 <username> <password> <bpjsno>")
    Exit
EndIf

; === Command line arguments ===
Local $username = $CmdLine[1]
Local $password = $CmdLine[2]
Local $bpjsno   = $CmdLine[3]

; === Constants ===
Global Const $LOGIN_TITLE = "[TITLE:Login Frista (Face Recognition BPJS Kesehatan); CLASS:TkTopLevel]"
Global Const $MAIN_TITLE  = "[TITLE:Frista (Face Recognition BPJS Kesehatan); CLASS:TkTopLevel]"
Global Const $FRISTA_PATH = "C:\Program Files (x86)\BPJS Kesehatan\frista.v.3.0.1\frista.exe"

; === Helper Functions ===

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

Func FocusWindow($title)
    Local $hWin = WinWait($title, "", 60)
    WinSetState($hWin, "", @SW_SHOW)
    WinSetOnTop($hWin, "", 1)
    WinActivate($hWin)
    Return $hWin
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
    Local $hMain = FocusWindow($MAIN_TITLE)
    Local $aPos = WinGetPos($MAIN_TITLE) ; [X, Y, Width, Height]
    Local $clickX = $aPos[0] + 800
    Local $clickY = $aPos[1] + 140
    MouseClick("left", $clickX, $clickY)
    Send($bpjsno, 0)
EndFunc

; === Main Logic ===

If WinExists($LOGIN_TITLE) Then
    FocusWindow($LOGIN_TITLE)
    PerformLogin()
    HandleMainWindow()

ElseIf WinExists($MAIN_TITLE) Then
    HandleMainWindow()

Else
    Run($FRISTA_PATH)
    FocusWindow($LOGIN_TITLE)
    PerformLogin()
    HandleMainWindow()
EndIf
