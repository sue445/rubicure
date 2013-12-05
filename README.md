# Rubicure (Ruby + Precure)

All about Japanese battle heroine "Pretty Cure (Precure)".

Inspired by [Acme::PrettyCure](http://perl-users.jp/articles/advent-calendar/2010/acme/6) and [pycure](https://github.com/drillbits/pycure).

## Requirements

* ruby >= 2.0.0

## Installation

Add this line to your application's Gemfile:

    gem 'rubicure'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubicure

## Usage

```ruby
§ irb

require "rubicure"
```

`Pretty.cure` and `Pre.cure` are the same.

### Select own precure series
```ruby
Pre.cure.unmarked.title
#=> "ふたりはプリキュア"

Pre.cure.title
#=> "ふたりはプリキュア"

Pre.cure.max_heart.title
#=> "ふたりはプリキュア Max Heart"

Pre.cure.splash_star.title
#=> "ふたりはプリキュア Splash Star"

Pre.cure.yes.title
#=> "Yes！ プリキュア5"

Pre.cure.yes_gogo.title
#=> "Yes！ プリキュア5 Go Go！"

Pre.cure.flesh.title
#=> "フレッシュプリキュア！"

Pre.cure.heart_catch.title
#=> "ハートキャッチプリキュア！"

Pre.cure.smile.title
#=> "スマイルプリキュア！"

Pre.cure.dokidoki.title
#=> "ドキドキ！プリキュア"
```

other pattern

```ruby
Pre.cure.fetch(:smile).title
#=> "スマイルプリキュア！"

Pre.cure[:smile].title
#=> "スマイルプリキュア！"
```

and [more aliases!](config/title_alias.yml)

### Get current precure series
`Pre.cure#now` (alias to `#current` ) return current precure series

```ruby
Pretty.cure.now
#=> {:title=>"ドキドキ！プリキュア", :started_date=>Sun, 03 Feb 2013, :ended_date=>Sun, 26 Jan 2014, :before_transform_message=>"プリキュアラブリンク！\nL! O! V! E!\n", :after_transform_message=>"響け愛の鼓動！ドキドキプリキュア！\n", :girls=>[{"human_name"=>"相田マナ", "precure_name"=>"キュアハート", "transform_message"=>"みなぎる愛！ キュアハート！\n愛を無くした悲しいジコチューさん、\nこのキュアハートがあなたのドキドキ取り戻してみせる！\n"}, {"human_name"=>"菱川六花", "precure_name"=>"キュアダイヤモンド", "transform_message"=>"英知の光！ キュアダイヤモンド！\n人の思いを踏みにじるなんて許せない、\nこのキュアダイヤモンドがあなたの頭を冷やしてあげる！"}, {"human_name"=>"四葉ありす", "precure_name"=>"キュアロゼッタ", "transform_message"=>"ひだまりポカポカ キュアロゼッタ！\n世界を制するのは愛だけです、\nさぁ、あなたも私と愛を育んでくださいな\n"}, {"human_name"=>"剣崎真琴", "precure_name"=>"キュアソード", "transform_message"=>"勇気の刃！ キュアソード！\nこのキュアソードが愛の剣で\nあなたの野望を断ち切ってみせる！\n"}, {"human_name"=>"円亜久里", "precure_name"=>"キュアエース", "transform_message"=>"愛の切り札！ キュアエース！\n美しさは正義の証し、ウインク一つで、\nあなたのハートを射抜いて差し上げますわ\n"}]}

Pre.cure.now
#=> {:title=>"ドキドキ！プリキュア", :started_date=>Sun, 03 Feb 2013, :ended_date=>Sun, 26 Jan 2014, :before_transform_message=>"プリキュアラブリンク！\nL! O! V! E!\n", :after_transform_message=>"響け愛の鼓動！ドキドキプリキュア！\n", :girls=>[{"human_name"=>"相田マナ", "precure_name"=>"キュアハート", "transform_message"=>"みなぎる愛！ キュアハート！\n愛を無くした悲しいジコチューさん、\nこのキュアハートがあなたのドキドキ取り戻してみせる！\n"}, {"human_name"=>"菱川六花", "precure_name"=>"キュアダイヤモンド", "transform_message"=>"英知の光！ キュアダイヤモンド！\n人の思いを踏みにじるなんて許せない、\nこのキュアダイヤモンドがあなたの頭を冷やしてあげる！"}, {"human_name"=>"四葉ありす", "precure_name"=>"キュアロゼッタ", "transform_message"=>"ひだまりポカポカ キュアロゼッタ！\n世界を制するのは愛だけです、\nさぁ、あなたも私と愛を育んでくださいな\n"}, {"human_name"=>"剣崎真琴", "precure_name"=>"キュアソード", "transform_message"=>"勇気の刃！ キュアソード！\nこのキュアソードが愛の剣で\nあなたの野望を断ち切ってみせる！\n"}, {"human_name"=>"円亜久里", "precure_name"=>"キュアエース", "transform_message"=>"愛の切り札！ キュアエース！\n美しさは正義の証し、ウインク一つで、\nあなたのハートを射抜いて差し上げますわ\n"}]}

Pre.cure.current
#=> {:title=>"ドキドキ！プリキュア", :started_date=>Sun, 03 Feb 2013, :ended_date=>Sun, 26 Jan 2014, :before_transform_message=>"プリキュアラブリンク！\nL! O! V! E!\n", :after_transform_message=>"響け愛の鼓動！ドキドキプリキュア！\n", :girls=>[{"human_name"=>"相田マナ", "precure_name"=>"キュアハート", "transform_message"=>"みなぎる愛！ キュアハート！\n愛を無くした悲しいジコチューさん、\nこのキュアハートがあなたのドキドキ取り戻してみせる！\n"}, {"human_name"=>"菱川六花", "precure_name"=>"キュアダイヤモンド", "transform_message"=>"英知の光！ キュアダイヤモンド！\n人の思いを踏みにじるなんて許せない、\nこのキュアダイヤモンドがあなたの頭を冷やしてあげる！"}, {"human_name"=>"四葉ありす", "precure_name"=>"キュアロゼッタ", "transform_message"=>"ひだまりポカポカ キュアロゼッタ！\n世界を制するのは愛だけです、\nさぁ、あなたも私と愛を育んでくださいな\n"}, {"human_name"=>"剣崎真琴", "precure_name"=>"キュアソード", "transform_message"=>"勇気の刃！ キュアソード！\nこのキュアソードが愛の剣で\nあなたの野望を断ち切ってみせる！\n"}, {"human_name"=>"円亜久里", "precure_name"=>"キュアエース", "transform_message"=>"愛の切り札！ キュアエース！\n美しさは正義の証し、ウインク一つで、\nあなたのハートを射抜いて差し上げますわ\n"}]}

# -2013/1/27  : smile precure
#  2013/2/5 - : dokidoki precure
require "delorean"
Delorean.time_travel_to "2013-02-01"
Pre.cure.now
#=> RuntimeError: Not on air precure!
```

### Rubicure::Series#on_air?

```ruby
Pre.cure.dokidoki.on_air?("2013-12-16")
#=> true

Pre.cure.smile.on_air?("2013-12-16")
#=> false
```

### Rubicure::Series#girls
```ruby
Pre.cure.smile.girls
#=> [#<Rubicure::Girl:0x007fe72b99abc8 @human_name="星空みゆき", @precure_name="キュアハッピー", @extra_names=["プリンセスハッピー", "ウルトラハッピー"], @current_state=0, @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！ハッピー！！)\nキラキラ輝く未来の光！ キュアハッピー！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @state_names=["星空みゆき", "キュアハッピー", "プリンセスハッピー", "ウルトラハッピー"]>, #<Rubicure::Girl:0x007fe72b99a9c0 @human_name="日野あかね", @precure_name="キュアサニー", @extra_names=["プリンセスサニー", "ウルトラサニー"], @current_state=0, @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！サニー！！)\n太陽サンサン熱血パワー！ キュアサニー！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @state_names=["日野あかね", "キュアサニー", "プリンセスサニー", "ウルトラサニー"]>, #<Rubicure::Girl:0x007fe72b99a650 @human_name="黄瀬やよい", @precure_name="キュアピース", @extra_names=["プリンセスピース", "ウルトラピース"], @current_state=0, @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！ピース！！)\nピカピカピカリンジャンケンポン！ キュアピース！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @state_names=["黄瀬やよい", "キュアピース", "プリンセスピース", "ウルトラピース"]>, #<Rubicure::Girl:0x007fe72b99a3f8 @human_name="緑川なお", @precure_name="キュアマーチ", @extra_names=["プリンセスマーチ", "ウルトラマーチ"], @current_state=0, @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！マーチ！！)\n勇気リンリン直球勝負！ キュアマーチ！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @state_names=["緑川なお", "キュアマーチ", "プリンセスマーチ", "ウルトラマーチ"]>, #<Rubicure::Girl:0x007fe72b99a1f0 @human_name="青木れいか", @precure_name="キュアビューティ", @extra_names=["プリンセスビューティ", "ウルトラビューティ"], @current_state=0, @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！ビューティ！！)\nしんしんと降り積もる清き心！ キュアビューティ！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @state_names=["青木れいか", "キュアビューティ", "プリンセスビューティ", "ウルトラビューティ"]>]

Pre.cure.smile.girls.map(&:human_name)
#=> ["星空みゆき", "日野あかね", "黄瀬やよい", "緑川なお", "青木れいか"]

Pre.cure.smile.girls.map(&:precure_name)
#=> ["キュアハッピー", "キュアサニー", "キュアピース", "キュアマーチ", "キュアビューティ"]

Pre.cure.smile.girls.count
#=> 5
```

### Rubicure::Girl
```ruby
yayoi = Pre.cure.smile.girls[2]

yayoi.name
#=> "黄瀬やよい"

yayoi.transform!

(レディ？)
プリキュア・スマイルチャージ！
(ゴー！ゴー！レッツ・ゴー！ピース！！)
ピカピカピカリンジャンケンポン！ キュアピース！
5つの光が導く未来！
輝け！スマイルプリキュア！

# 1st transform
yayoi.name
#=> "キュアピース"

# 2st transform
yayoi.transform!
yayoi.name
#=> "プリンセスピース"

# final transform
yayoi.transform!
yayoi.name
#=> "ウルトラピース"

# back to human
yayoi.transform!
yayoi.name
#=> "黄瀬やよい"

yayoi.transform!
yayoi.name
#=> "キュアピース"

# back to human
yayoi.humanize
yayoi.name
#=> "黄瀬やよい"

```

### Precure allstars
```ruby
Pre.cure.all_stars.count
#=> 33

Pre.cure.all_stars.map(&:precure_name)
#=> ["キュアブラック", "キュアホワイト", "シャイニールミナス", "キュアブルーム", "キュアイーグレット", "キュアドリーム", "キュアルージュ", "キュアレモネード", "キュアミント", "キュアアクア", "ミルキィローズ", "キュアピーチ", "キュアベリー", "キュアパイン", "キュアパッション", "キュアブロッサム", "キュアマリン", "キュアサンシャイン", "キュアムーンライト", "キュアメロディ", "キュアリズム", "キュアビート", "キュアミューズ", "キュアハッピー", "キュアサニー", "キュアピース", "キュアマーチ", "キュアビューティ", "キュアハート", "キュアダイヤモンド", "キュアロゼッタ", "キュアソード", "キュアエース"]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
