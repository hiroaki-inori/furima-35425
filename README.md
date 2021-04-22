# README

# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------        | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| last-name       | string | null: false |
| first-name      | string | null: false |
| last-name-kana  | string | null: false |
| first-name-kana | string | null: false |
| birthday        | date   | null: false |

### Association

- has_many :delivery_users
- has_many :deliverys, through: delivery_users
- has_many :items
- has_many :buys


## delivery_users テーブル

| Column  | Type       | Options                        |
| ------  | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| deliver | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user


## items テーブル

| Column          | Type       | Options                        |
| ------          | ------     | -----------                    |
| item-name       | string     | null: false                    |
| item-text       | text       | null: false                    |
| category        | string     | null: false                    |
| status          | string     | null: false                    |
| delivery_charge | string     | null: false                    |
| delivery_area   | string     | null: false                    |
| shipping_days   | string     | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |
| buy             | references | null: false, foreign_key: true |
| deliver         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :buy
- belongs_to :delivery


## buys テーブル

| Column          | Type       | Options                        |
| -------         | -------    | -----------                    |
| credit_card     | integer    | null: false                    |
| expiration_date | date       | null: false                    |
| security_code   | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :items
- has_one :delivery


## deliverys テーブル

| Column        | Type       | Options                        |
| -------       | -------    | -----------                    |
| postcode      | integer    | null: false                    |
| prefecture_id | string     | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building      | string     |                                |
| tel           | integer    | null: false                    |
| buy           | references | null: false, foreign_key: true |

### Association

- has_many :items
- has_many :user_buys
- has_many :users, through: user_buys
- belongs_to :buy