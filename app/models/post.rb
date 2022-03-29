class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :users, through: :likes
  # has_many :users, through: :comments

  def update_users_posts_counter
    self.author.increment!(:posts_counter)
    self.author.save
  end

  def last_5_comments
    self.comments.order(created_at: :desc).limit(5)
  end
end




