require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      post = build(:post)
      expect(post).to be_valid
    end

    it "is not valid without a title" do
      post = build(:post, title: nil)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it "is not valid without content" do
      post = build(:post, content: nil)
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include("can't be blank")
    end

    it "is not valid with an invalid label" do
      post = build(:post, label: "invalid_label")
      expect(post).not_to be_valid
      expect(post.errors[:label]).to include("is not included in the list")
    end

    it "is valid with a valid label (idea)" do
      post = build(:post, label: "idea")
      expect(post).to be_valid
    end
  end
end
