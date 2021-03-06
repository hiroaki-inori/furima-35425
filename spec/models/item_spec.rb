require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品登録できるとき' do
      it '全て入力すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '商品登録できないとき' do
      it '商品画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品の説明が空では登録できない' do
        @item.item_text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item text can't be blank")
      end
      it 'カテゴリーの情報が空では登録できない' do
        @item.category_id = '---'
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not a number')
      end
      it '商品の状態についての情報が空では登録できない' do
        @item.status_id = '---'
        @item.valid?
        expect(@item.errors.full_messages).to include('Status is not a number')
      end
      it '発送元の地域についての情報が空では登録できない' do
        @item.delivery_charge_id = '---'
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery charge is not a number')
      end
      it '発送までの日数についての情報が空では登録できない' do
        @item.shipping_day_id = '---'
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day is not a number')
      end
      it '販売価格についての情報が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'カテゴリーの情報がid:1では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it '商品の状態についての情報がid:1では登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status must be other than 1')
      end
      it '発送元の地域についての情報がid:1では登録できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery charge must be other than 1')
      end
      it '発送までの日数についての情報がid:1では登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day must be other than 1')
      end
      it '販売価格が¥300未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than 299')
      end
      it '販売価格が¥10,000,000以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 10000000')
      end
      it '販売価格の値が全角では登録できない' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '販売価格の値が半角英数字混合では登録できない' do
        @item.price = 'a500'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '販売価格の値が半角英字のみでは登録できない' do
        @item.price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'userが紐づいていない商品は登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
