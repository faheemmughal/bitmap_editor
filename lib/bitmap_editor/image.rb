# frozen_string_literal: true

module BitmapEditor
  class Image
    attr_accessor :rows, :columns, :bitmap

    def initialize(columns, rows)
      self.columns = columns
      self.rows = rows
      self.bitmap = Array.new(columns) { Array.new(rows, 'O') }
    end

    def pixel_at(x, y)
      bitmap[x][y]
    end
  end
end
