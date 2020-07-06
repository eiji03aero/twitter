# twitter
- gonna clone it

# initialize

```sh
$ rails new twitter -T --api --skip-bundle --database postgresql

# add gems
# gem 'active_model_serializers', '~> 0.10.0'
# gem 'rolify'
# gem 'pundit'
#
# group :development, :test do
#   gem 'rspec-rails'
#   gem 'faker'
#   gem 'factory_bot_rails'
# end
#
# group :development do
#   gem 'guard'
#   gem 'guard-rspec', require: false
#   gem 'annotate'
# end

# configure config/database.yml

$ bundle install
$ bin/rails db:create
$ rails g rspec:install
$ bundle exec guard init rspec
$ bundle exec rails g annotate:install
$ bundle exec rails g rolify Role User
$ bundle exec rails g pundit:install
```

# Todos
```
- user follows user
- get post feeds for certain user
- search post
- retweet post
- direct message
```

# Apis
```
- crud user
  - add model
  - controller
    - serializer
    - policy
- crud micro_post
  - add model
  - controller
    - serializer
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
  - has_many micro_posts
  - attributes
    - id: integer
    - name: string
    - self_introduction: text

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
