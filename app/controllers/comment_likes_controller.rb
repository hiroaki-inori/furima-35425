class CommentLikesController < ApplicationController
  
  def create
    CommentLike.create(user_id: current_user.id, comment_id: params[:id])
    redirect_to root_path
  end

  def destroy
    CommentLike.find_by(user_id: current_user.id, comment_id: params[:id]).destroy
    redirect_to root_path
  end

end
