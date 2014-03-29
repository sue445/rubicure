# Rubicure (Ruby + Precure) [![Gem Version](https://badge.fury.io/rb/rubicure.png)](http://badge.fury.io/rb/rubicure) [![Build Status](https://travis-ci.org/sue445/rubicure.png?branch=master)](https://travis-ci.org/sue445/rubicure) [![Code Climate](https://codeclimate.com/github/sue445/rubicure.png)](https://codeclimate.com/github/sue445/rubicure) [![Coverage Status](https://coveralls.io/repos/sue445/rubicure/badge.png)](https://coveralls.io/r/sue445/rubicure) [![Dependency Status](https://gemnasium.com/sue445/rubicure.png)](https://gemnasium.com/sue445/rubicure)

All about Japanese battle heroine "Pretty Cure (Precure)".

Inspired by [Acme::PrettyCure](http://perl-users.jp/articles/advent-calendar/2010/acme/6) and [pycure](https://github.com/drillbits/pycure).

[![Stories in Ready](https://badge.waffle.io/sue445/rubicure.png?label=ready)](http://waffle.io/sue445/rubicure) [![endorse](https://api.coderwall.com/sue445/endorsecount.png)](https://coderwall.com/sue445)

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

Precure.dokidoki
#=> {:title=>"ドキドキ！プリキュア", :started_date=>Sun, 03 Feb 2013, :ended_date=>Sun, 26 Jan 2014, :girls=>["cure_heart", "cure_diamond", "cure_rosetta", "cure_sword", "cure_ace"]}
```

other pattern

```ruby
Precure.find(:smile).title
#=> "スマイルプリキュア！"
```

and [more aliases!](config/series.yml)

### each with precure series
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
#=> [:unmarked, :max_heart, :splash_star, :yes, :yes_gogo, :fresh, :heart_catch, :suite, :smile, :dokidoki]

Precure.inject([]){|girl_count_of_series, series| girl_count_of_series << series.girls.count; girl_count_of_series  }
#=> [2, 3, 2, 5, 6, 4, 4, 4, 5, 5]
```

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

Shiny.luminous
#=> #<Rubicure::Girl:0x007fbd60ad7288 @human_name="九条ひかり", @precure_name="シャイニールミナス", @transform_message="ルミナス・シャイニングストリーム！\n輝く命、シャイニールミナス！\n光の心と光の意志、すべてを一つにするために！\n", @extra_names=[], @current_state=0, @state_names=["九条ひかり", "シャイニールミナス"]>

Milky.rose
#=> #<Rubicure::Girl:0x007fbd60aded08 @human_name="美々野くるみ", @precure_name="ミルキィローズ", @transform_message="スカイローズ・トランスレイト！\n青いバラは秘密のしるし！ ミルキィローズ！\n", @extra_names=[], @current_state=0, @state_names=["美々野くるみ", "ミルキィローズ"]>
```

and [more aliases!](config/girls.yml)

### Rubicure::Girl
```ruby
# these are same
yayoi = Cure.peace
yayoi = Precure.smile.girls[2]

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
yayoi.transform!.transform!
yayoi.name
#=> "プリンセスピース"

yayoi.humanize
#=> 0
yayoi.name
#=> "黄瀬やよい"
```

### Precure allstars
```ruby
Precure.all_stars.count
#=> 33

Precure.all_stars.map(&:precure_name)
#=> ["キュアブラック", "キュアホワイト", "シャイニールミナス", "キュアブルーム", "キュアイーグレット", "キュアドリーム", "キュアルージュ", "キュアレモネード", "キュアミント", "キュアアクア", "ミルキィローズ", "キュアピーチ", "キュアベリー", "キュアパイン", "キュアパッション", "キュアブロッサム", "キュアマリン", "キュアサンシャイン", "キュアムーンライト", "キュアメロディ", "キュアリズム", "キュアビート", "キュアミューズ", "キュアハッピー", "キュアサニー", "キュアピース", "キュアマーチ", "キュアビューティ", "キュアハート", "キュアダイヤモンド", "キュアロゼッタ", "キュアソード", "キュアエース"]

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

### one-liner

```
§ ruby -rubicure -e'puts Shiny.luminous.transform_message'
```

## More reference
http://rubydoc.info/gems/rubicure/frames

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
