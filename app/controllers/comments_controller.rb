class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to request.path, params: { success: true } }
      else
        format.html { redirect_to request.path, params: { success: false } }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
