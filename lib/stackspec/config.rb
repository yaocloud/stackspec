require 'singleton'
module Stackspec
  class Config < Struct.new(:username, :password, :tenant_name, :auth_url)
    include Singleton
  end

  class << self
    def config(&b)
      if block_given?
        b.call Config.instance
      end
      Config.instance
    end
  end
end
