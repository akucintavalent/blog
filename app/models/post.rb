class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, length: 1..250, presence: true, allow_blank: false
  validates :comments_counter, numericality: { only_integer: true, greater_than: -1 }
  validates :likes_counter, numericality: { only_integer: true, greater_than: -1 }

  def update_users_posts_counter
    author.increment!(:posts_counter)
    author.save
  end

  def last_5_comments
    comments.order(created_at: :asc).includes(:author).last(5)
  end
end
