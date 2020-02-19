module View
  class Terminal < View::Base
    def initialize(presenter, terminal_util)
      super(presenter)
      @terminal_util = terminal_util
    end
  end
end