# Users
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
             email: email,
             password:              password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now)
end

# マイクロポスト
users = User.order(:created_at).take(6)
50.times do
content = Faker::Lorem.sentence(word_count: 5)
users.each { |user| user.microposts.create!(content: content) }
end

# ユーザーフォローのリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# 映画登録
movies = [
  { title: "呪怨（ビデオ版）", genre: "心霊", director: "清水崇", cast: "柳ユーレイ 栗山千明" },
  { title: "呪怨2（ビデオ版）", genre: "心霊", director: "清水崇", cast: "大家由祐子 芦川誠" },
  { title: "呪怨（劇場版）", genre: "心霊", director: "清水崇", cast: "	奥菜恵 伊東美咲" },
  { title: "呪怨2（劇場版）", genre: "心霊", director: "清水崇", cast: "酒井法子 新山千春" },
  { title: "ハッピー・デス・デイ", genre: "ホラーコメディ", director: "クリストファー・B・ランドン", cast: "ジェシカ・ローテ イズラエル・ブルサード" },
  { title: "ハッピー・デス・デイ 2U", genre: "ホラーコメディ", director: "	クリストファー・B・ランドン", cast: "ジェシカ・ローテ イズラエル・ブルサード" },
  { title: "パラノーマル・アクティビティ", genre: "POV", director: "オーレン・ペリ", cast: "ケイティー・フェザーストン ミカ・スロート" },
  { title: "パラノーマル・アクティビティ2", genre: "POV", director: "トッド・ウィリアムズ", cast: "ケイティー・フェザーストン スプレイグ・グレイデン" },
  { title: "パラノーマル・アクティビティ3", genre: "POV", director: "ヘンリー・ジュースト アリエル・シュルマン", cast: "クリストファー・ニコラス・スミス ローレン・ビットナー" },
  { title: "パラノーマル・アクティビティ4", genre: "POV", director: "ヘンリー・ジュースト アリエル・シュルマン", cast: "ケイティー・フェザーストン キャスリン・ニュートン" },
  { title: "パラノーマル・アクティビティ/呪いの印", genre: "POV", director: "クリストファー・B・ランドン", cast: "アンドリュー・ジェイコブス ジョルジ・ディアス" },
  { title: "パラノーマル・アクティビティ5", genre: "POV", director: "グレゴリー・プロトキン", cast: "クリス・J・マーレイ ブリット・ショウ" },
  { title: "エクソシスト ディレクターズカット版", genre: "悪魔", director: "ウィリアム・フリードキン", cast: "リンダ・ブレア エレン・バースティン" },
  { title: "エクソシスト2", genre: "悪魔", director: "ジョン・ブアマン", cast: "リンダ・ブレア リチャード・バートン" },
  { title: "エクソシスト3", genre: "悪魔", director: "ウィリアム・ピーター・ブラッティ", cast: "ジョージ・C・スコット エド・フランダース" },
  { title: "エクソシスト ビギニング", genre: "悪魔", director: "レニー・ハーリン", cast: "ステラン・スカルスガルド ジェームズ・ダーシー" },
  { title: "サイコ", genre: "人怖", director: "アルフレッド・ヒッチコック", cast: "アンソニー・パーキンス ジャネット・リー" },
  { title: "サイコ2", genre: "人怖", director: "	リチャード・フランクリン", cast: "アンソニー・パーキンス ヴェラ・マイルズ" },
  { title: "サイコ3/怨霊の囁き", genre: "人怖", director: "アンソニー・パーキンス", cast: "アンソニー・パーキンス ダイアナ・スカーウィッド" },
  { title: "ミスト", genre: "SFホラー", director: "	フランク・ダラボン", cast: "トーマス・ジェーン ローリー・ホールデン" }
  # { title: "", genre: "", director: "", cast: "" },
  # { title: "", genre: "", director: "", cast: "" },
  # { title: "", genre: "", director: "", cast: "" },
  # { title: "", genre: "", director: "", cast: "" },
  # { title: "", genre: "", director: "", cast: "" },
]
# データベースに映画情報を登録
movies.each do |movie_info|
  Movie.create!(movie_info)
end