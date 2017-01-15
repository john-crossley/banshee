require "banshee/version"

module Banshee
  class Application
    def call(env)
      [200, {"Content-type" => "text/html"}, ["Hello, world!"]]
    end
  end
end
