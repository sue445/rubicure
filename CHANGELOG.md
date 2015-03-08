## master
[full changelog](http://github.com/sue445/rubicure/compare/v0.2.4...master)

## v0.2.3
[full changelog](http://github.com/sue445/rubicure/compare/v0.2.3...v0.2.4)

* Tweak transform message 
  * https://github.com/sue445/rubicure/pull/76

## v0.2.2
[full changelog](http://github.com/sue445/rubicure/compare/v0.2.2.1...v0.2.3)

* Add Go! Princess Precure
  * https://github.com/sue445/rubicure/pull/66

## v0.2.2.1
[full changelog](http://github.com/sue445/rubicure/compare/v0.2.2...v0.2.2.1)

* Tweak gem dependency
  * https://github.com/sue445/rubicure/pull/75

## v0.2.2
[full changelog](http://github.com/sue445/rubicure/compare/v0.2.1...v0.2.2)

* Add forever lovely
  * https://github.com/sue445/rubicure/pull/73
* Add happiness ended_date :cry:
  * https://github.com/sue445/rubicure/pull/74

## v0.2.1
[full changelog](http://github.com/sue445/rubicure/compare/v0.2.0...v0.2.1)

* Impl `Girl#cast_name`
  * https://github.com/sue445/rubicure/pull/71
* Impl `Girl#color`
  * https://github.com/sue445/rubicure/pull/72
* apply Hashie::Extensions::MethodAccess to Girl
  * https://github.com/sue445/rubicure/pull/69
  * **attention** : `Cure.xxxx` return plain `Hash` instance (not. `Rubicure::Giri`)

## v0.2.0
[full changelog](http://github.com/sue445/rubicure/compare/v0.1.4...v0.2.0)

* bugfix: precure all_stars count when new stage3
  * https://github.com/sue445/rubicure/pull/61
* refactor: divide `config/girls.yml` to `config/girls/*.yml`
  * https://github.com/sue445/rubicure/pull/64

## v0.1.4
[full changelog](http://github.com/sue445/rubicure/compare/v0.1.3...v0.1.4)

* Add `Girl#to_s` (alias of `#name`) (thx @zonuexe)
  * https://github.com/sue445/rubicure/pull/59
* Support User-defined `IO.put` in `Girl#print_by_line` (thx @bash)
  * https://github.com/sue445/rubicure/pull/60

## v0.1.3
[full changelog](http://github.com/sue445/rubicure/compare/v0.1.2...v0.1.3)

* Impl: `!Cure.passion`, `!Cure.beat`
  * https://github.com/sue445/rubicure/pull/48
* `Girl#humanize` -> `Girl#humanize!` and return self
  * https://github.com/sue445/rubicure/pull/52
  * `Girl#humanize` is deprecated

## v0.1.2
[full changelog](http://github.com/sue445/rubicure/compare/v0.1.1...v0.1.2)

* Support ruby 2.2.0-preview1
* Impl Series#each_with_girls
  * https://github.com/sue445/rubicure/pull/47

## v0.1.1
[full changelog](http://github.com/sue445/rubicure/compare/v0.1.0...v0.1.1)

* specific transform
  * https://github.com/sue445/rubicure/pull/36 (thx @zonuexe)
* Add `Cure.peace.pikarin_janken` (singleton method)
  * https://github.com/sue445/rubicure/pull/39 (thx @zonuexe)

## v0.1.0
[full changelog](http://github.com/sue445/rubicure/compare/v0.0.7...v0.1.0)

* Impl `Girl#attack!`
* Print transform and attack by line
* Add happiness charge form change

## v0.0.7
[full changelog](http://github.com/sue445/rubicure/compare/v0.0.6...v0.0.7)

* Support Cure Fortune

## v0.0.6
[full changelog](http://github.com/sue445/rubicure/compare/v0.0.5...v0.0.6)

* Support activesupport >= 4.0.0

## v0.0.5
[full changelog](http://github.com/sue445/rubicure/compare/v0.0.4...v0.0.5)

### Bugfixes
* Fix the transform message of Cure Windy (thx @kaosf)
  * https://github.com/sue445/rubicure/pull/18

### Enhancements
* Add Happiness Charge Precure !
  * https://github.com/sue445/rubicure/pull/10
* Add `ubicure`
  * https://github.com/sue445/rubicure/pull/22 (thx @zonuexe)

## v0.0.4
[full changelog](http://github.com/sue445/rubicure/compare/v0.0.3...v0.0.4)

### Enhancements
* Add cure heart engage mode :sparkling_heart:
* Add cure bright and cure windy (thx @kaosf)
  * https://github.com/sue445/rubicure/pull/15
* Impl `Precure#each_with_series` (alias to `Precure#each`)
  * https://github.com/sue445/rubicure/pull/13
* Add arg to `Precure#all_stars`
  * https://github.com/sue445/rubicure/pull/16

## v0.0.3
[full changelog](http://github.com/sue445/rubicure/compare/v0.0.2...v0.0.3)

### Enhancements
* define operators(`Girl#==`, `Series#===`) (thx @zonuexe)
  * https://github.com/sue445/rubicure/pull/7
* Remove last linebreaks of transform_messages (thx @zonuexe)
  * https://github.com/sue445/rubicure/pull/8

## v0.0.2
[full changelog](http://github.com/sue445/rubicure/compare/v0.0.1...v0.0.2)

### bugfixes
* Bugfix: fresh pretty cure (thx @kaosf)
  * https://github.com/sue445/rubicure/pull/6

## v0.0.1
* first release
