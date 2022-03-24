require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "Users", type: :request do
  context "testing responce" do
    it "GET /users" do
      get('/users')
      expect(response).to render_template('index') 
    end

    it "GET /users/:user_id" do
      get('/users/3')
      expect(response).to render_template('show') 
    end

    it "GET /users status 200" do
      get('/users')
      expect(response).to have_http_status(:ok) 
    end

    it "GET /users/:user_id/posts/:id status 200" do
      get('/users/3')
      expect(response).to have_http_status(:ok) 
    end
  end
end

RSpec.describe "Users", type: :feature do
  context "testing with capybara" do
    it "visit /users" do
      visit '/users'
      expect(page).to have_text('Here is a list users')
    end

    it "visit /users/:user_id" do
      visit '/users/3'
      expect(page).to have_text('Here is a given user\'s page')
    end
  end
end
