desc "Post today anime"
task :today_anime do
  require_relative "./lib/today_anime"
  TodayAnime.new.perform_all
end

desc "Post anime movie"
task :anime_movie do
  require_relative "./lib/anime_movie"
  AnimeMovie.new.perform
end
