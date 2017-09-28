# Ruby Weekly 日本語サマリー

This repository contains Japanese summaries of [Ruby Weekly](http://rubyweekly.com/) published on [my Japanese blog](http://rastam.hatenablog.com/). It also includes Rake tasks that help me prepare and publish the summaries for each issue.

## Installation

1. Clone this repository.

   ```
   $ git clone git@github.com:rastamhadi/ruby_weekly_ja.git
   ```

2. Install gems in the Gemfile.

   ```
   $ bundle install
   ```

## Usage

### Generating a blog post

```
$ rake 362.md
```

This will generate a skeletal blogpost with preformatted links to articles in issue #362 of Ruby Weekly.
