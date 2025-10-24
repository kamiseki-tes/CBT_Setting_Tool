@echo off

echo *****************************************************
echo 
echo 設定用バッチ, 更新バッチを配置してタスクスケジューラに登録します(手動実行)
echo v1.00
echo 
echo *****************************************************
echo;

@REM rem 管理者権限で実行していなければ管理者権限で再実行する
@REM for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
@REM if NOT "%LEVEL%"=="High" (
@REM powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas"
@REM exit
@REM )

@REM PC内の所定ディレクトリにファイルを配置（設定・更新）

@REM タスクスケジューラに登録（設定・更新） XML利用

@REM rem 設定バッチを最新化（サーバーの所定ディレクトリからコピー）

@REM rem 接続先サーバーアドレス
@REM set ipStr=172.16.224.25
@REM rem ネットワークドライブの割り当て
@REM net use Y: \\%ipStr%\共有

@REM xcopy /y Y:\PC設定\設定バッチ\02End_Win11CBTS終了後環境設定.bat %USERPROFILE%\Desktop\CBTS環境設定用_Win11\Assets\bat

@REM rem ネットワークドライブの除去
@REM net use Y: /delete /y
