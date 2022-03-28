class Post < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :users, through: :likes
  has_many :users, through: :comments
end
