class CommentsController < ApplicationController
  skip_before_action :authenticate_request
  before_action :authenticate_request, only: [:add_comment]
  protect_from_forgery with: :null_session, only: [:add_comment]

  def create
    @comment = current_user.comments.new(comment_params)

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

  # rubocop:disable Naming/AccessorMethodName

  def get_comments
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])

    respond_to do |format|
      if user
        if post
          format.json { render json: post.comments }
        else
          format.json { render json: { success: false, message: ['Post doesn\'t exist'] } }
        end
      else
        format.json { render json: { success: false, message: ['User doesn\'t exist'] } }
      end
    end
  end

  # rubocop:enable Naming/AccessorMethodName

  def add_comment
    comment = Comment.new(author: @curr_user, post_id: params[:post_id], text: params[:text])

    respond_to do |format|
      if comment.save
        format.json { render json: comment }
      else
        format.json { render json: { success: false, message: comment.errors.full_messages } }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
