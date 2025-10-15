@echo off
echo *****************************************************
echo 
echo CBTS終了環境設定を行います。
echo 
echo *****************************************************
echo;
echo WindowsDefenderを無効にします。
PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring 0 -DisableBehaviorMonitoring 0 -DisableBlockAtFirstSeen 0 -DisableIOAVProtection 0 -DisablePrivacyMode 0 -DisableArchiveScanning 0"
echo;
