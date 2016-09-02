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
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/east.svg" width="20"/></td><td>Ew</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/south.svg" width="20"/></td><td>Sw</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/west.svg" width="20"/></td><td>Ww</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/north.svg" width="20"/></td><td>Nw</td>
  </tr>
  <tr>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/chun.svg" width="20"/></td><td>Cd</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/hatsu.svg" width="20"/></td><td>Fd</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/haku.svg" width="20"/></td><td>Pd</td>
  </tr>
  <tr>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/man_1.svg" width="20"/></td><td>1m</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/man_2.svg" width="20"/></td><td>2m</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/man_3.svg" width="20"/></td><td>3m</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/man_4.svg" width="20"/></td><td>4m</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/man_5.svg" width="20"/></td><td>5m</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/man_6.svg" width="20"/></td><td>6m</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/man_7.svg" width="20"/></td><td>7m</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/man_8.svg" width="20"/></td><td>8m</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/man_9.svg" width="20"/></td><td>9m</td>
  </tr>
  <tr>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/sou_1.svg" width="20"/></td><td>1s</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/sou_2.svg" width="20"/></td><td>2s</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/sou_3.svg" width="20"/></td><td>3s</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/sou_4.svg" width="20"/></td><td>4s</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/sou_5.svg" width="20"/></td><td>5s</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/sou_6.svg" width="20"/></td><td>6s</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/sou_7.svg" width="20"/></td><td>7s</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/sou_8.svg" width="20"/></td><td>8s</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/sou_9.svg" width="20"/></td><td>9s</td>
  </tr>
  <tr>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/pin_1.svg" width="20"/></td><td>1p</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/pin_2.svg" width="20"/></td><td>2p</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/pin_3.svg" width="20"/></td><td>3p</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/pin_4.svg" width="20"/></td><td>4p</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/pin_5.svg" width="20"/></td><td>5p</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/pin_6.svg" width="20"/></td><td>6p</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/pin_7.svg" width="20"/></td><td>7p</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/pin_8.svg" width="20"/></td><td>8p</td>
    <td><img src="https://cdn.rawgit.com/mtsmfm/tegaki-jan/master/svg/pin_9.svg" width="20"/></td><td>9p</td>
  </tr>
</table>

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[flada-auxv]/tenpai_wakaru_man.
