@echo off
@if not “%~0″==”%~dp0.\%~nx0″ start /min cmd /c,”%~dp0.\%~nx0” %* & goto :eof

echo *****************************************************
echo 
echo 受講生用PCを設定します(タスクスケジューラからの定期実行)
echo v1.00
echo 
echo *****************************************************
echo;

@rem エクスプローラー関連
@rem 「ときどきスタートにおすすめを表示する」オフ
@rem 無効　reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
@rem 「スタートメニューまたはタスクバーのジャンプリストに最近開いた項目を表示する」オフ
@rem 無効　reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d "0" /f
@rem 「同期プロバイダーの通知を表示する」オフ ;OneDriveの同期を促す通知
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f
@rem 「隠しファイルの表示」オン（有効化）
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d "2" /f

@rem 個人用設定 > スタート > "スタート画面にアカウント関連の通知を時々表示する" オフ
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_AccountNotifications" /t REG_DWORD /d "0" /f
@rem 個人用設定 > スタート > "ヒント、ショートカット、新しいアプリなどのおすすめを表示します" オフ
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_IrisRecommendations" /t REG_DWORD /d "0" /f

@rem システム > 通知 > 追加の設定 > "更新後およびサインイン時に Windows のウェルカムエクスペリエンスを表示して、新機能と提案を表示する" オフ
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f
@rem システム > 通知 > 追加の設定 > "Windowsを使用する際のヒントや提案を入手する" オフ Win11_24H1 以前
@rem 古いので削除 reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f
@rem システム > 通知 > 追加の設定 > "Windowsを使用する際のヒントや提案を入手する" オフ 
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f
@rem システム > 通知 > 追加の設定 > "Windows を最大限に活用し、このデバイスの設定を完了する方法を提案する" オフ
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d "0" /f

@rem 個人用設定 > タスクバー > "ウィジェット" オフ
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f

@rem Edgeを常にInPrivateモードで起動する
@rem 保留 reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "InPrivateModeAvailability" /t REG_DWORD /d "2" /f