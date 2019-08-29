# これから放映されるアニメをポストするSlackボット
## Setup
```bash
bundle install
```

## Usage
```bash
export SLACK_WEBHOOK_URL=xxxxx

# optional
# export SLACK_CHANNEL=xxxxx

bundle exec ruby today_anime.rb
```

## 仕組み
* ブランチがpushされたら `#slack_sandbox` に投稿されます
  * [.github/workflows/bot.yml](.github/workflows/bot.yml) で設定
* スケジューラーからの実行はIncoming Webhookに設定されてるチャンネルに投稿されます

## オリジナル
https://github.com/sue445/today_anime
