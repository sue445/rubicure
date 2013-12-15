[![Stories in Ready](https://badge.waffle.io/sue445/rubicure.png?label=ready)](https://waffle.io/sue445/rubicure)  
# Rubicure (Ruby + Precure) [![Build Status](https://travis-ci.org/sue445/rubicure.png?branch=master)](https://travis-ci.org/sue445/rubicure)

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
B' irb

require "rubicure"
```

### Select own precure series

```ruby
Precure.unmarked.title
#=> "c5cc
c/cc*c-c%c""

Precure.title
#=> "c5cc
c/cc*c-c%c""

Precure.max_heart.title
#=> "c5cc
c/cc*c-c%c" Max Heart"

Precure.splash_star.title
#=> "c5cc
c/cc*c-c%c" Splash Star"

Precure.yes.title
#=> "Yeso< cc*c-c%c"5"

Precure.yes_gogo.title
#=> "Yeso< cc*c-c%c"5 Go Goo<"

Precure.flesh.title
#=> "cc,cc7c%cc*c-c%c"o<"

Precure.heart_catch.title
#=> "cc<cc-c#cccc*c-c%c"o<"

Precure.smile.title
#=> "c9cc$c+cc*c-c%c"o<"

Precure.dokidoki.title
#=> "c	c-c	c-o<cc*c-c%c""
```

other pattern

```ruby
Precure.find(:smile).title
#=> "c9cc$c+cc*c-c%c"o<"
```

and [more aliases!](config/series.yml)

### Get current precure series
`Precure#now` (alias to `#current` ) return current precure series

```ruby
Precure.now
#=> {:title=>"c	c-c	c-o<cc*c-c%c"", :started_date=>Sun, 03 Feb 2013, :ended_date=>Sun, 26 Jan 2014, :girls=>["cure_heart", "cure_diamond", "cure_rosetta", "cure_sword", "cure_ace"]}

Precure.current
#=> {:title=>"c	c-c	c-o<cc*c-c%c"", :started_date=>Sun, 03 Feb 2013, :ended_date=>Sun, 26 Jan 2014, :girls=>["cure_heart", "cure_diamond", "cure_rosetta", "cure_sword", "cure_ace"]}

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
#=> [#<Rubicure::Girl:0x007fbd60a5d6e0 @human_name="fg):c?cc", @precure_name="c-c%c"cccc<", @transform_message="(c,cc#o<)\ncc*c-c%c"c;c9cc$c+cc#c<c8o<\n(c4c<o<c4c<o<c,ccc;c4c<o<cccc<o<o<)\nc-c)c-c)h<cf*f%c.e	o< c-c%c"cccc<o<\n5c$c.e	ce0cf*f%o<\nh<co<c9cc$c+cc*c-c%c"o<\n", @extra_names=["cc*c3c;c9cccc<", "c&c+cc)cccc<"], @current_state=0, @state_names=["fg):c?cc", "c-c%c"cccc<", "cc*c3c;c9cccc<", "c&c+cc)cccc<"]>, #<Rubicure::Girl:0x007fbd60a5d5c8 @human_name="f%iccc-", @precure_name="c-c%c"c5cc<", @transform_message="(c,cc#o<)\ncc*c-c%c"c;c9cc$c+cc#c<c8o<\n(c4c<o<c4c<o<c,ccc;c4c<o<c5cc<o<o<)\ne$*i=c5c3c5c3g1h! cc/c<o< c-c%c"c5cc<o<\n5c$c.e	ce0cf*f%o<\nh<co<c9cc$c+cc*c-c%c"o<\n", @extra_names=["cc*c3c;c9c5cc<", "c&c+cc)c5cc<"], @current_state=0, @state_names=["f%iccc-", "c-c%c"c5cc<", "cc*c3c;c9c5cc<", "c&c+cc)c5cc<"]>, #<Rubicure::Girl:0x007fbd60a5d500 @human_name="i;g ,ccc", @precure_name="c-c%c"cc<c9", @transform_message="(c,cc#o<)\ncc*c-c%c"c;c9cc$c+cc#c<c8o<\n(c4c<o<c4c<o<c,ccc;c4c<o<cc<c9o<o<)\ncc+cc+cc+c*c3c8c#c3c1c3cc3o< c-c%c"cc<c9o<\n5c$c.e	ce0cf*f%o<\nh<co<c9cc$c+cc*c-c%c"o<\n", @extra_names=["cc*c3c;c9cc<c9", "c&c+cc)cc<c9"], @current_state=0, @state_names=["i;g ,ccc", "c-c%c"cc<c9", "cc*c3c;c9cc<c9", "c&c+cc)cc<c9"]>, #<Rubicure::Girl:0x007fbd60a5d410 @human_name="g7e7c*c
", @precure_name="c-c%c"cc<c", @transform_message="(c,cc#o<)\ncc*c-c%c"c;c9cc$c+cc#c<c8o<\n(c4c<o<c4c<o<c,ccc;c4c<o<cc<co<o<)\nef0c*c3c*c3g4geh2 o< c-c%c"cc<co<\n5c$c.e	ce0cf*f%o<\nh<co<c9cc$c+cc*c-c%c"o<\n", @extra_names=["cc*c3c;c9cc<c", "c&c+cc)cc<c"], @current_state=0, @state_names=["g7e7c*c
", "c-c%c"cc<c", "cc*c3c;c9cc<c", "c&c+cc)cc<c"]>, #<Rubicure::Girl:0x007fbd60a5d320 @human_name="if(ccc", @precure_name="c-c%c"cc%c<cc#", @transform_message="(c,cc#o<)\ncc*c-c%c"c;c9cc$c+cc#c<c8o<\n(c4c<o<c4c<o<c,ccc;c4c<o<cc%c<cc#o<o<)\nccccc(ic
g)ccf8ce?o< c-c%c"cc%c<cc#o<\n5c$c.e	ce0cf*f%o<\nh<co<c9cc$c+cc*c-c%c"o<\n", @extra_names=["cc*c3c;c9cc%c<cc#", "c&c+cc)cc%c<cc#"], @current_state=0, @state_names=["if(ccc", "c-c%c"cc%c<cc#", "cc*c3c;c9cc%c<cc#", "c&c+cc)cc%c<cc#"]>]

Precure.smile.girls.map(&:human_name)
#=> ["fg):c?cc", "f%iccc-", "i;g ,ccc", "g7e7c*c
", "if(ccc"]

Precure.smile.girls.map(&:precure_name)
#=> ["c-c%c"cccc<", "c-c%c"c5cc<", "c-c%c"cc<c9", "c-c%c"cc<c", "c-c%c"cc%c<cc#"]

Precure.smile.girls.count
#=> 5
```

### Select own precure girl
```ruby
Cure.lemonade
#=> #<Rubicure::Girl:0x007fbd60ae72a0 @human_name="f%f%icc	c	", @precure_name="c-c%c"c,c"cc<c	", @transform_message="cc*c-c%c"o<c!c?c"c+cc)c<c<o<\nc/cccc,c"c3c.i&c
c c-c%c"c,c"cc<c	o<\ne8fc.e
c(f*f%c.e	o<\nh/i:c+g>=c0cc5c$c.e?o<\nYeso<cc*c-c%c"5o<\n", @extra_names=[], @current_state=0, @state_names=["f%f%icc	c	", "c-c%c"c,c"cc<c	"]>

Cure.pine
#=> #<Rubicure::Girl:0x007fbd60aee640 @human_name="e11e9g%i", @precure_name="c-c%c"cc$c3", @transform_message="cc'c$c3c8o<cc*c-c%c"c;cc<cc"cco<\nc$c(c-c<cc<cc/g%c
c.ccco<\nc(ccc&cc,cc7c%c c-c%c"cc$c3o<\nc,cccc*c-c%c"o<\n", @extra_names=["c-c%c"c(c3c8c'c+cc$c3"], @current_state=0, @state_names=["e11e9g%i", "c-c%c"cc$c3", "c-c%c"c(c3c8c'c+cc$c3"]>

Cure.muse
#=> #<Rubicure::Girl:0x007fbd60af7510 @human_name="h*?h>:c"c3", @precure_name="c-c%c"cc%c<c:", @transform_message="c,cccc,c$o<cc*c-c%c"c"c8c%c,c<c7c'c3o<o<\ng*e<>cc/e%3g%c.h*?c9o< c-c%c"cc%c<c:o<\ni?c4d::c.g5f2o<c9c$c<ccc*c-c%c"o<\n", @extra_names=["c/c,cc7c'c3c	cc%c<c:"], @current_state=0, @state_names=["h*?h>:c"c3", "c-c%c"cc%c<c:", "c/c,cc7c'c3c	cc%c<c:"]>

Cure.peace
#=> #<Rubicure::Girl:0x007fbd60aceca0 @human_name="i;g ,ccc", @precure_name="c-c%c"cc<c9", @transform_message="(c,cc#o<)\ncc*c-c%c"c;c9cc$c+cc#c<c8o<\n(c4c<o<c4c<o<c,ccc;c4c<o<cc<c9o<o<)\ncc+cc+cc+c*c3c8c#c3c1c3cc3o< c-c%c"cc<c9o<\n5c$c.e	ce0cf*f%o<\nh<co<c9cc$c+cc*c-c%c"o<\n", @extra_names=["cc*c3c;c9cc<c9", "c&c+cc)cc<c9"], @current_state=0, @state_names=["i;g ,ccc", "c-c%c"cc<c9", "cc*c3c;c9cc<c9", "c&c+cc)cc<c9"]>

Cure.rosetta
#=> #<Rubicure::Girl:0x007fbd60af42c0 @human_name="eh	cc
c", @precure_name="c-c%c"c-c<cc?", @transform_message="cc*c-c%c"c)cc*c3c/o<\nL! O! V! E!\nc2c c>c
cc+cc+ c-c%c"c-c<cc?o<\ni?cfc.i<eo<c	c-c	c-cc*c-c%c"o<\nd8gce6ccc.c/fc cc'cc \nccc cc*ccg'c(fch2cc'cc ccc*\n", @extra_names=[], @current_state=0, @state_names=["eh	cc
c", "c-c%c"c-c<cc?"]>

Shiny.luminous
#=> #<Rubicure::Girl:0x007fbd60ad7288 @human_name="d9f!c2cc
", @precure_name="c7c#c$cc<c+cc
c9", @transform_message="c+cc
c9c;c7c#c$cc3c0c9cc*c<c o<\nh<ce=c c7c#c$cc<c+cc
c9o<\ne	c.e?c(e	c.fe?c cc9c&cd8 c$c+ccccc+o<\n", @extra_names=[], @current_state=0, @state_names=["d9f!c2cc
", "c7c#c$cc<c+cc
c9"]>

Milky.rose
#=> #<Rubicure::Girl:0x007fbd60aded08 @human_name="g>c iccc?", @precure_name="cc+c-c#c-c<c:", @transform_message="c9c+c$c-c<c:c;cc)c3c9c,c$co<\niccc)c/g'e/c.ccco< cc+c-c#c-c<c:o<\n", @extra_names=[], @current_state=0, @state_names=["g>c iccc?", "cc+c-c#c-c<c:"]>
```

and [more aliases!](config/girls.yml)

### Rubicure::Girl
```ruby
# these are same
yayoi = Cure.peace
yayoi = Precure.smile.girls[2]

yayoi.name
#=> "i;g ,ccc"

yayoi.transform!

(c,cc#o<)
cc*c-c%c"c;c9cc$c+cc#c<c8o<
(c4c<o<c4c<o<c,ccc;c4c<o<cc<c9o<o<)
cc+cc+cc+c*c3c8c#c3c1c3cc3o< c-c%c"cc<c9o<
5c$c.e	ce0cf*f%o<
h<co<c9cc$c+cc*c-c%c"o<

# 1st transform
yayoi.name
#=> "c-c%c"cc<c9"

# 2st transform
yayoi.transform!
yayoi.name
#=> "cc*c3c;c9cc<c9"

# final transform
yayoi.transform!
yayoi.name
#=> "c&c+cc)cc<c9"

# back to human
yayoi.transform!.transform!
yayoi.name
#=> "cc*c3c;c9cc<c9"

yayoi.humanize
#=> 0
yayoi.name
#=> "i;g ,ccc"
```

### Precure allstars
```ruby
Precure.all_stars.count
#=> 33

Precure.all_stars.map(&:precure_name)
#=> ["c-c%c"cc)cc/", "c-c%c"cc/c$c", "c7c#c$cc<c+cc
c9", "c-c%c"cc+c<c ", "c-c%c"c$c<c0c,cc", "c-c%c"c	c*c<c ", "c-c%c"c+c<c8c%", "c-c%c"c,c"cc<c	", "c-c%c"cc3c", "c-c%c"c"c/c"", "cc+c-c#c-c<c:", "c-c%c"cc<c", "c-c%c"cc*c<", "c-c%c"cc$c3", "c-c%c"ccc7c'c3", "c-c%c"cc-cc5c ", "c-c%c"cc*c3", "c-c%c"c5c3c7c#c$c3", "c-c%c"c c<c3c)c$c", "c-c%c"c!c-cc#", "c-c%c"c*c:c ", "c-c%c"cc<c", "c-c%c"cc%c<c:", "c-c%c"cccc<", "c-c%c"c5cc<", "c-c%c"cc<c9", "c-c%c"cc<c", "c-c%c"cc%c<cc#", "c-c%c"cc<c", "c-c%c"c c$c$c"c3c	", "c-c%c"c-c<cc?", "c-c%c"c=c<c	", "c-c%c"c(c<c9"]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
