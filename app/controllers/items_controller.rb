class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


# 記事の一覧、詳細を確認することができるのはログインユーザーのみ
  before_action :set_item, only: [:show, :edit, :update, :destroy]
# before_actionによって、アクションを起こす前にset_itemメソッドで同じプログラムをまとめた物を実行する  

  def index # 一覧表示:降順(DESC)並び替え
    @items = Item.all.order("created_at DESC")

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show

    
  end

  def edit  # 「商品に紐付いた購入履歴があったらトップページに遷移する」という条件もeditアクションに追加。 
    # ①ログイン＆購入済み商品選択した場合、②ログイン者＝出品者でもログイン者≠出品者でなくても、トップへ（出品者と非出品者の場合に区別）
     # ③ログイン者≠出品者で、非購入ならトップへ
    # 出品者とログイン者が同じで、購入済の編集画面URLを入力したらトップへ 
    if user_signed_in? && @item.purchase.present?     # ログインしている＆売却済み商品選択
      #redirect_to root_path   
       # 出品者とログイン者が異なるなら編集画面に行かないので編集画面URL入力しても飛ばない    
       #unless current_user.id == @item.user_id # ログイン者 ≠ 出品者
        redirect_to root_path  
       #end  
    end  
     
  end  # ログイン≠出品者なのに出品者の商品編集画面にいける！→出品者＝ログイン者なら編集画面に飛ぶので、出品者≠ログイン者は即トップへ

  def update

    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end


  def destroy # 挙動確認はほぼできない部分：URL直接入力しても反応しない制御をつける部分

    if current_user.id == @item.user_id
       @item.destroy
       redirect_to root_path
    else
       render :show
    end
  end

  private
  
  def item_params # このテーブルにこれらのキーを保存：セキュリティに関わる考え
    params.require(:item).permit(:product, :price, :description, :category_id, :condition_id, :deliveryfee_id, :area_id, :shipping_id, :image).merge(user_id: current_user.id)
  end

  def set_item # before_actionで上にまとめたメソッドの定義を記載
    @item = Item.find(params[:id])
  end

  
end


