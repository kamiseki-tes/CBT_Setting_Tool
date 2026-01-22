@echo off

echo *****************************************************
echo 設定用バッチ, 更新バッチをタスク登録します(手動実行)
echo v1.00
echo *****************************************************
echo;

@rem 管理者権限で実行していなければ管理者権限で再実行する
for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
if NOT "%LEVEL%"=="High" (
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas"
exit
)

@rem Cドライブ直下にmaintenanceBatフォルダを作成してファイル類を配置
echo 所定ディレクトリに必要データを配置します
xcopy /e /y %~dp0\Assets C:\maintenanceBat\Assets\
echo;

@rem XMLを読み込みタスクスケジューラに登録する（設定バッチ・更新バッチ）
echo バッチのタスク実行を2件登録します
schtasks /Create /XML %~dp0\forTaskReg\updateTunebatch.xml /tn "updateTunebatch" /F
schtasks /Create /XML %~dp0\forTaskReg\tuneTrainingPC.xml /tn "tuneTrainingPC" /F
echo;

pause