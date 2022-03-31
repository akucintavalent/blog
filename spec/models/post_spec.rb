require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'Updates a user\'s posts_counter' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg', bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create!(author: user, title: 'Post title', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
    post.update_users_posts_counter
    post.update_users_posts_counter
    expect(user.posts_counter).to be 2
  end

  it 'Gets users 5 most recent comments' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg', bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create!(author: user, title: 'Post title', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
    first_comment = Comment.create!(post: post, author: user, text: 'Hello there!' )
    second_comment = Comment.create!(post: post, author: user, text: 'How is it going for you, dude?' )
    five_recent_comments = post.last_5_comments
    expect(five_recent_comments.length).to be 2
    expect(five_recent_comments[0].id).to be first_comment.id
    expect(five_recent_comments[1].id).to be second_comment.id
  end

  it 'Creates invalid post (title, comments_counter, likes_counter)' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg', bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create(author: user)
    expect(post).to_not be_valid
  end

  it 'Creates invalid post (title length)' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg', bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create(author: user, title: "WTF?" * 100, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'Creates invalid post (comments_counter: -1)' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg', bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create(author: user, title: "TITLE", comments_counter: -1, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'Creates invalid post (comments_counter: -1)' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg', bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create(author: user, title: "TITLE", comments_counter: 1, likes_counter: -777)
    expect(post).to_not be_valid
  end

  it 'Creates invalid post (comments_counter: -1)' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg', bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create(author: user, title: "TITLE", comments_counter: nil, likes_counter: 777)
    expect(post).to_not be_valid
  end

  it 'Creates valid post' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg', bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create(author: user, title: "This is a title", comments_counter: 333, likes_counter: 777)
    expect(post).to be_valid
  end

  it 'Creates invalid post (title:"") ' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg', bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create(author: user, title: "", comments_counter: 333, likes_counter: 777)
    expect(post).to_not be_valid
  end
end
