@echo off
echo *****************************************************
echo 
echo Windows10用TOEFL終了後環境復旧を行います。
echo このバッチは『試験終了後』に使用してください。
echo 2017年7月31日バージョン
echo 
echo *****************************************************
echo;
echo ドメインFireWallの設定を有効にします。(この設定は再起動後に有効)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile"  /v "EnableFirewall" /t REG_DWORD /d 1 /f
echo;
echo プライベートFireWallの設定を有効にします。(この設定は再起動後に有効)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "EnableFirewall" /t REG_DWORD /d 1 /f
echo;
echo パブリックFireWallの設定を有効にします。(この設定は再起動後に有効)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "EnableFirewall" /t REG_DWORD /d 1 /f
echo;
echo WindowsDefenderを有効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 0 /f
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
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ScreenSaveActive" /t REG_SZ /d "0" /f
echo;
echo JavaUpdateを無効のままにします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\JavaSoft\Java Update\Policy" /v "EnableJavaUpdate" /t REG_DWORD /d 0 /f
echo;
echo 再起動します。再起動後、WindowsDefenderのリアルタイム保護を確認してください。
pause
shutdown.exe /r /t 0
pause