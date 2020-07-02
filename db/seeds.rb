User.delete_all

admin = User.new(
  name: "eijiosos",
  self_introduction: "ganbari-"
)
admin.add_role(Role::ADMIN)
admin.save

5.times do
  User.create(
    name: Faker::Internet.unique.username,
    self_introduction: Faker::Quote.famous_last_words
  )
end
