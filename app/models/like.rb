class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  before_save :update_posts_likes_counter

  def update_posts_likes_counter
    post.increment!(:likes_counter)
  end
end
