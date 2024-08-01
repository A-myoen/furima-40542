# テーブル設計

## users テーブル

| Column             | Type    | Options                  |
| ------------------ | ------- | ------------------------ |
| nickname           | string  | null: false              |
| email              | string  | null: false,unique: true |
| encrypted_password | string  | null: false              |
| firstname         | string  | null: false              |
| lastname          | string  | null: false              |
| firstnamekana    | string  | null: false              |
| lastnamekana     | string  | null: false              |
| birthdate           | date    | null: false              |

### Association
- has_many :items
- has_many :orders



## items テーブル

| Column           | Type       | Options                        |
| -----------------| ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| itemname        | string     | null: false                    |
| description      | string       | null: false                    |
| category      | string     | null: false                    |
| condition     | string    | null: false                    |
| postage       | string     | null: false                    |
| prefecture    | string     | null: false                    |
| shippingcost  | string     | null: false                    |
| price            | integer    | null: false                    |

### Association
- belongs_to :user
- has_one    :order



## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postcode       | string     | null: false                    |
| prefecture | string    | null: false                    |
| city          | string     | null: false                    |
| street        | string     | null: false                    |
| building      | string     |                                |
| phone         | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association
- belongs_to :order



## orders テーブル
| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association
- has_one :address
- belongs_to :item
- belongs_to :user