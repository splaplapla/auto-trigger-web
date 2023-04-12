# README
* 本ツールは、PBMへボタン入力をするためのWEBアプリケーションです

## できること
* ゲーム画面をキャプチャボード経由で読み込んで任意の操作をすることができます

## 必要なソフトウェア
* OS
    * MacOS
      * Windowsでは動かないかも
* ruby3.x
* sqlite3
* OpenCV 3.x
    * `brew install opencv@3`

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

## TIPS
* キャプチャーボードはキャプチャの設定は60フレームにしてください

## TODO
* Dockerで起動する？
  * カメラのキャプチャはコンテナからできるか？
  * パフォーマンスでるか？
