module Banshee
  class Controller
    def render(view, locals = {})
      filename = File.join("app", "views", controller, "#{view}.erb")
      template = File.read(filename)
    end

    def controller
      self.class.to_s.gsub(/Controller$/, "").snakeify
    end
  end
end
