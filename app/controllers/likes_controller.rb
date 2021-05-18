class LikesController < ApplicationController

  def create
    @like = Like.new(user_id: current_user.id, item_id: params[:item_id])
    @like.save
    @item = Item.find_by(id: @like.item_id)
    @like_count = Like.where(item_id: params[:item_id]).count
  end
  
  def delete
    @like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
    @item = Item.find_by(id: @like.item_id)
    @like.destroy
    @like_count = Like.where(item_id: params[:item_id]).count
  end

end
