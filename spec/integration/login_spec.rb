require 'swagger_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe 'Posts API' do
  path '/api/login' do
    post 'Logs in' do
      tags 'Log in'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :integer }
        },
        required: %w[email password]
      }

      response '200', 'returns tocken' do
        schema type: :object,
               properties: {
                 token: { type: :string }
               }

        let(:user) do
          user = User.create!(name: 'Bodia', email: 'blah@blah.balh', password: 'password', confirmed_at: Time.now,
                              posts_counter: 3, bio: 'My name is Bodian, I love cooking and riding rollerblades')
          { email: user.email, password: 'password' }
        end
        run_test!
      end

      response '401', 'unauthorized' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        let(:user) { { email: 'user', password: 'password' } }
        run_test!
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength