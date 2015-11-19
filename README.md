# LikeSystem

[![Build Status](https://travis-ci.org/pmviva/like_system.png?branch=master)](https://travis-ci.org/pmviva/like_system)
[![Gem Version](https://badge.fury.io/rb/like_system.svg)](http://badge.fury.io/rb/like_system)

An active record like system developed using ruby on rails 4.1 applying domain driven design and test driven development principles.

This gem is heavily influenced by cmer/socialization.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'like_system'
```

And then execute:

```ruby
$ bundle
```

Or install it yourself as:

```ruby
$ gem install like_system
```

## Usage

### Run the generator

```ruby
$ rails g like_system
```

Let's suppose for a moment that you have a blog application and a User can like a Post or several Post models.
The user model becomes the liker and the post model becomes the likee.

### Post object
```ruby
class Post < ActiveRecord::Base
  act_as_likee

  validates :content, presence: true
end
```

### User object
```ruby
class User < ActiveRecord::Base
  act_as_liker

  validates :username, { presence: true, uniqueness: true }
end
```

### Likee object methods
```ruby
post.is_likee? # returns true

post.liked_by?(user) # returns true if user likes the post object, false otherwise

post.likers_by(User) # returns a scope of LikeSystem::Like join model that belongs to the post object and belongs to liker objects of type User
```


### Liker object methods
```ruby
user.is_liker? # returns true

user.like(post) # Creates an instance of LikeSystem::Like join model associating the user object and the post object, returns true if succeded, false otherwise

user.unlike(post) # Destroys an instance of LikeSystem::Like join model that associates the user object and the post object, returns true if succeded, false otherwise

user.toggle_like(post) # Likes / unlikes the post

user.likes?(post) # returns true if the user object likes the post object, false otherwise

user.likees_by(Post) # returns a scope of LikeSystem::Like join model that belongs to the user object and belongs to likee objects of type Post
```

For more information read the [api documentation](http://rubydoc.info/gems/like_system).

## Contributing

1. Fork it ( https://github.com/pmviva/like_system/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

