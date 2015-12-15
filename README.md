# Stackspec

A testing framework for OpenStack resource orchestration.

[![Build Status](https://travis-ci.org/yaocloud/stackspec.svg?branch=master)](https://travis-ci.org/yaocloud/stackspec)

A member of [YAO](https://github.com/yaocloud/yao)'s family.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stackspec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stackspec

## Usage

Create `spec_helper.rb`:

```ruby
require 'stackspec'
require 'rspec/collection_matchers'

Stackspec.config do |c|
  # put .envrc and set OS_ environments
  # or just configure here
  # c.username = "udzura"
  # c.password = "p@ssw0rd"
  # c.tenant_name = "foo_tenant"
  # c.auth_url = "http://your.keystone.admin:35357/v2.0"
end

RSpec.configure do |config|
  config.before do
    # Is must
    Stackspec::OSClient.setup!
  end
end
```

Valid `OS_*` environment variables are `OS_USERNAME, OS_PASSWORD, OS_TENANT_NAME, OS_AUTH_URL`.

Then create your first spec `spec/#{tenant_name}/servers_spec.rb`:

```ruby
describe server('stackspec.example.com') do

  its(:name)            { should eq 'stackspec.example.com' }
  its(:key_name)        { should eq 'sample001' }

  its(:security_groups) { should have(4).security_groups }
  it { should have_security_group(name: "https") }

  its('flavor.id')      { should eq '8' }

end
```

Then run to check the OpenStack orchestration is OK:

```console
$ rspec spec/tenant_name/servers_spec.rb
OpenStack server "stackspec.example.com"
  should have security group {:name=>"https"}
  name
    should eq "stackspec.example.com"
  key_name
    should eq "sample001"
  security_groups
    should have 4 security_groups
  flavor.id
    should eq "8"

Finished in 2.36 seconds (files took 0.2018 seconds to load)
5 examples, 0 failures
```

Types will behave nicely with YAO's basic resource attribute calls,
and Stackspec adds them some useful attributes and matchers(more in the future).

See [examples](./examples) directory.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yaocloud/stackspec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## See also

* [Serverspec](https://github.com/mizzy/serverspec) by @mizzy for syntax.
* [Awspec](https://github.com/k1LoW/awspec) by @k1LoW for AWS orchestration.

## License

The gem is available as open source under the terms of the [MIT License](./LICENSE).
