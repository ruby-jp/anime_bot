# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "activesupport", require: "active_support/all"
gem "hpricot"
gem "libxml-ruby"
gem "rake", require: false
gem "slack-notifier", github: "fusic/slack-notifier", branch: "resolve_warning_ruby27" # c.f. https://github.com/stevenosloan/slack-notifier/pull/119
gem "syobocalite", ">= 1.0.0"
gem "syoboi_calendar"

group :development do
  gem "pry-byebug"
end
