class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  def update_posts_comments_counter
    post.increment!(:comments_counter)
    post.save
  end
end
