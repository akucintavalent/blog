class Like < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  belongs_to :post

  def update_posts_likes_counter
    self.post.increment!(:likes_counter)
    self.post.save
  end
end
