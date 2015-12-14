require 'yao'

module Stackspec
  module OSClient
    def self.setup!
      Yao.configure do
        tenant_name Stackspec.config.tenant_name || ENV['OS_TENANT_NAME']
        auth_url    Stackspec.config.auth_url    || ENV['OS_AUTH_URL']
        username    Stackspec.config.username    || ENV['OS_USERNAME']
        password    Stackspec.config.password    || ENV['OS_PASSWORD']
      end
    end
  end
end
