require 'rails_helper'

RSpec.describe "Users API", type: :request do
  describe "POST api/users (#create)" do
    context "when the request is valid" do
      before do
        post "/api/users",
          params: {
            data: {
              attributes: {
                name: "Tyshawn Johns Sr.",
                email: "tyshawn@mann.net",
                password: "12345678",
                birthdate: "1987-02-12"
              }
            }
          }
      end

      it "create a user" do
        expect(json["name"]).to eq("Tyshawn Johns Sr.")
        expect(json["email"]).to eq("tyshawn@mann.net")
        expect(json["birthdate"]).to eq("1987-02-12")
      end
    end
  end
end
