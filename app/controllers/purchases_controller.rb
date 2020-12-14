class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create]
# 購入の一覧、詳細を確認することができるのはログインユーザーのみ
  before_action :set_item, only: [:index, :create, :destroy]

  def index  #フォームオブジェクトのインスタンスを生成し、インスタンス変数に代入する
    @user_purchase = UserPurchase.new        # フォームオブジェクトモデルのインスタンスの生成⇨フォームオブジェクトモデルのクラス名
   # @item = Item.find(params[:item_id])      # 商品情報を入手し、商品のインスタンスへ代入（フィールド変更なのでIDに注意）
  end
  
  
  def create

    @user_purchase = UserPurchase.new(user_purchase_params)
    if @user_purchase.valid?
      @user_purchase.save
      redirect_to item_path(@item)   # 保存可=>商品一覧トップページに戻る
    else
    # @item = Item.find(params[:item_id])   ここにも商品情報の定義、if else間とelse end間の間に定義が必要
      render :index                  # 保存不可=>購入画面トップへ
    end
  end 

  def destroy # 挙動確認はほぼできない部分：URL直接入力しても反応しない制御をつける部分
    
   if current_user.id == @item.user_id
      @user_purchase.destroy
      redirect_to item_path(@item) 
   else
    # @item = Item.find(params[:item_id])
      render :index
   end
  end
   
    private
  
     
  def user_purchase_params  # 購入と配送のストロングパラメーターを1つに統合
    # params.require(:モデル名).permit(:配送カラム).merge（外部キー：商品情報）
     params.require(:user_purchase).permit(:postcd, :city, :area_id, :addressb, :building, :phone).merge(item_id: params[:item_id])
  end

  def set_item # before_actionで上にまとめたメソッドの定義を記載
    @item = Item.find(params[:item_id])
  end
  
end
