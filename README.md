# アニメ情報をポストするSlackボット
[![CircleCI](https://circleci.com/gh/ruby-jp/anime_bot/tree/master.svg?style=svg)](https://circleci.com/gh/ruby-jp/anime_bot/tree/master)

## Setup
```bash
bundle install
```

## Usage
```bash
export SLACK_WEBHOOK_URL=xxxxx

# optional
# export SLACK_CHANNEL=xxxxx

bundle exec rake today_anime
bundle exec rake anime_movie
```

## 仕組み
* ブランチがpushされたら `#slack_sandbox` に投稿されます
* スケジューラーからの実行はIncoming Webhookに設定されてるチャンネル ( `#anime` ) に投稿されます

## オリジナル
https://github.com/sue445/today_anime
