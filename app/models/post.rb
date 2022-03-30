class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def update_users_posts_counter
    author.increment!(:posts_counter)
    author.save
  end

  def last_5_comments
    comments.order(created_at: :asc).last(5)
  end
end
