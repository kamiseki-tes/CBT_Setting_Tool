@echo off
echo *****************************************************
echo;
echo CBTS終了後環境復旧を行います。
@rem このバッチは『試験終了後』に使用してください。
@rem 2017/07/31 バージョン1.00 TOEFL用に作成
@rem 2025/10/10 バージョン1.10 TOEFL用のFireWall無効化設定を削除, Defender無効化を削除, Windows Update無効化を改修, 電源設定を追加
@rem 2025/10/22 バージョン1.20 サーバーからの自動更新機能を追加
echo;
echo *****************************************************
echo;

rem 管理者権限で実行していなければ管理者権限で再実行する //現状の運用では必要なし
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas"
exit
)

rem 接続先サーバーアドレス
set ipStr=Benefull-srv01
rem ネットワークドライブの割り当て
net use Y: \\%ipStr%\共有

rem WindowsUpdateのスタートアップの種類は手動のままにします。
echo WindowsUpdateの自動更新を有効にします。
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f
echo;
echo WindowsUpdateを有効にします（グループポリシーによる制御）。
cd %USERPROFILE%\Desktop\CBTS環境設定用_Net_Win11\Assets\LGPO
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
set WALLPAPER=%USERPROFILE%\Desktop\CBTS環境設定用_Net_Win11\Assets\img\Net_standby.jpg
reg add "HKCU\Control Panel\Desktop" /v wallpaper /t REG_SZ /d "%WALLPAPER%" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
echo;

rem バッチを最新化（終了後バッチ処理では開始前バッチをコピーする）
xcopy /y Y:\PC設定用\設定バッチ配布元\01Start_Win11NET開始前環境設定.bat %USERPROFILE%\Desktop\CBTS環境設定用_Net_Win11\Assets\bat

rem ネットワークドライブの除去
net use Y: /delete /y

echo Windowsを再起動します。
pause
shutdown.exe /r /t 0
