require 'rails_helper'
RSpec.describe Item, type: :model do
  describe '商品出品' do
    before do
      @item = FactoryBot.build(:item)
    end

  context '商品出品保存できる時' do
    it "priceが空でなければ登録できる" do
      @item.price = 500
      expect(@item).to be_valid
   end

    it "descriptionが空でなければ登録できる" do
      @item.description = @item.description
       expect(@item).to be_valid
  end

    it "productが空でなければ登録できる" do
      @item.product = @item.product
      expect(@item).to be_valid
 end

  end

  context '商品出品保存できない時' do
    it "priceが空では登録できない" do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end


    it "productが空では登録できない" do
      @item.product = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Product can't be blank")
     end

     it "descriptionが空では登録できない" do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
     end

     it "category_idが0では登録できない" do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Category must be other than 0")
     end

     it "condition_idが0では登録できない" do 
      @item.condition_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition must be other than 0")
     end

     it "area_idが0では登録できない" do 
      @item.area_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Area must be other than 0")
     end

     it "deliveryfee_idが0では登録できない" do 
      @item.deliveryfee_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Deliveryfee must be other than 0")
     end

     it "shipping_idが0では登録できない" do 
      @item.shipping_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping must be other than 0")
     end

     it 'userが紐付いていないと保存できないこと' do 
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
     end
  end
 end
end
