## リクエストからレスポンスまでの流れについて(GET 編)

とある SNS アプリがあります。ユーザーの一覧ページがブラウザに表示されるまで

- ユーザーが Web ブラウザにて、一覧表示に遷移するため/user の URL が設定されているリンクを押す
  ↓
- /user に対して GET メソッドでリクエストがサーバに送信される
  ↓
- Web サーバーがリクエストを受け取り、routes.rb にてルーティング機能がそのリクエストの処理をすべきコントローラー（クラス）とアクション（メソッド）を特定し、アクションを実行します。
  ↓
- コントローラーのアクションにて User.all を呼び出し、User モデルを通して users データベースからコレクション（ドキュメントの集合体）を読み込む。
  ↓
- インスタンス変数@users にコレクションが代入される
  ↓
- @users がビューで展開され、クライアントにレンダリングされます

## リクエストからレスポンスまでの流れについて(POST 編)

とあるタスク管理アプリがあります。タスクを新規作成するときの流れを説明してください。
以下のような要件とします。

新規作成ページを表示する
タスク名(name)を入力する
作成ボタンを押す
タスクの詳細画面に遷移する
なお、説明にあたり以下の言葉を使うことを条件とします。

/tasks (← URL です)
POST
モデル
データベース
<br>

#### 新規作成ページを表示する

- まず初めに以下のような画面の新規登録画面ボタン(/tasks/new のリンク）をクリックします。
  [![Image from Gyazo](https://i.gyazo.com/2b861fd1ea803c318a0ca58920fa5212.png)](https://gyazo.com/2b861fd1ea803c318a0ca58920fa5212)
- /tasks/new に対して GET リクエストが送られる
  [![Image from Gyazo](https://i.gyazo.com/a1d267ce9abb29f1d54225bbf02f022f.png)](https://gyazo.com/a1d267ce9abb29f1d54225bbf02f022f)
- Web サーバーがリクエストを受け取り、routes.rb にてルーティング機能がそのリクエストの処理をすべきコントローラー（クラス）とアクション（メソッド）を特定し、アクションを実行します。
  『new アクションで Task.new で空のインスタンスを作り、@task に代入。』

```
#tasks_controller.rb
  def new
    @task = Task.new
  end
```

- 新規登録ページ（new.html.slim)がクライアントにレンダリングされる

```
/new.html.slim
= form_with model: task, local: true do |f|
  .form-group
    = f.label :name
    = f.text_field :name, class: 'form-control', id: 'task_name'
  .form-group
    = f.label :description
    = f.text_field :description, row: 5, class: 'form-control', id: 'task_description'
  =f.submit nil, class: 'btn btn-primary'
```

[![Image from Gyazo](https://i.gyazo.com/911b9913a11f299f413cae2706c46693.png)](https://gyazo.com/911b9913a11f299f413cae2706c46693)

#### タスク名(name)を入力する

- 名称　のフォーム内にタスク名を入力する『ビールの発注をする』
  　※今回、詳しい説明　と書いてあるフォームの説明は省略する
  [![Image from Gyazo](https://i.gyazo.com/6c6437a6921394e80c136b93dde83eb8.png)](https://gyazo.com/6c6437a6921394e80c136b93dde83eb8)
  表示されているフォームの部分は、`form_with`というヘルパーメソッドを使っており、以下のような使い方をします。
  ⬇️

①

```
データベースに保存しない場合のform_withの書き方
<%= form_with url: "パス" do |form| %>
  フォーム内容
<% end %>
```

②

```
データベースに保存する場合のform_withの書き方
<%= form_with model: モデルクラスのインスタンス do |form| %>
  フォーム内容
<% end %>
```

<br>
今回は②を使い
```
/new.html.slim
= form_with model: task, local: true do |f|
  .form-group 
    = f.label :name
    = f.text_field :name, class: 'form-control', id: 'task_name'
  .form-group 
    = f.label :description
    = f.text_field :description, row: 5, class: 'form-control', id: 'task_description'
  =f.submit nil, class: 'btn btn-primary'
  ```
となっています。そして、上記のビューファイルは以下のようなHTMLファイルを生成します。
[![Image from Gyazo](https://i.gyazo.com/d7b35407467093d164eb1d489bdaa287.png)](https://gyazo.com/d7b35407467093d164eb1d489bdaa287)
いくつか説明します。
1. `action`は送信先のURLを指定します。"/tasks"ということはcreateアクションのURLが指定されているということです。
2.  `method`はPOSTのHTTPリクエストを指定しています。
3.  `name=tasks[name]`は、params = { task: { name: "タスク名"}}のように、フォームデータが2重のハッシュ構造を持たせられる
#### 作成ボタンを押す
- 今回の場合は『登録する』ボタンが作成ボタンとなります。
[![Image from Gyazo](https://i.gyazo.com/6a9f704f2b8be9a5525626592dcc306c.png)](https://gyazo.com/6a9f704f2b8be9a5525626592dcc306c)
- すると以下のように/tasksというURLに対してPOSTリクエストがサーバーに送られます。
[![Image from Gyazo](https://i.gyazo.com/236ec658c0f834a7798f2715e50b1ac7.png)](https://gyazo.com/236ec658c0f834a7798f2715e50b1ac7)

- ルーティングで`tasks#create`のコントローラーとアクションが実行されます。

```
tasksコントローラのcreateアクション
  def create
    @task = Task.new(task_params)
  end
```

ストロングパラメータである tasks_params で受け取った値を new メソッドの引数として、Task モデルのインスタンスを生成します。
`@task`に代入します。

#### タスクの詳細画面に遷移する

- if 文を用いてデータベースへの保存が成功した際に詳細ページに遷移するよう分岐します。保存に失敗した際は新規登録ページに

```
tasksコントローラのcreateアクション
   def create
        @task = Task.new(task_params)
        if @task.save
            redirect_to @task, notice: "タスク「#{@task.name}」を登録しました"
        else
            render :new
        end
    end
```

- 詳細ページに遷移する際には　`redirect_to @task`により tasks コントローラの show アクションが呼び出され、クライアントから GET リクエストが発生する。
  ↓
- ルーティングで対応する`tasks#show`が実行される
  ↓

- show アクションが起動され、データベースから取得したデータが@task に代入される

```
def show
    @task = Task.find(params[:id]) #パラメーター経由で対象タスクのIDを受け取り、タスクオブジェクトをデータベースから取得
  end
```

-対応するビューファイルである`show.html.slim`がクライアントにレンダリングされる。

```
h1 タスクの詳細

nav.jusfity-content-end
 = link_to "一覧", tasks_path, class: "nav-link"
table.table.table-hover
  tbody
    tr
     th= Task.human_attribute_name(:id)
     td= @task.id
    tr
     th= Task.human_attribute_name(:name)
     td= @task.name
    tr
     th= Task.human_attribute_name(:description)
     td= simple_format(h(@task.description), {}, sanitize: false, wrapper_tag: "div")
    tr
     th= Task.human_attribute_name(:created_at)
     td= @task.created_at
    tr
     th= Task.human_attribute_name(:updated_at)
     td= @task.updated_at
= link_to  "編集", edit_task_path, class: "btn btn-primary mr-3"
= link_to "削除", @task, method: :delete, data: { confirm: "タスク『#{@task.name}』を削除します。よろしいですか？" }, class: "btn btn-danger"
```

[![Image from Gyazo](https://i.gyazo.com/1ee378ff58d4413d6170fb3b8565baf5.png)](https://gyazo.com/1ee378ff58d4413d6170fb3b8565baf5)
