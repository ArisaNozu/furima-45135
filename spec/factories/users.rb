FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { Faker::Internet.unique.email }
    password              { 'test1234' }
    password_confirmation { password }
    last_name             { '田中' }
    first_name            { '太朗' }
    last_name_kana        { 'タナカ' }
    first_name_kana       { 'タロウ' }
    birth_date            { '1990-01-01' }
  end
end
