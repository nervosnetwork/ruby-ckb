# Nervos CKB

Nervos CKB (Common Knowledge Base) is a permissionless blockchain, the secure state layer of Nervos Network.

* [Nervos CKB Whitepaper](https://github.com/NervosFoundation/binary/tree/master/whitepaper)

## TODO

- [] Chain
    - [] Tree
        - [] fork management
    - [] Block
        - [] Header
            - [] Schema
            - [] Validation
        - [] Schema
        - [] Validation
    - [] Transaction
        - [] Schema
        - [] Validation
    - [] Transaction Pool
    - [] Cell
    - [] VM
- [] Miner
    - [] Dummy Miner
    - [] Cuckoo Miner
- [] Network
    - [] P2P transport
    - [] Wire protocol
- [] RPC Server

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ckb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ckb

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Build

If you get build error on installing rbczmq, try to install rbczmq with CPPFLAGS in your terminal:

```
CPPFLAGS='-Wno-error=deprecated-declarations' gem install rbczmq -v '1.7.9'
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/NervosFoundation/ckb.
