ver:1.00
設定するWinバージョン:22H2

■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

機能：ローカルグループポリシーにWindows Updateの対象バージョンを設定します。

1,「winVer固定ツール」フォルダを対象のPCに配置してください
（配置階層はどこでもOK　USBから直接実行でもたぶん動く）

2,「addRegistory.bat」を右クリックして"管理者として実行"を押してください
（管理者実行されない場合、自分で管理者実行を要求してきます）

3, レジストリ追加が成功すると以下のようなメッセージが表示されます
------------------------------
; PROCESSING Computer POLICY
; Source file:  registry.pol

Computer
Software\Policies\Microsoft\Windows\WindowsUpdate
TargetReleaseVersion
DWORD:1

Computer
Software\Policies\Microsoft\Windows\WindowsUpdate
ProductVersion
SZ:Windows 10

Computer
Software\Policies\Microsoft\Windows\WindowsUpdate
TargetReleaseVersionInfo
SZ:22H2

; Computer POLICY SAVED.
------------------------------

4, 完了後はWindowsを再起動してください。


■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

MSが提供している「ローカル グループ ポリシー オブジェクト (LGPO) ツール」を使用しています。registry.polの内容を変更すれば対象のWinバージョンを変更できます。

作成時参照ページ：
https://nekoi.net/windows/lgpo/

上関