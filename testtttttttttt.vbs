' Save this code in a file with the .vbs extension (e.g., popup.vbs)
' This script shows a popup message.

Dim message, title, timeout
message = "Hello! This is your popup message."
title = "Popup Notification"
timeout = 5 ' Timeout in seconds

' Create the popup
Set shell = CreateObject("WScript.Shell")
shell.Popup message, timeout, title, 64
