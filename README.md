# twitter
- gonna clone it

# initialize

```sh
$ rails new twitter -T --api --skip-bundle --database postgresql

# add gems
# group :development, :test do
#   gem 'rspec-rails'
# end
# 
# group :development do
#   gem 'guard'
#   gem 'guard-rspec', require: false
# end

# configure config/database.yml

$ bundle install

$ bin/rails db:create

$ rails g rspec:install

$ bundle exec guard init rspec
```

# Apis
```
- crud user
  - policy
- crud micro_post
  - policy
- user follows user
- get post feeds for certain user
- search post
- retweet post
- direct message

```

# Models
```

- User
  - has_many micro_post
  - attributes
    - id: integer
    - name: string

- MicroPost
  - belongs_to user
  - attributes
    - id: integer
    - user_id: integer
    - content: text

- FollowRelationship
  - belongs_to follower, class_name: "User"
  - belongs_to followed, class_name: "User"
  - attributes
    - follower_id: integer (index)
    - followed_id: integer (index, composite unique index with follower_id)
```
