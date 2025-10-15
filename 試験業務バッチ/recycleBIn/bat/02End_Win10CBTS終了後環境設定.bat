@echo off
echo *****************************************************
echo 
echo CBTS終了後環境復旧を行います。
echo このバッチは『試験終了後』に使用してください。
echo 2017年7月31日バージョン1.00
echo 2025年10月1日バージョン1.02 Windows11で動作確認, TOEFL用のFireWall設定を削除した
echo 
echo *****************************************************
echo;
echo WindowsDefenderを有効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 0 /f
echo;
echo WindowsUpdateのスタートアップの種類は手動のままにします。
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
echo スリープ設定、画面オフ設定は「なし」のままにします。
echo;
echo JavaUpdateを無効のままにします。
echo;
echo 再起動します。再起動後、WindowsDefenderのリアルタイム保護を確認してください。
pause
shutdown.exe /r /t 0
pause