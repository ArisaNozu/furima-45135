FactoryBot.define do
  factory :order_form do
    association :user
    association :product

    postal_code     { '123-4567' }
    prefecture_id   { 2 } # 1以外のID（ActiveHashで「---」以外）
    city            { '横浜市' }
    house_number    { '青山1-1-1' }
    building_name   { '柳ビル103' }
    phone_number    { '09012345678' }
    token           { 'tok_abcdefghijk00000000000000000' }

    after(:build) do |order_form|
      order_form.user_id = create(:user).id
      order_form.product_id = create(:product).id
    end
  end
end
