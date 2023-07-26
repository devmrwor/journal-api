require 'faker'

[Post].each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table.table_name} RESTART IDENTITY CASCADE")
end

100.times do
  post = Post.create(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 2),
    label: Faker::Lorem.word,
  )
  post.update_attribute(:created_at, Faker::Date.between(from: 365.days.ago, to: Date.today))
  p "Created post - title: #{post.title} | content: #{post.content.truncate(20)} | label: #{post.label} | created_at: #{post.created_at}"
end
p "Created #{Post.count} posts"
