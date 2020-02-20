module Model
  class Team
    attr_reader :name, :move_strategy, :pieces

    def initialize(args)
      raise ArgumentError, "empty pieces array" if args[:pieces].length == 0

      @name = args[:name]
      @move_strategy = args[:move_strategy]
      @pieces = args[:pieces]

      @pieces.each { |p| p.team = self }
    end

    def selected_piece
      @pieces[0]
    end

    def computer?
      !@move_strategy.nil?
    end

    def available_moves(board)
      @pieces.each_with_object([]) do |piece, moves|
        moves.concat(piece.moves(board))
      end
    end
  end
end
