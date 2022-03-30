class CommentsController < ApplicationController
  def create
    author = User.find(params['comment']['author_id'].to_i)
    post = Post.find(params['comment']['post_id'].to_i)
    text = params['comment']['text']
    @comment = Comment.new(post: post, author: author, text: text)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to request.path, params: { success: true } }
      else
        format.html { redirect_to request.path, params: { success: false } }
      end
    end
  end
end
