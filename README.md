# README
* 本ツールは、PBMへボタン入力をするためのWEBアプリケーションです

## できること
* ゲーム画面をキャプチャボード経由で読み込んで任意の操作をすることができます

## 必要なソフトウェア
* MacOS
  * Windowsでもたぶん動きますが動作確認はしていません
* ruby3.x
* sqlite3

## 使い方
* 起動方法
    * `bin/start_server`
* 画面
    * TODO

## 開発
### インストール
* bundle install
* bin/rails db:create db:migrate
* bin/dev

## TODO
* Dockerで起動する？
  * 画像キャプチャはコンテナからできるか？
