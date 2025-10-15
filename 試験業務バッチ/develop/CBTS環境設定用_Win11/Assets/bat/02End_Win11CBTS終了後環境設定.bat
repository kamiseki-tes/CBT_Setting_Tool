@echo off
echo *****************************************************
echo;
echo CBTS終了後環境復旧を行います。
rem このバッチは『試験終了後』に使用してください。
rem 2017年7月31日バージョン1.00
rem 2025年10月1日バージョン1.10 Windows11で動作確認, TOEFL用のFireWall設定を削除, Defender無効化を削除
echo;
echo *****************************************************
echo;

rem 管理者権限で実行していなければ管理者権限で再実行する
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas"
exit
)

rem WindowsUpdateのスタートアップの種類は手動のままにします。
echo WindowsUpdateの自動更新を有効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f
echo;
echo WindowsUpdateを有効にします（グループポリシーによる制御）。
cd %USERPROFILE%\Desktop\CBTS環境設定用_Win11\Assets\LGPO
LGPO.exe /m 02restore.pol /v
echo;

echo ユーザアカウント制御をデフォルトに戻します。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "5" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "1" /f
echo;
rem JavaUpdateは無効のままにします。
rem スクリーンセーバーは無効のままにします。
rem 電源接続時のスリープ自動移行は「なし」のままにします。
rem ディスプレイの電源を切る設定は「なし」のままにします。

echo 適用済み確認用にデスクトップ画像を変更します。
set WALLPAPER=%USERPROFILE%\Desktop\CBTS環境設定用_Win11\Assets\img\CBTS_standby.png
reg add "HKCU\Control Panel\Desktop" /v wallpaper /t REG_SZ /d "%WALLPAPER%" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
echo;
echo Windowsを再起動します。
pause
shutdown.exe /r /t 0
