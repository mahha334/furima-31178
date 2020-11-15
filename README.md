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
* has_many :items 
* has_many :koruny


## items table
| Column                              | Type       | Options           |
|-------------------------------------|------------|-------------------|
| product                             | string     | null: false       | #商品名
| description                         | text       | null: false       | #商品の説明
| category_id                         | integer    | null: false       | #カテゴリー
| condition_id                        | integer    | null: false       | #商品の状態
| price_id                            | integer    | null: false       | #販売価格
| deliveryfee_id                      | integer    | null: false       | #配送料の負担
| area_id                             | integer    | null: false       | #発送元の地域
| shipping_id                         | integer    | null: false       | #発送までの日数
| user                                | references | foreign_key: true |#外部キー

### Association
- belongs_to :user
- has_one :koruny


## korunys table #購入
| Column      | Type       | Options           |
|-------------|------------|-------------------|
| user        | references | foreign_key: true |
| item        | references | foreign_key: true |

### Association
- has_one :haisou
- belongs_to :item
- belongs_to :user


## haisous table #配送 
| Column      | Type       | Options           |
|-------------|------------|-------------------|
| postcd      | string     | null: false       | #郵便番号
| city        | string     | null: false       | #市区町村
| adresj      | string     | null: false       | #住所
| adresb      | string     | null: false       | #番地
| building    | string     |                   | #建物名
| phone       | string     | null: false       | #電話番号
| koruny      | references | foreign_key: true |


### Association
- belongs_to :koruny
