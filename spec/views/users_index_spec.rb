require 'rails_helper'

RSpec.describe 'Users index page', type: :system do
  let!(:users) do
    [
      User.create!(
        name: 'Bodia',
        email: 'bodia@example.com',
        password: 'password',
        confirmed_at: Time.now,
        posts_counter: 3
      ),
      User.create!(
        name: 'Dan',
        email: 'dan@example.com',
        password: 'password',
        confirmed_at: Time.now,
        posts_counter: 7
      ),
      User.create!(
        name: 'Bohdan',
        email: 'bohdan@example.com',
        password: 'password',
        confirmed_at: Time.now,
        posts_counter: 12
      )
    ]
  end

  it 'checks if every user is shown on the page' do
    visit '/users/sign_in'
    fill_in 'user_email', with: users[0].email
    fill_in 'user_password', with: users[0].password
    click_button 'Log in'

    users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'checks if every user is has a profile picture' do
    visit '/users/sign_in'
    fill_in 'user_email', with: users[0].email
    fill_in 'user_password', with: users[0].password
    click_button 'Log in'

    expect(page.all(:css, 'img.squared-pic').length).to be users.length
  end

  it 'checks if we see the correct number of posts' do
    visit '/users/sign_in'
    fill_in 'user_email', with: users[0].email
    fill_in 'user_password', with: users[0].password
    click_button 'Log in'

    users.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  it 'checks if we go to the users page after clicking on their image' do
    visit '/users/sign_in'
    fill_in 'user_email', with: users[2].email
    fill_in 'user_password', with: users[2].password
    click_button 'Log in'

    page.all(:css, 'img.squared-pic')[0].click
    expect(page).to have_current_path("/users/#{users[0].id}")
  end
end
