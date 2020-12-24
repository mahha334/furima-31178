require 'rails_helper'
RSpec.describe UserPurchase, type: :model do
  describe '商品購入' do
 
    before do 
      user = FactoryBot.create(:user)  # ログイン者を設定
      item = FactoryBot.create(:item)  # 商品を選択
      @user_purchase = FactoryBot.build(:user_purchase, item_id: item.id, user_id: user.id)  # ログイン者が商品を設定して購入する。
                                     # 購入 ⇦ 商品箱に商品設定、ログイン者箱にログイン者設定
      sleep(1) # ターミナル稼働スピードを遅らせる記述
     end

 
    context '購入できる時' do
      it "すべての情報が正しいフォーマットで入力されていれば購入できる" do
       expect(@user_purchase).to be_valid
      end 

      it "buildingは空でも購入できる" do
        @user_purchase.building = nil
       expect(@user_purchase).to be_valid
      end 

    end
 

   context '購入できない時' do
     it "cityが空では登録できない" do 
       @user_purchase.city = nil
       @user_purchase.valid?
       expect(@user_purchase.errors.full_messages).to include("City can't be blank")
     end

     it "postcdが「-」を含む且つ7桁以外だと登録できない" do   
       @user_purchase.postcd = ("/\A\d{3}[-]\d{4}\z/")
       @user_purchase.valid?
       expect(@user_purchase.errors.full_messages).to include("Postcd is invalid. Include hyphen(-)")
     end
 
     it "phoneが数字以外では登録できない" do 
       @user_purchase.phone = ("＠")
       @user_purchase.valid?
       expect(@user_purchase.errors.full_messages).to include("Phone is invalid. Include nothyphen & <= 11")
     end
 
      it "phoneが12桁以上であれば登録できない" do 
        @user_purchase.phone = "123456789123"
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Phone is invalid. Include nothyphen & <= 11")
      end
 
      it "addressbが空では登録できない" do  
        @user_purchase.addressb = nil
        @user_purchase.valid?
       expect(@user_purchase.errors.full_messages).to include("Addressb can't be blank")
      end
 
      it "phoneが空では登録できない" do  
        @user_purchase.phone = nil
        @user_purchase.valid?
       expect(@user_purchase.errors.full_messages).to include("Phone can't be blank")
      end
 
      it "postcdが空では登録できない" do  
        @user_purchase.postcd = nil
        @user_purchase.valid?
       expect(@user_purchase.errors.full_messages).to include("Postcd can't be blank")
      end
 
      it "area_idが0では登録できない" do  
        @user_purchase.area_id = 0
        @user_purchase.valid?
       expect(@user_purchase.errors.full_messages).to include("Area must be other than 0")
      end
 
      it "tokenが空では登録できないこと" do
        @user_purchase.token = nil
        @user_purchase.valid?
        expect(@user_purchase.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが紐付いていないと保存できないこと' do 
        @user_purchase.user_id = nil
        @user_purchase.valid?
       expect(@user_purchase.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが紐付いていないと保存できないこと' do 
        @user_purchase.item_id = nil
        @user_purchase.valid?
       expect(@user_purchase.errors.full_messages).to include("Item can't be blank")
      end

    end
  end
end
 