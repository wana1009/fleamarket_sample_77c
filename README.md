# fleamarket DB設計
## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|detail|text|null: false|
|price|integer|null: false, index: true|
|size|string||
|condition|integer|null: false|
|charge|integer|null: false|
|prefecture|integer|null: false|
|day|integer|null: false|
|seller_id|references|null: false, foreign_key: true|
|order_id|references|foreign_key: true|
|category_id|references|null: false, foreign_key: true|
|brand_id|references|foreign_key: true|
### Association
- has_many :images
- belongs_to :brand
- belongs_to :category
- has_many :sellers
- has_many :orders
- belongs_to_active_hash :condition
- belongs_to_active_hash :charge
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :day


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
- has_many :sellers
- has_many :orders

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|string|null: false|
|customer_id|string|null: false|
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
|prefecture|integer|null: false|
|town|string|null: false|
|house_number|string|null: false|
|building_name|string||
|phone_number|string|unique :true|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to_active_hash :prefecture

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

## sellersテーブル
|Column|Type|Options|
|------|----|-------|
|revenue|integer||
|profit|integer||
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
|order_id|references|null: false, foreign_key: true|
### Association
- belongs_to :item
- belongs_to :user

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
### Association
- belongs_to :item
- belongs_to :user