require 'rails_helper'

RSpec.describe 'Users index page', type: :system do
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

  it 'checks if there is a profile image' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"

    pic = page.find(:css, 'img.squared-pic')
    expect(pic).to_not be nil
  end

  it 'checks if there is the user\'s username' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"

    expect(page).to have_content(user.name)
  end

  it 'checks if there is a correct number of posts' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"

    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end


  it 'checks if there is a correct number of posts' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"

    expect(page).to have_content(user.bio)
  end

  it 'checks if there are first 3 posts' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"

    3.times do |i|
      expect(page).to have_content(posts[i].title)
      expect(page).to have_content(posts[i].text)
    end
  end

  it 'checks if there a link "See all posts"' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"

    expect(page).to have_link('See all posts')
  end

  it 'checks if there a link "See all posts"' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"

    click_link posts[1].title
    expect(page).to have_current_path("/users/#{user.id}/posts/#{posts[1].id}")
  end

  it 'checks if there a link "See all posts"' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"

    click_link 'See all posts'
    expect(page).to have_current_path("/users/#{user.id}/posts")
  end
end
