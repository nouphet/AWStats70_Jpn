
--------------AWStats---------------
	 Advanced Web Statistics
------------------------------------

Advanced Web Statistics (AWStats)は強力なWebサーバーのログファイル解析
プログラムで, 訪問者数やページ数, ヒット数や訪問時間帯,検索エンジンや
あなたのサイトを発見するために利用されたキーワード, 無効なリンクやロボット
などについてのWebサーバーの統計データを取ることができます.

AWStatsは, IIS 5.0以上やApacheをはじめとするメジャーなWeb/WAP/Proxy/
ストリーミングサーバのログを, あらゆるOS上で解析することができます.
また，FTPサーバやメールサーバのログを解析することさえできます．

ライセンス : GNU GPL (GNU General Public License. ライセンスファイルを参照)
             OSI Certified Open Source Software license.
バージョン : 7.0
リリース日 : 2010年12月
プラットフォーム : 全て(Linux,NT,SCO,BSD,Solarisやその他のUNIX,BeOS,OS/2など)
作者 : Laurent Destailleur <eldy@users.sourceforge.net>
AWStats公式Webサイトと最新版 : http://awstats.sourceforge.net

I   - AWStatsの機能と動作用件
      I - 1) 機能：AWStatsでどのような統計が取れるのか
      I - 2) AWStatsを利用するための動作要件
      I - 3) ファイル
II  - AWStatsのインストール方法と利用方法
III - ベンチマーク
IV  - 作者について、ライセンスとサポート
V   - 日本語化について



I -AWStatsの機能と動作要件
------------------------------------

I - 1) 機能

	AWStatsは、詳細なログ解析を行うことにより, 以下の統計情報を表示することができます:
	* 延べ訪問者と重複を除いた訪問者の数
	* 滞在時間と最後の訪問日時
	* 認証されたユーザーと, その最後の訪問日時
	* 曜日別の統計やアクセスが集中した時間帯の統計
          (日/時間単位のページ数, ヒット数, KB)
	* 訪問者したホストのドメイン/国(ページ数, ヒット数, KB)
	* ホスト名の一覧, 最後の訪問日時, 名前解決できなかったIPの一覧
	* もっとも頻繁に閲覧された/最初に閲覧された/最後に閲覧されたページ
	* ファイルタイプ
	* 圧縮率の統計(mod_zipもしくはmod_deflateを利用しているサーバー向け)
	* 利用されたブラウザ(ブラウザ別のページ数, ヒット数, kb)
	* 利用されたOS(OS毎のページ数, ヒット数, kb)
	* ロボットの訪問
	* ワームの攻撃
	* ダウンロードと継続性の検知
	* あなたのサイトを発見するために利用された検索エンジンと検索文/検索語
	* HTTPエラー("ページが見つかりません"などを, 最新のReferer付きで)
	* 画面サイズのレポート
	* "お気に入り"に追加された回数
	* JavaやFlash, RealG2, Quicktime, WMA, PDFをサポートするブラウザの割合
	* ロードバランスを利用しているサーバの負荷率のレポート
	* その他のカスタマイズされたレポート

	以下の機能も持っています:
	* あらゆるログ形式を解析可能
	* コマンドライン/CGIのどちらからでも利用可能(チャートによっては動的に
	  フィルタをかけることが可能)
	* スケジューラーだけでなく, 必要に応じてブラウザから統計の更新が可能
	* ログサイズの制限が無く, 分割されたログファイル(ロードバランシングを
	  している環境)にも対応
	* 完全には時系列にソートされていないログファイルに対応し, 最初/最後に閲覧したページも解析可能
	* DNSの逆引きを解析前/後に行うことが可能, DNSキャッシュファイルに対応
	* IPアドレスやドメイン名から国を識別可能
	* WhoISのリンクを作成可能
	* 数多くのオプション/フィルタ/プラグインを利用可能
	* 複数の名前をもつWebサイトに対応(バーチャルサーバー)
	* Cross Site Scripting攻撃に対応
	* 多くの言語に対応
	* 入手性が悪いPerlライブラリに依存しない
	* 動的なレポートをCGIとして出力
	* 静的なレポートを単一ページ/フレームを利用したHTML/XHTMLとして出力
	* 試験的にPDF出力をサポート
	* 外見や配色をサイトデザインに合わせてカスタマイズ可能(CSS)
	* ヘルプ/Tooltipがレポートページで利用可能
	* 利用が容易(設定が必要なファイルは一つだけ)
	* 解析データベースはXML形式を利用可能(XSLTでの処理向け)
	* Webmin用のモジュールも併せて配布
	* フリー(GNU GPL)でソースと共に配布(Perlスクリプト)
	* プラットフォームを問わない


I - 2) 動作要件

	AWStats CGIスクリプトを利用するには, 以下の要件を満たす必要があります:
	* 統計対象Webサーバーで, あなたの権限で読むことができるログファイルに
	  Webアクセスを記録していること.
	* AWStatsをコマンドラインから利用する場合、OSがPerlスクリプト(.plファ
	  イル)を実行できること.

	AWStatsをCGI(リアルタイムの統計)として利用する場合, 同様にWebサーバ
	  もPerlスクリプトを実行できること. Perlを実行できない場合、最新版の
	  Perlを以下からダウンロードできます.
	  http://www.activestate.com/ActivePerl/ (Windows)
	  http://www.perl.com/pub/language/info/software.html (Unix/Linux/Other)


