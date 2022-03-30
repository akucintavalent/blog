class PostsController < ApplicationController
  def index; end

  def show
    @post = Post.where(id: params[:id])[0]
  end

  def new
    @post = Post.new
  end

  def create
    author = User.find(params['post']['author_id'].to_i)
    title = params['post']['title']
    text = params['post']['text']
    @post = Post.new(author: author, title: title, text: text)

    respond_to do |format|
      @post.save
      format.html { redirect_to "#{users_path}/#{current_user.id}" }
    end
  end
end
