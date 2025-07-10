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


; === Main Logic ===

Local $exe = "C:\Program Files (x86)\BPJS Kesehatan\Aplikasi Sidik Jari BPJS Kesehatan\After.exe"

Local $pid = Run($exe)

Local $winTitle = ""

Local $hWnd = ""


; Wait up to 30 seconds for the window to appear
For $i = 1 To 30
	Local $winList = WinList()
	For $j = 1 To $winList[0][0]
        Local $hWnd = $winList[$j][1]
		If WinGetProcess($hWnd) = $pid Then
			$winTitle = $winList[$j][0]
			ExitLoop 2
		EndIf
	Next
	Sleep(1000)
Next

If $winTitle <> "" Then
	WinWaitActive("Aplikasi Registrasi Sidik Jari")
	ConsoleWrite("Operation Completed" & @CRLF)
Else
	ConsoleWrite("Timeout: No window found for PID: " & $pid & @CRLF)
EndIf

Local $aPos = WinGetPos($winTitle) ; [X, Y, Width, Height]
Local $clickX = $aPos[0] + 235
Local $clickY = $aPos[1] + 177

Sleep(1000)
MouseClick("left", $clickX, $clickY)
SafeSend($username)
Send("{TAB}")
SafeSend($password)
Send("{TAB}")
Send("{ENTER}")

Sleep(1000)
Send($bpjsno, 0)
