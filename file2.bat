@echo off
set PYTHON_PATH=%userprofile%\AppData\Local\Programs\Python\Python313\pythonw.exe
cd %TEMP%
start /b "%PYTHON_PATH%" a.py
exit
