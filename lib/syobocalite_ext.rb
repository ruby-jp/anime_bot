class Syobocalite::Program
  # Slackに投稿するための文言に整形する
  # @return [String]
  def format
    start_time = st_time.strftime("%H:%M")

    elements = []
    elements << "#{start_time}〜【#{ch_name}】#{title}"

    if story_number >= 1 || !sub_title.blank?
      str = ""
      str << "第#{story_number}話" if story_number >= 1
      str << "「#{sub_title}」" unless sub_title.blank?
      elements << str
    end

    elements << display_flag unless display_flag.blank?

    unless prog_comment.blank?
      elements << "※#{prog_comment}"
    end

    elements.join(" ")
  end

  # flagを表示用に整形する
  def display_flag
    str = ""
    str << "【新】" if new?
    str << "【終】" if final?
    str << "【再】" if re_air?
    str
  end

  # 注
  def remark?
    flag & 0x01 != 0
  end

  # 新
  def new?
    flag & 0x02 != 0
  end

  # 終
  def final?
    flag & 0x04 != 0
  end

  # 再
  def re_air?
    flag & 0x08 != 0
  end

  private

  # @see https://sites.google.com/site/syobocal/spec/proginfo-flag
  def flag
    return @flag if @flag

    client = SyoboiCalendar::Client.new
    response = client.list_programs(title_id: tid, program_id: pid)

    @flag = response.resources.first.flag
  end
end
