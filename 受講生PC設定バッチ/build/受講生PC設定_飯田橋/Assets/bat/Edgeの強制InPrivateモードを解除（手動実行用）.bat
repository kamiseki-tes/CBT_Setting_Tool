@echo off

echo *****************************************************
echo EdgeでInPrivateモードを強制する設定を解除する(手動実行)
echo v1.00
echo *****************************************************
echo;

rem 管理者権限で実行していなければ管理者権限で再実行する
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas"
exit
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "InPrivateModeAvailability" /t REG_DWORD /d "0" /f
echo EdgeでInPrivateモードを強制する設定を一時的に解除しました
echo PCを再起動後に変更が適用されます

pause