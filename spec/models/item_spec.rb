require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
   end

  describe '商品出品' do
    context '商品の出品ができる場合' do
      it '必要な情報があれば商品出品成功' do
        expect(@item).to be_valid
      end
    end

    context '商品出品が不可' do
      it 'ユーザーがログイン必須' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
       it '商品の画像必須' do
        @item.image.attach(nil)
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
       end     
      it '商品名必須' do
        @item.itemname = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Itemname can't be blank")
      end
      it '商品説明必須' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリ必須' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品状態必須' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '送料の負担の説明必須' do
        @item.postage_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end
      it '発送元の地域必須' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数必須' do
        @item.shippingcost_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shippingcost can't be blank")
      end
      it '価格必須' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格は半角数値のみ保存可能' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格が300円未満の場合は出品不可' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '価格が9,999,999円を超える場合不可' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'カテゴリーに「---」は出品できない' do
        @item.category_id = 1
        @item.valid?
          expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態に「---」は出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担に「---」は出品できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end
      it '発送元の地域に「---」は出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数に「---」は出品できない' do
        @item.shippingcost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shippingcost can't be blank")
      end
    end
  end
end