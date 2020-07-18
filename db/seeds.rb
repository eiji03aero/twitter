User.delete_all

admin = User.new(
  name: "eijiosos",
  self_introduction: "ganbari-",
  password: 'hoge',
)
admin.add_role(Role::ADMIN)
admin.save

5.times do
  admin.micro_posts.create(
    content: Faker::Quote.famous_last_words
  )
end

5.times do
  u = User.create(
    name: Faker::Internet.unique.username,
    self_introduction: Faker::Quote.famous_last_words,
    password: 'hoge',
  )

  admin.follow(u)
  u.follow(admin)

  3.times do
    u.micro_posts.create(
      content: Faker::Quote.famous_last_words
    )
  end
end
