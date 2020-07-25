User.delete_all
MicroPost.delete_all

def hash_tags
  [
    "sao",
    "vim",
    "anytime_fitness",
    "macbookpro",
    "hatsune_miku",
  ]
end

def create_content
  content = Faker::Quote.famous_last_words

  if rand < 0.7
    content += " #" + hash_tags.sample
  end

  content
end

admin = User.new(
  name: "eijiosos",
  self_introduction: "ganbari-",
  password: 'hoge',
)
admin.add_role(Role::ADMIN)
admin.save

5.times do
  admin.micro_posts.create(
    content: create_content
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

  20.times do
    u.micro_posts.create(
      content: create_content
    )
  end
end

MicroPost.__elasticsearch__.create_index!
MicroPost.__elasticsearch__.import
