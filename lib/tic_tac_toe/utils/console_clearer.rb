module Utils
  module Terminal
    class << self
      def clear_screen
        system("clear") || system("cls")
      end
    end
  end
end