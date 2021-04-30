require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_delivery).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空の場合は保存できない' do
        @order_delivery.postcode = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postcode can't be blank")
      end
      it '郵便番号にハイフンがない場合は保存できない' do
        @order_delivery.postcode = 1234567
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it '郵便番号が全角の場合は保存できない' do
        @order_delivery.postcode = '１２３−４５６７'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it '都道府県が選択されていない場合は保存できない' do
        @order_delivery.prefecture_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村の値が空の場合は保存できない' do
        @order_delivery.city = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("City can't be blank")
      end
      it '番地の値が空の場合は保存できない' do
        @order_delivery.block = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号が空の場合は保存できない' do
        @order_delivery.tel = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tel can't be blank")
      end
      it '電話番号が数値ではない場合は保存できない' do
        @order_delivery.tel = "０９０１２３４５６７８"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tel is invalid.")
      end
      it '電話番号が11桁でない場合は保存できない' do
        @order_delivery.tel = "0901234567"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tel is invalid.")
      end
      it 'user_idが紐づいていない場合は保存できない' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていない場合は保存できない' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空の場合は保存できない' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end