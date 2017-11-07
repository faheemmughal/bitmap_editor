# frozen_string_literal: true

require 'logger'
require 'singleton'

module BitmapEditor
  class Log < Logger
    include Singleton

    def initialize
      super(log_file)
      self.level = Logger::INFO
    end

    def log_file
      # output to STDOUT when not configured
      ENV['LOG_FILE'] || STDOUT
    end
  end
end
