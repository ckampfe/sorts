class Board

  attr_writer :query

  def initialize
    @board = make_board
    @query
  end

  def make_board
    # alphabet = ('a'..'z').to_a
    # board = []
    # 4.times { board << Array.new(4) { alphabet[rand(26)] } }
    #
    ### CUSTOM BOARD FOR TESTING. THE ABOVE CODE IS FOR RANDOM BOARD
    board = [
      %w(h j k s),
      %w(a p x x),
      %w(d p l b),
      %w(z e z r)
    ]

    board
  end

  # start positions are constructed as a linear sequence
  # top-to-bottom, left-to-right, 0-15.
  # they are then iterated over with the while loop
  def start
    start_position = 0
    while start_position < 16
      return true if search(@query,
                            integer_to_yx(start_position),
                            integer_to_yx(start_position))
      start_position += 1
    end

    false
  end

  private

  def search(query, current_pos, bads)
    return true if query == "" # it's here!
    # is this a move we want (ie, the next letter of the query?)
    # if not, return false
    return false unless @board[current_pos[0]][current_pos[1]] == query[0]
    possible_moves = possible_moves(current_pos, bads)
    # build branching string with possible moves, like:
    # search( pos1 ) || search( pos2 ) || search( pos3 ) etc.
    method_string = possible_moves.map { |move| "search('#{query[1..-1]}',
                                         #{move},
                                         #{[bads] + [move]})" }.join(' || ')

    # evaluate the constructed calls
    eval(method_string)
  end

  def possible_moves(given_position, bads)
    # return a list of all possible moves from a given position,
    # NOT taking into account edge-of-board considerations
    possibles = position_permutations(given_position) # get raw directions

    # adjust for edge considerations and presence in the 'bads' list
    adjusted_possibles = possibles.select do |position|
      !bads.include?(position) && on_board?(position)
    end

    adjusted_possibles
  end

  def on_board?(position)
    y_index, x_index = position[0], position[1]
    if y_index < 0 || y_index > 3 # off top and bottom of board
      return false
    elsif x_index < 0 || x_index > 3 # off left and right of board
      return false
    end

    true
  end

  # given some 0-15 index, return translated to [y][x] for 2D array
  def integer_to_yx(some_index)
    [some_index / 4, some_index % 4]
  end

  def position_permutations(given_position)
    # the eight direction moves that a move could take from
    # a center position
    modifiers = [[-1, -1],
                 [-1, 0],
                 [-1, 1],
                 [0, 1],
                 [1, 1],
                 [1, 0],
                 [1, -1],
                 [0, -1]]
    modifiers.map { |pair| [pair[0] + given_position[0],
                            pair[1] + given_position[1]] }
  end
end


### TESTS ###
board = Board.new
board.make_board
board.query = 'apple'
p board.start == true

board.query = 'zl'
p board.start == true

board.query = 'xxxx'
p board.start == false

board.query = 'dppjks'
p board.start == true

board.query = 'burn'
p board.start == false

board.query = '7482'
p board.start == false
