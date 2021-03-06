# ANIMA

## サイト概要
ANIMAは視聴したアニメを評価して投稿することで友人と共有することができるSNSです。簡単なSNSと同様ユーザーは自身のアカウントを保持してアニメのレビューを投稿することができます。また友人をフォローすることやいいね、コメントもすることができます。機能や内容的には凝ったアプリケーションではありませんがもしこのようなアニメのためのSNSが大体的に普及すればアニメ界隈はより一層盛り上がると考えました。


### サイトテーマ
視聴したアニメを評価して投稿することで友人と共有することができるSNS


### テーマを選んだ理由
アニメは日本が誇る素晴らしい文化の一つであり、現在ではとても人気がありアニメに対するイメージはより良くなっています。しかし、一昔前まではアニメに対して偏見を持つ人が大勢いました。事実アニメを好きという理由だけで辛い経験をした人もいると思います。そのためアニメは好きだけど周りの人には言いづらいため全く別の場で誰かと共有したいと思っている人や純粋にアニメについて多くの人と語りたいと思う人、次にどのアニメを見るか悩んでいる人にとってもとても使いやすいツールになると考えました。また複数の評価基準を儲けることで人それぞれの受け取り方を知り、多角的方面からアニメを見ることができます。アニメに限った話ではありませんが作品というものは人の心を潤し、豊かにしてくれるものです。是非全世界のアニメ好きの方々に今まで以上にアニメを楽しんで欲しいという願いがこのテーマを選んだ理由です。

### ターゲットユーザ
- 純粋にアニメについて多くの人と語りたいと思う人
- アニメは好きだけど周りの人には言いづらいため全く別の場で誰かと共有したいと思っている人
- 次にどのアニメを見るか悩んでいる人


### 主な利用シーン
アニメを見た時。
見たいアニメを探す時。
暇つぶしや誰かとアニメについて話したい時。

## 設計書
https://docs.google.com/spreadsheets/d/1hzpUGtmykGSW78d3MzbVpXwQ7QpmjdB4XGOB37YG_fw/edit?usp=sharing
https://docs.google.com/spreadsheets/d/11wZ2UdfGLuQQmltukb9B5xo6k_fhb9ZlOoZTnEW3YLI/edit?usp=sharing
https://docs.google.com/spreadsheets/d/17R_y9Rb8a4ivin8sQi-HiWPHvTXZEZxU/edit?usp=sharing&ouid=112226673785996171858&rtpof=true&sd=true
https://drive.google.com/file/d/1iyktdDAsPGDsi6Rs-VdYNEnAKEnD0WcT/view?usp=sharing

## チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/1L9lLrEXNcbHB_Sp1XMqwiBtrX64yQZBkrHYDpRKHW7E/edit#gid=0

## 技術要素
- CRUD機能について
 - ANIMAでのレビュー投稿のCRUD機能について説明します。
  - Createについて
   newアクションを定義する。新規投稿するときにアクションする。
   createアクションを定義する。新規投稿で入力された情報をparamsで受け取り、DBに送る。
  - Readについて
   indexアクションを定義する。indexアクションではDBの情報を全て取り出す。
   showアクションを定義する。showアクションではindexアクションの中からさらに個別の情報をDBから取り出す。
  - Updateについて
   editアクションを定義する。編集したい情報を指定する。
   updateアクションを定義する。現在ログインしているユーザーと編集したい情報のuser_idが一致すれば動作する。
   編集内容が更新される流れはcreateと同じ。
  - Deleteについて
   destroyアクションを定義する。実装の内容はupdateと同じ。

- テストについて
 - 今回すべてをテストできているわけではありませんがメインとなる機能にフォーカスしてテストを実行しています。

## 開発環境
- OS：Amazon Linux release 2 (Karoo)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 注意事項
- このアプリケーションでは画像アップロードの際、アニメのスクリーンショット・キャプチャ画像等を使うなど著作権侵害する行為は禁止されています。

