require 'yao'

module Stackspec
  module OSClient
    def self.setup!
      Yao.configure do
        tenant_name Stackspec.tenant_name || ENV['OS_TENANT_NAME']
        auth_url    Stackspec.auth_url    || ENV['OS_AUTH_URL']
        username    Stackspec.username    || ENV['OS_USERNAME']
        password    Stackspec.password    || ENV['OS_PASSWORD']
      end
    end
  end
end
