require 'yao'

module Stackspec::Type
  class Server
    def initialize(name)
      @name = name
    end

    def resource
      @resource ||= find_counterpart_resource
    end

    def to_s
      "OpenStack server #{@name.inspect}"
    end

    def security_groups
      resource.security_groups.uniq {|sg| sg.name }
    end

    def has_security_group?(name: nil)
      !! resource.security_groups.find {|sg| sg.name == name }
    end

    alias inspect to_s

    private
    def find_counterpart_resource
      begin
        servers = Yao::Server.list_detail(name: @name)
      rescue => e
        raise Stackspec::ResourceNotFound, "Something is wrong: #{e.class}: #{e.message}"
      end

      if servers.empty?
        raise Stackspec::ResourceNotFound, "No server found for name: #{@name.inspect}"
      end
      servers.first
    end

    def method_missing(name)
      # FIXME: The resource reader
      if resource.respond_to? name
        return resource.send(name)
      end
      super
    end
  end
end
