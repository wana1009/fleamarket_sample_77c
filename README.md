#fleamarket DB設計
## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|detail|text|null: false|
|price|integer|null: false, index: true|
|size|string||
|condition_id|integer|null: false, index: true|
|charge_id|integer|null: false, foreign_key: true|
|prefecture_id|integer|null: false, foreign_key: true|
|days_id|integer|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|foreign_key: true|
### Association
- has_many :images
- belongs_to :brand
- belongs_to :category
- belongs_to :user

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_kana|string|null: false|
|last_kana|string|null: false|
|birthday|date|null: false|
### Association
- has_many :items
- has_many :cards
- has_one :address

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|integer|null: false|
|expiration_date|integer|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_kana|string|null: false|
|last_kana|string|null: false|
|postal_code|string|null: false|
|prefecture_id|integer|null: false, foreign_key: true|
|address1|string|null: false|
|address2|string|null: false|
|billding_name|string||
|phone_number|string|unique :true|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :item

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :items

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|index: true|
### Association
- has_many :items



