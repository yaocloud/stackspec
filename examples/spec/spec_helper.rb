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
    Stackspec::OSClient.setup!
  end
end
