# Rubicure (Ruby + Precure)

[![Gem Version](https://badge.fury.io/rb/rubicure.svg)](http://badge.fury.io/rb/rubicure)
[![Build Status](https://travis-ci.org/sue445/rubicure.png?branch=master)](https://travis-ci.org/sue445/rubicure)
[![Code Climate](https://codeclimate.com/github/sue445/rubicure.png)](https://codeclimate.com/github/sue445/rubicure)
[![Coverage Status](https://coveralls.io/repos/sue445/rubicure/badge.png)](https://coveralls.io/r/sue445/rubicure)
[![Dependency Status](https://gemnasium.com/sue445/rubicure.png)](https://gemnasium.com/sue445/rubicure)
[![Inline docs](http://inch-ci.org/github/sue445/rubicure.svg?branch=master)](http://inch-ci.org/github/sue445/rubicure)

All about Japanese battle heroine "Pretty Cure (Precure)".

Inspired by [Acme::PrettyCure](http://perl-users.jp/articles/advent-calendar/2010/acme/6) and [pycure](https://github.com/drillbits/pycure).

[![Stories in Ready](https://badge.waffle.io/sue445/rubicure.png?label=ready)](http://waffle.io/sue445/rubicure)
[![endorse](https://api.coderwall.com/sue445/endorsecount.png)](https://coderwall.com/sue445)
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/sue445/rubicure/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

## Requirements

* ruby >= 2.0.0
  * more: [.travis.yml](.travis.yml)

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

### Select own precure series

```ruby
Precure.title
#=> "ふたりはプリキュア"

Precure.unmarked.title
#=> "ふたりはプリキュア"

Precure.max_heart.title
#=> "ふたりはプリキュア Max Heart"

Precure.splash_star.title
#=> "ふたりはプリキュア Splash Star"

Precure.yes.title
#=> "Yes！ プリキュア5"

Precure.yes_gogo.title
#=> "Yes！ プリキュア5 Go Go！"

Precure.fresh.title
#=> "フレッシュプリキュア！"

Precure.heart_catch.title
#=> "ハートキャッチプリキュア！"

Precure.suite.title
#=> "スイートプリキュア♪"

Precure.smile.title
#=> "スマイルプリキュア！"

Precure.dokidoki.title
#=> "ドキドキ！プリキュア"

Precure.happiness_charge.title
#=> "ハピネスチャージプリキュア！"

Precure.dokidoki
#=> {:title=>"ドキドキ！プリキュア", :started_date=>Sun, 03 Feb 2013, :ended_date=>Sun, 26 Jan 2014, :girls=>["cure_heart", "cure_diamond", "cure_rosetta", "cure_sword", "cure_ace"]}
```

other pattern

```ruby
Precure.find(:smile).title
#=> "スマイルプリキュア！"
```

and [more aliases!](config/series.yml)

### Get current precure series
`Precure#now` (alias to `#current` ) return current precure series

```ruby
Precure.now
#=> {:title=>"ドキドキ！プリキュア", :started_date=>Sun, 03 Feb 2013, :ended_date=>Sun, 26 Jan 2014, :girls=>["cure_heart", "cure_diamond", "cure_rosetta", "cure_sword", "cure_ace"]}

Precure.current
#=> {:title=>"ドキドキ！プリキュア", :started_date=>Sun, 03 Feb 2013, :ended_date=>Sun, 26 Jan 2014, :girls=>["cure_heart", "cure_diamond", "cure_rosetta", "cure_sword", "cure_ace"]}

# -2013/1/27  : smile precure
#  2013/2/5 - : dokidoki precure
require "delorean"
Delorean.time_travel_to "2013-02-01"
Precure.now
#=> RuntimeError: Not on air precure!
```

### Rubicure::Series#on_air?

```ruby
Precure.dokidoki.on_air?("2013-12-16")
#=> true

Precure.smile.on_air?("2013-12-16")
#=> false
```

### Rubicure::Series#girls
```ruby
Precure.smile.girls
#=> [#<Rubicure::Girl:0x007fbd60a5d6e0 @human_name="星空みゆき", @precure_name="キュアハッピー", @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！ハッピー！！)\nキラキラ輝く未来の光！ キュアハッピー！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @extra_names=["プリンセスハッピー", "ウルトラハッピー"], @current_state=0, @state_names=["星空みゆき", "キュアハッピー", "プリンセスハッピー", "ウルトラハッピー"]>, #<Rubicure::Girl:0x007fbd60a5d5c8 @human_name="日野あかね", @precure_name="キュアサニー", @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！サニー！！)\n太陽サンサン熱血パワー！ キュアサニー！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @extra_names=["プリンセスサニー", "ウルトラサニー"], @current_state=0, @state_names=["日野あかね", "キュアサニー", "プリンセスサニー", "ウルトラサニー"]>, #<Rubicure::Girl:0x007fbd60a5d500 @human_name="黄瀬やよい", @precure_name="キュアピース", @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！ピース！！)\nピカピカピカリンジャンケンポン！ キュアピース！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @extra_names=["プリンセスピース", "ウルトラピース"], @current_state=0, @state_names=["黄瀬やよい", "キュアピース", "プリンセスピース", "ウルトラピース"]>, #<Rubicure::Girl:0x007fbd60a5d410 @human_name="緑川なお", @precure_name="キュアマーチ", @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！マーチ！！)\n勇気リンリン直球勝負！ キュアマーチ！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @extra_names=["プリンセスマーチ", "ウルトラマーチ"], @current_state=0, @state_names=["緑川なお", "キュアマーチ", "プリンセスマーチ", "ウルトラマーチ"]>, #<Rubicure::Girl:0x007fbd60a5d320 @human_name="青木れいか", @precure_name="キュアビューティ", @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！ビューティ！！)\nしんしんと降り積もる清き心！ キュアビューティ！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @extra_names=["プリンセスビューティ", "ウルトラビューティ"], @current_state=0, @state_names=["青木れいか", "キュアビューティ", "プリンセスビューティ", "ウルトラビューティ"]>]

Precure.smile.girls.map(&:human_name)
#=> ["星空みゆき", "日野あかね", "黄瀬やよい", "緑川なお", "青木れいか"]

Precure.smile.girls.map(&:precure_name)
#=> ["キュアハッピー", "キュアサニー", "キュアピース", "キュアマーチ", "キュアビューティ"]

Precure.smile.girls.count
#=> 5
```

### Select own precure girl
```ruby
Cure.lemonade
#=> #<Rubicure::Girl:0x007fbd60ae72a0 @human_name="春日野うらら", @precure_name="キュアレモネード", @transform_message="プリキュア！メタモルフォーゼ！\nはじけるレモンの香り、キュアレモネード！\n希望の力と未来の光！\n華麗に羽ばたく5つの心！\nYes！プリキュア5！\n", @extra_names=[], @current_state=0, @state_names=["春日野うらら", "キュアレモネード"]>

Cure.pine
#=> #<Rubicure::Girl:0x007fbd60aee640 @human_name="山吹祈里", @precure_name="キュアパイン", @transform_message="チェインジ！プリキュア・ビートアップ！\nイエローハートは祈りのしるし！\nとれたてフレッシュ、キュアパイン！\nレッツプリキュア！\n", @extra_names=["キュアエンジェルパイン"], @current_state=0, @state_names=["山吹祈里", "キュアパイン", "キュアエンジェルパイン"]>

Cure.sunshine
#=> #<Rubicure::Girl:0x007f83413a6e18 @human_name="明堂院いつき", @precure_name="キュアサンシャイン", @transform_message="(プリキュアの種、いくですぅ！)\nプリキュア！オープンマイハート！\n陽の光浴びる一輪の花！ キュアサンシャイン！\nハートキャッチ、プリキュア！\n", @extra_names=["スーパーキュアサンシャイン"], @current_state=0, @state_names=["明堂院いつき", "キュアサンシャイン", "スーパーキュアサンシャイン"]>

Cure.muse
#=> #<Rubicure::Girl:0x007fbd60af7510 @human_name="調辺アコ", @precure_name="キュアミューズ", @transform_message="レッツプレイ！プリキュアモジュレーション！！\n爪弾くは女神の調べ！ キュアミューズ！\n響け4人の組曲！スイートプリキュア！\n", @extra_names=["クレッシェンドミューズ"], @current_state=0, @state_names=["調辺アコ", "キュアミューズ", "クレッシェンドミューズ"]>

Cure.peace
#=> #<Rubicure::Girl:0x007fbd60aceca0 @human_name="黄瀬やよい", @precure_name="キュアピース", @transform_message="(レディ？)\nプリキュア・スマイルチャージ！\n(ゴー！ゴー！レッツ・ゴー！ピース！！)\nピカピカピカリンジャンケンポン！ キュアピース！\n5つの光が導く未来！\n輝け！スマイルプリキュア！\n", @extra_names=["プリンセスピース", "ウルトラピース"], @current_state=0, @state_names=["黄瀬やよい", "キュアピース", "プリンセスピース", "ウルトラピース"]>

Cure.rosetta
#=> #<Rubicure::Girl:0x007fbd60af42c0 @human_name="四葉ありす", @precure_name="キュアロゼッタ", @transform_message="プリキュアラブリンク！\nL! O! V! E!\nひだまりポカポカ キュアロゼッタ！\n響け愛の鼓動！ドキドキプリキュア！\n世界を制するのは愛だけです、\nさぁ、あなたも私と愛を育んでくださいな\n", @extra_names=[], @current_state=0, @state_names=["四葉ありす", "キュアロゼッタ"]>

Cure.honey
#=> #<Rubicure::Girl:0x007fb041afb768 @human_name="大森ゆうこ", @precure_name="キュアハニー", @transform_message="かわルンルン！\nプリキュアくるりんミラーチェンジ！\n大地に実る命の光！キュアハニー！\nハピネス注入！幸せチャージ！\nハピネスチャージプリキュア！", @extra_names=[], @created_date=Sun, 17 Mar 2013, @current_state=0, @state_names=["大森ゆうこ", "キュアハニー"]>

Shiny.luminous
#=> #<Rubicure::Girl:0x007fbd60ad7288 @human_name="九条ひかり", @precure_name="シャイニールミナス", @transform_message="ルミナス・シャイニングストリーム！\n輝く命、シャイニールミナス！\n光の心と光の意志、すべてを一つにするために！\n", @extra_names=[], @current_state=0, @state_names=["九条ひかり", "シャイニールミナス"]>

Milky.rose
#=> #<Rubicure::Girl:0x007fbd60aded08 @human_name="美々野くるみ", @precure_name="ミルキィローズ", @transform_message="スカイローズ・トランスレイト！\n青いバラは秘密のしるし！ ミルキィローズ！\n", @extra_names=[], @current_state=0, @state_names=["美々野くるみ", "ミルキィローズ"]>
```

and [more aliases!](config/girls/)

### Rubicure::Girl
```ruby
# these are same
yayoi = Cure.peace
yayoi = Precure.smile.girls[2]

yayoi.name
#=> "黄瀬やよい"

yayoi.attack!
#=> RuntimeError: require transform


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

yayoi.attack!

プリキュア！ピースサンダー！！

# 2st transform
yayoi.transform!
yayoi.name
#=> "プリンセスピース"

yayoi.attack!

開け、ロイヤルクロック！
(みんなの力を1つにするクル！)
届け、希望の光！
はばたけ！光り輝く未来へ！
プリキュア！ロイヤルレインボーバースト！

# final transform
yayoi.transform!
yayoi.name
#=> "ウルトラピース"

yayoi.attack!

(みんなの力を1つにするクル！)
プリキュア！ミラクルレインボーバースト！
輝けー！！
スマイルプリキュア！！

# back to human
yayoi.transform!.transform!
yayoi.name
#=> "プリンセスピース"

yayoi.humanize!
#=> 0
yayoi.name
#=> "黄瀬やよい"
```

### Specific transform
```ruby
Cure.black.dual_aurora_wave!
デュアル・オーロラ・ウェイブ！！
光の使者、キュアブラック！
ふたりはプリキュア！
闇の力のしもべ達よ！
とっととお家に帰りなさい！

Cure.luminous.luminous_shining_stream!
ルミナス・シャイニングストリーム！
輝く命、シャイニールミナス！
光の心と光の意志、すべてを一つにするために！

Cure.bloom.dual_spilitual_power!
デュアル・スピリチュアル・パワー！
花開け大地に！
輝く金の花！ キュアブルーム！
ふたりはプリキュア！
聖なる泉を汚す者よ！
阿漕な真似はお止めなさい！

Cure.dream.metamorphose!
プリキュア！メタモルフォーゼ！
大いなる希望の力、キュアドリーム！
希望の力と未来の光！
華麗に羽ばたく5つの心！
Yes！プリキュア5！

Milky.rose.sky_rose_translate!
スカイローズ・トランスレイト！
青いバラは秘密のしるし！ ミルキィローズ！

Cure.peach.change_precure_beatup!
チェインジ！プリキュア・ビートアップ！
ピンクのハートは愛あるしるし！
もぎたてフレッシュ、キュアピーチ！
レッツプリキュア！

Cure.blossom.open_my_heart!
(プリキュアの種、いくですぅ！)
プリキュア！オープンマイハート！
大地に咲く一輪の花！ キュアブロッサム！
ハートキャッチ、プリキュア！

Cure.melody.lets_play_precure_modulation!
レッツプレイ！プリキュアモジュレーション！！
爪弾くは荒ぶる調べ！ キュアメロディ！
届け4人の組曲！スイートプリキュア！

Cure.happy.smile_charge!
(レディ？)
プリキュア・スマイルチャージ！
(ゴー！ゴー！レッツ・ゴー！ハッピー！！)
キラキラ輝く未来の光！ キュアハッピー！
5つの光が導く未来！
輝け！スマイルプリキュア！

Cure.heart.love_link!
プリキュアラブリンク！
L! O! V! E!
みなぎる愛！ キュアハート！
響け愛の鼓動！ドキドキプリキュア！
愛を無くした悲しいジコチューさん、
このキュアハートがあなたのドキドキ取り戻してみせる！

Cure.ace.dressup!
プリキュアドレスアップ！
(キュピラッパー！)
愛の切り札！ キュアエース！
響け愛の鼓動！ドキドキプリキュア！
美しさは正義の証し、ウインク一つで、
あなたのハートを射抜いて差し上げますわ

Cure.lovely.kururin_mirror_change!
(かわルンルン！)
プリキュアくるりんミラーチェンジ！
世界に広がるビッグな愛！キュアラブリー！
ハピネス注入！幸せチャージ！
ハピネスチャージプリキュア！

Cure.fortune.kirarin_star_symphony!
(かわルンルン！)
プリキュアきらりんスターシンフォニー！
夜空にきらめく希望の星！キュアフォーチュン！
ハピネス注入！幸せチャージ！
ハピネスチャージプリキュア！
```

### Precure allstars
```ruby
Precure.all_stars.count
#=> 36

Precure.all_stars.map(&:precure_name)
#=> ["キュアブラック", "キュアホワイト", "シャイニールミナス", "キュアブルーム", "キュアイーグレット", "キュアドリーム", "キュアルージュ", "キュアレモネード", "キュアミント", "キュアアクア", "ミルキィローズ", "キュアピーチ", "キュアベリー", "キュアパイン", "キュアパッション", "キュアブロッサム", "キュアマリン", "キュアサンシャイン", "キュアムーンライト", "キュアメロディ", "キュアリズム", "キュアビート", "キュアミューズ", "キュアハッピー", "キュアサニー", "キュアピース", "キュアマーチ", "キュアビューティ", "キュアハート", "キュアダイヤモンド", "キュアロゼッタ", "キュアソード", "キュアエース", "キュアラブリー", "キュアプリンセス", "キュアハニー"]

Precure.all_stars("2013-10-26").count
#=> 33
Precure.all_stars(:dx).count
#=> 14
Precure.all_stars(:dx2).count
#=> 17
Precure.all_stars(:dx3).count
#=> 21
Precure.all_stars(:new_stage).count
#=> 28
Precure.all_stars(:new_stage2).count
#=> 32
Precure.all_stars(:new_stage3).count
#=> 36
```

and [more aliases!](config/movies.yml)


### Equivalence
```ruby
yayoi = Cure.peace.dup
cure_peace = Cure.peace.dup.transform!

yayoi == cure_peace
#=> true
```

```ruby
precure = Rubicure::Girl.find(:passion)

case precure
when Precure.dokidoki
  puts "The girl is a member of Dokidoki! Precure"
when Precure.fresh
  puts "The girl is a member of Fresh Precure!"
else
  puts "The girl is not which member of Dokidoki! Precure and Fresh Precure!"
end
```

### Pikarin janken
```ruby
Cure.peace.pikarin_janken
ピカピカピカリン
ジャンケンポン！
（パー）
#=> "ピカピカピカリン\nジャンケンポン！\n（パー）\n"

Cure.peace.janken
ピカピカピカリン
ジャンケンポン！
（グー）
# => "ピカピカピカリン\nジャンケンポン！\n（グー）\n"
```

### one-liner

```
§ ruby -rubicure -e'puts Shiny.luminous.transform_message'
```

### Enumerable
```ruby
Precure.each{|series| puts series.title  }
ふたりはプリキュア
ふたりはプリキュア Max Heart
ふたりはプリキュア Splash Star
Yes！ プリキュア5
Yes！ プリキュア5 Go Go！
フレッシュプリキュア！
ハートキャッチプリキュア！
スイートプリキュア♪
スマイルプリキュア！
ドキドキ！プリキュア
ハピネスチャージプリキュア！
#=> [:unmarked, :max_heart, :splash_star, :yes, :yes_gogo, :fresh, :heart_catch, :suite, :smile, :dokidoki, :happiness_charge]

Precure.inject([]){|girl_count_of_series, series| girl_count_of_series << series.girls.count; girl_count_of_series  }
#=> [2, 3, 2, 5, 6, 4, 4, 4, 5, 5, 3]

Precure.map(&:title)
=> ["ふたりはプリキュア", "ふたりはプリキュア Max Heart", "ふたりはプリキュア Splash Star", "Yes！ プリキュア5", "Yes！ プリキュア5 Go Go！", "フレッシュプリキュア！", "ハートキャッチプリキュア！", "スイートプリキュア♪", "スマイルプリキュア！", "ドキドキ！プリキュア", "ハピネスチャージプリキュア！"]

Precure.happiness_charge.map(&:precure_name)
=> ["キュアラブリー", "キュアプリンセス", "キュアハニー", "キュアフォーチュン"]

Precure.map{|series| series.map(&:precure_name) }
=> [["キュアブラック", "キュアホワイト"], ["キュアブラック", "キュアホワイト", "シャイニールミナス"], ["キュアブルーム", "キュアイーグレット"], ["キュアドリーム", "キュアルージュ", "キュアレモネード", "キュアミント", "キュアアクア"], ["キュアドリーム", "キュアルージュ", "キュアレモネード", "キュアミント", "キュアアクア", "ミルキィローズ"], ["キュアピーチ", "キュアベリー", "キュアパイン", "キュアパッション"], ["キュアブロッサム", "キュアマリン", "キュアサンシャイン", "キュアムーンライト"], ["キュアメロディ", "キュアリズム", "キュアビート", "キュアミューズ"], ["キュアハッピー", "キュアサニー", "キュアピース", "キュアマーチ", "キュアビューティ"], ["キュアハート", "キュアダイヤモンド", "キュアロゼッタ", "キュアソード", "キュアエース"], ["キュアラブリー", "キュアプリンセス", "キュアハニー", "キュアフォーチュン"]]
```

### Not operator
```ruby
passion = Cure.passion
passion.name
=> "東せつな"

!passion

passion.name
=> "イース"

beat = Cure.beat

beat.name
=> "黒川エレン"

!beat

beat.name
=> "セイレーン"
```

## More reference
http://rubydoc.info/gems/rubicure/frames

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request



