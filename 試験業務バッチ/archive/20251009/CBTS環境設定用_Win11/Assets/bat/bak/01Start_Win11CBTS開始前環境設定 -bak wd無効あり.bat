@echo off
echo *****************************************************
echo 
echo CBTS開始前環境設定を行います。
echo このバッチは『事前準備』の時に使用してください。
echo 2017年7月31日バージョン1.00
echo 2025年10月1日バージョン1.02 Windows11で動作確認, TOEFL用のFireWall無効化設定を削除, 電源設定を追加
echo 
echo *****************************************************
echo;
echo WindowsDefenderを無効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $true -DisableBehaviorMonitoring $true -DisableBlockAtFirstSeen $true -DisableIOAVProtection $true -DisablePrivacyMode $true -DisableArchiveScanning $true"
echo;
echo WindowsUpdateのスタートアップの種類を手動にします。
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f
echo;
echo WindowsUpdateの自動更新を無効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
echo;
echo ユーザアカウント制御を「通知しない」にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 1 /f
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
echo JavaUpdateを無効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\JavaSoft\Java Update\Policy" /v "EnableJavaUpdate" /t REG_DWORD /d 0 /f
echo;
echo 再起動します。
pause
shutdown.exe /r /t 0
