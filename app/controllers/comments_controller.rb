class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.update_posts_comments_counter

    respond_to do |format|
      flash[:notice] = if @comment.save
                         'Successfully created a comment'
                       else
                         'Failed to create a comment'
                       end
      format.html { redirect_to request.path }
    end
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    comment.post.decrement!(:comments_counter)
    comment.destroy
    flash[:notice] = 'Comment was successfully removed'
    redirect_to request.path
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
