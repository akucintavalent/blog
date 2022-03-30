class LikesController < ApplicationController
  def create
    author = User.find(params['like']['author_id'].to_i)
    post = Post.find(params['like']['post_id'].to_i)
    @like = Like.new(post: post, author: author)

    respond_to do |format|
      @like.save
      format.html { redirect_to request.path }
    end
  end
end
