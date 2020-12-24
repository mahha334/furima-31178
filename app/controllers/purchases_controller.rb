class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
 # 購入の一覧、詳細を確認することができるのはログインユーザーのみ
  before_action :set_item, only: [:index, :create] 
  before_action :move_to_roguout, only: [:index]
  before_action :move_to_purchase, only: [:index]

  def index   #フォームオブジェクトのインスタンスを生成し、インスタンス変数に代入する
    @user_purchase = UserPurchase.new        # フォームオブジェクトモデルのインスタンスの生成⇨フォームオブジェクトモデルのクラス名
   # @item = Item.find(params[:item_id])      # 商品情報を入手し、商品のインスタンスへ代入（フィールド変更なのでIDに注意）
  end
  
  
  def create

    @user_purchase = UserPurchase.new(user_purchase_params)
    if @user_purchase.valid?
      pay_item
      @user_purchase.save
      redirect_to item_path(@item)   # 保存可=>商品一覧トップページに戻る
    else
    # @item = Item.find(params[:item_id])   ここにも商品情報の定義、if else間とelse end間の間に定義が必要
      render :index                  # 保存不可=>購入画面トップへ
    end
  end 

    private
     
  def user_purchase_params  # 購入と配送のストロングパラメーターを1つに統合
    # params.require(:モデル名).permit(:配送カラム).merge（外部キー：商品情報）
     params.require(:user_purchase).permit(:postcd, :city, :area_id, :addressb, :building, :phone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item # before_actionで上にまとめたメソッドの定義を記載
    @item = Item.find(params[:item_id])
  end

  def pay_item  # Payjp::Charge.create(内の記述ルールは「amount: card: currency:」の順番で記述するのがルール)
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述 ⇨ 秘密鍵代入した環境変数を呼び込めるように修正
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段 itemで入力された金額を入手できるようにする。 @item.priceで=> 5000と表示
      card: user_purchase_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

 # - ログイン者＝出品物が、URLを直接入力してその出品物を商品購入ページに遷移しようとすると、トップページに遷移すること
                   #        やりたいこと：ニック＝ニック、自分の商品購入ページ -> トップページ
  def move_to_roguout    
    if current_user.id == @item.user_id     # ログイン者 = 出品者で自身の出品した商品購入
      redirect_to root_path           #トップページパス 
    end            
  end

 # - 単純にログイン状態で、売却済み画面のURLを直入力すると、トップページに遷移すること
  def move_to_purchase 
                   #         やりたいこと：単純にログインした状態で、売却済み商品URLを入力 -> トップページ
                    
       if user_signed_in? # ログインしているなら 
         redirect_to root_path                      # トップページ
       end  
   

  end     

end           
                