require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'Increments its post\'s comments_counter three times' do
    user = User.create!(name: 'Semen Dick', photo: 'https://incels.wiki/images/5/58/Francisco.jpg',
                        bio: 'Just a pretty boy. Roaaaaarrrrrr', posts_counter: 0)
    post = Post.create(author: user, title: 'This is a title', comments_counter: 333, likes_counter: 777)
    comment = Comment.create(author: user, post: post, text: 'This is the text')
    comment.update_posts_comments_counter
    comment.update_posts_comments_counter
    comment.update_posts_comments_counter
    expect(post.comments_counter).to be 336
  end
end
