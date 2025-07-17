FactoryBot.define do
  factory :product do
    association :user
    name { 'サンプル商品' }
    description { 'これはテスト用の商品です。' }
    category_id { 2 }
    condition_id { 2 }
    shipping_cost_id { 2 }
    prefecture_id { 2 }
    shipping_day_id { 2 }
    price { 1000 }

    after(:build) do |product|
      product.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
