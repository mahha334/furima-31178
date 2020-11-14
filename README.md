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
* has_many :koruny


## items table
| Column                              | Type       | Options           |
|-------------------------------------|------------|-------------------|
| product                             | text       | null: false       | #商品名
| description                         | text       | null: false       | #商品の説明
| category                            | integer    | null: false       | #カテゴリー
| condition                           | integer    | null: false       | #商品の状態
| price                               | text       | null: false       | #販売価格
| deliveryfee                         | integer    | null: false       | #配送料の負担
| area                                | integer    | null: false       | #発送元の地域
| koruny                              | references | foreign_key: true |
| user                                | references | foreign_key: true |#外部キー

### Association
- belongs_to :user
- has_many :koruny


## koruny table #購入
| Column      | Type       | Options           |
|-------------|------------|-------------------|
| user        | references | foreign_key: true |
| item        | references | foreign_key: true |

### Association
- has_one :haisou
- belongs_to :item
- belongs_to :user


## haisou table #配送 
| Column      | Type       | Options           |
|-------------|------------|-------------------|
| adress      | text       | null: false       | #住所（都道府県のみの入力）
| koruny      | references | foreign_key: true |

### Association
- belongs_to :koruny
- has_one :item
