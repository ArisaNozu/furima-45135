require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product)
    @order_form = FactoryBot.build(:order_form, user_id: user.id, product_id: product.id)
  end

  describe '商品購入' do
    context '購入できるとき' do
      it 'すべての項目が正しく入力されていれば購入できる' do
        expect(@order_form).to be_valid
      end

      it 'building_nameが空でも購入できる' do
        @order_form.building_name = ''
        expect(@order_form).to be_valid
      end
    end

    context '購入できないとき' do
      it 'postal_codeが空だと購入できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors[:postal_code]).to include("can't be blank")
      end

      it 'postal_codeが「3桁-4桁」でないと購入できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        puts @order_form.errors.full_messages
        expect(@order_form.errors.full_messages).to include('Postal code は「123-4567」の形式で入力してください')
      end

      it 'prefecture_idが1（---）だと購入できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Prefecture を選択してください')
      end

      it 'cityが空だと購入できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberが空だと購入できない' do
        @order_form.house_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空だと購入できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では購入できない' do
        @order_form.phone_number = '090123456'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number は10〜11桁の半角数字で入力してください')
      end

      it 'phone_numberが12桁以上では購入できない' do
        @order_form.phone_number = '090123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number は10〜11桁の半角数字で入力してください')
      end

      it 'phone_numberにハイフンがあると購入できない' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number は10〜11桁の半角数字で入力してください')
      end

      it 'tokenが空だと購入できない' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空だと購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'product_idが空だと購入できない' do
        @order_form.product_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Product can't be blank")
      end
    end
  end
end
