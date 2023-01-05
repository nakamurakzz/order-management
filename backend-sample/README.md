# backend-sample
- いずれクラウドに載せるまでの一時的なバックエンドです

# 環境構築
MySQL起動
```bash
docker compose up
```

APIサーバ起動
```
yarn
yarn dev
```

# APIの設計方針
- APIのパスは複数形、スネークケースとする
- 各HTTPメソッドと役割は以下の通り
  - GET .../resources： 全件取得
  - GET .../resources/{id}： 単件取得
  - POST: .../resources： 新規登録
  - POST: .../resources/{id}/action： resourceのactionに関する更新処理 ※1
    - ex.) .../orders/1/cancel： order.id=1 をcancel状態に変更する
  - PUT: .../resources/{id}： 更新（全パラメータ指定必須）
  - PATCH: .../resources/{id}： 一部のパラメータの更新 ※1

※ 基本はPATCH APIで一部パラメータを変更するが、変更したいパラメータに関して何らかのロジックをサーバ側に持つ場合は`POST .../resources/{id}/action`の使用を検討する

- レスポンスは以下の形式に統一する（統一したい）
```javascript
{
  message: エラー時のメッセージ、正常時は空,
  data: 配列またはオブジェクト、エラー時はNull
}
```

# 実装方針
- Usecase層はドメイン層とインフラ層のメソッドを利用するだけとして、ロジックはなるべく書かない
- リポジトリ層もなるべくロジックは書かない
  - 将来的にはMySQLではなく、NoSQL（DynamoDBを想定）に代替したい
- とにかくドメイン層にロジックをまとめて、ドメイン層のUnitテストをなるべく書く

#　備考
- DB migrationは自動実行します
