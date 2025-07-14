class Product < ApplicationRecord

# アソシエーション
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day


# バリデーション
  validates :name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1 , message: "を選択してください"}
  validates :condition_id, presence: true, numericality: { other_than: 1 , message: "を選択してください"}
  validates :shipping_cost_id, presence: true, numericality: { other_than: 1 , message: "を選択してください"}
  validates :prefecture_id, presence: true, numericality: { other_than: 1 , message: "を選択してください"}
  validates :shipping_day_id, presence: true, numericality: { other_than: 1 , message: "を選択してください"}
  validates :price, presence: true
  validates :image, presence: true


  # 価格の範囲チェック（例：300〜9,999,999円）
  validates :price, numericality: { 
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: 'は300円〜9,999,999円の間で設定してください'
  }


end



