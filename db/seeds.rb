# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: "admin",
  email: "admin@gmail.com",
  password: "03051994",
  is_admin: true)

User.create!(name: "user",
  email: "user@gmail.com",
  password: "03051994",
  password_confirmation: "03051994",
  is_admin: false)

5.times do |n|
  Subject.create!(name: "Subject#{n}")
  4.times do |question|
    question_create = Question.create!(content: "Question#{question}", state: :accept, question_type: :single_choice,
      subject_id: n+1, user_id: 1)
    ans = rand(4)
    4.times do |answer|
      Answer.create!(content: "Answer#{answer}.#{question}", question_id: question_create.id, is_correct: (answer==ans))
    end
  end
end
