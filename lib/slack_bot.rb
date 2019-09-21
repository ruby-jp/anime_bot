ENV["ENVIRONMENT"] ||= "development"

Bundler.require(*[:default, ENV["ENVIRONMENT"]].compact)

class SlackBot
  def initialize
    raise "SLACK_WEBHOOK_URL is required" unless ENV["SLACK_WEBHOOK_URL"]

    @slack_webhook_url = ENV["SLACK_WEBHOOK_URL"]
  end

  # @param channel [String]
  # @param username [String]
  # @param message [String]
  # @param icon_emoji [String]
  # @param icon_url [String]
  def post_slack(channel: ENV["SLACK_CHANNEL"], username: nil, message:, icon_emoji: nil, icon_url: nil)
    notifier = Slack::Notifier.new(@slack_webhook_url)

    # c.f. https://api.slack.com/methods/chat.postMessage
    options = {
      username: username,
      unfurl_links: false,
      icon_emoji: icon_emoji,
      icon_url: icon_url,
      channel: channel
    }.compact

    puts <<~MSG
      -----------
      [username] #{username}
  
      [message]
      #{message}
      -----------
    MSG

    notifier.ping(message, options)
  end
end
