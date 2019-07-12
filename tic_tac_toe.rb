class Board
  def initialize
    @board = [[1,2,3],
              [4,5,6],
              [7,8,9]]
  end

  def display
    system "clear" or system "cls"
    puts " #{get_coord(1)} | #{get_coord(2)} | #{get_coord(3)} "
    puts "---|---|---"
    puts " #{get_coord(4)} | #{get_coord(5)} | #{get_coord(6)} "
    puts "---|---|---"
    puts " #{get_coord(7)} | #{get_coord(8)} | #{get_coord(9)} "
  end

  def get_coord(coordinate)
    coordinate =
      case coordinate
      when 1 then @board[0][0]
      when 2 then @board[0][1]
      when 3 then @board[0][2]
      when 4 then @board[1][0]
      when 5 then @board[1][1]
      when 6 then @board[1][2]
      when 7 then @board[2][0]
      when 8 then @board[2][1]
      when 9 then @board[2][2]
      else "Box not valid"
      end
  end

  def set_coord(coordinate, value)
    case coordinate
      when 1 then update(0, 0, value)
      when 2 then update(0, 1, value)
      when 3 then update(0, 2, value)
      when 4 then update(1, 0, value)
      when 5 then update(1, 1, value)
      when 6 then update(1, 2, value)
      when 7 then update(2, 0, value)
      when 8 then update(2, 1, value)
      when 9 then update(2, 2, value)
      else "Box not valid"
    end
  end

  def update(row, column, mark)
    if @board[row][column].is_a? Numeric
      @board[row][column] = mark
    else
      "Box already used"
    end
  end

  def wins?(mark)
    horizontal_win?(mark) || vertical_win?(mark)
  end

  def horizontal_win?(mark)
    @board.include?([mark, mark, mark])
  end

  def vertical_win?(mark)
    @board.transpose.include?([mark, mark, mark])
  end

  def diagonal_win?(mark)
    @board
  end

  def draw?
    if @board.flatten.any?{|e| e.is_a?(Integer)}
      false
    else
      true
    end
  end
end

class Player
  attr_accessor :name, :mark

  def initialize(name, mark)
    @name = name
    @mark = mark
  end
end

class Game
  def initialize
    @board = Board.new
    @player_x = Player.new('Player X', :X)
    @player_o = Player.new('Player O', :O)
  end

  def play
    @board.display
    @current_player = @player_x
    loop do
      make_a_move
      @board.display
      break if game_over
      next_turn
    end
  end

  private

  def make_a_move
    puts "Select a box #{@current_player.name}: "
    coord = gets.chomp

    @board.set_coord(coord.to_i, @current_player.mark)
  end

  def next_turn
    @current_player =
      if @current_player == @player_x
        @player_o
      else
        @player_x
      end
  end

  def game_over
    if @board.wins?(@current_player.mark)
      puts "#{@current_player.name} wins!"
      return true
    elsif @board.draw?
      puts "Game is a tie!"
      return true
    end
  end
end

game = Game.new
game.play
