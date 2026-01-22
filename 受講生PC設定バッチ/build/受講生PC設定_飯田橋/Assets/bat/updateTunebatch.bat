@echo off
@if not "%~0"=="%~dp0.\%~nx0" start /min cmd /c,"%~dp0.\%~nx0" %* & goto EOF

echo *****************************************************
echo 設定用バッチを更新します(タスクスケジューラからの定期実行)
echo 飯田橋用はサーバーアドレス、参照階層が異なるので注意
echo v1.00
echo *****************************************************
echo;

@REM 接続先サーバーアドレス（飯田橋）
set ipStr=192.168.10.2
@REM ネットワークドライブの割り当て
net use Y: \\%ipStr%\共有

@REM サーバーの所定ディレクトリからバッチをコピーする（最新化）
xcopy /y Y:\PC設定用\maintenance\bat\tuneTrainingPC.bat C:\maintenanceBat\Assets\bat

@REM rem ネットワークドライブの除去
net use Y: /delete /y
