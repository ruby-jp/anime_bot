require_relative "./slack_bot"
require_relative "./syobocalite_ext"

class TodayAnime < SlackBot
  END_HOUR = 4
  END_MINUTE = 0

  def initialize
    super
    Time.zone = "Tokyo"
  end

  def perform_all
    config = YAML.load_file("#{__dir__}/../config/today_anime.yml")

    config["areas"].each do |hash|
      perform(title: hash["title"], channel_ids: hash["channel_ids"])
    end
  end

  # @param title       [String]
  # @param channel_ids [Array<Integer>]
  def perform(title:, channel_ids:)
    # 実行時の時間（分以下は切り捨て）〜翌4:00までのアニメを取得する
    # 例) 19:19に実行されたら19:00〜翌4:00で取得する
    start_at = Time.current.change(min: 0)
    end_at = (start_at + 1.day).change(hour: END_HOUR, minute: END_MINUTE)

    puts "now: #{Time.current}"
    puts "start_at: #{start_at}"
    puts "end_at: #{end_at}"

    programs = Syobocalite.search(start_at: start_at, end_at: end_at)

    programs.select! { |program| channel_ids.include?(program.ch_id) } unless channel_ids.empty?

    programs.sort_by! { |program| [program.st_time, program.ch_name, program.title] }

    message = programs.each_with_object("") do |program, str|
      str << "- #{program.format}\n"
    end

    message = "今日のアニメは無いようです" if message.blank?

    post_slack(username: "今日のアニメ（#{title}）", message: message, icon_emoji: ":tv:")
  end
end
