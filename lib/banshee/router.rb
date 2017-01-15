module Banshee
  class Router
    def initialize
      # regex, target (controller & action)
      @routes = []
    end

    def match(url, *args)
      target = args.shift unless args.empty?

      @routes << {
        regexp: Regexp.new("^#{url}$"),
        target: target
      }
    end

    def match_url(url)
      @routes.each do |route|
        if route[:regexp].match(url) &&
           /^(?<name>[^@]+)@(?<action>[^@]+)$/ =~ route[:target]
          controller = Object.const_get("#{name.camelify}Controller")
          return controller.action(action)
        end
      end
    end
  end

  class Application
    def route(&block)
      @router ||= Banshee::Router.new
      @router.instance_eval(&block)
    end

    def get_application(env)
      @router.match_url(env['PATH_INFO'])
    end
  end
end
