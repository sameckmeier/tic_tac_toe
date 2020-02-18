module View
  class Base
    def initialize(controller)
      @controller = controller
    end

    def render(controller)
      raise NotImplementedError
    end
  end
end