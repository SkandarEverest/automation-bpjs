#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

If $CmdLine[0] < 2 Then
    MsgBox(16, "Error", "Missing arguments. Usage: open-frista.au3 <username> <password> <bpjsno>")
    Exit
EndIf

; Get values from command line
Local $username = $CmdLine[1]
Local $password = $CmdLine[2]
Local $bpjsno   = $CmdLine[3]

Run("C:\Program Files (x86)\BPJS Kesehatan\Aplikasi Sidik Jari BPJS Kesehatan\After.exe")
WinWaitActive("[REGEXPCLASS:HwndWrapper.*]")

Sleep(1000)
Send($username, 0) 
Send("{TAB}")
Send($password, 0)
Send("{TAB}")
Send("{ENTER}")

Sleep(1000)
Send($bpjsno, 0)