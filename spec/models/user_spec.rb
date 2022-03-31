require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Creates a three valid post for a user and gets them from a database' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg', bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    first_post = Post.create!(author: user, title: 'Post title', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
    second_post = Post.create!(author: user, title: 'I love Valent', text: 'Valent is my purest love', comments_counter: 0, likes_counter: 0)
    third_post = Post.create!(author: user, title: 'Aku cinta Valent', text: 'Aku mencintaimu Valent', comments_counter: 0, likes_counter: 0)
    last_3_posts = user.last_3_posts
    expect(last_3_posts[0].id).to be first_post.id
    expect(last_3_posts[1].id).to be second_post.id
    expect(last_3_posts[2].id).to be third_post.id
  end

  it 'Creates an invalid user' do
    invalid_user = User.create
    expect(invalid_user).to_not be_valid
  end

  it 'Creates an invalid user' do
    invalid_user = User.create(name: 'God')
    expect(invalid_user).to_not be_valid
  end

  it 'Creates an invalid user' do
    valid_user = User.create(name: 'God', posts_counter: 0)
    expect(valid_user).to be_valid
  end
end
