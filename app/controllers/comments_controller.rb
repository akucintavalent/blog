class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.update_posts_comments_counter

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Successfully created a comment'
      else
        flash[:notice] = 'Failed to create a comment'
      end
      format.html { redirect_to request.path }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
