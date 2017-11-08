# frozen_string_literal: true

module BitmapEditor
  class Image
    MIN_COLUMNS = MIN_ROWS = 1
    MAX_COLUMNS = MAX_ROWS = 250

    attr_accessor :number_of_rows, :number_of_columns, :bitmap

    def initialize(columns, rows)
      # we are going to store the image in zero based arrays
      # and do translation on fly
      self.number_of_columns = columns
      self.number_of_rows = rows
      self.bitmap = generate_white_bitmap
    end

    def clear
      self.bitmap = generate_white_bitmap
    end

    def colour(x, y, colour)
      unless valid_coordinate?(x, y)
        Log.instance.error "Coordinate (#{x}, #{y}) are out of bounds for \
          image of with max coordinates \
          (#{number_of_columns}, #{number_of_rows})"
          .squeeze(' ')
        return
      end

      bitmap[x - 1][y - 1] = colour
    end

    def pixel_at(x, y)
      bitmap[x - 1][y - 1]
    end

    def to_s
      output = +''
      # O(n^2) time
      number_of_rows.times do |y|
        number_of_columns.times do |x|
          output << pixel_at(x, y)
        end
        output << "\n"
      end
      output
    end

    private

    def generate_white_bitmap
      Array.new(number_of_columns) do
        Array.new(number_of_rows, 'O')
      end
    end

    def valid_coordinate?(x, y)
      x.between?(MIN_ROWS, number_of_columns) &&
        y.between?(MIN_COLUMNS, number_of_rows)
    end
  end
end
