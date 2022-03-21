class Public::CommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @comment = current_end_user.comments.new(comment_params)
    @comment.review_id = @review.id
    if @comment.save
       @review.create_notification_comment!(current_end_user, @comment.id)
    else
      render 'error'
    end

  end

  def destroy
    Comment.find(params[:id]).destroy
    @review = Review.find(params[:review_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
