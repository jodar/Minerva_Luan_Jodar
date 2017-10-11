require 'rails_helper'

RSpec.describe "Posts API", type: :request do
  describe "GET /api/posts (#index)" do
    let!(:post) { create(:post) }

    before { get '/api/posts' }

    it "return posts" do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end
  end

  describe "GET api/posts (#show)" do
    let!(:post) { create(:post) }

    context "when the request is valid" do
      before { get "/api/posts/#{post.id}" }

      it "returns the post" do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq((post.id).to_s)
      end
    end
  end

  describe "POST api/posts (#create)" do
    context "when the request is valid" do
      before do
        post '/api/posts',
          params: {
            data: {
              attributes: {
                title: "Titulo do post",
                body: "Corpo do post"
              }
            }
          }
      end

      it "create a post" do
        expect(json['data']['attributes']['title']).to eq("Titulo do post")
        expect(json['data']['attributes']['body']).to eq("Corpo do post")
      end

      it "return status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before do
        post '/api/posts',
          params: {
            data: {
              attributes: {
                title: "Titulo post"
              }
            }
          }
      end

      it "resturns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT /api/posts/:id (#update)" do
    let!(:post) { create(:post) }

    context "when the record exists" do
      before do
        put "/api/posts/#{post.id}",
          params: {
            data: {
              attributes: {
                title: "The Old brother"
              }
            }
          }
      end

      it "updates the records" do
        expect(response.body).not_to be_empty
      end

      it "returns status code 200" do
        post.reload
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE /api/posts/:id (#destroy)" do
    let!(:post) { create(:post) }

    context "when the request is destroyed" do
      before { delete "/api/posts/#{post.id}" }

      it "returns post empty" do
        expect(Post.where(id: post.id).all).to eq []
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end
end
