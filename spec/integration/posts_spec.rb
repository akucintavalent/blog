require 'swagger_helper'

# rubocop:disable Metrics/BlockLength
# rubocop:disable Layout/LineLength

RSpec.describe 'Posts API' do
  include JsonWebToken

  path '/api/posts' do
    get 'Gets posts' do
      tags 'Posts'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer }
        },
        required: ['user_id']
      }

      response '200', 'posts downloaded' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   comments_counter: { type: :integer },
                   likes_counter: { type: :integer },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   author_id: { type: :integer }
                 }
               }

        let(:user) do
          user = User.create!(id: 3, name: 'Bodia', email: 'blah@blah.balh', password: 'password',
                              confirmed_at: Time.now, posts_counter: 3, bio: 'My name is Bodian, I love cooking and riding rollerblades')
          Post.create!(author: user, title: 'To jest tytył', text: 'A to jest juz tekst', likes_counter: 0,
                       comments_counter: 0)
          { user_id: user.id }
        end
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

        let(:user) { { user_id: 'foo' } }
        run_test!
      end
    end
  end
end

# rubocop:enable Layout/LineLength
# rubocop:enable Metrics/BlockLength
