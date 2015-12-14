require 'yao'

module Stackspec::Type
  class Server
    def initialize(name)
      @name = name
    end

    def resource
      @resource ||= find_counterpart_resource
    end

    private
    def find_counterpart_resource
      servers =Yao::Server.list_detail(name: @name)
      if servers.empty?
        raise Stackspec::ResourceNotFound, "No server found for name: #{@name.inspect}"
      end
      servers.first
    rescue => e
      raise Stackspec::ResourceNotFound, "Something is wrong: #{e.class}: #{e.message}"
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
