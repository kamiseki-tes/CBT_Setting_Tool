@echo off
echo *****************************************************
echo 
echo CBTS開始前環境設定を行います。
echo 
echo *****************************************************
echo;
echo WindowsDefenderを無効にします。
PowerShell -Command "Set-MpPreference -DisableRealtimeMonitoring 1 -DisableBehaviorMonitoring 1 -DisableBlockAtFirstSeen 1 -DisableIOAVProtection 1 -DisablePrivacyMode 1 -DisableArchiveScanning 1"
echo;
