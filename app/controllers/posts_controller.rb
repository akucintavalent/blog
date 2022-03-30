class PostsController < ApplicationController
  def index; end

  def show
    @post = Post.where(id: params[:id])[0]
  end

  def new
    @new_post = Post.new
  end

  def create
    author = User.find(params['post']['author_id'].to_i)
    title = params['post']['title']
    text = params['post']['text']
    @post = Post.new(author: author, title: title, text: text)

    path_array = request.path.split('/')
    path_array.pop
    url = path_array.join('/')

    respond_to do |format|
      if @post.save
        format.html { redirect_to url, params: { success: true } }
      else
        format.html { redirect_to url, params: { success: false } }
      end
    end
  end
end
