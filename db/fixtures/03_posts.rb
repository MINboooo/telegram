unless Rails.env.production?
  # 50件のデータを用意する
  POST_MAX = 50

  # Proc.newでその後の配列をオブジェクトとしてpost_attrsに代入
  post_attrs = Proc.new do
    # Array.newでその後の内容を配列としてオブジェクト化する準備
    Array.new(POST_MAX) do |idx|
      { id: idx + 1,
        # Fakerを使って文言を用意
        caption: Faker::Lorem.paragraph,
        user_id: User.pluck(:id).sample
      }
    end
  end

  # Proc.newでオブジェクト化したデータ(*post_attrs)を.callで呼び出して保存
  # seed_onceメソッドは上書きを行わない。なおかつバリデーションは無効化して登録できる。
  Post.seed_once(:id, *post_attrs.call)

end
