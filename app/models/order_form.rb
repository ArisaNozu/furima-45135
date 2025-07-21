class OrderForm
  include ActiveModel::Model
  # Orderテーブルのカラム（user_id, product_id）
  attr_accessor :user_id, :product_id
  # Addressテーブルのカラム（addressesテーブルの各フィールド）
  attr_accessor :postal_code, :prefecture_id, :city,
                :house_number, :building_name, :phone_number
  # クレジットカードのトークン
  attr_accessor :token

  # 共通の空欄チェック
  with_options presence: true do
    validates :user_id
    validates :product_id
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :house_number
    validates :phone_number
    validates :token
  end

  # 郵便番号のフォーマット（例：123-4567）
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「123-4567」の形式で入力してください' }

  # 都道府県の選択（id:1は「---」などの初期値と仮定）
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }

  # 電話番号：10〜11桁の半角数字のみ
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10〜11桁の半角数字で入力してください' }

  def save
    order = Order.create(user_id: user_id, product_id: product_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      house_number: house_number,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
