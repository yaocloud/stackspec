require 'rspec'

module Stackspec
  module Helpers
    module Type
      extend self

      require 'stackspec/type/server'
      def server(hostname)
        Stackspec::Type::Server.new(hostname)
      end
    end
  end
end

[self.method(:extend), RSpec::Core::ExampleGroup.method(:include), RSpec::Core::ExampleGroup.method(:extend)].each do |m|
  m.call(Stackspec::Helpers::Type)
end
