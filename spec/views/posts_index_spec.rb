require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe 'Posts index page', type: :system do
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
      ),
      Post.create!(
        author: user,
        title: 'To jest tytył 2',
        text: 'A to jest juz tekst 2',
        likes_counter: 0,
        comments_counter: 0
      ),
      Post.create!(
        author: user,
        title: 'This is a title 2',
        text: 'This is text 2',
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
      )
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

  it 'checks if there is a profile image' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"

    pic = page.find(:css, 'img.squared-pic')
    expect(pic).to_not be nil
  end

  it 'checks if there is the user\'s username' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"

    expect(page).to have_content(user.name)
  end

  it 'checks if there is a correct number of posts' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"

    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  it 'checks if there are all posts listed' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"

    posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  it 'checks if we can see last 5 comment (only)' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"

    5.times do |i|
      expect(page).to have_content(comments[i + 1].text)
    end
    expect(page).not_to have_content(comments[0].text)
  end

  it 'checks if there are proper numbers of comments listed' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"

    expect(page).to have_content("#{posts[1].comments.length} 💬")
    expect(page).to have_content('0 💬')
  end

  it 'checks if there are proper numbers of likes' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"

    expect(page).to have_content("💬\n#{posts[1].likes.length}")
    expect(page).to have_content("💬\n#{posts[0].likes.length}")
    expect(page).to have_content("💬\n0")
  end

  it 'checks if there is a button called Pagination' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"

    expect(page).to have_button('Pagination')
  end

  it 'checks if clicking a post\'s title leads to its page' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"

    click_link posts[2].title
    expect(page).to have_current_path("/users/#{user.id}/posts/#{posts[2].id}")
  end
end

# rubocop:enable Metrics/BlockLength
