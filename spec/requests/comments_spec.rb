require 'rails_helper'

RSpec.describe "Comments API", type: :request do
  let!(:post) { create(:post) }
  let!(:comments) { create(:comment, post: post) }

  describe "GET /api/posts/:posts_id/comments (#index)" do
    context "when post exists" do
      before { get "/api/posts/#{post.id}/comments" }

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
    context "when post comment exists" do
      before { get "/api/posts/#{post.id}/comments/#{comment.id}" }

      it "returns status code 200" do
        ap json
        expect(response).to have_http_status(200)
      end

      it "returns the comment" do
        expect(json['data']['id']).to eq(id)
      end
    end
  end
end
