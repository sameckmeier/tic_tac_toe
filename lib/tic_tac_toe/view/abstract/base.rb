module View
  class Base
    def render
      raise NotImplementedError
    end

    def display_msg(msg)
      puts msg
    end
  end
end