require 'faker'

[Post].each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table.table_name} RESTART IDENTITY CASCADE")
end

100.times do
  post = Post.create(
    title: Faker::FunnyName.name,
    content: Faker::Quote.famous_last_words,
    label: ["idea", "fun", "work", "life"].sample,
  )
  post.update_attribute(:created_at, Faker::Date.between(from: 365.days.ago, to: Date.today))
  p "Created post - title: #{post.title} | content: #{post.content.truncate(20)} | label: #{post.label} | created_at: #{post.created_at}"
end
p "Created #{Post.count} posts"
