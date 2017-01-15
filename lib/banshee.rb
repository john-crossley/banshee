require 'banshee/version'
require 'banshee/controller'
require 'banshee/utils'
require 'banshee/dependencies'
require 'banshee/scream'

module Banshee
  class Application
    def call(env)
      if env['PATH_INFO'] == '/'
        return [302, { 'Location' => '/hello/world' }, []]
      end

      return [500, {}, []] if env['PATH_INFO'] == '/favicon.ico'

      # env['PATH_INFO'] = '/hello/world' => HelloController.send(:world)
      controller_class, action = get_controller_and_action(env)
      controller_class.new(env).send(action)
    end

    def get_controller_and_action(env)
      _, controller, action = env['PATH_INFO'].split('/')

      controller = '#{controller.camelify}Controller'
      [Object.const_get(controller), action]
    end

  end
end
