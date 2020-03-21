unless Rails.env.production?
  # 10件のデータを用意する
  USER_MAX = 10
  user_attrs = Proc.new do
    Array.new(USER_MAX) do |idx|
      { id: idx + 1,
        # Fakerを使ってデータを用意
        email: Faker::Internet.email,
        name: Faker::Name.name,
        username: Faker::Name.name,
        description: Faker::Lorem.paragraph,
        password: 'password',
        password_confirmation: 'password',
      }
    end
  end

  # 配列を一度に登録する(一度だけ)
  User.seed_once(:id, *user_attrs.call)

end
