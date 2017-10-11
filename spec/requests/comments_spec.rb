require 'rails_helper'

RSpec.describe "Comments API", type: :request do
  let!(:article) { create(:post) }

  describe "GET /api/posts/:posts_id/comments (#index)" do
    let!(:comments) { create(:comment, post: article) }

    context "when post exists" do
      before { get "/api/posts/#{article.id}/comments" }

      it 'return the comment' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end

      it "returns status code 200" do
        expect(json).not_to have_http_status(200)
      end
    end

  end

  describe "GET /api/posts/:posts_id/comments/:id (#show)" do
    let!(:comments) { create(:comment, post: article) }

    before { get "/api/posts/#{article.id}/comments/#{comments.id}" }

    context "when post comment exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns the comment" do
        expect(json['data']['id']).to eq((comments.id).to_s)
      end
    end
  end

  describe "POST /api/posts/:post_id/comments/ (#create)" do
    context "when the request is valid" do
      before do
        post "/api/posts/#{article.id}/comments/",
          params: {
            data: {
              type: "comments",
              attributes: {
                body: "Comentário do post"
              },
              relationships: {
                post: {
                  data: {
                    id: article.id,
                    type: "post"
                  }
                }
              }
            }
          }
      end

      it "create a post" do
        expect(article.comments[0]['body']).to eq("Comentário do post")
      end

      it "return status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe "POST /api/posts/:post_id/comments/ (#update)" do
    let!(:comments) { create(:comment, post: article) }

    context "when the record exists" do
      before do
        put "/api/posts/#{article.id}/comments/#{comments.id}",
          params: {
            data: {
              type: "comments",
              attributes: {
                body: "Esse post é muito legal"
              },
              relationships: {
                post: {
                  data: {
                    id: article.id,
                    type: "post"
                  }
                }
              }
            }
          }
      end

      it "updates the records" do
        expect(response.body).not_to be_empty
      end

      it "returns status code 200" do
        comments.reload
        expect(response).to have_http_status(200)
      end

      it "update a post" do
        expect(json['data']['attributes']['body']).to eq("Esse post é muito legal")
      end
    end
  end

  describe "POST /api/posts/:post_id/comments/ (#destroy)" do
    let!(:comments) { create(:comment, post: article) }

    context "when the request is destroyed" do
      before { delete "/api/posts/#{article.id}/comments/#{comments.id}" }

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end
end
