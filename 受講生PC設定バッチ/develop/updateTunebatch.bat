@echo off
@if not “%~0″==”%~dp0.\%~nx0″ start /min cmd /c,”%~dp0.\%~nx0” %* & goto :eof

echo *****************************************************
echo 
echo 設定用バッチを最新化します(タスクスケジューラからの定期実行)
echo v1.00
echo 
echo *****************************************************
echo;

@REM rem 管理者権限で実行していなければ管理者権限で再実行する //現状では必要なし
@REM for /f "tokens=3 delims=\ " %%i in ('whoami /groups^|find "Mandatory"') do set LEVEL=%%i
@REM if NOT "%LEVEL%"=="High" (
@REM powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -Command "Start-Process %~f0 -Verb runas"
@REM exit
@REM )


@REM 設定バッチを最新化（サーバーの所定ディレクトリからコピー）

@REM 接続先サーバーアドレス（新宿）
set ipStr=192.168.100.8
@REM ネットワークドライブの割り当て
net use Y: \\%ipStr%\共有

@REM バッチを最新化（開始前バッチ処理では終了後バッチをコピーする）
xcopy /y Y:\PC設定\設定バッチ\tuneTrainingPC.bat C:\maintenanceBat\Assets\bat

@REM rem ネットワークドライブの除去
net use Y: /delete /y
