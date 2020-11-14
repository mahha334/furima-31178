# DB 設計

## users table

| Column             | Type                | Options                 |
|--------------------|---------------------|-------------------------|
| nickname           | string              | null: false             |
| email              | string              | null: false             |
| password           | string              | null: false             |
| Identification     | text                | null: false             | #本人確認        
| birthday           | text                | null: false             | #生年月日

### Association

* has_many :items # テーブル同士を関連付ける
* has_many :comments

## items table

| Column                              | Type       | Options           |
|-------------------------------------|------------|-------------------|
| image                               | text       | null: false       |
| text                                | text       | null: false       |
| user_id                             | references | foreign_key: true |#外部キー

### Association

- belongs_to :user
- has_many :comments

## comments table

| Column      | Type       | Options           |
|-------------|------------|-------------------|
| text        | text       | null: false       |
| user_id     | references | foreign_key: true |
| item_id     | references | foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user


## koruny table #購入

| Column      | Type       | Options           |
|-------------|------------|-------------------|
| price       | text       | null: false       |　＃販売価格
| fee         | text       | null: false       |　＃手数料
| profit      | text       | null: false       |　＃利益
| user_id     | references | foreign_key: true |
| item_id     | references | foreign_key: true |
| comments_id | references | foreign_key: true |
| hansom_id   | references | foreign_key: true |

### Association

- has_one :hansom
- has_many :user
- has_many :item
- has_many :comments

## hansom table #配送

| Column      | Type       | Options           |
|-------------|------------|-------------------|
| deliveryfee | text       | null: false       | #配送料の負担
| area        | text       | null: false       | #発送元の地域
| shipping    | text       | null: false       | #発送までの日数
| koruny_id   | references | foreign_key: true |

### Association

- belongs_to :koruny