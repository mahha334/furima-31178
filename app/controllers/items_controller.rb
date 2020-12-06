class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
# 記事の一覧、詳細を確認することができるのはログインユーザーのみ

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
    @item = Item.find(params[:id])
  end

  #def edit
  #  @item = Items.find(params[:id])
  #  unless current_user == @item.user
  #   redirect_to root_path
  #  end
  #end

  #def update
  #  @item = Item.find(params[:id])
  #  if @item.update(item_params)
  #    redirect_to item_path(@item)
  #  else
  #    render :edit
  #  end
  #end

  #def destroy
  #  item = Item.find(params[:id])
  #  item.destroy
  #  redirect_to root_path
  #end

  private

  def item_params # このテーブルにこれらのキーを保存：セキュリティに関わる考え
    params.require(:item).permit(:product, :price, :description, :category_id, :condition_id, :deliveryfee_id, :area_id, :shipping_id, :item_image).merge(user_id: current_user.id)
  end
  
end


