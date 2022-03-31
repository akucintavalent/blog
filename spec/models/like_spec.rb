require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'Increments likes_counter' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg',
                        bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create(author: user, title: 'This is a title', comments_counter: 333, likes_counter: 777)
    like = Like.create(author: user, post: post)
    like.update_posts_likes_counter
    like.update_posts_likes_counter
    like.update_posts_likes_counter
    expect(post.likes_counter).to be 780
  end
end
