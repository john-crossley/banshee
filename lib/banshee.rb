require "banshee/version"

module Banshee
  class Application
    def call(env)
      if env["PATH_INFO"] == "/"
        return [ 302, { "Location" => "/hello/world" }, [] ]
      end

      return [ 500, {}, [] ] if env["PATH_INFO"] == "/favicon.ico"

      # env["PATH_INFO"] = "/hello/world" => HelloController.send(:world)
      controller, action = get_controller_and_action(env)
      response = controller.new.send(action)
      [ 200, {"Content-type" => "text/html"}, [ response ] ]
    end
  
    def get_controller_and_action(env)
      p env
      _, controller, action = env["PATH_INFO"].split("/")

      controller = "#{controller.capitalize}Controller"
      [ Object.const_get(controller), action ]
    end

  end
end
