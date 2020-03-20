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
