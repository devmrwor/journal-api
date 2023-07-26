require 'faker'

[Post].each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table.table_name} RESTART IDENTITY CASCADE")
end

100.times do
  Post.create(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 2)
  )
end
