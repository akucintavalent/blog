require 'swagger_helper'
require_relative '../../app/controllers/concerns/json_web_token'

# rubocop:disable Layout/LineLength
# rubocop:disable Metrics/BlockLength

RSpec.describe 'Posts API' do
  include JsonWebToken

  path '/api/comments' do
    post 'Creates a comment' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          post_id: { type: :integer },
          text: { type: :string }
        },
        required: %w[post_id text]
      }

      response '201', 'user created' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 text: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string },
                 post_id: { type: :integer },
                 author_id: { type: :integer }
               }

        let(:user1) do
          User.create!(name: 'Bodia', email: 'blah@blah.balh', password: 'password', confirmed_at: Time.now, posts_counter: 3,
                       bio: 'My name is Bodian, I love cooking and riding rollerblades')
        end
        let(:post1) do
          Post.create!(author: user1, title: 'To jest tytył', text: 'A to jest juz tekst', likes_counter: 0,
                       comments_counter: 0)
        end
        let(:Authorization) { "Bearer #{jwt_encode(user_id: user1.id)}" }
        let(:comment) { { post_id: post1.id, text: 'this is the text of the comment' } }
        run_test!
      end

      response '422', 'invalid request' do
        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 message: {
                   type: :array,
                   items: { type: :string }
                 }
               }

        let(:user1) do
          User.create!(name: 'Bodia', email: 'blah@blah.balh', password: 'password', confirmed_at: Time.now, posts_counter: 3,
                       bio: 'My name is Bodian, I love cooking and riding rollerblades')
        end
        let(:post1) do
          Post.create!(author: user1, title: 'To jest tytył', text: 'A to jest juz tekst', likes_counter: 0,
                       comments_counter: 0)
        end
        let(:Authorization) { "Basic #{jwt_encode(user_id: user1.id)}" }
        let(:comment) { { post_id: 77_777_777 } }
        run_test!
      end
    end

    get 'Gets comments' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_post, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          post_id: { type: :integer }
        },
        required: %w[user_id post_id]
      }

      response '200', 'comments downloaded' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   text: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   post_id: { type: :integer },
                   author_id: { type: :integer }
                 }
               }

        let(:user1) do
          User.create!(name: 'Bodia', email: 'blah@blah.balh', password: 'password', confirmed_at: Time.now, posts_counter: 3,
                       bio: 'My name is Bodian, I love cooking and riding rollerblades')
        end
        let(:post1) do
          post1 = Post.create!(author: user1, title: 'To jest tytył', text: 'A to jest juz tekst', likes_counter: 0,
                               comments_counter: 0)
          Comment.create!(author: user1, post: post1, text: 'A to jest komentarz')
          post1
        end
        let(:user_post) { { post_id: post1.id, user_id: user1.id } }
        run_test!
      end

      response '404', 'invalid request' do
        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 message: {
                   type: :array,
                   items: { type: :string }
                 }
               }

        let(:user1) do
          User.create!(name: 'Bodia', email: 'blah@blah.balh', password: 'password', confirmed_at: Time.now, posts_counter: 3,
                       bio: 'My name is Bodian, I love cooking and riding rollerblades')
        end
        let(:post1) do
          Post.create!(author: user1, title: 'To jest tytył', text: 'A to jest juz tekst', likes_counter: 0,
                       comments_counter: 0)
        end
        let(:comment1) { Comment.create!(author: user1, post: post1, text: 'A to jest komentarz') }
        let(:user_post) { { post_id: 88_888, user_id: 777_777 } }
        run_test!
      end
    end
  end
end

# rubocop:enable Layout/LineLength
# rubocop:enable Metrics/BlockLength
