class PostsController < ApplicationController
  skip_before_action :authenticate_request

  def index; end

  def show
    @post = Post.where(id: params[:id])[0]
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Created a post succesfully'
        format.html { redirect_to "#{users_path}/#{current_user.id}" }
      else
        flash[:notice] = 'Failed to create a post. Try again'
        format.html { render :new }
      end
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    post.author.decrement!(:posts_counter)
    post.destroy
    flash[:notice] = 'Post was successfully removed'
    splitted_path = params[:url].split('/')
    splitted_path.pop if splitted_path.length == 7 # If the user removed the post while being on its page
    redirect_to params[:url]
  end

  # rubocop:disable Naming/AccessorMethodName

  def get_posts
    id = 0
    params.each_pair do |key, value|
      id = JSON.parse(key)['user_id'] if value.nil?
    end
    user = User.where(id: id || params[:user_id])[0]

    respond_to do |format|
      if user
        format.json { render json: user.posts }
      else
        format.json { render json: { success: false, message: ['User must exist'] }, status: 404 }
      end
    end
  end

  # rubocop:enable Naming/AccessorMethodName

  private

  def post_params
    params.require(:post).permit(:author_id, :title, :text, :comments_counter, :likes_counter)
  end
end
