require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  describe "GET /api/v1/posts" do
    it "returns all posts" do
      create_list(:post, 3)
      get "/api/v1/posts"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /api/v1/posts?label=idea" do
    it "returns all posts with the specified label" do
      create_list(:post, 3, label: "idea")
      get "/api/v1/posts?label=idea"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /api/v1/posts/:id" do
    it "returns a single post" do
      post = create(:post)
      get "/api/v1/posts/#{post.id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["title"]).to eq(post.title)
    end
  end

  describe "GET /api/v1/posts?date=2021-01-01" do
    it "returns a post created on the specified date" do
      post = create(:post)
      today_date = Date.today.strftime("%Y-%m-%d")
      get "/api/v1/posts?date=#{today_date}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first["title"]).to eq(post.title)
    end
  end

  describe "POST /api/v1/posts" do
    it "creates a new post" do
      post_params = { post: { title: "New Post", content: "Lorem ipsum", label: "fun" } }
      post "/api/v1/posts", params: post_params
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["title"]).to eq("New Post")
    end
  end

  describe "PATCH /api/v1/posts/:id" do
    it "updates an existing post" do
      post = create(:post)
      patch "/api/v1/posts/#{post.id}", params: { post: { title: "Updated Post" } }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["title"]).to eq("Updated Post")
    end
  end

  describe "DELETE /api/v1/posts/:id" do
    it "deletes a post" do
      post = create(:post)
      delete "/api/v1/posts/#{post.id}"
      expect(response).to have_http_status(:no_content)
      expect { post.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
