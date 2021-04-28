- users - nick_name:string
  - email:string
  - avator:string(アバター画像を用意する）
    ※Active Storage を使えばカラムを用意しなくても ○
    https://railsguides.jp/active_storage_overview.html
  - password_digest:string
    https://qiita.com/ryosuketter/items/805452b7e6bf9637cb57
  - adnim:boolean
    <br>
- question - title:string - body:text - user_id:bigint
  <br>
- answer
  - body:text
  - user_id:bigint
  - qiestion_id:bigint
