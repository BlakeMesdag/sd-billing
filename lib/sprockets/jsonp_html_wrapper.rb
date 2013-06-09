require 'sprockets'

module Sprockets
  class JsonpHtmlWrapper < Tilt::Template

    class_attribute :callback
    self.callback = 'registerViews'

    class_attribute :path_filter
    self.path_filter = Proc.new do |path|
      path.sub(/^.*?\/html\//, '')
    end

    def self.default_mime_type
      'application/javascript'
    end

    def self.engine_initialized?
      defined? ::ActiveSupport::JSON
    end

    def initialize_engine
      require 'active_support/json'
    end

    def prepare
      options[:callback] ||= self.class.callback
      options[:path_filter] ||= self.class.path_filter
      @output = nil
    end

    def evaluate(scope, locals, &block)
      @output ||= "#{options[:callback]}(#{json_wrapper(scope)})"
    end

    private

    def json_wrapper(scope)
      view_path = options[:path_filter].call(scope.logical_path)
      ActiveSupport::JSON.encode(view_path => data)
    end
  end
end
