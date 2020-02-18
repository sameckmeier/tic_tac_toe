module View
  class Terminal < View::Base
    def initialize(controller, terminal_util)
      super(controller)
      @terminal_util = terminal_util
    end
  end
end