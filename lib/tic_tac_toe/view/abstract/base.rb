module View
  class Base
    def initialize(presenter)
      @presenter = presenter
    end

    def render
      raise NotImplementedError
    end
  end
end