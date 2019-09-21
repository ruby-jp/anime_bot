require_relative "./slack_bot"
require "open-uri"

class AnimeMovie < SlackBot
  # 何日先までの映画を取得するかどうか
  MOVIE_DAYS = 13

  def perform
    movies = fetch_movie_list

    start_date = Date.current
    end_date   = Date.current + MOVIE_DAYS

    latest_movies = movies.select do |movie|
      (start_date..end_date).cover?(movie[:date])
    end

    message = <<~MSG
    #{start_date.strftime("%Y/%m/%d(%a)")} 〜 #{end_date.strftime("%Y/%m/%d(%a)")} に上映開始するアニメ映画の一覧

    MSG

    latest_movies.each do |movie|
      message << "- #{movie[:date].strftime("%Y/%m/%d(%a)")} "

      if movie[:url]
        message << "<#{movie[:url]}|#{movie[:title]}>"
      else
        message << movie[:title]
      end

      message << "\n"
    end

    post_slack(username: "もうすぐ始まるアニメ映画お知らせ君", message: message, icon_emoji: ":movie_camera:")
  end

  # http://www.kansou.me/animeka/movie.html をスクレイピングした結果を返す
  #
  # @return [Array<Hash>] :date, :title, :url をKeyにもつHashのArray
  def fetch_movie_list
    doc = URI.open("http://www.kansou.me/animeka/movie.html") { |f| Hpricot(f) }

    movies =
      doc.search("//table[@class='list']/tr").each_with_object([]) do |tr, movies|
        next unless tr.at("//td")

        date = tr.at("//td[1]").inner_text.strip

        unless date.match?(%r(^\d+/\d+/\d+))
          # 正確な日付が入っていない場合はスキップする
          next
        end

        movie = {
          date: Date.parse(date),
          title: tr.at("//td[2]").inner_text.strip,
        }

        if (a = tr.at("//td[2]/a"))
          movie[:url] = a["href"]
        end

        movies << movie
      end

    movies.sort_by { |movie| [movie[:date], movie[:title]] }
  end
end
