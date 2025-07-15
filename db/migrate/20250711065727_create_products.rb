class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string     :name,              null: false                     # 商品名
      t.text       :description,       null: false                     # 商品の説明
      t.integer    :category_id,       null: false                     # カテゴリー（ActiveHash）
      t.integer    :condition_id,      null: false                     # 商品の状態（ActiveHash）
      t.integer    :shipping_cost_id,  null: false                     # 配送料の負担（ActiveHash）
      t.integer    :prefecture_id,     null: false                     # 発送元の地域（ActiveHash）
      t.integer    :shipping_day_id,   null: false                     # 発送までの日数（ActiveHash）
      t.integer    :price,             null: false                     # 商品価格
      t.references :user,              null: false, foreign_key: true  # 出品者
      t.timestamps
    end
  end
end
