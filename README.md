## usersテーブル

|カラム|データ型|
|----|----|
|name|string|
|email|string|
|password_digest|string|

## tasksテーブル

|カラム|データ型|
|----|----|
|name|string|
|description|text|
|end_date|date|
|status|string|

## labelsテーブル

|カラム|データ型|
|----|----|
|name|string|

## labelingsテーブル

|カラム|データ型|
|----|----|
|task_id|integer|
|label_id|integer|

## herokuへのデプロイ方法

- herokuへlogin  
`heroku login`

- herokuに新しいアプリケーションを作成  
`heroku create`

- herokuにデプロイする  
`git push heroku master`

- データベースの移行  
`heroku run rails db:migrate`

- アプリケーションにアクセスする  
`https://アプリ名.herokuapp.com/`
