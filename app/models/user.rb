class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  # has_many :posts, through: :likes
  # has_many :posts, through: :comments

  def last_3_posts
    self.posts.order(created_at: :desc).limit(3)
  end
end
