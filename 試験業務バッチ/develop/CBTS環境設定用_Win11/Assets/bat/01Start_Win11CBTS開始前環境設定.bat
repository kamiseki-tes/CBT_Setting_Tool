@echo off
echo *****************************************************
echo;
echo CBTS開始前環境設定を行います。
rem このバッチは『事前準備』の時に使用してください。
rem 2017/07/31 バージョン1.00 TOEFL用に作成
rem 2019/06/16 バージョン1.01 ショートカットファイルの作成（管理者権限での実行設定）
rem 2025/10/10 バージョン1.10 TOEFL用のFireWall無効化設定を削除, Defender無効化を削除, Windows Update無効化を改修, 電源設定を追加
echo;
echo *****************************************************
echo;

rem 管理者権限で実行していなければ管理者権限で再実行する //現状では必要なし
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas"
exit
)

echo WindowsUpdateのスタートアップの種類を手動にします。
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f
echo;
echo WindowsUpdateの自動更新を無効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
echo;
echo WindowsUpdateを無効にします（グループポリシーによる制御）。
cd %USERPROFILE%\Desktop\CBTS環境設定用_Win11\Assets\LGPO
LGPO.exe /m 01disable.pol /v
echo;

echo ユーザアカウント制御を「通知しない」にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 1 /f
echo;
echo JavaUpdateを無効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\JavaSoft\Java Update\Policy" /v "EnableJavaUpdate" /t REG_DWORD /d 0 /f
echo;
echo スクリーンセーバーを無効にします。
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ScreenSaveActive" /t REG_SZ /d "0" /f
echo;
echo 電源接続時のスリープ自動移行を「なし」にします。
powercfg /x standby-timeout-ac 0
echo;
echo ディスプレイの電源を切る設定を「なし」にします。
powercfg -x monitor-timeout-ac 0
echo;

rem echo 適用済み確認用のファイルをデスクトップに作成します。
rem type nul > %USERPROFILE%\Desktop\試験バッチ適用中.txt
rem echo;
echo 適用済み確認用にデスクトップ画像を変更します。
set WALLPAPER=%USERPROFILE%\Desktop\CBTS環境設定用_Win11\Assets\img\CBTS_ready.png
reg add "HKCU\Control Panel\Desktop" /v wallpaper /t REG_SZ /d "%WALLPAPER%" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
echo;
echo Windowsを再起動します。
pause
shutdown.exe /r /t 0
