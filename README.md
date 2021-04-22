# README

# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| --------           | ------ | -----------               |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last-name          | string | null: false               |
| first-name         | string | null: false               |
| last-name-kana     | string | null: false               |
| first-name-kana    | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :buys


## items テーブル

| Column             | Type       | Options                        |
| ------             | ------     | -----------                    |
| item_name          | string     | null: false                    |
| item_text          | text       | null: false                    |
| category_id        | integer    | null: false                    |
| status_id          | integer    | null: false                    |
| delivery_charge_id | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| shipping_day_id    | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :buy


## buys テーブル

| Column         | Type       | Options                        |
| -------        | -------    | -----------                    |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery


## deliverys テーブル

| Column           | Type       | Options                        |
| -------          | -------    | -----------                    |
| postcode         | string     | null: false                    |
| prefecture_id    | integer    | null: false                    |
| city             | string     | null: false                    |
| block            | string     | null: false                    |
| building         | string     |                                |
| tel              | string     | null: false                    |
| buy              | references | null: false, foreign_key: true |

### Association

- belongs_to :buy