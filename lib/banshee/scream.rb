module Banshee
  class Scream
    def self.empty_binding
      binding
    end

    def self.render(template:, locals: {})
      bind = empty_binding
      locals.each { |key, value| bind.local_variable_set(key, value) }
      ERB.new(template).result(bind)
    end
  end
end
