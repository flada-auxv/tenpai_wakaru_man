# TenpaiWakaruMan
[![Gem Version](https://badge.fury.io/rb/tenpai_wakaru_man.svg)](https://badge.fury.io/rb/tenpai_wakaru_man)
[![Build Status](https://travis-ci.org/flada-auxv/tenpai_wakaru_man.svg?branch=master)](https://travis-ci.org/flada-auxv/tenpai_wakaru_man)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tenpai_wakaru_man'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tenpai_wakaru_man

## Usage

```ruby
# ready(聴牌) or not
TenpaiWakaruMan.ready?('123m123p23sSSSwPPd') # => true

# win(和了) or not
TenpaiWakaruMan.win?('234m234m234m222p55m') # => true

# You can also like this
TenpaiWakaruMan.win?('222333444455m222p') # => true
```
<table>
  <tr>
    <td>🀀</td><td>Ew</td>
    <td>🀁</td><td>Sw</td>
    <td>🀂</td><td>Ww</td>
    <td>🀃</td><td>Nw</td>
  </tr>
  <tr>
    <td>🀄</td><td>Cd</td>
    <td>🀅</td><td>Fd</td>
    <td>🀆</td><td>Pd</td>
  </tr>
  <tr>
    <td>🀇</td><td>1m</td>
    <td>🀈</td><td>2m</td>
    <td>🀉</td><td>3m</td>
    <td>🀊</td><td>4m</td>
    <td>🀋</td><td>5m</td>
    <td>🀌</td><td>6m</td>
    <td>🀍</td><td>7m</td>
    <td>🀎</td><td>8m</td>
    <td>🀏</td><td>9m</td>
  </tr>
  <tr>
    <td>🀐</td><td>1s</td>
    <td>🀑</td><td>2s</td>
    <td>🀒</td><td>3s</td>
    <td>🀓</td><td>4s</td>
    <td>🀔</td><td>5s</td>
    <td>🀕</td><td>6s</td>
    <td>🀖</td><td>7s</td>
    <td>🀗</td><td>8s</td>
    <td>🀘</td><td>9s</td>
  </tr>
  <tr>
    <td>🀙</td><td>1p</td>
    <td>🀚</td><td>2p</td>
    <td>🀛</td><td>3p</td>
    <td>🀜</td><td>4p</td>
    <td>🀝</td><td>5p</td>
    <td>🀞</td><td>6p</td>
    <td>🀟</td><td>7p</td>
    <td>🀠</td><td>8p</td>
    <td>🀡</td><td>9p</td>
  </tr>
</table>

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[flada-auxv]/tenpai_wakaru_man.
