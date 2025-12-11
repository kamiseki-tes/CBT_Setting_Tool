rem winVer固定ツール
@echo off
cd /d %~dp0
cd Assets
rem 必ず管理者権限で実行する
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas"
exit
)

@echo on
rem LGPOのバックアップ復元を実行
LGPO.exe /m registry.pol /v

@echo Windowsを再起動してください
pause
