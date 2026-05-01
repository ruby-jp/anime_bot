# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "activesupport", require: "active_support/all"

# FIXME: Workaround until https://github.com/sferik/multi_xml/commit/27fd3bb59f79a0f746256afa041d03b890fa14a6 is released
# gem "libxml-ruby"
gem "libxml-ruby", "< 6.0.0"

gem "mechanize"
gem "rake", require: false
gem "slack-notifier", ">= 2.4.0"
gem "syobocalite", ">= 1.2.0"
gem "uri", ">= 1.0.3"
