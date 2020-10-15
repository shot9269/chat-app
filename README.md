# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


#テーブル設計

##users テーブル

|Column   |  type     | options     |
|---------|-----------|-------------|   
|name     |  string   | null: false |   
|email    |  string   | null: false |   
|password |  string   | null: false |  

###Asociation
- has_many :room_users
- has_many :rooms, through: room_users
- has_many :messages


##rooms テーブル

|Column   |  type     | options     |
|---------|-----------|-------------|   
|name     |  string   | null: false |  

###Asociation
- has_many :room_users
- has_many :users, through: room_users
- has_many :messages


##rooms_users テーブル

|Column   |  type        | options                        |
|---------|--------------|--------------------------------|   
|user     |  reference   | null: false,foreign_key: true  |   
|room     |  reference   | null: false,foreign_key: true  |   

###Asociation
- belongs_to :user
- belongs_to :room


##messages テーブル

|Column   |  type     | options                       |
|---------|-----------|-------------------------------|   
|content  |  string   | null: false ,foreign_key: true|   
|user     |  string   | null: false ,foreign_key: true|   
|room     |  string   | null: false ,foreign_key: true| 

###Asociation
- belongs_to :user
- belongs_to :room
