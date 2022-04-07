require 'rails_helper'

RSpec.describe 'Posts show page', type: :system do
  let!(:user) do
    User.create!(
      name: 'Bodia',
      email: 'bodia@example.com',
      password: 'password',
      confirmed_at: Time.now,
      posts_counter: 3,
      bio: 'My name is Bodian, I love cooking and riding rollerblades'
    )
  end

  let!(:posts) do
    [
      Post.create!(
        author: user, 
        title: 'To jest tytył',
        text: 'A to jest juz tekst',
        likes_counter: 0,
        comments_counter: 0
      ),
      Post.create!(
        author: user, 
        title: 'This is a title',
        text: 'This is text',
        likes_counter: 0,
        comments_counter: 0
      )
    ]
  end

  let!(:comments) do
    [
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'A to jest komentarz'
      ),
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'A to jest drugi komentarz'
      ),
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'A to jest trzeci komentarz'
      ),
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'A to jest czwarty komentarz'
      ),
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'A to jest piąty komentarz'
      ),
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'A to jest szósty komentarz'
      ),
    ]
  end

  let!(:likes) do
    [
      Like.create!(post: posts[1], author: user),
      Like.create!(post: posts[1], author: user),
      Like.create!(post: posts[1], author: user),
      Like.create!(post: posts[0], author: user)
    ]
  end

  it 'checks if there is title and text of the post' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts/#{posts[1].id}"

    expect(page).to have_content(posts[1].title)
    expect(page).to have_content(posts[1].text)
  end

  it 'checks if we can see who wrote the post' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts/#{posts[1].id}"

    expect(page).to have_link(posts[1].author.name)
  end

  it 'checks if there is the proper number of comments listed' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    comment = comments[0]
    visit "/users/#{user.id}/posts/#{posts[1].id}"

    expect(page).to have_content("#{posts[1].comments.length} 💬")
  end

  it 'checks if there are proper numbers of likes' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts/#{posts[1].id}"

    expect(page).to have_content("💬\n#{posts[1].likes.length}")
  end

  it 'checks if we can see all comments\' author names' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts/#{posts[1].id}"

    comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end

  it 'checks if we can see all comments' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts/#{posts[1].id}"

    comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end