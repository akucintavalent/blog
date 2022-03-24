require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Posts', type: :request do
  context 'testing responce' do
    it 'GET /users/:user_id/posts' do
      get('/users/3/posts')
      expect(response).to render_template('index')
    end

    it 'GET /users/:user_id/posts/:id' do
      get('/users/3/posts/3')
      expect(response).to render_template('show')
    end

    it 'GET /users/:user_id/posts status 200' do
      get('/users/3/posts')
      expect(response).to have_http_status(:ok)
    end

    it 'GET /users/:user_id/posts/:id status 200' do
      get('/users/3/posts/3')
      expect(response).to have_http_status(:ok)
    end
  end
end

RSpec.describe 'Posts', type: :feature do
  context 'testing with capybara' do
    it 'visit /users/:user_id/posts' do
      visit '/users/3/posts'
      expect(page).to have_text('Here is a list of posts for a given user')
    end

    it 'visit /users/:user_id/posts/:id' do
      visit '/users/3/posts/3'
      expect(page).to have_text('Here is a given post for a given user')
    end
  end
end
