# capistrano-restart-check

Check if your application has restarted completely.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano', '~> 3.1.0'
gem 'capistrano-restart-check'
```

And then execute:

``` bash
$ bundle
```

Or install it yourself as:

``` bash
$ gem install capistrano-restart-check
```

## Usage

Require in `Capfile` to use the default task:

``` ruby
require 'capistrano/restart-check'
```

