FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    surname {"山田"}
    name {"隆太郎"}
    surnamef {"ヤマダ"}
    namef {"リクタロウ"}
    birthday {"2000.10.11"}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}

  end
end