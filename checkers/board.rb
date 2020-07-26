require_relative 'exceptions'

module Checkers
  class Board
    WHITE = 'w'
    BLACK = 'b'
    EMPTY = nil


    def initialize
      @board = Array.new(8) { Array.new(8) { EMPTY } }
    end

    def board
      @board.dup
    end

    def set_pawns
      @board[0..1] = player_default_pawns(WHITE)
      @board[6..7] = player_default_pawns(BLACK)

      true
    end

    def make_move(src_field, dst_field)
      src_row, src_column = parse_field(src_field)
      dst_row, dst_column = parse_field(dst_field)

      unless @board[src_row][src_column] != EMPTY && @board[dst_row][dst_column] == EMPTY
        throw ::Checkers::InvalidMoveError.new
      end

      @board[dst_row][dst_column] = @board[src_row][src_column]
      @board[src_row][src_column] = EMPTY

      true
    end


    private

    def player_default_pawns(color)
      Array.new(2) { Array.new(8) { color } }
    end

    def parse_field(field)
      throw ::Checkers::FieldParseError.new unless valid_field?(field)

      column = get_column_index(field[0])
      row = get_row_index(field[1])

      [row, column]
    end

    def valid_field?(field)
      field.is_a?(String) && /^[a-h][1-8]$/i.match?(field)
    end

    def get_column_index(column)
      column.downcase.ord - 'a'.ord
    end

    def get_row_index(row)
      row.to_i - 1
    end
  end
end
