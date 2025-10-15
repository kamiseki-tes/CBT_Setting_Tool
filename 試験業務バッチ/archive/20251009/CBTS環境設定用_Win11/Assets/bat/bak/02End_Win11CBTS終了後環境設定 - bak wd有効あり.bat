@echo off
echo *****************************************************
echo 
echo CBTS終了後環境復旧を行います。
echo このバッチは『試験終了後』に使用してください。
echo 2017年7月31日バージョン1.00
echo 2025年10月1日バージョン1.02 Windows11で動作確認, TOEFL用のFireWall設定を削除
echo 
echo *****************************************************
echo;
echo WindowsDefenderを有効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 0 /f
PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring $false -DisableBehaviorMonitoring $false -DisableBlockAtFirstSeen $false -DisableIOAVProtection $false -DisablePrivacyMode $false -DisableArchiveScanning $false"
echo;
echo WindowsUpdateのスタートアップの種類を手動にします。
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f
echo;
echo WindowsUpdateの自動更新を有効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f
echo;
echo ユーザアカウント制御をデフォルト値に戻します。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "5" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "1" /f
echo;
echo スクリーンセーバーは無効のままにします。
echo;
echo スリープ、ディスプレイ自動オフ設定は無効のままにします。
echo;
echo JavaUpdateを無効のままにします。
echo;
echo 目視確認用のファイルをデスクトップから削除します。
del C:\Users\b21ws31\Desktop\試験バッチ適用中.txt
echo;
echo 再起動します。
pause
shutdown.exe /r /t 0
pause