#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
    Automates login for BPJS Fingerprint application.

#ce ----------------------------------------------------------------------------

; === Configuration ===
AutoItSetOption("WinTitleMatchMode", 3)

Global Const $FINGERPRINT_TITLE = "[REGEXPCLASS:HwndWrapper\[After\.exe;;.*\]]"
Global Const $FINGERPRINT_PATH  = "C:\Program Files (x86)\BPJS Kesehatan\Aplikasi Sidik Jari BPJS Kesehatan\After.exe"

; === Validate arguments ===
If $CmdLine[0] < 3 Then
    MsgBox(16, "Error", "Missing arguments. Usage: open-fingerprint.au3 <username> <password> <bpjsno>")
    Exit
EndIf

; === Command line args ===
Local $username = $CmdLine[1]
Local $password = $CmdLine[2]
Local $bpjsno   = $CmdLine[3]

; === Helper functions ===

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
    Local $hWin = WinWait($title, "", 30)
    WinSetState($hWin, "", @SW_SHOW)
    WinSetOnTop($hWin, "", 1)
    WinActivate($hWin)
    WinWaitActive($hWin)
    Return $hWin
EndFunc

; === Main Logic ===

Run($FINGERPRINT_PATH)
FocusWindow($FINGERPRINT_TITLE)

Sleep(1000)
SafeSend($username)
Send("{TAB}")
SafeSend($password)
Send("{TAB}")
Send("{ENTER}")

Sleep(1000)
Send($bpjsno, 0)
