module Utils
  class Terminal
    class << self
      def clear_screen
        system('clear') || system('cls')
      end

      def get_input
        val = gets.chomp

        val
      end

      def get_integer_input
        get_input.to_i
      end
    end
  end
end