I - 3) ファイル

	AWStatsの配布パッケージには, 以下のファイルが含まれています:
	README.TXT		このファイル
	docs/LICENSE		GPLライセンス
	docs/*			AWStatsのドキュメント(セットアップ/利用方法等)
	wwwroot/cgi-bin/awstats.pl	AWStatsのメインプログラム(CLI/CGI)
	wwwroot/cgi-bin/awredir.pl	サイトを去るクリックを検知するツール
	wwwroot/cgi-bin/awstats.model.conf	サンプル設定ファイル
	wwwroot/cgi-bin/lang	言語ファイルが格納されたディレクトリ
	wwwroot/cgi-bin/lib	AWStatsが参照する情報が格納されたディレクトリ
	wwwroot/cgi-bin/plugins	オプションのプラグインが格納されたディレクトリ
	wwwroot/icon/browser	ブラウザのアイコンが格納されたディレクトリ
	wwwroot/icon/clock	時計のアイコンが格納されたディレクトリ
	wwwroot/icon/cpu	CPUのアイコンが格納されたディレクトリ
	wwwroot/icon/flags	国旗が格納されたディレクトリ
	wwwroot/icon/os		OSのアイコンが格納されたディレクトリ
	wwwroot/icon/other	その他のアイコンが格納されたディレクトリ
	wwwroot/classes		graphappletプラグイン用のJavaアプレット
	wwwroot/css		サンプルCSSファイル
	wwwroot/js		特定の目的で利用するJavaスクリプトのソース
	tools/*			そのほかの提供ツール群
	tools/webmin/awstats-x.x.wbm	AWStats用Webminモジュール
        tools/xslt/awstats61.xsd	AWStatsのXMLデータベーススキーマデスクリプタ
        tools/xslt/*		AWStatsのXMLデータベースの操作例



II - AWStatsのインストール方法と利用方法
-----------------------------------

このリリース時点での最新のドキュメントは, HTML形式でdocsディレクトリに格納
されています.

最新のドキュメントは, 以下のURLで入手できます:
http://awstats.sourceforge.net



III - ベンチマーク
-----------------------------------

テストとその結果は, /docsディレクトリ内のドキュメントを参照して下さい.



IV - 作者について, ライセンスとサポート
-----------------------------------------
Copyright (C) 2000-2010 - Laurent Destailleur - eldy@users.sourceforge.net

このプログラムはフリーソフトウェアです. あなたはFree Software Foundationが公開
しているGNU General Public Licence Version 2の条件下にこのソフトウェアを再配布
および/もしくは修正することが可能です.

このプログラムは利用する人にとって役立つものであるようにと願って配布されていま
すが, 如何なる保証もありませんし, 黙示的な市場性もしくは特定目的適合性への保証
もありません. 詳細についてはCOPYING.TXTのGNU General Public Licenseを参照して
下さい.

このプログラムと共にこのファイルのコピーを受け取らなかった場合は, Free Software
Foundation, Inc.に御連絡下さい.
59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

V - 日本語化について
-----------------------------------------
前章までがオリジナルのAWStatsのREADME.TXTの翻訳になり, この章は日本語化にあた
り独自に追加された章になりますのでご注意下さい. 忠実に訳したため, I-3のファイ
ル名など, 一部日本語版の内容と合致しない部分がありますが御了承下さい.

AWStatsの日本語化は, Ryu Hiyoshi(http://www.starplatinum.jp)が行いました.
日本語化にあたって行った作業は以下の通りです.

Ver. 2.23
 - decode.plによる検索エンジンのキーワードのデコード機能(英語版だとエンコード
   状態のまま集計).
 - 日本独自の検索エンジン(Ex. goo, biglobeなど)の検出機能の追加.
 - 画面表示部分の日本語化.
 - 配布ドキュメントの日本語化.

Ver.3.0
 - decode.plのロジック見直し(単純化, 対応検索エンジン追加).
 - 他言語との完全な共存(画面最上部の国旗をクリックすると他言語に切り替わる).
 - ブラウザリストにi-mode, J-Sky, auを追加(Thanks to Mr.Kobe).

Ver.5.0
 - decode.plのUTF-8(主にgoogleが利用)対応(Thanks to ミドリさん).
 - decode.plがgoogleのキャッシュからのアクセスに対応.
 - 管理人のサイトに来ていた新顔の検索エンジン(Naver, TOCC)に対応.
 - 配布ドキュメントの日本語化.

Ver.6.0
 - (本家で対応している日本語化の修正として)より完璧な日本語化
 - 日本独特の各種要素(検索エンジン, ロボット, ブラウザ等)に対応
 - 配布ドキュメントの日本語化

Ver.6.5
 - LunascapeとSleipnirの検知機能の追加
 - AU / Docomo / Vodafoneの検知機能の追加(オリジナルにも携帯電話の検知機能は
   あるものの, 欧米圏向けで事実上役に立たないため)
 - utf8_decode.plの改良(Thanks to Hobbit氏)

Ver.6.6
 - Vodafoneの表示をSoftbankに修正.
 - utf8_decode.plとして, hobiit氏が公開されているものを利用.

Ver.7.0
 - utf8_decode.plのGoogleキャッシュからのアクセスの識別ロジックを修正
   # URLが変更されていたために正常に機能していなかったため

日本語化されたAWStatsはGPLライセンスに基づき自由に改変/再配布できます.
日本語版の配布は以下のURLで行っております.

http://www.starplatinum.jp

質問や対応検索エンジンの追加要望等がありましたら, 本ファイルのダウンロード
ページのコメント欄にご意見をお寄せ頂ければ幸いです.

