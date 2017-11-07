# frozen_string_literal: true

module BitmapEditor
  class Image
    attr_accessor :number_of_rows, :number_of_columns, :bitmap

    def initialize(columns, rows)
      # we are going to store the image in zero based arrays
      # and do translation on fly
      self.number_of_columns = columns
      self.number_of_rows = rows
      self.bitmap = Array.new(number_of_columns) do
        Array.new(number_of_rows, 'O')
      end
    end

    def pixel_at(x, y)
      bitmap[x - 1][y - 1]
    end

    def to_s
      output = +''
      number_of_rows.times do |y|
        number_of_columns.times do |x|
          output << pixel_at(x, y)
        end
        output << "\n"
      end
      output
    end
  end
end
