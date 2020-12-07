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

  def edit
    
    unless current_user == @item.user
     redirect_to root_path
    end
  end

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
    params.require(:item).permit(:product, :price, :description, :category_id, :condition_id, :deliveryfee_id, :area_id, :shipping_id, :item_image).merge(user_id: current_user.id)
  end

  def set_item # before_actionで上にまとめたメソッドの定義を記載
    @item = Item.find(params[:id])
  end
  
end


