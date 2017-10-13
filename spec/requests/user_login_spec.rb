require 'rails_helper'

RSpec.describe "User sign in", type: :request do
  let(:user)  { create(:user) }
  let(:email) { user.email }
  let(:password) { "12345678" }
  let(:payload) do
    {
      email: email,
      password: password
    }
  end

  context "when credentials are correct" do
    it "signs the user in" do
      post "/auth/sign_in", params: payload

      expect(json).to eq({
        "data" => {
          "id"        => user.id,
          "email"     => user.email,
          "provider"  => user.provider,
          "uid"       => user.uid,
          "name"      => user.name,
          "birthdate" => "1987-02-12",
          "type"      => "user"
        }
      })

      access_token = response.headers["client"]
      created_token = User.first.tokens.keys.last

      expect(access_token).to eq(created_token)
    end
  end
end
