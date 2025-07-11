class Product < ApplicationRecord


  validates :name, presence: true                  
  validates :description, presence: true           
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :shipping_cost_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_day_id, presence: true
  validates :price, presence: true


  belongs_to :user

end



