module View
  class Base
    def initialize(controller)
      @controller = controller
    end

    def render
      raise NotImplementedError
    end
  end
end