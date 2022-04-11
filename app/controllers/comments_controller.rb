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
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/PerceivedComplexity

  def get_comments
    user_id = nil
    post_id = nil
    params.each_pair do |key, value|
      next unless value.nil?

      json_key = JSON.parse(key)
      user_id = json_key['user_id']
      post_id = json_key['post_id']
    end

    user = User.where(id: user_id || params[:user_id])[0]

    respond_to do |format|
      if user
        post = user.posts.where(id: post_id || params[:post_id])[0]
        if post
          format.json { render json: post.comments }
        else
          format.json { render json: { success: false, message: ['Post must exist'] }, status: 404 }
        end
      else
        format.json { render json: { success: false, message: ['User must exist'] }, status: 404 }
      end
    end
  end

  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Naming/AccessorMethodName
  # rubocop:enable Metrics/PerceivedComplexity

  def add_comment
    comment = Comment.new(author: @curr_user, post_id: params[:post_id], text: params[:text])

    respond_to do |format|
      if comment.save
        format.json { render json: comment, status: 201 }
      else
        format.json { render json: { success: false, message: comment.errors.full_messages }, status: 422 }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
