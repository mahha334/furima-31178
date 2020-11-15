# DB 設計


## users table
| Column             | Type                | Options                 |
|--------------------|---------------------|-------------------------|
| nickname           | string              | null: false             | #ニックネーム
| surname            | string              | null: false             | #姓名
| name               | string              | null: false             | #名前
| surnamef           | string              | null: false             | #姓名（フリガナ）
| namef              | string              | null: false             | #名前（フリガナ）
| email              | string              | null: false             |
| encrypted_password | string              | null: false             |      
| birthday           | date                | null: false             | #生年月日

### Association
* has_many :items # テーブル同士を関連付ける
* has_many :korunys


## items table
| Column                              | Type       | Options           |
|-------------------------------------|------------|-------------------|
| product                             | string     | null: false       | #商品名
| description                         | text       | null: false       | #商品の説明
| category_id                         | integer    | null: false       | #カテゴリー
| condition_id                        | integer    | null: false       | #商品の状態
| price                               | integer    | null: false       | #販売価格
| deliveryfee_id                      | integer    | null: false       | #配送料の負担
| area_id                             | integer    | null: false       | #発送元の地域
| koruny                              | references | foreign_key: true |
| user                                | references | foreign_key: true |#外部キー

### Association
- belongs_to :users
- has_one :korunys


## korunys table #購入
| Column      | Type       | Options           |
|-------------|------------|-------------------|
| card        | date       | null: false       | #カード情報
| deadmon     | date       | null: false       | #有効期限 月
| deadyer     | date       | null: false       | #有効期限 年
| security    | date       | null: false       | #セキリティコード ４または３桁
| user        | references | foreign_key: true |
| item        | references | foreign_key: true |

### Association
- has_one :haisous
- belongs_to :items
- belongs_to :users


## haisous table #配送 
| Column      | Type       | Options           |
|-------------|------------|-------------------|
| postcd      | date       | null: false       | #郵便番号
| city        | string     | null: false       | #市区町村
| adresj      | string     | null: false       | #住所
| adresb      | string     | null: false       | #番地
| building    | string     | null: false       | #建物名
| phone       | string     | null: false       | #電話番号
| koruny      | references | foreign_key: true |


### Association
- belongs_to :korunys
