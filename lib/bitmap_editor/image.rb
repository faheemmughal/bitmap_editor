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

    def draw_horizontal(x1, x2, y, colour)
      x1, x2 = [x1, x2].sort
      unless valid_coordinate?(x1, y) && valid_coordinate?(x2, y)
        log_coordinates_out_of_bound([x1, y], [x2, y])
        return
      end

      (x1..x2).each do |x|
        bitmap[x - 1][y - 1] = colour
      end
    end

    def draw_vertical(x, y1, y2, colour)
      y1, y2 = [y1, y2].sort
      unless valid_coordinate?(x, y1) && valid_coordinate?(x, y2)
        log_coordinates_out_of_bound([x, y1], [x, y2])
        return
      end

      (y1..y2).each do |y|
        bitmap[x - 1][y - 1] = colour
      end
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
      (1..number_of_rows).each do |y|
        (1..number_of_columns).each do |x|
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
      x.between?(MIN_COLUMNS, number_of_columns) &&
        y.between?(MIN_ROWS, number_of_rows)
    end

    def log_coordinates_out_of_bound(coordinate1, coordinate2)
      Log.instance.error "Coordinate (#{coordinate1[0]}, #{coordinate1[1]}) or \
        (#{coordinate2[0]}, #{coordinate2[1]}) are out of bounds for image of \
        with max coordinates (#{number_of_columns}, #{number_of_rows})"
        .squeeze(' ')
    end
  end
end
