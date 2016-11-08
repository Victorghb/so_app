namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    users = User.limit(6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.questions.create!(content: content) }
    end
  end
end