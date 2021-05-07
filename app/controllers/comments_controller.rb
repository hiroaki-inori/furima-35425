class CommentsController < ApplicationController
  def new
  end

  def create
    @comment = Comment.new(comment_params)
    @user = @comment.user
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment, user: @user,
                                                      created_at: @comment.created_at.strftime('%Y/%m/%d %H:%M')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
