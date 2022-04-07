class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)

    respond_to do |format|
      flash[:notice] = if @like.save
                         'Successfully created a like'
                       else
                         'Failed to create a like'
                       end
      format.html { redirect_to request.path }
    end
  end

  private

  def like_params
    params.require(:like).permit(:author_id, :post_id)
  end
end
