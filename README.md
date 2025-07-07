## usersテーブル

| Column             | Type   | Options                   |                            |
| ------------------ | ------ | ------------------------- |----------------------------|
| nickname           | string | null: false.              | ニックネーム                 |
| email              | string | null: false, unique: true | メールアドレス（ログインID）    |
| encrypted_password | string | null: false               | 暗号化されたパスワード          |
| last_name          | string | null: false               | 苗字（全角）                  |
| first_name         | string | null: false               | 名前（全角）                  |
| last_name_kana     | string | null: false               | 苗字のフリガナ（全角カタカナ）   |
| first_name_kana    | string | null: false               | 名前のフリガナ（全角カタカナ）   |
| birth_date         | date   | null: false               | 生年月日（年・月・日をまとめた形式）|


### Association
- has_many :products
- has_many :orders




## productsテーブル

| Column            | Type      | Options          |                            |
|-------------------|-----------|------------------|----------------------------|
| id                | integer   | PRIMARY KEY      | 商品のID（自動採番）         |
| name              | string    | null: false      | 商品名                     |
| description       | text      | null: false      | 商品の説明                  |
| category_id       | integer   | null: false      | カテゴリーのID（ActiveHash） |
| condition_id      | integer   | null: false      | 商品の状態のID（ActiveHash） |
| shipping_cost_id  | integer   | null: false      | 配送料の負担（ActiveHash）   |
| prefecture_id     | integer   | null: false      | 発送元の地域（ActiveHash）   |
| shipping_day_id   | integer   | null: false      | 発送までの日数（ActiveHash） |
| price             | integer   | null: false      | 商品価格                    |
| user              | references | null: false, foreign_key: true | 出品者のユーザーID      |

### Association
- belongs_to :user
- has_one :order




## ordersテーブル

| Column     | Type       | Options                         | 説明                                       |
|------------|------------|---------------------------------|--------------------------------------------|
| id         | integer    | PRIMARY KEY                     | 購入記録のID（自動採番）                       |
| user       | references | null: false, foreign_key: true  | 購入者のユーザーID（外部キー）                  |
| product    | references | null: false, foreign_key: true  | 購入された商品のID（外部キー）                  |


### Association
-  belongs_to :user
-  belongs_to :product





