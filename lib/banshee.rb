require 'banshee/version'
require 'banshee/controller'
require 'banshee/utils'
require 'banshee/dependencies'
require 'banshee/scream'
require 'banshee/router'

module Banshee
  class Application
    def call(env)
      return [500, {}, []] if env['PATH_INFO'] == '/favicon.ico'

      get_rack_app(env).call(env)
    end
  end
end
