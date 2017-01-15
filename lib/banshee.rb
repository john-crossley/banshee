require "banshee/version"
require "banshee/controller"
require "banshee/utils"
require "banshee/dependencies"
require "banshee/scream"

module Banshee
  class Application
    def call(env)
      if env["PATH_INFO"] == "/"
        return [ 302, { "Location" => "/hello/world" }, [] ]
      end

      return [ 500, {}, [] ] if env["PATH_INFO"] == "/favicon.ico"

      # env["PATH_INFO"] = "/hello/world" => HelloController.send(:world)
      controller_class, action = get_controller_and_action(env)
      controller = controller_class.new(env)
      response = controller.send(action)

      if controller.get_response
        controller.get_response
      else
        controller.render(action)
        controller.get_response
        # [ 200, {"Content-type" => "text/html"}, [ response ] ]
      end
    end

    def get_controller_and_action(env)
      p env
      _, controller, action = env["PATH_INFO"].split("/")

      controller = "#{controller.camelify}Controller"
      [ Object.const_get(controller), action ]
    end

  end
end
