require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @order_form = FactoryBot.build(:order_form)
  end

  describe '商品の購入' do
    context '商品の購入ができる' do
      it '必要な情報があれば商品を購入できる' do
        expect(@order_form).to be_valid
      end
      it '建物名が空でも購入できる' do
        @order_form.building = nil
        expect(@order_form).to be_valid
      end
    end
  end

    context '商品購入ができない' do
       it '郵便番号必須' do
        @order_form.postcode = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postcode can't be blank")
      end

      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能' do
        @order_form.postcode = '123'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postcode input correctly")
      end

      it '郵便番号が半角ハイフンを含む形でなければ購入できない' do
        @order_form.postcode = '１２３４５６７'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postcode input correctly")
      end

      it '都道府県必須' do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '都道府県に「---」が選択されている場合は購入できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村必須' do
        @order_form.city = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地必須' do
        @order_form.street = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Street can't be blank")
      end

      it '電話番号必須' do
        @order_form.phone = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone can't be blank")
      end

      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能' do
        @order_form.phone = '090-0000-0000'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone input only number")
      end

      it '電話番号が9桁以下では購入できない' do
        @order_form.phone = '09012345'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone input only number")
      end

      it '電話番号が12桁以上では購入できない' do
        @order_form.phone = '0901234567890'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone input only number")
      end

      it 'token必須' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'user必須' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item必須' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end


    end

end