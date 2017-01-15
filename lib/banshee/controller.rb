module Banshee
  class Controller

    attr_reader :request, :params

    def initialize(env)
      @request ||= Rack::Request.new(env)
    end

    def params
      @params ||= Hash[request.params.map { |key, value| [key.to_sym, value] }]
    end

    def render(*args)
      response(body: render_template(*args))
    end

    def response(body:, status: 200, headers: {})
      @response = Rack::Response.new(body, status, headers)
    end

    def get_response
      @response
    end

    def render_template(view, locals = {})
      filename = File.join('app', 'views', controller, "#{view}.erb")

      # Add the defined variables inside the view to the template
      instance_variables.each do |instance_variable|
        key = instance_variable.to_s.delete('@').to_sym
        locals[key] = instance_variable_get(instance_variable)
      end

      Banshee::Scream.render(template: File.read(filename), locals: locals)
    end

    def controller
      self.class.to_s.gsub(/Controller$/, '').snakeify
    end
  end
end
