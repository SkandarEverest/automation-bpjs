#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here



Run("C:\Program Files (x86)\BPJS Kesehatan\Aplikasi Sidik Jari BPJS Kesehatan\After.exe")
WinWaitActive("Aplikasi Verifikasi dan Registrasi Sidik Jari")
Sleep(2000)
Send("test") 
Send("{TAB}")
Send("test")
Send("{TAB}")
Send("{ENTER}")