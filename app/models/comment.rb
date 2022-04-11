class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  before_save :update_posts_comments_counter

  def update_posts_comments_counter
    post.increment!(:comments_counter)
  end
end
