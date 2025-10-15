@echo off
echo *****************************************************
echo 
echo Windows10用TOEFL開始前環境設定を行います。
echo このバッチは『事前準備』の時に使用してください。
echo 2017年7月31日バージョン
echo 
echo *****************************************************
echo;
echo ドメインFireWallの設定を無効にします。(この設定は再起動後に有効)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile"  /v "EnableFirewall" /t REG_DWORD /d 0 /f
echo;
echo プライベートFireWallの設定を無効にします。(この設定は再起動後に有効)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f
echo;
echo パブリックFireWallの設定を無効にします。(この設定は再起動後に有効)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "EnableFirewall" /t REG_DWORD /d 0 /f
echo;
echo WindowsDefenderを無効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
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
echo JavaUpdateを無効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\JavaSoft\Java Update\Policy" /v "EnableJavaUpdate" /t REG_DWORD /d 0 /f
echo;
echo 再起動します。
pause
shutdown.exe /r /t 0
