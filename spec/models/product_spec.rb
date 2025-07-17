require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品出品' do
    context '出品できるとき（正常系）' do
      it 'すべての項目が正しく入力されていれば出品できる' do
        expect(@product).to be_valid
      end
    end

    context '出品できないとき（異常系）' do
      it '商品画像が空では出品できない(商品画像を1枚つけることが必須であること)' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include "Image can't be blank"
      end

      it '商品名が空では出品できない(商品名が必須であること)' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Name can't be blank"
      end

      it '商品説明が空では出品できない(商品の説明が必須であること)' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Description can't be blank"
      end

      it 'カテゴリーが「---」では出品できない(カテゴリーの情報が必須であること)' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include 'Category を選択してください'
      end

      it '商品の状態が「---」では出品できない(商品の状態の情報が必須であること)' do
        @product.condition_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include 'Condition を選択してください'
      end

      it '配送料の負担が「---」では出品できない(配送料の負担の情報が必須であること)' do
        @product.shipping_cost_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include 'Shipping cost を選択してください'
      end

      it '発送元の地域が「---」では出品できない(発送元の地域の情報が必須であること)' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include 'Prefecture を選択してください'
      end

      it '発送までの日数が「---」では出品できない(発送までの日数の情報が必須であること)' do
        @product.shipping_day_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include 'Shipping day を選択してください'
      end

      it '価格が空では出品できない(価格の情報が必須であること)' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include "Price can't be blank"
      end

      it '価格が299円以下では出品できない(価格は¥300以上であること)' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price は300円〜9,999,999円の間で設定してください'
      end

      it '価格が10,000,000円以上では出品できない(価格は¥9,999,999以下であること)' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price は300円〜9,999,999円の間で設定してください'
      end

      it '価格が全角文字では出品できない' do
        @product.price = '３００'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price は数値で入力してください'
      end

      it '価格が文字列では出品できない' do
        @product.price = 'abc'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price は数値で入力してください'
      end

      it '価格が英数字混合では出品できない' do
        @product.price = '123abc'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price は数値で入力してください'
      end

      it 'userが紐づいていない場合は登録できない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include 'User must exist'
      end
    end
  end
end
