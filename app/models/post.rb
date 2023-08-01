class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :label, inclusion: { in: %w(idea fun work life) }
end
